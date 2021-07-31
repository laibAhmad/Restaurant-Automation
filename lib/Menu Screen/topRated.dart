import 'package:LaFoodie/Menu%20Screen/itemDes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Data.dart';

class TopRated extends StatefulWidget {
  const TopRated({Key key}) : super(key: key);

  @override
  _TopRatedState createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  ////getting menu items from firebase
  List<Dishes> dataList1 = [];

  DatabaseReference referenceData1 =
      FirebaseDatabase.instance.reference().child("Dishes");
  DatabaseReference referenceData2 =
      FirebaseDatabase.instance.reference().child("Drinks");
  DatabaseReference referenceData3 =
      FirebaseDatabase.instance.reference().child("FFoods");
  DatabaseReference referenceData4 =
      FirebaseDatabase.instance.reference().child("Desserts");

  void initState() {
    super.initState();

    referenceData1.once().then((DataSnapshot dataSnapShot) async {
      dataList1.clear();
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        String ratings = values[key]['ratings'];
        double rating = double.parse(ratings);

        if (rating >= 4.7) {
          Dishes data = new Dishes(
              values[key]['description'],
              values[key]['img'],
              values[key]['price'],
              values[key]['ratings'],
              values[key]['title'],
              key
              //key is the uploadid
              );
          dataList1.add(data);
        }

        setState(() {});
      }
    });

    referenceData2.once().then((DataSnapshot dataSnapShot) {
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        String ratings = values[key]['ratings'];
        double rating = double.parse(ratings);

        if (rating >= 4.8) {
          Dishes data = new Dishes(
              values[key]['description'],
              values[key]['img'],
              values[key]['price'],
              values[key]['ratings'],
              values[key]['title'],
              key
              //key is the uploadid
              );
          dataList1.add(data);
        }
        setState(() {});
      }
    });

    referenceData3.once().then((DataSnapshot dataSnapShot) {
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        String ratings = values[key]['ratings'];
        double rating = double.parse(ratings);

        if (rating >= 4.8) {
          Dishes data = new Dishes(
              values[key]['description'],
              values[key]['img'],
              values[key]['price'],
              values[key]['ratings'],
              values[key]['title'],
              key
              //key is the uploadid
              );
          // dataList3.add(data);
          dataList1.add(data);
        }
        setState(() {});
      }
    });

    referenceData4.once().then((DataSnapshot dataSnapShot) {
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        String ratings = values[key]['ratings'];
        double rating = double.parse(ratings);

        if (rating >= 4.8) {
          Dishes data = new Dishes(
              values[key]['description'],
              values[key]['img'],
              values[key]['price'],
              values[key]['ratings'],
              values[key]['title'],
              key
              //key is the uploadid
              );
          // dataList4.add(data);
          dataList1.add(data);
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'La Foodie',
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Our Top Rated Items",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: dataList1.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.count(
                        physics: BouncingScrollPhysics(),
                        childAspectRatio: 1.2 / 1.5,
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: List<Widget>.generate(
                          dataList1.length,
                          (index) => cardUI(dataList1[index], index),
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardUI(Dishes dish, int index) {
    final color = Colors.purple[50];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ItemDescription(
              dish: dish,
              color: Colors.purple[100],
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
                color: Colors.grey[300],
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, 1.0),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //image
                Expanded(
                  child: Hero(
                    tag: dish.title,
                    child: Image.network(
                      dish.img,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),

                //name of dish
                Text(
                  dish.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width / 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //ratings star

                Container(
                  child: RichText(
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
                          text: " " + dish.ratings,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      r"Rs. " + dish.price,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width / 28,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
