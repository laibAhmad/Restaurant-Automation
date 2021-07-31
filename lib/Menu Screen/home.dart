import 'package:LaFoodie/Cart/cart.dart';
import 'package:LaFoodie/Cart/cartState.dart';
import 'package:LaFoodie/Menu%20Screen/dessertsHome.dart';
import 'package:LaFoodie/Menu%20Screen/drinksHome.dart';
import 'package:LaFoodie/Menu%20Screen/Data.dart';
import 'package:LaFoodie/Menu%20Screen/fastFoodHome.dart';
import 'package:LaFoodie/Menu%20Screen/topRated.dart';
import 'package:LaFoodie/reservations/profile.dart';
import 'package:LaFoodie/reservations/reservation.dart';
import 'package:LaFoodie/reservations/tableState.dart';
import 'package:LaFoodie/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:LaFoodie/Menu%20Screen/itemDes.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  List<Dishes> dataList = [];
  String selected = "dish";

//data list
  @override
  void initState() {
    super.initState();

    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Dishes");
    referenceData.once().then((DataSnapshot dataSnapShot) {
      dataList.clear();

      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        Dishes data = new Dishes(
            values[key]['description'],
            values[key]['img'],
            values[key]['price'],
            values[key]['ratings'],
            values[key]['title'],
            key
            //key is the uploadid
            );
        dataList.add(data);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    final tableState = Provider.of<TableState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("La Foodie"),
        actions: <Widget>[
          tableState.table.length == 0
              ? Container()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Container(
                    // height: 150.0,
                    // width: 30.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => Cart()));
                      },
                      child: Stack(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: null,
                          ),
                          appState.cart.length == 0
                              ? Container()
                              : Positioned(
                                  child: Stack(
                                    children: <Widget>[
                                      Icon(
                                        Icons.circle,
                                        size: 20.0,
                                        color: Colors.amber,
                                      ),
                                      Positioned(
                                          top: 2.7,
                                          right: 5.5,
                                          child: Center(
                                            child: Text(
                                              appState.cart.length.toString(),
                                              style: TextStyle(
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
          Container(
            child: new GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TopRated()));
              },
              child: IconButton(
                icon: Icon(
                  Icons.star_rate_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: null,
              ),
            ),
          ),
          // ignore: deprecated_member_use
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: Container(
              child: new GestureDetector(
                onTap: () async {
                  await _auth.signOut();
                },
                child: IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: null,
                ),
              ),
            ),
          ),
        ],
      ),

      //drawer

      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                //text row
                Row(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Your Best Food at Our Place \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: "Have a Look to Our Today's Menu \n",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ))
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 5)),
              ],
            ),
          ),

          //items main box

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    selected:
                    "dish";

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Home()));
                  });
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        // color: Color(0xffffcdd2),
                        color: selected == 'dish'
                            ? Colors.red[100]
                            : Colors.red[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/foodIcon.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'DISHES',
                      style: TextStyle(
                        // color: Colors.black,
                        color:
                            selected == 'dish' ? Colors.black : Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 35,
                      height: 3,
                      color: selected == 'dish'
                          ? Colors.purple
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selected:
                    'drink';
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => DrinkHome()));
                  });
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.blue[100],
                        color: selected == 'drink'
                            ? Colors.blue[100]
                            : Colors.blue[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/drinkIcon.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'DRINKS',
                      style: TextStyle(
                        // color: Colors.black,
                        color:
                            selected == 'drink' ? Colors.black : Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 35,
                      height: 3,
                      color: selected == 'drink'
                          ? Colors.purple
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selected:
                    'fast';
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => FastHome()));
                  });
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.orange[100],
                        color: selected == 'fast'
                            ? Colors.orange[100]
                            : Colors.orange[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/pizzaIcon.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'FAST FOODS',
                      style: TextStyle(
                        // color: Colors.black,
                        color:
                            selected == 'fast' ? Colors.black : Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 35,
                      height: 3,
                      color: selected == 'fast'
                          ? Colors.purple
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selected:
                    'dessert';
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => DessertHome()));
                  });
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.orange[100],
                        color: selected == 'dessert'
                            ? Colors.green[100]
                            : Colors.green[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/dessertIcon.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'DESSERTS',
                      style: TextStyle(
                        // color: Colors.black,
                        color: selected == 'dessert'
                            ? Colors.black
                            : Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 35,
                      height: 3,
                      color: selected == 'dessert'
                          ? Colors.purple
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),

              //
            ],
          ),

          SizedBox(
            height: 20,
          ),

          Expanded(
            child: dataList.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: dataList.length,
                    itemBuilder: (_, index) {
                      return cardUI(dataList[index], index);
                    }),
          ),

          //food items
        ],
      ),

      //bottom navigation bar
      bottomNavigationBar: CustomBar(),
    );
  }

  Widget cardUI(Dishes dish, int index) {
    //change string to int
    final color = Colors.red[50];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ItemDescription(
              dish: dish,
              color: Colors.red[100],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 1.0),
            )
          ],
        ),
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Image.network(
            dish.img,
            width: 80,
          ),
          title: Text(
            dish.title,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                r"Rs. " + dish.price,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                // textAlign: TextAlign.right,
              ),
              // Text(ratings),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                        size: 15,
                      ),
                    ),
                    TextSpan(
                      text: dish.ratings,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}

//bottom navigation bar
class CustomBar extends StatefulWidget {
  @override
  _CustomBarState createState() => _CustomBarState();
}

class _CustomBarState extends State<CustomBar> {
  int currentindex = 0;

  _onTap() {
    // this has changed
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => _children[currentindex]));
  }

  final List<Widget> _children = [
    Home(),
    Reservation(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentindex,
      onTap: (index) {
        setState(() {
          currentindex = index;
        });
        _onTap();
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text("Menu"),
          icon: Icon(Icons.food_bank),
        ),
        BottomNavigationBarItem(
          title: Text("Make Reservation"),
          icon: Icon(Icons.bookmark),
        ),
        BottomNavigationBarItem(
          title: Text("Profile"),
          icon: Icon(Icons.person),
        )
      ],
    );
  }
}
