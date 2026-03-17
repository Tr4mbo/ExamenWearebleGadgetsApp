import 'package:flutter/foundation.dart';
import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => [..._orders];

  void addOrder(OrderModel order) {
    _orders.add(order);
    notifyListeners();
  }
}
