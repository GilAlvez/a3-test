class Favorite {
  final int id;
  final String name;
  final String url;

  Favorite({
    required this.id,
    required this.name,
    required this.url,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}
