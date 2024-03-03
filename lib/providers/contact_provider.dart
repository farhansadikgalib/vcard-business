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

Future<void> updateFavorite(ContactModel contactModel)async
{
  final value =  contactModel.favorite ? 0 :1;
  await db.updateFavorite(contactModel.id, value);
  final index = contactList.indexOf(contactModel);
  contactList[index].favorite = !contactList[index].favorite;
  notifyListeners();
}


}