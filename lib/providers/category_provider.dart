import 'package:flutter/material.dart';
import 'package:groceryList/providers/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _category = [
    Category(id: 3,title: 'Dairy',imageUrl: 'https://i.postimg.cc/RhF7h7Xc/icons8-milk-bottle-100.png'),
    Category(id: 2,title: 'Vegetable',imageUrl: 'https://i.postimg.cc/7ZTpb7R8/icons8-beetroot-and-carrot-64.png'),
    Category(id: 1,title: 'Fruit',imageUrl: 'https://i.postimg.cc/Fz9PZkGR/icons8-fruit-bag-48.png'),
    Category(id: 4,title: 'Bread & Pastries',imageUrl: 'https://i.postimg.cc/BnWFff95/icons8-cake-48.png'),
    Category(id: 5,title: 'Milk & Cheese',imageUrl: 'https://i.postimg.cc/Lsvh5nhS/icons8-milk-bottle-48.png'),
    Category(id: 6,title: 'Care & Health',imageUrl: 'https://i.postimg.cc/brDZ43mF/icons8-heart-health-64.png'),
    Category(id: 7,title: 'House Hold',imageUrl: 'https://i.postimg.cc/VLX9KWdk/icons8-bathtub-mirror-48.png'),
    Category(id: 8,title: 'Snack & Sweet',imageUrl: 'https://i.postimg.cc/rFgsyDH9/icons8-kawaii-french-fries-48.png'),

  ];

  List<Category> get category {
    return [..._category];
  }
}