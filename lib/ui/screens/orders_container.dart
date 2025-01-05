import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersContainer extends ConsumerStatefulWidget {
  const OrdersContainer({super.key});

  @override
  ConsumerState<OrdersContainer> createState() => _OrdersContainerState();
}

class _OrdersContainerState extends ConsumerState<OrdersContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Orders Page Here')),
      ),
    );
  }
}
