import 'package:LaFoodie/Cart/cart.dart';
import 'package:LaFoodie/Cart/cartState.dart';
import 'package:LaFoodie/Menu%20Screen/Data.dart';
import 'package:LaFoodie/Menu%20Screen/star.dart';
import 'package:LaFoodie/reservations/tableState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ItemDescription extends StatefulWidget {
  Dishes dish;
  Color color;
  ItemDescription({
    Key key,
    this.dish,
    this.color,
    // this.valueSetter,
  }) : super(key: key);
  @override
  _ItemDescriptionState createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  int counter = 1;
  // bool yes = true;
  @override
  Widget build(BuildContext context) {
    final tableState = Provider.of<TableState>(context, listen: true);
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
        backgroundColor: widget.color,
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 48),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )),
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.black,
                            size: 28,
                          )),
                    ),
                  ],
                ),
              ),

              //image of item
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Hero(
                    tag: widget.dish.title,
                    child: Image.network(widget.dish.img),
                  ),
                ),
              ),

              //white space
              SizedBox(
                height: 32,
              ),

              Expanded(
                  child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, bottom: 40, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //name of dish
                      Text(
                        widget.dish.title,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      //ratings
                      Container(
                        child: Row(
                          children: [
                            StarRating(
                              rating: double.parse(widget.dish.ratings),
                              onRatingChanged: (rating) => setState(() =>
                                  this.widget.dish.ratings = rating.toString()),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Text(
                              "\(" + widget.dish.ratings.toString() + "\)",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          tableState.table.length == 0
                              ? Container(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          'You can book Food too but after Table Reservation',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  child: Row(
                                  children: <Widget>[
                                    Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: counter == 1
                                              ? Colors.grey[100]
                                              : Colors.grey[200],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.remove),
                                          color: counter == 1
                                              ? Colors.black54
                                              : Colors.black,
                                          onPressed: () {
                                            if (counter == 1) {
                                              setState(() {
                                                counter = 1;
                                              });
                                            } else {
                                              setState(() {
                                                counter = counter - 1;
                                              });
                                            }
                                          },
                                        )),
                                    Container(
                                      color: Colors.grey[200],
                                      width: 35,
                                      height: 35,
                                      child: Center(
                                        child: Text(
                                          '$counter',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.black,
                                        onPressed: () {
                                          setState(() {
                                            counter = counter + 1;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          Container(
                              child: Text(
                            r"Rs " + widget.dish.price,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )),
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Text(
                              "Product Description:",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            //description text
                            Text(
                              widget.dish.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      tableState.table.length == 0
                          ? Container()
                          : Row(
                              children: [
                                Container(
                                  child: cartIcon(),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  // width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () {
                                      appState.addItemInToCart(widget.dish,
                                          quantity: counter, context: context);
                                      setState(() {
                                        // cartIcon();
                                      });
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: widget.color,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(13),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text("Add to cart",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }

  Widget cartIcon() {
    final appState = Provider.of<AppState>(context, listen: false);
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          color: widget.color,
          width: 2,
        ),
      ),
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(3, 5, 5, 9),
        child: new Container(
          child: new GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => Cart()));
            },
            child: new Stack(
              children: <Widget>[
                new IconButton(
                  icon: Icon(
                    Icons.shopping_cart_rounded,
                    color: widget.color,
                    size: 40,
                  ),
                  onPressed: null,
                ),
                appState.cart.length == 0
                    ? new Container()
                    : new Positioned(
                        child: new Stack(
                          children: <Widget>[
                            new Icon(
                              Icons.circle,
                              size: 22.0,
                              color: Colors.amber,
                            ),
                            new Positioned(
                                top: 3.0,
                                right: 6.5,
                                child: new Center(
                                  child: new Text(
                                    appState.cart.length.toString(),
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
