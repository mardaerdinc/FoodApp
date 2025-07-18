class FoodModel {
  String name;
  double price;
  String image;
  FoodModel({
    required this.name,
    required this.price,
    required this.image,
  });
}

List<FoodModel> foodList = [
  FoodModel(
    name: 'A plate of fruit',
    price: 35.50,
    image: 'assets/1.png',
  ),
  FoodModel(
    name: 'Pasta with omelette',
    price: 35.00,
    image: 'assets/5.png',
  ),
  FoodModel(
    name: 'Pancake',
    price: 23.0,
    image: 'assets/7.png',
  ),
  FoodModel(
    name: 'A plate of fruit with egg',
    price: 45.0,
    image: 'assets/2.png',
  ),
  FoodModel(
    name: 'A plate of salad',
    price: 28.0,
    image: 'assets/3.png',
  ),
  FoodModel(
    name: 'A bowl of corn',
    price: 35.0,
    image: 'assets/4.png',
  ),
  FoodModel(
    name: 'A bowl of noodles with prawn',
    price: 45.0,
    image: 'assets/6.png',
  ),
];
