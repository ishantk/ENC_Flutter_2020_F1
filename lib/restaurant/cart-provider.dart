import 'package:enc_flutter_2020_f1/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart"),),
      body: CartList()
    );
  }
}

class CartList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Here we are getting the reference of FoodItemCart and if anything changes, widget will be re-built
    var foodItemCart = context.watch<FoodItemCart>();

    return ListView.builder(
        itemCount: foodItemCart.cart.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.fastfood),
          title: Text(foodItemCart.cart[index].title),
          subtitle: Text("Rs. ${foodItemCart.cart[index].price} | Quantity ${foodItemCart.cart[index].quantity} | TotalPrice: ${foodItemCart.cart[index].totalPrice}"),
        )
    );
  }
}



