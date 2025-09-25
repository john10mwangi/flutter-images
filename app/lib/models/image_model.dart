// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ImageResponse welcomeFromJson(String str) => ImageResponse.fromJson(json.decode(str));

String welcomeToJson(ImageResponse data) => json.encode(data.toJson());

class ImageResponse {
    final int? total;
    final int? totalHits;
    final List<Hit>? hits;

    ImageResponse({
        this.total,
        this.totalHits,
        this.hits,
    });

    factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        total: json["total"],
        totalHits: json["totalHits"],
        hits: json["hits"] == null ? [] : List<Hit>.from(json["hits"]!.map((x) => Hit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "totalHits": totalHits,
        "hits": hits == null ? [] : List<dynamic>.from(hits!.map((x) => x.toJson())),
    };
}

class Hit {
    final int? id;
    final String? pageUrl;
    final String? type;
    final String? tags;
    final String? previewUrl;
    final int? previewWidth;
    final int? previewHeight;
    final String? webformatUrl;
    final int? webformatWidth;
    final int? webformatHeight;
    final String? largeImageUrl;
    final int? imageWidth;
    final int? imageHeight;
    final int? imageSize;
    final int? views;
    final int? downloads;
    final int? collections;
    final int? likes;
    final int? comments;
    final int? userId;
    final String? user;
    final String? userImageUrl;
    final bool? noAiTraining;
    final bool? isAiGenerated;
    final bool? isGRated;
    final bool? isLowQuality;
    final String? userUrl;

    Hit({
        this.id,
        this.pageUrl,
        this.type,
        this.tags,
        this.previewUrl,
        this.previewWidth,
        this.previewHeight,
        this.webformatUrl,
        this.webformatWidth,
        this.webformatHeight,
        this.largeImageUrl,
        this.imageWidth,
        this.imageHeight,
        this.imageSize,
        this.views,
        this.downloads,
        this.collections,
        this.likes,
        this.comments,
        this.userId,
        this.user,
        this.userImageUrl,
        this.noAiTraining,
        this.isAiGenerated,
        this.isGRated,
        this.isLowQuality,
        this.userUrl,
    });

    factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        id: json["id"],
        pageUrl: json["pageURL"],
        type: json["type"],
        tags: json["tags"],
        previewUrl: json["previewURL"],
        previewWidth: json["previewWidth"],
        previewHeight: json["previewHeight"],
        webformatUrl: json["webformatURL"],
        webformatWidth: json["webformatWidth"],
        webformatHeight: json["webformatHeight"],
        largeImageUrl: json["largeImageURL"],
        imageWidth: json["imageWidth"],
        imageHeight: json["imageHeight"],
        imageSize: json["imageSize"],
        views: json["views"],
        downloads: json["downloads"],
        collections: json["collections"],
        likes: json["likes"],
        comments: json["comments"],
        userId: json["user_id"],
        user: json["user"],
        userImageUrl: json["userImageURL"],
        noAiTraining: json["noAiTraining"],
        isAiGenerated: json["isAiGenerated"],
        isGRated: json["isGRated"],
        isLowQuality: json["isLowQuality"],
        userUrl: json["userURL"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pageURL": pageUrl,
        "type": type,
        "tags": tags,
        "previewURL": previewUrl,
        "previewWidth": previewWidth,
        "previewHeight": previewHeight,
        "webformatURL": webformatUrl,
        "webformatWidth": webformatWidth,
        "webformatHeight": webformatHeight,
        "largeImageURL": largeImageUrl,
        "imageWidth": imageWidth,
        "imageHeight": imageHeight,
        "imageSize": imageSize,
        "views": views,
        "downloads": downloads,
        "collections": collections,
        "likes": likes,
        "comments": comments,
        "user_id": userId,
        "user": user,
        "userImageURL": userImageUrl,
        "noAiTraining": noAiTraining,
        "isAiGenerated": isAiGenerated,
        "isGRated": isGRated,
        "isLowQuality": isLowQuality,
        "userURL": userUrl,
    };
}
