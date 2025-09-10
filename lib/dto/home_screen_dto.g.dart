// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeScreenModel _$HomeScreenModelFromJson(Map<String, dynamic> json) =>
    HomeScreenModel(
      userId: (json['userId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$HomeScreenModelToJson(HomeScreenModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
