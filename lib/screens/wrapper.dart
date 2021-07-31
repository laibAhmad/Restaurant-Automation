import 'package:LaFoodie/Menu%20Screen/home.dart';
import 'package:LaFoodie/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    final user = Provider.of<User>(context);
    print(user);

    //return home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
