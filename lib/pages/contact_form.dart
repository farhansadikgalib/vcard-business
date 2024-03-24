import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/pages/home_page.dart';
import 'package:vcard/providers/contact_provider.dart';
import 'package:vcard/utils/helper_functions.dart';

class ContactForm extends StatefulWidget {
  static const String routeName = 'form';

  final ContactModel contactModel;

  const ContactForm({super.key, required this.contactModel});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();
  final companyController = TextEditingController();
  final desinationController = TextEditingController();

  // final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.contactModel.name;
    emailController.text = widget.contactModel.email;
    phoneController.text = widget.contactModel.mobile;
    addressController.text = widget.contactModel.address;
    websiteController.text = widget.contactModel.website;
    companyController.text = widget.contactModel.company;
    desinationController.text = widget.contactModel.designation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Form'),
        actions: [
          IconButton(
              onPressed: () {
                saveContact();
              },
              icon: const Icon(
                Icons.save,
                size: 25,
              ))
        ],
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Contact Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please insert your contact's name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Mobile Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please insert your contact's number";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please insert your contact's name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: companyController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Contact's company name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please insert your contact's company name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: desinationController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Contact Desination'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please insert your contact's desination";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: websiteController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Contact Website'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please insert your contact's website";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: addressController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Contact Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please insert your contact's address";
                  }
                  return null;
                },
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    websiteController.dispose();
    companyController.dispose();
    desinationController.dispose();
  }

  saveContact() async {
    if (_formKey.currentState!.validate()) {
      widget.contactModel.name = nameController.text;
      widget.contactModel.mobile = phoneController.text;
      widget.contactModel.email = emailController.text;
      widget.contactModel.company = companyController.text;
      widget.contactModel.designation = desinationController.text;
      widget.contactModel.address = addressController.text;
      widget.contactModel.website = websiteController.text;

      Provider.of<ContactsProvider>(context, listen: false)
          .insertContact(widget.contactModel)
          .then((value) {
        if (value > 0) {
          showMsg(context, 'Saved');
          context.goNamed(HomePage.routeName);
        }
      }).catchError((onError) {
        showMsg(context, 'Failed to save');
      });
    }
  }
}
