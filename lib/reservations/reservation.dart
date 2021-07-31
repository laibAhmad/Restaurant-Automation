import 'dart:collection';
import 'dart:math';
import 'package:LaFoodie/Menu%20Screen/Data.dart';
import 'package:LaFoodie/reservations/details.dart';
import 'package:LaFoodie/reservations/profile.dart';
import 'package:LaFoodie/reservations/tableState.dart';
import 'package:LaFoodie/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Menu Screen/home.dart';

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    print(uid);
    await DatabaseService(uid: uid).storeUserData(id, date, time, intGuest);
  }

  List<ReservID> dataList = [];

  ///
  /////to get differnce between date selected and date today
  int diffInDays(DateTime date1, DateTime date2) {
    return ((date1.difference(date2) -
                    Duration(hours: date1.hour) +
                    Duration(hours: date2.hour))
                .inHours /
            24)
        .round();
  }

////reservation id
  int randomNmbr() {
    Random random = new Random();

    int randomNo = random.nextInt(10000);
    // String str = randomNo.toString();
    return randomNo;
  }

//////time conversion
  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

/////time
  DateTime timeChecking(TimeOfDay t) {
    // TimeOfDay t;
    final now = new DateTime.now();
    return new DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  //////show snackbar when details not entered
  showSnackBar() {
    final snackbar = new SnackBar(
      content: Text("Choose all details Please"),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
    );

    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Color clrContainer = Colors.purple[50];

  ///////dropdown
  String dropdownValue = 'Two';
  String dropdownValue1 = 'Table 1';
  String holder = '';

  void getDropDownItem() {
    setState(() {
      guest = dropdownValue;
      return guest;
    });
  }

  void getDropDownItem1() {
    setState(() {
      table = dropdownValue1;
      return table;
    });
  }

  int intGuest;
  var date = '-';
  var time = '-';
  var guest = '-';
  var table = '-';
  int id;
  String data = 'ok';

  int guestNo() {
    int number;
    switch (guest) {
      case "Two":
        {
          number = 2;
        }
        break;

      case "Three":
        {
          number = 3;
        }
        break;

      case "Four":
        {
          number = 4;
        }
        break;

      case "Five":
        {
          number = 5;
        }
        break;
      case "Six":
        {
          number = 6;
        }
        break;

      case "Eight":
        {
          number = 8;
        }
        break;

      default:
        {
          number = 0;
        }
        break;
    }
    return number;
  }

////getting data from database
  @override
  void initState() {
    super.initState();

    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Reserv");
    referenceData.once().then((DataSnapshot dataSnapShot) {
      dataList.clear();

      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        ReservID data = new ReservID(
            values[key]['TableID'],
            values[key]['date'],
            values[key]['id'],
            values[key]['people'],
            values[key]['reserve'],
            values[key]['time'],
            key
            //key is the uploadid
            );
        dataList.add(data);
        setState(() {});
      }
    });
  }

  ////showing date time people at selecting
  @override
  Widget build(BuildContext context) {
    final tableState = Provider.of<TableState>(context, listen: true);
    var _date = Text(
      "$date",
      style: TextStyle(
        fontSize: 20,
      ),
    );
    var _guest = Text(
      "$guest",
      style: TextStyle(
        fontSize: 20,
      ),
    );
    var _time = Text(
      "$time",
      style: TextStyle(
        fontSize: 20,
      ),
    );
    var _table = Text(
      "$table",
      style: TextStyle(
        fontSize: 20,
      ),
    );

    ///page design
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Make your Reservation"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  //
                  //heading text row
                  Row(
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text:
                                'Have Quality Time with your Loved Ones At Our Place\n',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width / 30,
                                fontWeight: FontWeight.w300),
                          ),
                          TextSpan(
                            text: "Tell us When you Want To Dine!\n\n\n\n",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: "Date of Reservation:",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15)),

                  SizedBox(
                    height: 10,
                  ),

                  //date blocks
                  Container(
                    height: 70.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        //
                        //day1
                        InkWell(
                          onTap: () {
                            date = DateFormat("E, MMM d yyyy")
                                .format(DateTime.now());
                            setState(() {
                              _date;
                              // clrContainer = Colors.purple;
                            });
                          },
                          child: Container(
                            width: 130.0,
                            decoration: BoxDecoration(
                              color: clrContainer,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              //getting date
                              DateFormat("E, MMM d").format(DateTime.now()),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            )),
                          ),
                        ),

                        //day2
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            date = DateFormat("E, MMM d yyyy")
                                .format(DateTime.now().add(Duration(days: 1)));
                            setState(() {
                              _date;
                            });
                          },
                          child: Container(
                            width: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              //getting date
                              DateFormat("E, MMM d").format(
                                  DateTime.now().add(Duration(days: 1))),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            )),
                          ),
                        ),

                        //day3
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            date = DateFormat("E, MMM d yyyy")
                                .format(DateTime.now().add(Duration(days: 2)));
                            setState(() {
                              _date;
                            });
                          },
                          child: Container(
                            width: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              //getting date
                              DateFormat("E, MMM d").format(
                                  DateTime.now().add(Duration(days: 2))),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            )),
                          ),
                        ),

                        //day4
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            date = DateFormat("E, MMM d yyyy")
                                .format(DateTime.now().add(Duration(days: 3)));
                            setState(() {
                              _date;
                            });
                          },
                          child: Container(
                            width: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              //getting date
                              DateFormat("E, MMM d").format(
                                  DateTime.now().add(Duration(days: 3))),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            )),
                          ),
                        ),

                        //day5
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            date = DateFormat("E, MMM d yyyy")
                                .format(DateTime.now().add(Duration(days: 4)));
                            setState(() {
                              _date;
                            });
                          },
                          child: Container(
                            width: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              //getting date
                              DateFormat("E, MMM d").format(
                                  DateTime.now().add(Duration(days: 4))),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 35,
                  ),

                  //   //no of people row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //selected date
                      Container(
                        child: Text(
                          "Number of Guests:",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),

                      //select people dropdown
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.purple,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.purple, fontSize: 18),
                        underline: Container(
                          height: 2,
                          color: Colors.purple,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                          getDropDownItem();
                        },
                        items: <String>[
                          'Two',
                          'Three',
                          'Four',
                          'Five',
                          'Six',
                          'Eight'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     //selected date
                  //     Container(
                  //       child: Text(
                  //         "Table Number:",
                  //         style: TextStyle(
                  //           fontSize: 19,
                  //           fontWeight: FontWeight.w600,
                  //           color: Colors.grey[600],
                  //         ),
                  //       ),
                  //     ),

                  //     //select people dropdown
                  //     DropdownButton<String>(
                  //       value: dropdownValue1,
                  //       icon: Icon(
                  //         Icons.keyboard_arrow_down,
                  //         color: Colors.purple,
                  //       ),
                  //       iconSize: 24,
                  //       elevation: 16,
                  //       style: TextStyle(color: Colors.purple, fontSize: 18),
                  //       underline: Container(
                  //         height: 2,
                  //         color: Colors.purple,
                  //       ),
                  //       onChanged: (String newValue) {
                  //         setState(() {
                  //           dropdownValue1 = newValue;
                  //         });
                  //         getDropDownItem1();
                  //       },
                  //       items: <String>[
                  //         'Table 1',
                  //         'Table 2',
                  //         'Table 3',
                  //         'Table 4',
                  //         'Table 5',
                  //         'Table 6',
                  //         'Table 7',
                  //         'Table 8',
                  //         'Table 9',
                  //         'Table 10'
                  //       ].map<DropdownMenuItem<String>>((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //     ),
                  //     SizedBox(
                  //       width: 25,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 35,
                  // ),

                  //time text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Choose Time",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //////time slots
                  Container(
                    height: 70.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        //
                        //day1
                        InkWell(
                          onTap: () {
                            time = '11:00 AM';
                            // DateFormat("hh:mm a").format(
                            //     DateTime.now().add(Duration(minutes: 30)));
                            setState(() {
                              _time;
                            });
                          },
                          child: Container(
                            width: 110.0,
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              '11:00 AM',
                              //getting date
                              // DateFormat("hh:mm a").format(
                              //     DateTime.now().add(Duration(minutes: 30))),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),

                        //day2
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            time = '02:00 PM';
                            // DateFormat("hh:mm a").format(
                            //     DateTime.now().add(Duration(minutes: 60)));
                            setState(() {
                              _time;
                            });
                          },
                          child: Container(
                            width: 110.0,
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              '02:00 PM',
                              //getting date
                              // DateFormat("hh:mm a").format(
                              //     DateTime.now().add(Duration(minutes: 60))),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),

                        //day4
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            time = '04:00 PM';
                            // DateFormat("hh:mm a").format(
                            //     DateTime.now().add(Duration(minutes: 120)));
                            setState(() {
                              _time;
                            });
                          },
                          child: Container(
                            width: 110.0,
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              '04:00 PM',
                              //getting date
                              // DateFormat("hh:mm a").format(
                              //     DateTime.now().add(Duration(minutes: 120))),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),

                        //day5
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            time = '06:00 PM';
                            // DateFormat("hh:mm a").format(
                            //     DateTime.now().add(Duration(minutes: 150)));
                            setState(() {
                              _time;
                            });
                          },
                          child: Container(
                            width: 110.0,
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              '06:00 PM',
                              //getting date
                              // DateFormat("hh:mm a").format(
                              //     DateTime.now().add(Duration(minutes: 150))),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),

                        //
                        InkWell(
                          onTap: () {
                            time = '09:00 PM';
                            // DateFormat("hh:mm a").format(
                            //     DateTime.now().add(Duration(minutes: 180)));
                            setState(() {
                              _time;
                            });
                          },
                          child: Container(
                            width: 110.0,
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            alignment: Alignment.center,

                            //date in center
                            child: Center(
                                child: Text(
                              '09:00 PM',
                              //getting date
                              // DateFormat("hh:mm a").format(
                              //     DateTime.now().add(Duration(minutes: 180))),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
////////////////
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 35,
                  ),

                  Text(
                    "You have Choosen\n",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  //show selected data
                  Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0),
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
                                  _date,
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
                                  _time,
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
                                    "Guests",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  _guest,
                                ],
                              ),
                            )
                          ],
                        ),
                        // TableRow(
                        //   children: [
                        //     TableCell(
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: <Widget>[
                        //           Text(
                        //             "Table Number",
                        //             style: TextStyle(
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //           ),
                        //           _table,
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.8),
                        child: Text(
                          '**Kindly reserve the table carefully. After Confirming, Reservation will not be Cancelled.',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 24,
                  ),

                  //button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.8),
                        height: 50,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () async {
                            id = randomNmbr();
                            intGuest = guestNo();
                            int i;
                            DateTime now = DateTime.now();
                            DateTime dateCheck = new DateFormat("E, MMM d yyyy")
                                .parse(_date.data);

                            TimeOfDay time1 = stringToTimeOfDay(time);
                            DateTime time2 = timeChecking(time1);

                            ///// if any data is empty
                            if (_date.data == "-" ||
                                _time.data == "-" ||
                                _guest.data == "-") {
                              setState(() {
                                data = 'no';
                              });
                              showSnackBar();
                            }

                            ///// if selected time is less than time now then ALERT
                            else if (diffInDays(dateCheck, now) <= 0 &&
                                now.isAfter(time2)) {
                              setState(() {
                                data = 'no';
                              });
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.warning,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " WARNING!",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  content: const Text(
                                      "Selected time is not suitable for Today's Reservation. Kindly change Time or Date."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else if (dataList.isEmpty) {
                              tableState.addItemInToCart(date, time, guest, id,
                                  context: context);
                              setState(() {
                                data = 'no';
                              });
                              DatabaseReference databaseReference =
                                  FirebaseDatabase.instance
                                      .reference()
                                      .child("Reserv");

                              String uploadId = databaseReference.push().key;
                              HashMap map = new HashMap();
                              map["TableID"] = 'table1';
                              map["date"] = date;
                              map["time"] = time;
                              map["people"] = intGuest;
                              map["id"] = id;
                              map["reserve"] = 'true';

                              databaseReference.child(uploadId).set(map);
                              inputData();

                              ///navigate to new page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Details(
                                        // date, time, guest, id
                                        )),
                              );
                            } else {
                              for (i = 0; i < dataList.length; i++) {
                                ///
                                //
                                ///// if same data avaiable with reservation = true in firebase
                                if (dataList[i].date.contains(date) &&
                                    dataList[i].time.contains(time) &&
                                    dataList[i].people.compareTo(intGuest) ==
                                        0 &&
                                    dataList[i].reserve.contains("true")) {
                                  ///show alert
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.info_outline_rounded,
                                                size: 30,
                                                color: Colors.purple,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " Sorry for inconvenience!",
                                              style: TextStyle(
                                                color: Colors.purple,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      content: const Text(
                                        "Table already reserved at the selected time of the day.\nKindly choose another time.",
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                  setState(() {
                                    data = 'no';
                                  });
                                  i = dataList.length;
                                  break;
                                } else {
                                  setState(() {
                                    data = 'ok';
                                  });
                                }
                              }
                            }
                            if (data == 'ok') {
                              tableState.addItemInToCart(date, time, guest, id,
                                  context: context);
                              DatabaseReference databaseReference =
                                  FirebaseDatabase.instance
                                      .reference()
                                      .child("Reserv");

                              String uploadId = databaseReference.push().key;
                              HashMap map = new HashMap();
                              map["TableID"] = 'table1';
                              map["date"] = date;
                              map["time"] = time;
                              map["people"] = intGuest;
                              map["id"] = id;
                              map["reserve"] = 'true';

                              databaseReference.child(uploadId).set(map);

                              ///navigate to new page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Details(
                                        //   dateBook:
                                        // date,timeBook: time,guest: guest,id: id
                                        )),
                              );
                              inputData();
                            }
                          },
                          color: Colors.purple,
                          child: Text(
                            "Reserve a Table",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
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
