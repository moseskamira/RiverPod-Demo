import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_project/models/product_model.dart';
import 'package:riverpod_project/providers/product/product_detail_provider.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final String id;

  const ProductDetailPage(this.id, {super.key});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.productDetails),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: ref.watch(productDetailProvider(widget.id).future),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData) {
                    var productModel = snapshot.data as ProductModel;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.network(
                            '${productModel.thumbnail}',
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, st) {
                              return Container(
                                color: Colors.grey,
                                width: 100,
                                height: 100,
                                child: const Icon(Icons.error),
                              );
                            },
                            repeat: ImageRepeat.repeat,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title: ',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Flexible(
                                  child: Text(
                                '${productModel.title}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description: ',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Flexible(
                                child: Text(
                                  '${productModel.description}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Category: ',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Flexible(
                                  child: Text(
                                '${productModel.category}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price: ',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Flexible(
                                  child: Text(
                                '${productModel.price}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Stock: ',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Flexible(
                                  child: Text(
                                '${productModel.stock}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Brand: ',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Flexible(
                                  child: Text(
                                '${productModel.brand}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weight: ',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Flexible(
                                  child: Text(
                                '${productModel.weight}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    throw Exception('');
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
