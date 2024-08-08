import 'package:hive_flutter/hive_flutter.dart';

part 'blog_model.g.dart';

@HiveType(typeId: 0)
class Blog extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(2)
  final String title;

  @HiveField(1)
  final String imageUrl;

  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}
