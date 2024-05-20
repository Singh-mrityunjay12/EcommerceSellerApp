import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../shop/model/order_model.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen(
      {super.key, required this.orderModel, required this.email});

  final OrderModel orderModel;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAppBar(
        title: Text('User Address'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: MRoundedContainer(
          padding: const EdgeInsets.all(MSizes.md),
          width: double.infinity,
          showBorder: true,
          // backgroundColor:
          //     ? MColors.primary.withOpacity(0.5)
          //     : Colors.transparent,
          // borderColor: selectedAddress
          //     ? Colors.transparent
          //     : dark
          //         ? MColors.darkerGrey
          //         : MColors.grey,
          margin: const EdgeInsets.only(bottom: MSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name:${orderModel.address!.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: MSizes.sm / 2,
              ),
              Text("Phone No:${orderModel.address!.phoneNumber}",
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(
                height: MSizes.sm / 2,
              ),
              Text(
                "Email:$email",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
              ),
              const SizedBox(
                height: MSizes.sm / 2,
              ),
              Text(
                "Local Address:${orderModel.address!.street}, ${orderModel.address!.city} ,${orderModel.address!.state} ,${orderModel.address!.country}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
              ),
              const SizedBox(
                height: MSizes.sm / 2,
              ),
              Text(
                "Postal Code:${orderModel.address!.postalCode}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
              ),
              const SizedBox(
                height: MSizes.sm / 2,
              ),
              Text(
                "Order Status:${orderModel.status.toString().substring(12)}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
              ),
              const SizedBox(
                height: MSizes.sm / 2,
              ),
              Text(
                "Order Date:${orderModel.orderDate}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
              ),
              const SizedBox(
                height: MSizes.sm / 2,
              ),
              Text(
                "Delivered Date:${orderModel.deliveryDate}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
              ),
              const SizedBox(
                height: MSizes.sm / 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
