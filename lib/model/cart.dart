import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/model/dish.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/cupertino.dart';

class FoodItemCart extends ChangeNotifier{

  List<Dish> _cartWithDishes = [];
  List<Dish> get cart => _cartWithDishes;

  FoodItemCart(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).collection(Constants.CART_COLLECTION).snapshots().forEach((QuerySnapshot element) {
      List<QueryDocumentSnapshot> documentList = element.docs;

      documentList.forEach((QueryDocumentSnapshot documentSnapshot) {

        Map<String, dynamic> map = documentSnapshot.data();

        var dish = Dish.init(
          price: map['price'],
          description: map['description'],
          imageURL: map['imageURL'],
          quantity: map['quantity'],
          restaurant: map['restaurant'],
          restaurantId: map['restaurantId'],
          title: map['title'],
          totalPrice: map['totalPrice'],
          type: map['type'],
        );
        add(dish);
      });
    });
  }

  double get totalPrice => _cartWithDishes.fold(0, (total, element) => total + element.totalPrice);

  void add(Dish dish){
    _cartWithDishes.add(dish);
    notifyListeners();
  }

}