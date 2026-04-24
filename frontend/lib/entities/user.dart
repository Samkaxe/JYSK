import 'user_role.dart';

class User {
  final String id;
  final String name;
  final String? profilePicture;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    this.profilePicture,
    required this.role,
  });

  bool get canPost => role == UserRole.admin || role == UserRole.teamLeader;
}
