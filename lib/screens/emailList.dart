import 'package:LaFoodie/Menu%20Screen/Data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailList extends StatefulWidget {
  @override
  _EmailListState createState() => _EmailListState();
}

class _EmailListState extends State<EmailList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserDetails>>(context);
    users.forEach((users) {
      print(users.id);
      print(users.date);
      print(users.time);
      print(users.people);
    });
    return Container();
  }
}
