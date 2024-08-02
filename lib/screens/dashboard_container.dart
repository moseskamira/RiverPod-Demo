import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_project/models/product_model.dart';
import '../app_routes/route_path.dart';
import '../providers/product_provider.dart';

class DashboardContainer extends ConsumerStatefulWidget {
  const DashboardContainer({super.key});

  @override
  ConsumerState<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends ConsumerState<DashboardContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsFuture = ref.watch(productsProvider);
    return Container(
      color: Colors.grey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Column(
                children: [Text('My Reserved Section')],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: productsFuture.when(
                    data: (dynamicList) {
                      var products = dynamicList
                          .map((product) => ProductModel.fromJson(product))
                          .toList();
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                context.push(RoutePath.productDetailsView,
                                    extra: {
                                      'prodId': products[index].id.toString()
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ListTile(
                                      title: Text('${products[index].title}'),
                                      subtitle: Text(
                                          '${products[index].description}'),
                                      leading: CircleAvatar(
                                        child: Image.network(
                                          products[index].images![0],
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    error: ((error, stackTrace) => Text(error.toString())),
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
