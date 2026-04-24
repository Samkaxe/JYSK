import '../entities/user.dart';
import '../entities/user_role.dart';
import '../entities/post.dart';
import '../entities/post_type.dart';
import '../entities/vote_option.dart';

class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  // Current logged-in user (you can change this for testing)
  User currentUser = User(
    id: '1',
    name: 'John Doe',
    profilePicture: null,
    role: UserRole.employee,
  );

  // Mock users
  final List<User> users = [
    User(
      id: '1',
      name: 'John Doe',
      profilePicture: null,
      role: UserRole.employee,
    ),
    User(
      id: '2',
      name: 'Sarah Admin',
      profilePicture: null,
      role: UserRole.admin,
    ),
    User(
      id: '3',
      name: 'Mike Leader',
      profilePicture: null,
      role: UserRole.teamLeader,
    ),
    User(
      id: '4',
      name: 'Emma Worker',
      profilePicture: null,
      role: UserRole.employee,
    ),
  ];

  // Mock posts
  final List<Post> posts = [
    Post(
      id: '1',
      author: User(
        id: '2',
        name: 'Sarah Admin',
        profilePicture: null,
        role: UserRole.admin,
      ),
      content: 'Welcome to JYSK Safety App! Please make sure to follow all safety guidelines.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      type: PostType.regular,
      likeCount: 15,
      dislikeCount: 1,
    ),
    Post(
      id: '2',
      author: User(
        id: '3',
        name: 'Mike Leader',
        profilePicture: null,
        role: UserRole.teamLeader,
      ),
      content: 'Team meeting scheduled for tomorrow at 10 AM. Attendance is mandatory.',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      type: PostType.regular,
      likeCount: 8,
      dislikeCount: 0,
    ),
    Post(
      id: '3',
      author: User(
        id: '2',
        name: 'Sarah Admin',
        profilePicture: null,
        role: UserRole.admin,
      ),
      content: 'What time works best for the safety training session?',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      type: PostType.vote,
      likeCount: 5,
      dislikeCount: 0,
      voteOptions: [
        VoteOption(id: 'v1', text: 'Morning (9 AM - 12 PM)', voteCount: 12),
        VoteOption(id: 'v2', text: 'Afternoon (1 PM - 4 PM)', voteCount: 8),
        VoteOption(id: 'v3', text: 'Evening (5 PM - 7 PM)', voteCount: 3),
      ],
    ),
    Post(
      id: '4',
      author: User(
        id: '3',
        name: 'Mike Leader',
        profilePicture: null,
        role: UserRole.teamLeader,
      ),
      content: 'Great work everyone this week! Keep up the excellent safety records.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      type: PostType.regular,
      likeCount: 22,
      dislikeCount: 0,
    ),
    Post(
      id: '5',
      author: User(
        id: '2',
        name: 'Sarah Admin',
        profilePicture: null,
        role: UserRole.admin,
      ),
      content: 'Which safety topic should we focus on next month?',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      type: PostType.vote,
      likeCount: 10,
      dislikeCount: 1,
      voteOptions: [
        VoteOption(id: 'v4', text: 'Fire Safety', voteCount: 15),
        VoteOption(id: 'v5', text: 'Forklift Operations', voteCount: 18),
        VoteOption(id: 'v6', text: 'First Aid', voteCount: 7),
        VoteOption(id: 'v7', text: 'Ergonomics', voteCount: 5),
      ],
    ),
  ];

  List<Post> getPosts() {
    posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return posts;
  }

  void likePost(String postId, String userId) {
    final post = posts.firstWhere((p) => p.id == postId);
    if (post.isDislikedBy(userId)) {
      post.dislikedByUsers.remove(userId);
      post.dislikeCount--;
    }
    if (post.isLikedBy(userId)) {
      post.likedByUsers.remove(userId);
      post.likeCount--;
    } else {
      post.likedByUsers.add(userId);
      post.likeCount++;
    }
  }

  void dislikePost(String postId, String userId) {
    final post = posts.firstWhere((p) => p.id == postId);
    if (post.isLikedBy(userId)) {
      post.likedByUsers.remove(userId);
      post.likeCount--;
    }
    if (post.isDislikedBy(userId)) {
      post.dislikedByUsers.remove(userId);
      post.dislikeCount--;
    } else {
      post.dislikedByUsers.add(userId);
      post.dislikeCount++;
    }
  }

  void voteOnOption(String postId, String userId, String optionId) {
    final post = posts.firstWhere((p) => p.id == postId);
    if (post.type != PostType.vote || post.voteOptions == null) return;

    // Remove previous vote if exists
    final previousVote = post.userVotes?[userId];
    if (previousVote != null) {
      final previousOption = post.voteOptions!.firstWhere((o) => o.id == previousVote);
      previousOption.voteCount--;
    }

    // Add new vote
    post.userVotes![userId] = optionId;
    final option = post.voteOptions!.firstWhere((o) => o.id == optionId);
    option.voteCount++;
  }
}
