import 'package:LaFoodie/Cart/payments.dart';
import 'package:LaFoodie/services/loading.dart';
import 'package:flutter/material.dart';
import 'cartState.dart';
import 'package:LaFoodie/Menu Screen/Data.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: true);
    var taxAmount = 0;
    if (appState.cart.length == 0) {
      setState(() {
        taxAmount = 0;
      });
    } else {
      setState(() {
        taxAmount = 100;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("La Foodie"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          // padding: EdgeInsets.symmetric(horizontal: 100.0),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(
            bottom: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
              ),
              SizedBox(height: 15),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Your Order",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 0.5,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      appState.cart.isEmpty
                          ? Expanded(
                              child: Center(
                                  child: Text(
                              "No items in the cart",
                              style: TextStyle(fontSize: 17),
                            )))
                          : Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return placesWidget(
                                      appState.cart[index], context);
                                },
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(
                                  child: Divider(
                                    color: Colors.grey[400],
                                  ),
                                  height: 18,
                                ),
                                itemCount: appState.cart.length,
                              ),
                            ),
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total (${appState.cart.fold(0, (previousValue, element) => element.quantity + previousValue)} items)",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          Text(
                            "\R\s\. ${appState.cart.fold(0, (previousValue, element) => element.totalPrice() + previousValue)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 24),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "+Taxes",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black45),
                          ),
                          Text(
                            "$taxAmount",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black45),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Payable",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "\R\s\. ${appState.cart.fold(0, (previousValue, element) => element.totalPrice() + previousValue) + taxAmount}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          if (appState.cart.length == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Add Item to Cart Please.")));
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => appState.cart.isEmpty
                                    ? Loading()
                                    : Payments(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.all(
                              Radius.circular(13),
                            ),
                          ),
                          child: Center(
                            child: Text("Confirm Order",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row placesWidget(CartItem cartItem, context) {
    final appState = Provider.of<AppState>(context, listen: true);

    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(cartItem.dishesFirebase.img))),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${cartItem.dishesFirebase.title}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    "Rs ${cartItem.dishesFirebase.price}  x  ${cartItem.quantity}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                  Spacer(),
                  Text(
                    "Rs ${cartItem.totalPrice()}",
                    style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.w600,
                        color: Colors.purple),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      appState.removeItemFromTheCart(cartItem.dishesFirebase,
                          context: context);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.delete_forever,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      appState.decreaseItemQuantityInTheCart(
                          cartItem.dishesFirebase,
                          context: context);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.orange,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                      ),
                      child: Center(
                        child: Text(
                          "${cartItem.quantity}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      appState.increaseItemQuantityInTheCart(
                          cartItem.dishesFirebase,
                          context: context);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
