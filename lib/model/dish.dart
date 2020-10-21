
class Dish{

  String description;
  String imageURL;
  int price;
  int quantity;
  String restaurant;
  String restaurantId;
  String title;
  int totalPrice;
  String type;
  String docId;

  Dish();

  Dish.init({this.description, this.imageURL, this.price, this.quantity, this.restaurant, this.restaurantId, this.title, this.totalPrice, this.type});

  Dish.fromMap(Map <String, dynamic> map){
    //....
  }

  Map<String, dynamic> toMap(){
    return{
      "description": description,
      "imageURL":imageURL,
      "price": price,
      "quantity":quantity,
      "restaurant":restaurant,
      "restaurantId":restaurantId,
      "title":title,
      "totalPrice":totalPrice,
      "type": type
    };
  }

}