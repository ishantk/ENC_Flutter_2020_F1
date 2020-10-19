import 'package:enc_flutter_2020_f1/provider-tutorial/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart"),),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CartList(),
              ),
            ),
            Divider(height: 4.0, color: Colors.blueGrey,),
            Total()
          ],
        ),
      ),
    );
  }
}

class CartList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // tells the flutter to re-build this widget as in when the FoodItemCart changes :)
    var cart = context.watch<FoodItemCart>();

    return ListView.builder(
      itemCount: cart.cart.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.fastfood),
        title: Text(cart.cart[index].name),
        subtitle: Text("Rs. ${cart.cart[index].price}"),
      )
    );
  }
}

class Total extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Consumer<FoodItemCart>(
            builder: (context, cart, child) => Text("${cart.totalPrice}"),
          ),
          SizedBox(width: 24.0,),
          FlatButton(
            child: Text("PROCEED >"),
            onPressed: (){

            },
          )
        ],
      ),
    );
  }
}


