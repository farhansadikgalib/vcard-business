import 'package:flutter/material.dart';
import 'package:vcard/models/contact_model.dart';

class ContactForm extends StatefulWidget {

  static const String routeName = 'form';

  final ContactModel contactModel;


  const ContactForm({super.key, required this.contactModel});
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.contactModel.name),),
    );
  }
}
