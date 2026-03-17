import 'cart_item.dart';

class OrderModel {
  final String orderId;
  final double subtotal;
  final double iva;
  final double shippingCost;
  final double total;
  final DateTime date;
  final List<CartItem> items;
  final Map<String, String> shippingAddress;

  OrderModel({
    required this.orderId,
    required this.subtotal,
    required this.iva,
    required this.shippingCost,
    required this.total,
    required this.date,
    required this.items,
    required this.shippingAddress,
  });
}
