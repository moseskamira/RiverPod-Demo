import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_product_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class LocalProductModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? category;

  @HiveField(4)
  double? price;

  @HiveField(5)
  dynamic discountPercentage;

  @HiveField(6)
  double? rating;

  @HiveField(7)
  int? stock;

  @HiveField(8)
  List<String>? tags;

  @HiveField(9)
  String? brand;

  @HiveField(10)
  String? sku;

  @HiveField(11)
  int? weight;

  @HiveField(12)
  String? warrantyInformation;

  @HiveField(13)
  String? shippingInformation;

  @HiveField(14)
  String? availabilityStatus;

  @HiveField(15)
  String? returnPolicy;

  @HiveField(16)
  int? minimumOrderQuantity;

  @HiveField(17)
  String? thumbnail;

  @HiveField(18)
  List<String>? images;

  LocalProductModel(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.tags,
      this.brand,
      this.sku,
      this.weight,
      this.warrantyInformation,
      this.shippingInformation,
      this.availabilityStatus,
      this.returnPolicy,
      this.minimumOrderQuantity,
      this.thumbnail,
      this.images});

  factory LocalProductModel.fromJson(Map<String, dynamic> json) =>
      _$LocalProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalProductModelToJson(this);
}
