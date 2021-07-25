class Author {
  Author({
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

  factory Author.fromJson(Map<String,dynamic> parsedjson) => 
  Author(
        id: parsedjson["id"],
        name: parsedjson["name"],
        email: parsedjson["email"],
        apiToken: parsedjson["api_token"],
        emailVerifiedAt: parsedjson["email_verified_at"],
        avatar: parsedjson["avatar"],
        createdAt: parsedjson["created_at"],
        updatedAt: parsedjson["updated_at"],
      );

  
}
