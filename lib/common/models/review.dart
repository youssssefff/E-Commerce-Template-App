class Review {
  final int id;
  final String content;
  final double rating;
  final String username;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.content,
    required this.rating,
    required this.username,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      content: json['content'],
      rating: json['rating'],
      username: json['username'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
