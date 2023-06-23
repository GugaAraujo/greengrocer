import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/custom_colors.dart';
import '../../../../models/cart_item_model.dart';
import '../../../../services/utils_services.dart';
import '../../../commom_widgets/quantity_widgets.dart';
import '../../controller/cart_controller.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;

  const CartTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsServices utilsServices = UtilsServices();
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        // imagem
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),

        // titulo
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        // total
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        // quantidade
        trailing: QuantityWidget(
          suffixText: widget.cartItem.item.unit,
          value: widget.cartItem.quantity,
          result: (quantity) {
            controller.changeItemQuantity(
              item: widget.cartItem,
              quantity: quantity,
            );
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
