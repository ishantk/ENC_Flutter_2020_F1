import 'package:enc_flutter_2020_f1/model/dish.dart';

class Order {

  String orderID;
  String userID;
  String restaurantID;
  DateTime orderDateTime;
  int totalPrice;
  List<Map<String, dynamic>> dishes;

  Order();
  Order.init({this.orderID, this.userID, this.restaurantID, this.orderDateTime, this.totalPrice, this.dishes});

  Map<String, dynamic> toMap(){
    return {
      "orderID": this.orderID,
      "userID": this.userID,
      "restaurantID": this.restaurantID,
      "orderDateTime": this.orderDateTime,
      "totalPrice": this.totalPrice,
      "dishes": this.dishes
    };
  }

}
