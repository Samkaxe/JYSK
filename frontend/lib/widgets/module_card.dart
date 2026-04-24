import 'package:flutter/material.dart';
import '../entities/safety_module.dart';
import '../entities/module_status.dart';

class ModuleCard extends StatelessWidget {
  final SafetyModule module;
  final VoidCallback onTap;

  const ModuleCard({
    super.key,
    required this.module,
    required this.onTap,
  });

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

  @override
  Widget build(BuildContext context) {
    final status = module.status;
    final progress = module.progressPercentage;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0051A5).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getIcon(module.iconName),
                      size: 32,
                      color: const Color(0xFF0051A5),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getStatusColor(status),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      _getStatusText(status),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(status),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                module.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                module.description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        '${progress.toInt()}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: progress == 100
                              ? Colors.green.shade700
                              : const Color(0xFF0051A5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      minHeight: 8,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress == 100
                            ? Colors.green.shade600
                            : const Color(0xFF0051A5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${module.completedSubmodulesCount}/${module.submodules.length} lessons completed',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
