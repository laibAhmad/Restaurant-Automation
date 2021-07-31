import 'dart:ui';

class Item {
  String title;
  String description;
  Color color;
  String price;
  String img;
  int ratings;

  Item(this.title, this.description, this.color, this.price, this.img,
      this.ratings);
}

List<Item> getGridItems() {
  return <Item>[
    Item(
        'Biryani',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris libero mauris, dictum ac justo nec, viverra porttitor nunc.',
        Color(0xffffcdd2),
        '350',
        'assets/img/biryani.png',
        4),
    Item(
        'Fish',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris libero mauris, dictum ac justo nec, viverra porttitor nunc.',
        Color(0xffffcdd2),
        '600',
        'assets/img/fish.png',
        4),
    Item(
        'Kabab',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris libero mauris, dictum ac justo nec, viverra porttitor nunc.',
        Color(0xffffcdd2),
        '250 (5 pieces)',
        'assets/img/kabab.png',
        3),
    Item(
        'Chicken Karahi',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris libero mauris, dictum ac justo nec, viverra porttitor nunc.',
        Color(0xffffcdd2),
        '900',
        'assets/img/karahi.png',
        4),
    Item(
        'Egg Fried Rice',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris libero mauris, dictum ac justo nec, viverra porttitor nunc.',
        Color(0xffffcdd2),
        '850',
        'assets/img/rice.png',
        4),
  ];
}
