import 'dart:ui';

import 'package:LaFoodie/Menu%20Screen/home.dart';
import 'package:LaFoodie/reservations/profile.dart';
import 'package:LaFoodie/reservations/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UserReservations extends StatefulWidget {
  @override
  _UserReservationsState createState() => _UserReservationsState();
}

class _UserReservationsState extends State<UserReservations> {
  final auth = FirebaseAuth.instance;
  FirebaseUser userEmail;
  String uid;

  Future<void> getCurrentUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      userEmail = user;
      uid = user as String;
      // print(uid);
    });
  }

  String userId;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user.uid);
    String userId = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Reservations"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(userId)
              .collection('reservations')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasData) {
                  print("Userid $userId");
                  print(snapshot.data.documents.length);
                  if (snapshot.data.documents.length == 0) {
                    return Center(
                      child: Text(
                        'No Reservations',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          int id = snapshot.data.documents[index]['id'];
                          String date = snapshot.data.documents[index]['date'];
                          String time = snapshot.data.documents[index]['time'];
                          int people = snapshot.data.documents[index]['people'];

                          return detailsCard(
                            id: id,
                            date: date,
                            time: time,
                            people: people,
                          );
                        });
                  }
                } else {
                  return Center(
                    child: Text('Error'),
                  );
                }
            }
          }),
      bottomNavigationBar: CustomBar(),
    );
  }

  Widget detailsCard({
    int id,
    String date,
    String time,
    int people,
    String table,
  }) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
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
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: EdgeInsets.all(13),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        //
                        ///reservation id
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Res. ID: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                              TextSpan(
                                text: '   $id',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ////date
                      Container(
                        width: double.infinity,
                        //
                        ///reservation id
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Date: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                              TextSpan(
                                text: '   $date',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///time
                      Container(
                        width: double.infinity,
                        //
                        ///reservation id
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Time: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                              TextSpan(
                                text: '   $time',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ////
                      Container(
                        width: double.infinity,
                        //
                        ///reservation id
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'No. of People: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                              TextSpan(
                                text: '   $people',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
