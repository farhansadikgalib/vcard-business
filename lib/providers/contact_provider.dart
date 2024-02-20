import 'package:flutter/cupertino.dart';
import 'package:vcard/db/db_helper.dart';

import '../models/contact_model.dart';

class ContactsProvider  extends ChangeNotifier{

  List <ContactModel> contactList = [];
  final db =  DbHelper();

  Future<int> insertContact(ContactModel contactModel)async{
    return db.insertContact(contactModel);
  }
  Future<void> getAllContacts()async{
    contactList =  await db.getAllContacts();
    notifyListeners();
  }



}