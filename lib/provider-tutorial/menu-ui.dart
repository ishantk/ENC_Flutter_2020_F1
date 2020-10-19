import 'package:enc_flutter_2020_f1/provider-tutorial/cart-ui.dart';
import 'package:enc_flutter_2020_f1/provider-tutorial/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFoodMenuApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        // here we are using a simple provider as menu wont change :)
        Provider(create: (context) => FoodMenu()),

        // we may have some data which needs to be updated/changed
        ChangeNotifierProxyProvider<FoodMenu, FoodItemCart>(
          create: (context) => FoodItemCart(),
          update: (context, foodMenu, cart) {
            cart.menu = foodMenu;
            return cart;
          },
        )
      ],
      child: MaterialApp(
        title: "Food App",
        routes: {
          "/": (context) => MenuPage(),
          "/cart": (context) => CartPage(),
        },
        initialRoute: "/",
      ),
    );
  }
}

class MenuPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    var length = context.select<FoodMenu, int>(
        (foodMenu) => foodMenu.items.length
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MyAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => FoodListItem(index),
                childCount: length
            ),
          )
        ],
      ),
    );

  }
}

class MyAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text("Food Menu"),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, "/cart"),
        )
      ],
    );
  }
}

class FoodListItem extends StatelessWidget{

  final int index;
  FoodListItem(this.index, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    var item = context.select<FoodMenu, FoodItem>(
            (foodMenu) => foodMenu.items[index]
    );

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(width: 12.0,),
          Expanded(
            child: Text(item.name),
          ),
          SizedBox(width: 12.0,),
          AddButton(foodItem: item)
        ],
      ),
    );
  }
}

class AddButton extends StatelessWidget {

  final FoodItem foodItem;

  AddButton({Key key, this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var isInCart = context.select<FoodItemCart, bool>(
            (cart) => cart.cart.contains(foodItem)
    );

    return FlatButton(
      onPressed: isInCart ? null: (){
        var cart = context.read<FoodItemCart>();
        cart.add(foodItem);
      },
      child: isInCart ? Text("ADDED"): Text("ADD")
    );
  }
}
