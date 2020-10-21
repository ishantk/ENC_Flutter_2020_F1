import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/model/cart.dart';
import 'package:enc_flutter_2020_f1/model/dish.dart';
import 'package:enc_flutter_2020_f1/profile/cart.dart';
import 'package:enc_flutter_2020_f1/restaurant/cart-provider.dart';
import 'package:enc_flutter_2020_f1/restaurant/counter.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RestaurantAppBar extends StatelessWidget {

  String title;

  RestaurantAppBar({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            MaterialPageRoute route = MaterialPageRoute(builder: (context) => CartPage());
            Navigator.push(context, route);
          }
        )
      ],
    );
  }
}

class RestaurantMenuPage extends StatelessWidget{

  Map<String, dynamic> restaurant;
  String restaurantID;

  RestaurantMenuPage({Key key, @required this.restaurant, @required this.restaurantID}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          RestaurantAppBar(title: restaurant['name']),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => RestaurantDishItem(dish: restaurant['menu'][index], restaurantId: restaurantID,),
                childCount: restaurant['menu'].length
            ),
          )
        ],
      ),
    );

  }
}

class RestaurantDishItem extends StatelessWidget{

  Map<String, dynamic> dish;
  String restaurantId;
  RestaurantDishItem({Key key, this.dish, this.restaurantId}): super(key: key);

  @override
  Widget build(BuildContext context) {

    // Get the Reference of the Cart which we created from Provider initially
    var foodItemCart = context.watch<FoodItemCart>();
    // Check if dish is available in cart or not on the basis of title or any other attribute of your choice
    var isInCart = foodItemCart.checkDishTitle(dish['title']);

    print("${dish['title']} Is In Cart $isInCart");

    return Expanded(
        child: Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: NetworkImage(dish['imageURL']),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  /*ClipRRect(
                child:  Image.network(widget.restaurant['menu'][index]['imageURL'], height: 125, width: 125,),
                borderRadius: BorderRadius.circular(8.0),
              ),*/
                  Padding(padding: EdgeInsets.all(2.0),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dish['title'], style: TextStyle(fontSize: 16.0, color: Colors.black87),),
                      Text("Rs. ${dish['price']}", style: TextStyle(fontSize: 14.0, color: Colors.brown),),
                      Text(dish['description'], style: TextStyle(fontSize: 12.0, color: Colors.black38),),
                      Text(dish['type'], style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),),
                    ],
                  ),
                  isInCart ?
                  Counter(quantity: foodItemCart.foundDishInCart.quantity, dishPrice: dish['price'], docId: foodItemCart.foundDishInCart.docId)
                      :
                  OutlineButton(
                      child: Text("Add  +"),
                      onPressed: (){
                        // On press we get the entire map in dishData
                        dish['quantity'] = 1;
                        dish['restaurant'] = dish['name'];
                        dish['restaurantId'] = restaurantId;
                        dish['totalPrice'] = dish['price'];

                        FirebaseFirestore db = FirebaseFirestore.instance;
                        db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).collection(Constants.CART_COLLECTION).add(dish)
                            .then((value){
                          print("Document Added");
                          //Show a SnackBar :)
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      )
                  )
                ],
              ),
            )
        )
    );
  }
}
