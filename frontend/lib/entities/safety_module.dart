import 'module_status.dart';
import 'submodule.dart';
import 'quiz.dart';

class SafetyModule {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final List<Submodule> submodules;
  final Quiz quiz;

  SafetyModule({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.submodules,
    required this.quiz,
  });

  int get completedSubmodulesCount {
    return submodules.where((sub) => sub.isCompleted).length;
  }

  double get progressPercentage {
    if (submodules.isEmpty) return 0;
    return (completedSubmodulesCount / submodules.length) * 100;
  }

  ModuleStatus get status {
    if (completedSubmodulesCount == 0) return ModuleStatus.notStarted;
    if (completedSubmodulesCount == submodules.length && quiz.isPassed == true) {
      return ModuleStatus.completed;
    }
    return ModuleStatus.inProgress;
  }

  bool get isQuizUnlocked {
    return completedSubmodulesCount == submodules.length;
  }
}
