import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class News {
  String? name;
  String? content;
  String? hour;
  String? image;
  String? like;
  String? comment;

  News(this.name, this.content, this.hour, this.image, this.like, this.comment);

   News.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.content = json["content"];
    this.hour = json["hour"];
    this.image = json["image"];
    this.like = json["like"];
    this.comment = json["comment"];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> listData = new Map<String, dynamic>();
    listData["name"] = this.name;
    listData["content"] = this.content;
    listData["hour"] = this.hour;
    listData["image"] = this.image;
    listData["like"] = this.like;
    listData["comment"] = this.comment;
    return listData;
  }
}