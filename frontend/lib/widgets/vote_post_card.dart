import 'package:flutter/material.dart';
import '../entities/post.dart';
import '../entities/user_role.dart';
import '../entities/vote_option.dart';

class VotePostCard extends StatelessWidget {
  final Post post;
  final String currentUserId;
  final Function(String optionId) onVote;
  final VoidCallback onLike;
  final VoidCallback onDislike;

  const VotePostCard({
    super.key,
    required this.post,
    required this.currentUserId,
    required this.onVote,
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

  int _getTotalVotes() {
    return post.voteOptions?.fold<int>(0, (sum, option) => sum + option.voteCount) ?? 0;
  }

  double _getPercentage(VoteOption option) {
    final total = _getTotalVotes();
    if (total == 0) return 0;
    return (option.voteCount / total * 100);
  }

  @override
  Widget build(BuildContext context) {
    final isLiked = post.isLikedBy(currentUserId);
    final isDisliked = post.isDislikedBy(currentUserId);
    final userVote = post.getVoteByUser(currentUserId);
    final totalVotes = _getTotalVotes();

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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.poll, size: 14, color: Colors.orange),
                      SizedBox(width: 4),
                      Text(
                        'Vote',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
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
            const SizedBox(height: 20),
            // Vote options
            ...post.voteOptions!.map((option) {
              final percentage = _getPercentage(option);
              final isSelected = userVote == option.id;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => onVote(option.id),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF0051A5)
                            : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Progress bar
                        FractionallySizedBox(
                          widthFactor: percentage / 100,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF0051A5).withOpacity(0.15)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        // Text content
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  option.text,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? const Color(0xFF0051A5)
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              Text(
                                '${percentage.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? const Color(0xFF0051A5)
                                      : Colors.grey[700],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '(${option.voteCount})',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 8),
            Text(
              '$totalVotes ${totalVotes == 1 ? 'vote' : 'votes'}',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
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
