import 'package:LaFoodie/reservations/profile.dart';
import 'package:LaFoodie/reservations/reservation.dart';
import 'package:LaFoodie/reservations/tableState.dart';
import 'package:LaFoodie/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Menu Screen/home.dart';

// ignore: must_be_immutable
class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String dateBook;
    String timeBook;
    String guest;
    int id;
    final tableState = Provider.of<TableState>(context, listen: true);
    for (int i = 0; i < tableState.table.length; i++) {
      dateBook = tableState.table[i].dateBook;
      timeBook = tableState.table[i].timeBook;
      guest = tableState.table[i].guest;
      id = tableState.table[i].id;
    }
    return dateBook == null && timeBook == null && guest == null && id == null
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Reservation Details"),
            ),
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      // padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 10.0),
                      child: Column(
                        children: <Widget>[
                          //
                          //Profile circle
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/img/confirm.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          //reservation number
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Reservation Number: \n $id",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "**Screenshot your Registration Number or save it somewhere.\n",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Details",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          //reservation button
                          Container(
                            margin:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Center(
                              child: Table(
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Date  ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "$dateBook",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Time  ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "$timeBook",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Guest",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "$guest",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Divider(),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Do you want to Book Food?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Home()),
                                        );
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "      |     ",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        tableState.table.clear();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Home()));
                                      },
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ],
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
            bottomNavigationBar: CustomBar(),
          );
  }
}

class CustomBar extends StatefulWidget {
  @override
  _CustomBarState createState() => _CustomBarState();
}

class _CustomBarState extends State<CustomBar> {
  int currentindex = 1;

  _onTap() {
    // this has changed
    Navigator.of(context).pushReplacement(MaterialPageRoute(
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
