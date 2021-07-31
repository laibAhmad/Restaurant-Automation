import 'package:LaFoodie/Menu%20Screen/home.dart';
import 'package:LaFoodie/reservations/profile.dart';
import 'package:LaFoodie/reservations/reservation.dart';
import 'package:LaFoodie/services/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderConfirm extends StatefulWidget {
  int id;
  OrderConfirm({this.id});

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("La Foodie"),
            ),
            body: Center(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 80,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Done!",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Divider(
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Remember You Reservation ID\n",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.id.toString(),
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 40,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Divider(
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 24,
                          ),
                          Text(
                            "See you at Our Place!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            bottomNavigationBar: CustomBar(),
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
