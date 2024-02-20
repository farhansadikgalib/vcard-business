const String tableContact = 'tbl_contact';
const String tableContactColId = 'id';
const String tableContactColName = 'name';
const String tableContactColMobile = 'mobile';
const String tableContactColEmail = 'email';
const String tableContactColCompany = 'company';
const String tableContactColDesination = 'desination';
const String tableContactColAddress = 'address';
const String tableContactColWebsite = 'website';
const String tableContactColImage = 'image';
const String tableContactColFavorite = 'favorite';

class ContactModel {
  int id;
  String name;
  String mobile;
  String email;
  String company;
  String desination;
  String address;
  String website;
  String image;
  bool favorite;

  ContactModel(
      {this.id = -1,
      required this.name,
      this.email = '',
      required this.mobile,
      this.company = '',
      this.desination = '',
      this.address = '',
      this.website = '',
      this.image = '',
      this.favorite = false});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tableContactColName: name,
      tableContactColMobile: mobile,
      tableContactColEmail: email,
      tableContactColCompany: company,
      tableContactColDesination: desination,
      tableContactColAddress: address,
      tableContactColWebsite: website,
      tableContactColImage: image,
      tableContactColFavorite: favorite ? 1 : 0,
    };

    if (id > 0) {
      map[tableContact] = id;
    }

    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
        name: map[tableContactColName],
        mobile: map[tableContactColMobile],
        email: map[tableContactColEmail],
        address: map[tableContactColAddress],
        company: map[tableContactColCompany],
        desination: map[tableContactColDesination],
        website: map[tableContactColWebsite],
        image: map[tableContactColImage],
        favorite: map[tableContactColFavorite] == 1 ? true : false,
      );
}
