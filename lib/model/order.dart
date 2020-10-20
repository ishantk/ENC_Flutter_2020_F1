import 'package:enc_flutter_2020_f1/model/dish.dart';

class Order {

  String orderID;
  String userID;
  String restaurantID;
  DateTime orderDateTime;
  int totalPrice;
  Map<String, dynamic> deliveryAddress;
  String paymentOption;
  List<Map<String, dynamic>> dishes;
  int orderState;

  Order();
  Order.init({this.orderID, this.userID, this.restaurantID, this.orderDateTime, this.totalPrice, this.dishes, this.orderState});

  Map<String, dynamic> toMap(){
    return {
      "orderID": this.orderID,
      "userID": this.userID,
      "restaurantID": this.restaurantID,
      "orderDateTime": this.orderDateTime,
      "totalPrice": this.totalPrice,
      "deliveryAddress": this.deliveryAddress,
      "paymentOption": this.paymentOption,
      "dishes": this.dishes,
      "orderState": this.orderState
    };
  }

}
