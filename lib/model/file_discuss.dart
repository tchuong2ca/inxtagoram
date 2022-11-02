import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FileDiscuss{
  String? attId;
  String? courseId;
  String? courseDayId;
  String? courseDayDiscussId;
  String? fileName;
  String? contentType;
  String? link;
  String? type;
  String? createDate;
  String? createUser;
  String? updateDate;
  String? updateUser;

  FileDiscuss(
      {this.attId,
      this.courseId,
      this.courseDayId,
      this.courseDayDiscussId,
      this.fileName,
      this.contentType,
      this.link,
      this.type,
      this.createDate,
      this.createUser,
      this.updateDate,
      this.updateUser});
  FileDiscuss.fromJson(Map<String, dynamic> json) {
    this.attId = json["attId"];
    this.courseId = json["courseId"];
    this.courseDayId = json["courseDayId"];
    this.courseDayDiscussId = json["courseDayDiscussId"];
    this.fileName = json["fileName"];
    this.contentType = json["contentType"];
    this.link = json["link"];
    this.type = json["type"];
    this.createDate = json["createDate"];
    this.createUser = json["createUser"];
    this.updateDate = json["updateDate"];
    this.updateUser = json["updateUser"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> listData = new Map<String, dynamic>();
    listData["attId"] = this.attId;
    listData["courseId"] = this.courseId;
    listData["courseDayId"] = this.courseDayId;
    listData["courseDayDiscussId"] = this.courseDayDiscussId;
    listData["fileName"] = this.fileName;
    listData["contentType"] = this.contentType;
    listData["link"] = this.link;
    listData["type"] = this.type;
    listData["createDate"] = this.createDate;
    listData["createUser"] = this.createUser;
    listData["updateDate"] =  this.updateDate;
    listData["updateUser"] = this.updateUser;
    return listData;
  }
}