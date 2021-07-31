import 'package:LaFoodie/reservations/reservation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:LaFoodie/reservations/userReservations.dart';
import '../Menu Screen/home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;
  FirebaseUser userEmail;

  Future<void> getCurrentUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      userEmail = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 9,
                  ),

                  //email row
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        // "laiba@gmail.com",
                        "Email:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        userEmail.email,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 90,
                  ),

                  //reservation button
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          // "laiba@gmail.com",
                          'See your Reservations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width * 0.8),
                          height: 50,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          UserReservations()));
                            },
                            color: Colors.purple,
                            child: Text(
                              "Your Reservations",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
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
  int currentindex = 2;

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
