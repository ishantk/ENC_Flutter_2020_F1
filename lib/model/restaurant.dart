import 'package:enc_flutter_2020_f1/model/address.dart';
import 'package:enc_flutter_2020_f1/model/dish.dart';

class Restaurant{

  String name="";
  String isActive="";
  String imageURL="";
  double pricePerPerson=0;
  double ratings=0;

  // default all the variables will have null
  List<String> types; // for filtering the dishes for our search operation in app
  List<String> tags;
  List<Dish> menu;
  List<Address> addresses;

  Restaurant();

  Restaurant.init({this.name, this.isActive, this.imageURL, this.pricePerPerson, this.ratings, this.types, this.tags, this.menu, this.addresses});

  Map<String, dynamic> toMap(){
    return{
      "name":name,
      "isActive": isActive,
      "imageURL":imageURL,
      "pricePerPerson": pricePerPerson,
      "types":types,
      "tags": tags,
      "menu": menu,
      "addresses": addresses,
    };
  }

}