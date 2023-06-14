import 'package:hello_world/src/models/item_model.dart';

class CartItemModel {
  ItemModel item;
  int quantity;

  CartItemModel({
    required this.quantity,
    required this.item,
  });

  totalPrice() => item.price * quantity;
}