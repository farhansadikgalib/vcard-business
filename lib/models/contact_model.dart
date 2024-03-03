const String tableContact = 'tbl_contact';
const String tblContactColId = 'id';
const String tblContactColName = 'name';
const String tblContactColMobile = 'mobile';
const String tblContactColEmail = 'email';
const String tblContactColCompany = 'company';
const String tblContactColDesignation = 'designation';
const String tblContactColAddress = 'address';
const String tblContactColWebsite = 'website';
const String tblContactColImage = 'image';
const String tblContactColFavorite = 'favorite';

class ContactModel {
  int id;
  String name;
  String mobile;
  String email;
  String company;
  String designation;
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
      this.designation = '',
      this.address = '',
      this.website = '',
      this.image = '',
      this.favorite = false});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactColName: name,
      tblContactColMobile: mobile,
      tblContactColEmail: email,
      tblContactColCompany: company,
      tblContactColDesignation: designation,
      tblContactColAddress: address,
      tblContactColWebsite: website,
      tblContactColImage: image,
      tblContactColFavorite: favorite ? 1 : 0,
    };

    if (id > 0) {
      map[tableContact] = id;
    }

    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
        id: map[tblContactColId],
        name: map[tblContactColName],
        mobile: map[tblContactColMobile],
        email: map[tblContactColEmail],
        address: map[tblContactColAddress],
        company: map[tblContactColCompany],
        designation: map[tblContactColDesignation],
        website: map[tblContactColWebsite],
        image: map[tblContactColImage],
        favorite: map[tblContactColFavorite] == 1 ? true : false,
      );

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, mobile: $mobile, email: $email, company: $company, designation: $designation, address: $address, website: $website, image: $image, favorite: $favorite}';
  }
}
