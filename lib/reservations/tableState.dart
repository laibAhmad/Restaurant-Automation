import 'package:LaFoodie/Menu%20Screen/Data.dart';
import 'package:flutter/material.dart';

class TableState extends ChangeNotifier {
  final List<TableProvider> table = [];

  void addItemInToCart(String date, String time, String guest, int id,
      {@required BuildContext context}) {
    table.add(TableProvider(date, time, guest, id));
    print("table $id is stored");

    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("Item added in cart")));

    notifyListeners();
  }
}
