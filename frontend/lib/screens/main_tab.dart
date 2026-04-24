import 'package:flutter/material.dart';
import '../entities/post.dart';
import '../entities/post_type.dart';
import '../services/mock_data_service.dart';
import '../widgets/post_card.dart';
import '../widgets/vote_post_card.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  final MockDataService _dataService = MockDataService();
  late List<Post> _posts;

  @override
  void initState() {
    super.initState();
    _posts = _dataService.getPosts();
  }

  void _handleLike(String postId) {
    setState(() {
      _dataService.likePost(postId, _dataService.currentUser.id);
    });
  }

  void _handleDislike(String postId) {
    setState(() {
      _dataService.dislikePost(postId, _dataService.currentUser.id);
    });
  }

  void _handleVote(String postId, String optionId) {
    setState(() {
      _dataService.voteOnOption(postId, _dataService.currentUser.id, optionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JYSK Feed',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0051A5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _posts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.feed_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No posts yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _posts = _dataService.getPosts();
                });
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];

                  if (post.type == PostType.vote) {
                    return VotePostCard(
                      key: ValueKey(post.id),
                      post: post,
                      currentUserId: _dataService.currentUser.id,
                      onVote: (optionId) => _handleVote(post.id, optionId),
                      onLike: () => _handleLike(post.id),
                      onDislike: () => _handleDislike(post.id),
                    );
                  } else {
                    return PostCard(
                      key: ValueKey(post.id),
                      post: post,
                      currentUserId: _dataService.currentUser.id,
                      onLike: () => _handleLike(post.id),
                      onDislike: () => _handleDislike(post.id),
                    );
                  }
                },
              ),
            ),
      floatingActionButton: _dataService.currentUser.canPost
          ? FloatingActionButton.extended(
              onPressed: () {
                // TODO: Navigate to create post screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Create post feature coming soon!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              backgroundColor: const Color(0xFF0051A5),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Create Post',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
