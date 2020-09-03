
import 'package:enc_flutter_2020_f1/model/address.dart';

class User{

  String name;
  String phone;
  String email;
  bool active;
  String imageURL;
  List<Address> addresses;

  // Default Constructor
  User(){
    name = "";
    phone = "";
    email = "";
    active = false;
    imageURL = "";
    addresses = null;
  }

  // Named Constructor
  User.init({this.name, this.phone, this.email, this.active, this.imageURL, this.addresses});

  // factory constructor uses another constructor to create and return object
  factory User.fromDocument(Map<String, dynamic> document){
    return User.init(name: document['name'], phone: document['phone'],
        email: document['email'], active: document['active'], imageURL: document['imageURL'], addresses: document['addresses']);
  }

  // toMap -> user defined function which returns a HashMap for the Object :)
  Map<String, dynamic> toMap(){
    return{
      "name":name,
      "phone": phone,
      "email": email,
      "active": active,
      "imageURL": imageURL,
      "addresses":addresses
    };
  }

}