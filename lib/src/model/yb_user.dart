// To parse this JSON data, do
//
//     final ybUser = ybUserFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

YbUser ybUserFromJson(String str) => YbUser.fromJson(json.decode(str));

String ybUserToJson(YbUser data) => json.encode(data.toJson());

class YbUser {
  final String? uid;
  final String? username;
  final String? email;
  final String? nationality;
  final String? profile;
  final List<dynamic> peek;
  final List<dynamic> bookmark;
  final DateTime? createAt;
  final DateTime? updateAt;

  const YbUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.nationality,
    required this.profile,
    required this.peek,
    required this.bookmark,
    required this.createAt,
    required this.updateAt,
  });

  YbUser copyWith({
    String? uid,
    String? username,
    String? email,
    String? nationality,
    String? profile,
    List<dynamic>? peek,
    List<dynamic>? bookmark,
    DateTime? createAt,
    DateTime? updateAt,
  }) =>
      YbUser(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        email: email ?? this.email,
        nationality: nationality ?? this.nationality,
        profile: profile ?? this.profile,
        peek: peek ?? this.peek,
        bookmark: bookmark ?? this.bookmark,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );

  factory YbUser.fromJson(Map<String, dynamic> json) => YbUser(
        uid: json["uid"] == null ? "" : json["uid"] as String,
        username: json["username"] == null ? "" : json["username"] as String,
        email: json["email"] == null ? "" : json["email"] as String,
        nationality:
            json["nationality"] == null ? "" : json["nationality"] as String,
        profile: json["profile"] == null ? "" : json["profile"] as String,
        peek: List<dynamic>.from(json["peek"].map((x) => x)),
        bookmark: List<dynamic>.from(json["bookmark"].map((x) => x)),
        createAt: json["createAt"] == null ? null : json["username"],
        updateAt: json["updateAt"] == null ? null : json["username"],
      );

  static YbUser formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    var createAt = (snapshot['createAt'] as Timestamp).toDate();
    var updateAt = (snapshot['updateAt'] as Timestamp).toDate();

    return YbUser(
      uid: snapshot['uid'] ?? '',
      username: snapshot['username'] ?? '',
      email: snapshot['email'] ?? '',
      nationality: snapshot['nationality'] ?? '',
      profile: snapshot['profile'] ?? '',
      peek: snapshot['peek'] ?? [],
      bookmark: snapshot['bookmark'] ?? [],
      createAt: createAt,
      updateAt: updateAt,
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "nationality": nationality,
        "profile": profile,
        "peek": List<dynamic>.from(peek.map((x) => x)),
        "bookmark": List<dynamic>.from(bookmark.map((x) => x)),
        "createAt": createAt,
        "updateAt": updateAt,
      };
}
