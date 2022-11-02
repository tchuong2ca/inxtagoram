import 'package:json_annotation/json_annotation.dart';

import 'discuss_child.dart';
import 'file_discuss.dart';

@JsonSerializable()
class DiscussData{
  String? id;
  String? courseId;
  String? courseDayId;
  String? username;
  String? fullName;
  String? role;
  String? content;
  int? totalLike;
  String? createDate;
  String? createUser;
  String? avatarFull;
  bool? yourself;
  bool? pinned;
  bool? liked;
  String? reactionId;
  String? createDateView;
  int? depthLevel;
  List<DiscussChild>? childItems;
  FileDiscuss? fileImage;
  FileDiscuss? fileAtt;
  String? parentId;
  DiscussData(
      {this.id,
        this.courseId,
        this.courseDayId,
        this.username,
        this.fullName,
        this.role,
        this.content,
        this.totalLike,
        this.createDate,
        this.createUser,
        this.avatarFull,
        this.yourself,
        this.pinned,
        this.liked,
        this.reactionId,
        this.createDateView,
        this.depthLevel,
        this.childItems,
        this.fileImage,
        this.fileAtt,
        this.parentId});

  DiscussData.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.courseId = json["courseId"];
    this.courseDayId = json["courseDayId"];
    this.parentId = json["parentId"];
    this.username = json["username"];
    this.fullName = json["fullName"];
    this.role = json["role"];
    this.content = json["content"];
    this.totalLike = json["totalLike"];
    this.createDate = json["createDate"];
    this.createUser = json["createUser"];
    this.avatarFull = json["avatarFull"];
    this.yourself = json["yourself"];
    this.pinned = json["pinned"];
    this.liked = json["liked"];
    this.reactionId = json["reactionId"];
    this.createDateView = json["createDateView"];
    this.depthLevel = json["depthLevel"];
    this.childItems = json["childItems"];
    this.fileImage = json["fileImage"];
    this.fileAtt = json["fileAtt"];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> listData = new Map<String, dynamic>();
    listData["id"] = this.id;
    listData["courseId"] = this.courseId;
    listData["courseDayId"] = this.courseDayId;
    listData["parentId"] = this.parentId;
    listData["username"] = this.username;
    listData["fullName"] = this.fullName;
    listData["role"] = this.role;
    listData["content"] =  this.content;
    listData["totalLike"] = this.totalLike;
    listData["createDate"] = this.createDate;
    listData["createUser"] = this.createUser;
    listData["avatarFull"] =  this.avatarFull;
    listData["yourself"] =  this.yourself;
    listData["pinned"] =  this.pinned;
    listData["liked"] =  this.liked;
    listData["reactionId"] =  this.reactionId;
    listData["createDateView"] =  this.createDateView;
    listData["depthLevel"] =  this.depthLevel;
    listData["childItems"] =  this.childItems;
    listData["fileImage"] = this.fileImage;
    listData["fileAtt"] = this.fileAtt;
    return listData;
  }
}