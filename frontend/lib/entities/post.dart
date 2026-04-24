import 'user.dart';
import 'post_type.dart';
import 'vote_option.dart';

class Post {
  final String id;
  final User author;
  final String content;
  final DateTime createdAt;
  final PostType type;
  final String? imageUrl;
  final String? videoUrl;
  int likeCount;
  int dislikeCount;
  List<VoteOption>? voteOptions;
  Set<String> likedByUsers;
  Set<String> dislikedByUsers;
  Map<String, String>? userVotes; // userId -> optionId

  Post({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    this.type = PostType.regular,
    this.imageUrl,
    this.videoUrl,
    this.likeCount = 0,
    this.dislikeCount = 0,
    this.voteOptions,
    Set<String>? likedByUsers,
    Set<String>? dislikedByUsers,
    Map<String, String>? userVotes,
  })  : likedByUsers = likedByUsers ?? {},
        dislikedByUsers = dislikedByUsers ?? {},
        userVotes = userVotes ?? {};

  bool isLikedBy(String userId) => likedByUsers.contains(userId);
  bool isDislikedBy(String userId) => dislikedByUsers.contains(userId);
  String? getVoteByUser(String userId) => userVotes?[userId];
}
