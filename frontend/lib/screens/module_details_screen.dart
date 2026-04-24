import 'package:flutter/material.dart';
import '../entities/safety_module.dart';
import '../entities/submodule.dart';
import '../entities/module_status.dart';
import 'lesson_screen.dart';
import 'quiz_screen.dart';

class ModuleDetailsScreen extends StatefulWidget {
  final SafetyModule module;
  final VoidCallback onUpdate;

  const ModuleDetailsScreen({
    super.key,
    required this.module,
    required this.onUpdate,
  });

  @override
  State<ModuleDetailsScreen> createState() => _ModuleDetailsScreenState();
}

class _ModuleDetailsScreenState extends State<ModuleDetailsScreen> {
  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'fire_extinguisher':
        return Icons.fire_extinguisher;
      case 'forklift':
        return Icons.local_shipping;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'emergency':
        return Icons.emergency;
      case 'directions_walk':
        return Icons.directions_walk;
      case 'handyman':
        return Icons.handyman;
      default:
        return Icons.school;
    }
  }

  Color _getStatusColor(ModuleStatus status) {
    switch (status) {
      case ModuleStatus.notStarted:
        return Colors.grey.shade400;
      case ModuleStatus.inProgress:
        return Colors.orange.shade600;
      case ModuleStatus.completed:
        return Colors.green.shade600;
    }
  }

  String _getStatusText(ModuleStatus status) {
    switch (status) {
      case ModuleStatus.notStarted:
        return 'Not Started';
      case ModuleStatus.inProgress:
        return 'In Progress';
      case ModuleStatus.completed:
        return 'Completed';
    }
  }

  IconData _getSubmoduleIcon(Submodule submodule) {
    switch (submodule.type.name) {
      case 'video':
        return Icons.play_circle_filled;
      case 'imageText':
        return Icons.image;
      default:
        return Icons.article;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.module.progressPercentage;
    final status = widget.module.status;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Module Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0051A5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Module Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0051A5), Color(0xFF4A90E2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0051A5).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getIcon(widget.module.iconName),
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.module.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.module.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          status == ModuleStatus.completed
                              ? Icons.check_circle
                              : status == ModuleStatus.inProgress
                                  ? Icons.timelapse
                                  : Icons.radio_button_unchecked,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getStatusText(status),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Progress Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Progress',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${progress.toInt()}%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: progress == 100
                              ? Colors.green.shade700
                              : const Color(0xFF0051A5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      minHeight: 12,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress == 100
                            ? Colors.green.shade600
                            : const Color(0xFF0051A5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${widget.module.completedSubmodulesCount}/${widget.module.submodules.length} lessons completed',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Lessons Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Lessons',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Submodules List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.module.submodules.length,
              itemBuilder: (context, index) {
                final submodule = widget.module.submodules[index];
                return _buildSubmoduleCard(submodule, index);
              },
            ),

            // Quiz Section
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Final Quiz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildQuizCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmoduleCard(Submodule submodule, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonScreen(
                  module: widget.module,
                  submodule: submodule,
                  onComplete: () {
                    setState(() {});
                    widget.onUpdate();
                  },
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: submodule.isCompleted
                        ? Colors.green.shade100
                        : const Color(0xFF0051A5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: submodule.isCompleted
                        ? Icon(Icons.check_circle, color: Colors.green.shade700, size: 24)
                        : Icon(
                            _getSubmoduleIcon(submodule),
                            color: const Color(0xFF0051A5),
                            size: 22,
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        submodule.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: submodule.isCompleted
                              ? Colors.grey[600]
                              : Colors.black87,
                          decoration: submodule.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lesson ${index + 1} • ${submodule.type.name}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard() {
    final isUnlocked = widget.module.isQuizUnlocked;
    final isPassed = widget.module.quiz.isPassed == true;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: isUnlocked ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        elevation: isUnlocked ? 2 : 0,
        child: InkWell(
          onTap: isUnlocked
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        module: widget.module,
                        onComplete: () {
                          setState(() {});
                          widget.onUpdate();
                        },
                      ),
                    ),
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isPassed
                        ? Colors.green.shade100
                        : isUnlocked
                            ? Colors.orange.shade100
                            : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      isPassed
                          ? Icons.check_circle
                          : isUnlocked
                              ? Icons.quiz
                              : Icons.lock,
                      color: isPassed
                          ? Colors.green.shade700
                          : isUnlocked
                              ? Colors.orange.shade700
                              : Colors.grey.shade600,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Final Quiz',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isUnlocked ? Colors.black87 : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isUnlocked
                            ? isPassed
                                ? 'Passed ✓'
                                : '${widget.module.quiz.questions.length} questions'
                            : 'Complete all lessons to unlock',
                        style: TextStyle(
                          fontSize: 12,
                          color: isPassed
                              ? Colors.green.shade700
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isUnlocked)
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
