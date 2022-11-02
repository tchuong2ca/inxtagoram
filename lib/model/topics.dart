import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Topics{
  String? key;
  String? name;
  List<dynamic>? collection;
  bool? isSelect = false;


  Topics({this.key, this.name, this.collection, this.isSelect});

   Topics.fromJson(Map<String, dynamic> json) {
     this.key = json["key"];
     this.name = json["name"];
     this.collection = json["collection"];
this.isSelect=json["isSelect"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> listData = new Map<String, dynamic>();
    listData["key"] = this.key;
    listData["name"] = this.name;
    listData["collection"] = this.collection;
    listData["isSelect"] = this.isSelect;
    return listData;
  }
}