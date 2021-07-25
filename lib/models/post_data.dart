// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PostData postsdataFromJson(String str) => PostData.fromJson(json.decode(str));

String welcomeToJson(PostData data) => json.encode(data.toJson());

class PostData {
    PostData({
         this.data,
         this.links,
         this.meta,
    });

    List<Post> data;
    Links links;
    Meta meta;

    factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        data: List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
    };
}

class Post {
    Post({
         this.id,
         this.title,
         this.content,
         this.dateWritten,
         this.featuredImage,
         this.votesUp,
         this.votesDown,
         this.userId,
         this.categoryId,
         this.createdAt,
         this.updatedAt,
         this.user,
    });

    int id;
    String title;
    String content;
    String dateWritten;
    String featuredImage;
    int votesUp;
    int votesDown;
    int userId;
    int categoryId;
    String createdAt;
    String updatedAt;
    User user;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        dateWritten: json["date_written"],
        featuredImage: json["featured_image"],
        votesUp: json["votes_up"],
        votesDown: json["votes_down"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "date_written": dateWritten,
        "featured_image": featuredImage,
        "votes_up": votesUp,
        "votes_down": votesDown,
        "user_id": userId,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user.toJson(),
    };
}

class User {
    User({
         this.id,
         this.name,
         this.email,
         this.apiToken,
         this.emailVerifiedAt,
         this.avatar,
         this.createdAt,
         this.updatedAt,
    });

    int id;
    String name;
    String email;
    String apiToken;
    String emailVerifiedAt;
    String avatar;
    String createdAt;
    String updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        apiToken: json["api_token"],
        emailVerifiedAt: json["email_verified_at"],
        avatar: json["avatar"],
        createdAt: json["created_at"],
        updatedAt:json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "api_token": apiToken,
        "email_verified_at": emailVerifiedAt,
        "avatar": avatar,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class Links {
    Links({
        this.first,
         this.last,
        this.prev,
         this.next,
    });

    String first;
    String last;
    dynamic prev;
    String next;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
    };
}

class Meta {
    Meta({
         this.currentPage,
         this.from,
         this.lastPage,
        this.path,
         this.perPage,
         this.to,
         this.total,
    });

    int currentPage;
    int from;
    int lastPage;
    String path;
    String perPage;
    int to;
    int total;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
    };
}
