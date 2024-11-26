import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class PhotoModel with _$PhotoModel {
  const factory PhotoModel({
    required String imageId,
    required String imagePath,
    @Default(false) bool upload,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(dynamic json) => _$PhotoModelFromJson(json);
}
