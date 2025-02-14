import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_project/core/providers/product/product_index_provider.dart';
import 'package:riverpod_project/ui/utils/reusable_functions.dart';

import '../../core/providers/product/product_detail_provider.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final String id;

  const ProductDetailPage(this.id, {super.key});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  late PageController _pageController;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    final initialIndex = ref.read(productIndexProvider).pageIndex;
    _pageController = PageController(initialPage: initialIndex);
  }

  void isSelectedFunc(int ind, List<dynamic> list, bool sel) {
    for (int i = 0; i < list.length; i++) {
      if (i == ind) {
        list[i]['selected'] = sel;
        setState(() {});
      } else {
        isSelected = false;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productFuture = ref.watch(productDetailProvider(widget.id).future);
    final imageIndex = ref.watch(productIndexProvider).pageIndex;
    final List<dynamic> sizeList = [
      {'size': '20', 'selected': false},
      {'size': '30', 'selected': false},
      {'size': '40', 'selected': false},
      {'size': '50', 'selected': false}
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.productDetails),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: productFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No product found'));
          }
          final product = snapshot.data!;
          final imagesList = product.images ?? [];

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                title: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(Icons.close)),
                      const Icon(Icons.more_horiz),
                    ],
                  ),
                ),
                pinned: true,
                floating: true,
                expandedHeight: MediaQuery.sizeOf(context).height,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        width: MediaQuery.sizeOf(context).width,
                        child: PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: imagesList.length,
                          onPageChanged: (page) {
                            ref
                                .read(productIndexProvider.notifier)
                                .setPageIndex(page);
                          },
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  color: Colors.grey.shade300,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.39,
                                  width: MediaQuery.sizeOf(context).width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: CachedNetworkImage(
                                    imageUrl: imagesList[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: MediaQuery.sizeOf(context).height * 0.09,
                                  right: 10,
                                  child: const Icon(
                                    Icons.heart_broken_rounded,
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      imagesList.length,
                                      (dotIndex) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: CircleAvatar(
                                          radius: 4,
                                          backgroundColor:
                                              imageIndex == dotIndex
                                                  ? Colors.blue
                                                  : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: -30,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.645,
                            width: MediaQuery.sizeOf(context).width,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Text(
                                    '${product.title}',
                                    style: ReUsableFunctions.appStyle(
                                        28, Colors.black, FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${product.category}',
                                        style: ReUsableFunctions.appStyle(
                                            18, Colors.black, FontWeight.w400),
                                      ),
                                      const SizedBox(width: 5),
                                      RatingBar.builder(
                                          initialRating: 4,
                                          minRating: 1,
                                          maxRating: 5,
                                          itemCount: 5,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemSize: 18,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 1,
                                          ),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                size: 18,
                                                color: Colors.black,
                                              ),
                                          onRatingUpdate: (rating) {
                                            print('MYRATINGIS: $rating');
                                          }),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${product.price}',
                                        style: ReUsableFunctions.appStyle(
                                            18, Colors.black, FontWeight.w600),
                                      ),
                                      const Row(
                                        children: [
                                          Text('Colors'),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            radius: 7,
                                            backgroundColor: Colors.black,
                                          ),
                                          CircleAvatar(
                                            radius: 7,
                                            backgroundColor: Colors.orange,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Selected Size'),
                                          const SizedBox(width: 5),
                                          Text(
                                            'View Size Guide',
                                            style: ReUsableFunctions.appStyle(
                                                14,
                                                Colors.grey,
                                                FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                            itemCount: sizeList.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (ctx, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ChoiceChip(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      80,
                                                    ),
                                                  ),
                                                  disabledColor: Colors.white,
                                                  label: Text(
                                                    sizeList[index]['size'],
                                                  ),
                                                  selected: sizeList[index]
                                                      ['selected'],
                                                  onSelected: (newState) {
                                                    print(
                                                        'MYVALUEIS: ${newState}');
                                                    // isSelected = newState;
                                                    // setState(() {});
                                                    isSelectedFunc(index,
                                                        sizeList, newState);
                                                  },
                                                ),
                                              );
                                            }),
                                      ),
                                      const SizedBox(height: 10),
                                      const Divider(
                                        color: Colors.black,
                                        height: 1,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${product.description}',
                                        textAlign: TextAlign.justify,
                                        maxLines: 4,
                                        style: ReUsableFunctions.appStyle(
                                            12, Colors.black, FontWeight.w400),
                                      ),
                                      SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Container(
                                              height: 30,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.4,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Checkout',
                                                style:
                                                    ReUsableFunctions.appStyle(
                                                        12,
                                                        Colors.white,
                                                        FontWeight.w400),
                                              )),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
