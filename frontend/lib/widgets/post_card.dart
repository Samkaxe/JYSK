import 'package:flutter/material.dart';
import '../entities/post.dart';
import '../entities/user_role.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final String currentUserId;
  final VoidCallback onLike;
  final VoidCallback onDislike;

  const PostCard({
    super.key,
    required this.post,
    required this.currentUserId,
    required this.onLike,
    required this.onDislike,
  });

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String _getRoleBadge(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.teamLeader:
        return 'Team Leader';
      case UserRole.employee:
        return 'Employee';
    }
  }

  Color _getRoleBadgeColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return Colors.red.shade700;
      case UserRole.teamLeader:
        return Colors.blue.shade700;
      case UserRole.employee:
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLiked = post.isLikedBy(currentUserId);
    final isDisliked = post.isDislikedBy(currentUserId);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Profile picture, name, role, time
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF0051A5).withOpacity(0.1),
                  child: post.author.profilePicture != null
                      ? ClipOval(
                          child: Image.network(
                            post.author.profilePicture!,
                            fit: BoxFit.cover,
                            width: 48,
                            height: 48,
                          ),
                        )
                      : Text(
                          post.author.name[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0051A5),
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.author.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getRoleBadgeColor(post.author.role)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _getRoleBadge(post.author.role),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getRoleBadgeColor(post.author.role),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getTimeAgo(post.createdAt),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Content
            Text(
              post.content,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            // Media (image/video placeholder)
            if (post.imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  post.imageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ],
            if (post.videoUrl != null) ...[
              const SizedBox(height: 12),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.play_circle_outline, size: 64, color: Colors.grey),
                ),
              ),
            ],
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),
            // Like/Dislike buttons
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onLike,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                            size: 20,
                            color: isLiked ? const Color(0xFF0051A5) : Colors.grey[700],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${post.likeCount}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isLiked ? const Color(0xFF0051A5) : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: InkWell(
                    onTap: onDislike,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
                            size: 20,
                            color: isDisliked ? Colors.red[700] : Colors.grey[700],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${post.dislikeCount}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isDisliked ? Colors.red[700] : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
