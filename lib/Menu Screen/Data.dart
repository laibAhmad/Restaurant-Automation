class Dishes {
  String description, img, price, ratings, title, key;

  Dishes(
    this.description,
    this.img,
    this.price,
    this.ratings,
    this.title,
    this.key,
  );
}

class ReservID {
  String table, date;
  int id, people;
  String reserve, time;
  String key;
  ReservID(this.table, this.date, this.id, this.people, this.reserve, this.time,
      this.key);
}

class UserDetails {
  int id;
  String date, time;
  int people;
  UserDetails({this.id, this.date, this.time, this.people});
}

class CartItem {
  final Dishes dishesFirebase;
  int quantity;

  CartItem(this.dishesFirebase, this.quantity);

  void increaseQuantity() {
    quantity++;
  }

  void decreaseQuantity() {
    assert(quantity > 1, "Quantity should be greater than one to be removed");
    quantity--;
  }

  void updateQuantity(int quantity) {
    assert(quantity > 0, "Quantity can not be zero or negative");
    this.quantity = quantity;
  }

  double totalPrice() {
    return quantity * double.tryParse(dishesFirebase.price);
  }
}

class TableProvider {
  String dateBook;
  String timeBook;
  String guest;
  int id;

  TableProvider(this.dateBook, this.timeBook, this.guest, this.id);
}
