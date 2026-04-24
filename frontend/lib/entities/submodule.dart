import 'submodule_type.dart';

class Submodule {
  final String id;
  final String title;
  final String content;
  final SubmoduleType type;
  final String? videoUrl;
  final String? imageUrl;
  final int order;
  bool isCompleted;

  Submodule({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    this.videoUrl,
    this.imageUrl,
    required this.order,
    this.isCompleted = false,
  });
}
