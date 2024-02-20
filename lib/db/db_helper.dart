import 'package:path/path.dart' as P;
import 'package:sqflite/sqflite.dart';
import 'package:vcard/models/contact_model.dart';

class DbHelper {
  final String _createTableContact = '''create table $tableContact(
  $tableContactColId integer primary key autoincrement,
  $tableContactColName text,
  $tableContactColEmail text,
  $tableContactColMobile text,
  $tableContactColAddress text,
  $tableContactColDesination text,
  $tableContactColCompany text,
  $tableContactColImage text,
  $tableContactColFavorite text)''';

  Future<Database> _open() async {
    final root = await getDatabasesPath();
    final dbPath = P.join(root, 'contact.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(_createTableContact);
    });
  }

  Future<int> insertContact(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(tableContact, contactModel.toMap());
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList =  await db.query(tableContact);
    return List.generate(mapList.length, (index) => ContactModel.fromMap
      (mapList[index]));
  }

}
