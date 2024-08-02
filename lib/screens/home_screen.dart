import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/models/product_model.dart';
import '../providers/product_provider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsFuture = ref.watch(productsProvider);
    // List<ProductModel> cartProducts = ref.watch(cartNotifierProvider).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: productsFuture.when(
          data: (dynamicList) {
            var products = dynamicList
                .map((product) => ProductModel.fromJson(product))
                .toList();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('${products[index].title}'),
                      Text('${products[index].description}'),
                      Text('${products[index].price}'),
                    ],
                  ),
                );
              }),
            );
          },
          error: ((error, stackTrace) => Text(error.toString())),
          loading: () {
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
