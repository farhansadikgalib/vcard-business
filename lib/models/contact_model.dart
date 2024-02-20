class ContactModel {
  int id;
  String name;
  String email;
  String phone;
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
      required this.phone,
      this.company = '',
      this.desination = '',
      this.address = '',
      this.website = '',
      this.image = '',
      this.favorite = false});
}
