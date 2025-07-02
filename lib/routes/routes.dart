import 'package:flutter/material.dart';
import 'package:my_bloc_app/view/cart/UI/cart.dart';
import 'package:my_bloc_app/view/favourite/UI/fav.dart';

import '../view/home/UI/homePage.dart';

class Routes {
  static const String home = '/';
  static const String fav = '/fav';
  static const String cart = '/cart';

  static Map<String, WidgetBuilder> myRoutes = {
    home: (context) => Homepage(),
    fav: (context) => Fav(),
    cart: (context) => Cart(),
  };
}
