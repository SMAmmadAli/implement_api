import 'package:json_annotation/json_annotation.dart';
part 'home_screen_dto.g.dart';

@JsonSerializable()
class HomeScreenModel {
    @JsonKey(name: "userId")
    final int? userId;
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "title")
    final String? title;
    @JsonKey(name: "body")
    final String? body;

    HomeScreenModel({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    factory HomeScreenModel.fromJson(Map<String, dynamic> json) => _$HomeScreenModelFromJson(json);

    Map<String, dynamic> toJson() => _$HomeScreenModelToJson(this);
}
