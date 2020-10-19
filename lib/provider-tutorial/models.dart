// Model (Object) -> Representing Food Item
import 'package:flutter/cupertino.dart';

class FoodItem{
  String name;
  int price;

  FoodItem({this.name, this.price});
}

// Model (Object) -> Representing Menu of Food Items
class FoodMenu{

  List<FoodItem> itemList;

  FoodMenu(){
    this.itemList = [
      FoodItem(name: "Dal Makhani", price: 200),
      FoodItem(name: "Panner Tikka", price: 300),
      FoodItem(name: "Burger", price: 50),
      FoodItem(name: "Noodles", price: 100),
      FoodItem(name: "Sandwich", price: 80),
      FoodItem(name: "Fires", price: 60),
      FoodItem(name: "Coke", price: 40),
      FoodItem(name: "Soya Champ", price: 160),
      FoodItem(name: "Pizza", price: 350),
      FoodItem(name: "Vanilla Ice Cream", price: 50),
      FoodItem(name: "Chocolate Shake", price: 100),
    ];
  }

  List<FoodItem> get items => itemList;

}

// Model (Object) -> Representing Cart
class FoodItemCart extends ChangeNotifier{

  List<FoodItem> _cartWithFoodItems = [];
  List<FoodItem> get cart => _cartWithFoodItems;

  FoodMenu _foodMenu;
  FoodMenu get menu => _foodMenu;

  int get totalPrice => _cartWithFoodItems.fold(0, (total, element) => total + element.price);

  set menu(FoodMenu newMenu){
    _foodMenu = newMenu;
    notifyListeners();
  }

  void add(FoodItem foodItem){
    _cartWithFoodItems.add(foodItem);
    notifyListeners();
  }

}