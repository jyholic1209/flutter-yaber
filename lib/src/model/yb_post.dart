// To parse this JSON data, do
//
//     final ybPost = ybPostFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

YbPost ybPostFromJson(String str) => YbPost.fromJson(json.decode(str));

String ybPostToJson(YbPost data) => json.encode(data.toJson());

class YbPost {
  final String uid;
  final String username;
  final String nationality;
  final String postId;
  final String description;
  final String profImage;
  final String link;
  final List<dynamic> postImage;
  final List<dynamic> like;
  final List<dynamic> dislike;
  final List<dynamic> bookmark;
  final String nation;
  final String city;
  final DateTime publishedAt;

  YbPost({
    required this.uid,
    required this.username,
    required this.nationality,
    required this.postId,
    required this.description,
    required this.profImage,
    required this.link,
    required this.postImage,
    required this.like,
    required this.dislike,
    required this.bookmark,
    required this.nation,
    required this.city,
    required this.publishedAt,
  });

  YbPost copyWith({
    String? uid, // 작성자 uid
    String? username, // 작성자 이름
    String? nationality, // 작성자 국적
    String? postId, // 포스트 id
    String? description, // 포스트 contents
    String? profImage, // 프로필 사진
    String? link, // 사용자 링크
    List<dynamic>? postImage, // 포스트 이미지 리스트 (3개까지 넣을 예정)
    List<dynamic>? like, // 좋아요 한 사용자 uid 리스트
    List<dynamic>? dislike, // 싫어요 한 사용자 uid 리스트
    List<dynamic>? bookmark, // 이 포스트를 북마크한 사용자 uid
    String? nation, // 포스팅 작성 여행지 나라
    String? city, // 포스팅 작성  여행지 도시
    DateTime? publishedAt, // 포스팅 일자
  }) =>
      YbPost(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        nationality: nationality ?? this.nationality,
        postId: postId ?? this.postId,
        description: description ?? this.description,
        profImage: profImage ?? this.profImage,
        link: link ?? this.link,
        postImage: postImage ?? this.postImage,
        like: like ?? this.like,
        dislike: dislike ?? this.dislike,
        bookmark: bookmark ?? this.bookmark,
        nation: nation ?? this.nation,
        city: city ?? this.city,
        publishedAt: publishedAt ?? this.publishedAt,
      );

  factory YbPost.fromJson(Map<String, dynamic> json) => YbPost(
        uid: json["uid"] ?? '',
        username: json["username"] ?? '',
        nationality: json["nationality"] ?? '',
        postId: json["postId"] ?? '',
        description: json["description"] ?? '',
        profImage: json["profImage"] ?? '',
        link: json["link"] ?? '',
        postImage: List<dynamic>.from(json["postImage"].map((x) => x)),
        like: List<dynamic>.from(json["like"].map((x) => x)),
        dislike: List<dynamic>.from(json["dislike"].map((x) => x)),
        bookmark: List<dynamic>.from(json["bookmark"].map((x) => x)),
        nation: json["nation"] ?? '',
        city: json["city"] ?? '',
        publishedAt: json["publishedAt"],
      );

  static YbPost fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    var publishedAt = (snap['publishedAt'] as Timestamp).toDate();
    return YbPost(
        uid: snap['uid'] ?? '',
        username: snap['username'] ?? '',
        nationality: snap['nationality'] ?? '',
        postId: snap['postId'] ?? '',
        description: snap['description'] ?? '',
        profImage: snap['profImage'] ?? '',
        link: snap['link'] ?? '',
        postImage: snap['postImage'] ?? [],
        like: snap['like'] ?? [],
        dislike: snap['dislike'] ?? [],
        bookmark: snap['bookmark'] ?? [],
        nation: snap['nation'] ?? '',
        city: snap['city'] ?? '',
        publishedAt: publishedAt);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "nationality": nationality,
        "postId": postId,
        "description": description,
        "profImage": profImage,
        "link": link,
        "postImage": List<dynamic>.from(postImage.map((x) => x)),
        "like": List<dynamic>.from(like.map((x) => x)),
        "dislike": List<dynamic>.from(dislike.map((x) => x)),
        "bookmark": List<dynamic>.from(bookmark.map((x) => x)),
        "nation": nation,
        "city": city,
        "publishedAt": publishedAt,
      };
}
