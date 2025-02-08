import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_project/ui/utils/reusable_functions.dart';

class AppProductCard extends StatefulWidget {
  final String image;
  final String category;
  final String name;
  final String price;

  const AppProductCard(
      {super.key,
      required this.image,
      required this.category,
      required this.name,
      required this.price});

  @override
  State<AppProductCard> createState() => _AppProductCardState();
}

class _AppProductCardState extends State<AppProductCard> {
  @override
  Widget build(BuildContext context) {
    bool selected = true;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.6,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 0.6,
                offset: Offset(1, 1),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.23,
                      decoration: BoxDecoration(
                        image:
                            DecorationImage(image: NetworkImage(widget.image)),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: GestureDetector(
                        onTap: null,
                        child: const Icon(
                          CommunityMaterialIcons.heart_box_outline,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: ReUsableFunctions.appStyle(
                            24, Colors.black, FontWeight.bold),
                      ),
                      Text(
                        widget.category,
                        style: ReUsableFunctions.appStyle(
                            18, Colors.grey, FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: ReUsableFunctions.appStyle(
                            16, Colors.black, FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            'Colors',
                            style: ReUsableFunctions.appStyle(
                                16, Colors.grey, FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            child: ChoiceChip(
                              label: const Text(''),
                              selected: selected,
                              visualDensity: VisualDensity.compact,
                              selectedColor: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
