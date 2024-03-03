import 'package:flutter/cupertino.dart';
import 'package:vcard/db/db_helper.dart';

import '../models/contact_model.dart';

class ContactsProvider  extends ChangeNotifier{

  List <ContactModel> contactList = [];
  final db =  DbHelper();

  Future<int> insertContact(ContactModel contactModel)async{
   final rowId =  await db.insertContact(contactModel);
   contactModel.id = rowId;
   contactList.add(contactModel);
   notifyListeners();
   return rowId;

  }
  Future<void> getAllContacts()async{
    contactList =  await db.getAllContacts();
    notifyListeners();
  }


Future<int> deleteContact (int id){
    return db.deleteContact(id);
}



}