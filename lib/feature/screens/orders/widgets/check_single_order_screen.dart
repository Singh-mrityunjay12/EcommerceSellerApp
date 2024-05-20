import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../shop/model/cart_item_model.dart';
import '../../../shop/model/order_model.dart';

class CheckSingleOrderScreen extends StatelessWidget {
  const CheckSingleOrderScreen(
      {super.key, required this.cartItemModel, required this.orderModel});

  final CartItemModel cartItemModel;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAppBar(
        title: Text(
          "Ordered Item by User",
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
                shrinkWrap: true,
                itemCount: orderModel.items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 260, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          orderModel.items[index].image!,
                          height: 140,
                        ),
                        Text(orderModel.items[index].title),
                        Text('${orderModel.items[index].price}'),
                        Text('${orderModel.items[index].brandName}')
                      ],
                    ),
                  );
                }),
            Text(' Total Amount: ${orderModel.totalAmount} Rs'),
            Text(' User Id: ${orderModel.userId}'),
          ],
        ),
      ),
    );
  }
}
