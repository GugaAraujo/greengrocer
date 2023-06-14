import 'package:hello_world/src/models/cart_item_model.dart';

class OrderModel {

  String id;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  List<CartItemModel> items;
  String status;
  String copyAndPast;
  double total;

  OrderModel({
    required this.total,
    required this.items,
    required this.copyAndPast,
    required this.createdDateTime,
    required this.id,
    required this.overdueDateTime,
    required this.status,
  });
}
