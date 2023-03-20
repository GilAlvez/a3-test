class Repository {
  final int id;
  final String name;
  final String description;
  final String url;
  final int stars;
  final String language;
  final String createdAt;

  Repository({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.stars,
    required this.language,
    required this.createdAt,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      url: json['html_url'],
      stars: json['stargazers_count'],
      language: json['language'] ?? 'Unknown',
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'html_url': url,
      'stargazers_count': stars,
      'language': language,
      'created_at': createdAt,
    };
  }
}
