
import 'package:enc_flutter_2020_f1/model/address.dart';

class User{

  String name;
  String phone;
  String email;
  bool active;
  String imageURL;
  List<Address> addresses;

  // Default Constructor
  User();

  // Named Constructor
  User.init({this.name, this.phone, this.email, this.active, this.imageURL, this.addresses});


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