import 'package:flutter/material.dart';
import 'package:hello_world/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/order_model.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;

  PaymentDialog({
    Key? key,
    required this.order,
  }) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Conteudo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Pagamento com pix',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // QR Code
                  QrImage(
                    data: 'q1w2e3r4t54y6u7i8o9',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),

                  // Vencimento
                  Text(
                      'Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)}',
                      style: const TextStyle(
                        fontSize: 12,
                      )),

                  // Total
                  Text(
                    'Total: ${utilsServices.priceToCurrency(order.total)}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Copia e cola
                  OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.green,
                          )),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.copy,
                        size: 15,
                      ),
                      label: const Text(
                        'Copiar código Pix',
                        style: TextStyle(fontSize: 13),
                      ))
                ],
              ),
            ),

            Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ))
          ],
        ));
  }
}
