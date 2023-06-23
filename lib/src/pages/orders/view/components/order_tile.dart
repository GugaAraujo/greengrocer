import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/cart_item_model.dart';
import '../../../../models/order_model.dart';
import '../../../../services/utils_services.dart';
import '../../../commom_widgets/payment_dialog.dart';
import '../../controller/order_controller.dart';
import 'order_status_widget.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: GetBuilder<OrderController>(
            init: OrderController(order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                onExpansionChanged: (value) {
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pedido: ${order.id}'),
                    Text(
                      utilsServices.formatDateTime(order.createdDateTime!),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              // Itens do pedido
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                    children: controller.order.items.map((orderItem) {
                                      return _OrderItemWidget(
                                        utilsServices: utilsServices,
                                        orderItem: orderItem,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),

                              // divisor
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                                width: 8,
                              ),

                              // Detalhes das etapas
                              Expanded(
                                  flex: 2,
                                  child: OrderStatusWidget(
                                    status: order.status,
                                    isOverduo: order.overdueDateTime
                                        .isBefore(DateTime.now()),
                                  )),
                            ],
                          ),
                        ),

                        // Total
                        Text.rich(TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            children: [
                              const TextSpan(
                                  text: 'Total ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text:
                                    utilsServices.priceToCurrency(order.total),
                              )
                            ])),

                        // BTN Pagamento
                        Visibility(
                          visible: order.status == 'pending_payment' && !order.isOverDue,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return PaymentDialog(order: order);
                                    });
                              },
                              icon: const Icon(Icons.pix),
                              label: const Text('Ver QR Code Pix')),
                        )
                      ],
              );
            },
          )),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    required this.utilsServices,
    required this.orderItem,
  });

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(utilsServices.priceToCurrency(orderItem.totalPrice()))
        ],
      ),
    );
  }
}
