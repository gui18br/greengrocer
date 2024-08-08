import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../../commom_widgets/quantity_widget.dart';

class CartTitle extends StatefulWidget {
  final CartItemModel cartItem;
  final Function(CartItemModel) remove;

  const CartTitle({
    Key? key,
    required this.cartItem,
    required this.remove,
  }) : super(key: key);

  @override
  State<CartTitle> createState() => _CartTitleState();
}

class _CartTitleState extends State<CartTitle> {
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          //imagem
          leading: Image.asset(
            widget.cartItem.item.imgUrl,
            height: 60,
            width: 60,
          ),

          //titulo
          title: Text(
            widget.cartItem.item.itemName,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),

          //total
          subtitle: Text(
            utilsServices.priceToCurrency(widget.cartItem.totalPrice()),
            style: TextStyle(
              color: CustomColors.customSwatchColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          //quantidade
          trailing: QuantityWidget(
              suffixText: widget.cartItem.item.unit,
              value: widget.cartItem.quantity,
              result: (quantity) {

                setState(() {
                  widget.cartItem.quantity = quantity;
                  if (quantity == 0) {
                    widget.remove(widget.cartItem);
                  }
                });

              },
              isRemovable: true),
        ));
  }
}
