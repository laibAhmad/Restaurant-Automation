import 'dart:async';

import 'package:LaFoodie/Cart/cartState.dart';
import 'package:LaFoodie/models/user.dart';
import 'package:LaFoodie/reservations/tableState.dart';
import 'package:LaFoodie/screens/wrapper.dart';
import 'package:LaFoodie/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => TableState()),
      ],
      child: MyApp(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // loadData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Wrapper(),
      ),
    );
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 1), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
  }

  screen(BuildContext context) {
    return Container(
      // color: Colors.purple,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Image.asset(
        "assets/img/1bg.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

class ShimmerImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Color(0xffab47bc),
          child: Image.asset("assets/img/1.png"),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
