import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_project/ui/screens/re_usable_widgets/app_product_card.dart';

import '../../core/models/product_model.dart';
import '../../core/providers/product/product_provider.dart';
import '../app_routes/route_path.dart';
import '../utils/reusable_functions.dart';

class DashboardContainer extends ConsumerStatefulWidget {
  const DashboardContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardContainerState();
}

class _DashboardContainerState extends ConsumerState<DashboardContainer>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  List<String> categoryList = [];
  int productIndex = 0;

  void _onScroll() {
    if (_scrollController.hasClients) {
      int newIndex = (_scrollController.offset / 260).round();
      if (newIndex != productIndex) {
        setState(() {
          productIndex = newIndex;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProductList(
      String category, Future<List<ProductModel>> productsFuture) {
    return FutureBuilder<List<ProductModel>>(
      future: productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        final products = snapshot.data!;
        final filteredProducts =
            products.where((prod) => prod.category == category).toList();
        return SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filteredProducts.map((product) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 2,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (context.mounted) {
                            context.push(RoutePath.productDetailsView,
                                extra: {'prodId': product.id.toString()});
                          }
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: AppProductCard(
                            image: product.thumbnail ?? '',
                            category: product.category ?? 'Unknown',
                            name: product.title ?? 'No title',
                            price: product.price?.toString() ?? '0',
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              _buildLatestShoesSection(),
              _buildProductCarousel(filteredProducts, productIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLatestShoesSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'More Images',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Row(
              children: [
                Text('See All'),
                Icon(Icons.arrow_forward_ios_rounded, size: 14)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCarousel(List<ProductModel> products, int prodIndex) {
    if (products.isEmpty || productIndex >= products.length) {
      return const SizedBox();
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.all(10),
      color: Colors.grey,
      child: ListView.builder(
        itemCount: products[prodIndex].images?.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 0.8,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.28,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: '${products[prodIndex].images?[index]}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsFuture = ref.watch(productsProvider.future);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: FutureBuilder<List<ProductModel>>(
            future: productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LinearProgressIndicator();
              }
              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return const Text("No categories available");
              }

              final categories = snapshot.data!
                  .map((product) => product.category ?? "Unknown")
                  .toSet()
                  .toList();

              if (categoryList.length != categories.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    categoryList = categories;
                    _tabController.dispose();
                    _tabController =
                        TabController(length: categoryList.length, vsync: this);
                  });
                });
              }

              return TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.orange,
                labelColor: Colors.blue,
                labelStyle: ReUsableFunctions.appStyle(
                    18, Colors.black, FontWeight.bold),
                unselectedLabelColor: Colors.black,
                isScrollable: true,
                tabs: categoryList
                    .map((category) => Tab(text: category))
                    .toList(),
              );
            },
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categoryList
            .map((category) => _buildProductList(category, productsFuture))
            .toList(),
      ),
    );
  }
}
