import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/pages/contact_form.dart';
import 'package:vcard/utils/constants.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = 'scan';

  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanOver = false;
  List<String> lines = [];
  String name = '',
      mobile = '',
      email = '',
      address = '',
      company = '',
      designation = '',
      website = '',
      image = '';

  createContacts() {
    final contact = ContactModel(
        name: name,
        mobile: mobile,
        email: email,
        address: address,
        company: company,
        website: website,
        designation: designation,
        image: image);

    if (kDebugMode) {
      print(contact.toString());
    }

    context.goNamed(ContactForm.routeName, extra: contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
        actions: [
          IconButton(
              onPressed: image.isEmpty
                  ? null
                  : () {
                      createContacts();
                    },
              icon: const Icon(Icons.arrow_forward))
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Capture')),
              TextButton.icon(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo_album),
                  label: const Text('Gallery')),
            ],
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  DragTargetItem(
                      property: ContactProperties.name,
                      onDrop: getPropertyValue),
                  DragTargetItem(
                      property: ContactProperties.mobile,
                      onDrop: getPropertyValue),
                  DragTargetItem(
                      property: ContactProperties.email,
                      onDrop: getPropertyValue),
                  DragTargetItem(
                      property: ContactProperties.companyName,
                      onDrop: getPropertyValue),
                  DragTargetItem(
                      property: ContactProperties.designation,
                      onDrop: getPropertyValue),
                  DragTargetItem(
                      property: ContactProperties.address,
                      onDrop: getPropertyValue),
                  DragTargetItem(
                      property: ContactProperties.website,
                      onDrop: getPropertyValue),
                ],
              ),
            ),
          ),
          Wrap(children: lines.map((line) => LineItem(line: line)).toList())
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(source: source);
    if (xFile != null) {
      setState(() {
        image = xFile.path;
      });
      EasyLoading.show(status: 'Please wait for a while');
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);

      final recognizedText = await textRecognizer
          .processImage(InputImage.fromFile(File(xFile.path)));

      EasyLoading.dismiss();

      final tempList = <String>[];

      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          tempList.add(line.text);
        }
      }

      print(tempList);

      setState(() {
        lines = tempList;
        isScanOver = true;
      });
    }
  }

  getPropertyValue(String property, String value) {
    switch (property) {
      case ContactProperties.name:
        name = value;
        break;
      case ContactProperties.mobile:
        mobile = value;
        break;
      case ContactProperties.email:
        email = value;
        break;
      case ContactProperties.companyName:
        company = value;
        break;
      case ContactProperties.designation:
        designation = value;
        break;
      case ContactProperties.address:
        address = value;
        break;
      case ContactProperties.website:
        website = value;
        break;
    }
  }
}

class LineItem extends StatelessWidget {
  final String line;

  const LineItem({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
        data: line,
        dragAnchorStrategy: childDragAnchorStrategy,
        feedback: Container(
          key: GlobalKey(),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Colors.black38),
          child: Text(
            line,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
        child: Chip(label: Text(line)));
  }
}

class DragTargetItem extends StatefulWidget {
  final String property;
  final Function(String, String) onDrop;

  const DragTargetItem(
      {super.key, required this.property, required this.onDrop});

  @override
  State<DragTargetItem> createState() => _DragTargetItemState();
}

class _DragTargetItemState extends State<DragTargetItem> {
  String dragItem = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(widget.property)),
        Expanded(
            flex: 2,
            child: DragTarget(
              builder: (context, candidateData, rejecteData) => Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: candidateData.isNotEmpty
                        ? Border.all(color: Colors.deepOrange, width: 2)
                        : null),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(dragItem.isEmpty ? 'Drop here' : dragItem)),
                    if (dragItem.isNotEmpty)
                      InkWell(
                        onTap: () {
                          setState(() {
                            dragItem = '';
                          });
                        },
                        child: const Icon(
                          Icons.clear,
                          size: 15,
                        ),
                      )
                  ],
                ),
              ),
              onAccept: (val) {
                setState(() {
                  if (dragItem.isEmpty) {
                    dragItem = val.toString();
                  } else {
                    dragItem += ' ${val.toString()}';
                  }
                });
                widget.onDrop(widget.property, dragItem);
              },
            ))
      ],
    );
  }
}
