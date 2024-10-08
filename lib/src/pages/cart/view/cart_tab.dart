import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/pages/cart/view/components/cart_title.dart';
import 'package:greengrocer/src/pages/commom_widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_service.dart';
import 'package:greengrocer/src/config/app_data.dart' as appData;

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  double cartTotalPrice() {
    // double total = 0;
    // for (var item in appData.cartItems) {
    //   total += item.totalPrice();
    // }

    // return total;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Carrinho'),
        ),
        body: Column(
          children: [
            Expanded(child: GetBuilder<CartController>(
              builder: (controller) {
                if (controller.cartItems.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 40,
                        color: CustomColors.customSwatchColor,
                      ),
                      const Text('Não há itens no carrinho'),
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) {
                    return CartTitle(
                      cartItem: controller.cartItems[index],
                    );
                  },
                );
              },
            )),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3,
                      spreadRadius: 2,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Total geral',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  GetBuilder<CartController>(
                    builder: (controller) {
                      return Text(
                        utilsServices.priceToCurrency(
                          controller.cartTotalPrice(),
                        ),
                        style: TextStyle(
                            fontSize: 23,
                            color: CustomColors.customSwatchColor,
                            fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                      onPressed: () async {
                        bool? result = await showOrderConfirmation();

                        if (result ?? false) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return PaymentDialog(
                                  order: appData.orders.first,
                                );
                              });
                        } else {
                          utilsServices.showToast(
                              message: 'Pedido não confirmado', isError: true);
                        }
                      },
                      child: const Text(
                        'Concluir pedido',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            )
          ],
        );
      },
    );
  }
}
