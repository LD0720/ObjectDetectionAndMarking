// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhotoModelImpl _$$PhotoModelImplFromJson(Map<String, dynamic> json) =>
    _$PhotoModelImpl(
      imageId: json['imageId'] as String,
      imagePath: json['imagePath'] as String,
      upload: json['upload'] as bool? ?? false,
    );

Map<String, dynamic> _$$PhotoModelImplToJson(_$PhotoModelImpl instance) =>
    <String, dynamic>{
      'imageId': instance.imageId,
      'imagePath': instance.imagePath,
      'upload': instance.upload,
    };
