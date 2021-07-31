import 'dart:collection';
import 'package:LaFoodie/Cart/cartState.dart';
import 'package:LaFoodie/Cart/orderConfirm.dart';
import 'package:LaFoodie/Menu%20Screen/Data.dart';
import 'package:LaFoodie/reservations/tableState.dart';
import 'package:LaFoodie/services/loading.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  bool loading = false;

  ScrollController _controller = ScrollController();

  @override
  initState() {
    super.initState();
  }

  Row placesItems(CartItem cartItem, BuildContext context) {
    // final appState = Provider.of<AppState>(context, listen: true);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${cartItem.quantity} x  ${cartItem.dishesFirebase.title}",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.grey[700],
          ),
        ),
        Text(
          "Rs ${cartItem.totalPrice()}",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w400,
            color: Colors.grey[900],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String date, time, guest;
    int orderId;
    final appState = Provider.of<AppState>(context, listen: true);
    final tableState = Provider.of<TableState>(context, listen: true);
    for (int i = 0; i < tableState.table.length; i++) {
      date = tableState.table[i].dateBook;
      time = tableState.table[i].timeBook;
      guest = tableState.table[i].guest;
      orderId = tableState.table[i].id;
    }

    var taxAmount = 100;

    return tableState.table.isEmpty || appState.cart.isEmpty
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("La Foodie"),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 430,
                      width: 800,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Payment",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700),
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
                            height: 50,
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return placesItems(
                                    appState.cart[index], context);
                              },
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 7,
                              ),
                              itemCount: appState.cart.length,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  '\R\s\. ${appState.cart.fold(0, (previousValue, element) => element.totalPrice() + previousValue) + taxAmount}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              SizedBox(height: 30),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Make Payment via',
                            style: TextStyle(
                              fontSize: 20,
                              // color: Colors.purple,
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: 300,
                            width: 800,
                            child: ListView(
                              controller: _controller,
                              padding: const EdgeInsets.all(20),
                              children: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.purple,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  child: Text(
                                    "Debit/Credit Card",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  onPressed: () async {
                                    DatabaseReference databaseReference =
                                        FirebaseDatabase.instance
                                            .reference()
                                            .child("Orders");

                                    String uploadId =
                                        databaseReference.push().key;
                                    HashMap map = new HashMap();
                                    map["date"] = date + ' ' + time;
                                    map["tableID"] = 'table1';
                                    map["orderID"] = orderId.toString();
                                    map["status"] = "Reserved";
                                    map["total"] =
                                        "${appState.cart.fold(0, (previousValue, element) => element.totalPrice() + previousValue) + taxAmount}";

                                    map["items"] = appState.cart
                                        .map((cart) => {
                                              "price":
                                                  cart.dishesFirebase.price,
                                              "quantity": cart.quantity,
                                              "title":
                                                  cart.dishesFirebase.title,
                                            })
                                        .toList();
                                    databaseReference.child(uploadId).set(map);
                                    tableState.table.clear();
                                    appState.cart.clear();
                                    setState(
                                      () => loading = true,
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderConfirm(id: orderId)));
                                  },
                                ),
                                Divider(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.purple,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  child: Text(
                                    "JazzCash",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  onPressed: () async {
                                    DatabaseReference databaseReference =
                                        FirebaseDatabase.instance
                                            .reference()
                                            .child("Orders");

                                    String uploadId =
                                        databaseReference.push().key;
                                    HashMap map = new HashMap();
                                    map["date"] = date + ' ' + time;
                                    map["tableID"] = 'table1';
                                    map["orderID"] = orderId.toString();
                                    map["status"] = "Reserved";
                                    map["total"] =
                                        "${appState.cart.fold(0, (previousValue, element) => element.totalPrice() + previousValue) + taxAmount}";

                                    map["items"] = appState.cart
                                        .map((cart) => {
                                              "price":
                                                  cart.dishesFirebase.price,
                                              "quantity": cart.quantity,
                                              "title":
                                                  cart.dishesFirebase.title,
                                            })
                                        .toList();
                                    databaseReference.child(uploadId).set(map);
                                    tableState.table.clear();
                                    appState.cart.clear();
                                    setState(
                                      () => loading = true,
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderConfirm(id: orderId)));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
