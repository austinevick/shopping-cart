class ProductModel {
  final int? id;
  final String? name;
  final String? image;
  final num? price;
  final String? category;
  final bool? favourite;
  int? quantity;
  ProductModel({
    this.name,
    this.id,
    this.quantity = 1,
    this.image,
    this.price,
    this.favourite = false,
    this.category,
  });
}

List<ProductModel> products = [
  ProductModel(
      id: 0,
      name: 'Rose',
      image: "images/flower1.jpeg",
      price: 7.3,
      category: 'Flower'),
  ProductModel(
      id: 1,
      name: 'Flower',
      image: "images/flower2.jpeg",
      price: 8.3,
      category: 'Flower'),
  ProductModel(
      id: 2,
      name: 'Orange',
      image: "images/fruit1.jpeg",
      price: 8.5,
      category: 'Fruit'),
  ProductModel(
      id: 3,
      name: 'Strawberry',
      image: "images/fruit2.jpeg",
      price: 10.5,
      category: 'Fruit'),
  ProductModel(
      id: 4,
      name: 'HP Laptop',
      image: "images/laptop1.jpg",
      price: 104.3,
      category: 'Laptop'),
  ProductModel(
      id: 5,
      name: 'Laptop',
      image: "images/laptop2.jpeg",
      price: 112.3,
      category: 'Laptop'),
  ProductModel(
      id: 6,
      name: 'Phone',
      image: "images/phone2.jpeg",
      price: 15.3,
      category: 'Phone'),
  ProductModel(
      id: 7,
      name: 'Phone',
      image: "images/phone1.jpeg",
      price: 15.3,
      category: 'Phone'),
  ProductModel(
      id: 8,
      name: 'Pizza',
      image: "images/pizza1.jpeg",
      price: 10,
      category: 'Pizza'),
  ProductModel(
      id: 9,
      name: 'Pizza',
      image: 'images/pizza3.jpeg',
      price: 8,
      category: 'Pizza'),
  ProductModel(
      id: 10,
      name: 'Pizza',
      image: "images/pizza2.jpeg",
      price: 7,
      category: 'Pizza'),
  ProductModel(
      id: 11,
      name: 'Shirt',
      image: "images/shirt1.jpeg",
      price: 7,
      category: 'Shirt'),
  ProductModel(
      id: 12,
      name: 'Shirt',
      image: "images/shirt2.jpeg",
      price: 7,
      category: 'Shirt'),
  ProductModel(
      id: 13,
      name: 'Shoe',
      image: "images/shoe1.jpg",
      price: 5,
      category: 'Shoe'),
  ProductModel(
      id: 14,
      name: 'Shoe',
      image: "images/shoe2.jpeg",
      price: 5,
      category: 'Shoe'),
];
