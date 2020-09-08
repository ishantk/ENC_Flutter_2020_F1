
class Dish{

  String name="";
  String description="";
  String imageURL="";
  double price=0;
  double discount=0;

  // default all the variables will have null
  List<String> types; // for filtering the dishes for our search operation in app

  Dish();

  Dish.init({this.name, this.description, this.imageURL, this.price, this.discount, this.types});

  Map<String, dynamic> toMap(){
    return{
      "name":name,
      "description": description,
      "imageURL":imageURL,
      "price": price,
      "discount":discount,
      "type": types
    };
  }

}