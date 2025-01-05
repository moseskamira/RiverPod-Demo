import 'package:json_annotation/json_annotation.dart';

part 'dimension_model.g.dart';

@JsonSerializable()
class Dimension {
  double? width;
  double? height;
  double? depth;

  Dimension({this.width, this.height, this.depth});

  factory Dimension.fromJson(Map<String, dynamic> json) =>
      _$DimensionFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionToJson(this);
}
