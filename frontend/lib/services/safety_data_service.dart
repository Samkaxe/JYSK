import '../entities/safety_module.dart';
import '../entities/submodule.dart';
import '../entities/submodule_type.dart';
import '../entities/quiz.dart';
import '../entities/question.dart';
import '../entities/module_status.dart';

class SafetyDataService {
  static final SafetyDataService _instance = SafetyDataService._internal();
  factory SafetyDataService() => _instance;
  SafetyDataService._internal();

  final List<SafetyModule> modules = [
    // Fire Safety Module
    SafetyModule(
      id: 'm1',
      title: 'Fire Safety',
      description: 'Learn about fire prevention, detection, and emergency response procedures.',
      iconName: 'fire_extinguisher',
      submodules: [
        Submodule(
          id: 's1_1',
          title: 'Fire Prevention Basics',
          content: '''Fire safety is critical in warehouse environments. Understanding fire prevention basics can save lives and protect property.

Key Points:
• Keep work areas clean and free of flammable materials
• Store chemicals properly in designated areas
• Maintain clear access to fire exits and equipment
• Report any fire hazards immediately
• Never block fire extinguishers or sprinkler systems

Remember: Prevention is always better than fighting a fire!''',
          type: SubmoduleType.text,
          order: 1,
        ),
        Submodule(
          id: 's1_2',
          title: 'Fire Extinguisher Types',
          content: '''Different types of fires require different extinguishers. Learn to identify and use the correct type.

Types of Extinguishers:
🔴 Class A: Ordinary combustibles (wood, paper, cloth)
🔴 Class B: Flammable liquids (oil, gasoline, grease)
🔴 Class C: Electrical fires
🔴 Class D: Combustible metals
🔴 Class K: Kitchen fires (cooking oils)

Always check the label before using an extinguisher!''',
          type: SubmoduleType.imageText,
          order: 2,
        ),
        Submodule(
          id: 's1_3',
          title: 'Emergency Evacuation',
          content: '''Know your evacuation routes and assembly points.

In Case of Fire:
1. Alert others immediately
2. Activate the fire alarm
3. Evacuate using the nearest safe exit
4. Never use elevators
5. Meet at the designated assembly point
6. Do not re-enter until cleared by authorities

Your life is more valuable than any property!''',
          type: SubmoduleType.text,
          order: 3,
        ),
      ],
      quiz: Quiz(
        id: 'q1',
        moduleId: 'm1',
        passingScore: 70,
        questions: [
          Question(
            id: 'q1_1',
            question: 'What should you do first when you discover a fire?',
            options: [
              'Try to extinguish it yourself',
              'Alert others and activate the fire alarm',
              'Collect your belongings',
              'Take a photo for documentation',
            ],
            correctAnswerIndex: 1,
          ),
          Question(
            id: 'q1_2',
            question: 'Which fire extinguisher is used for electrical fires?',
            options: [
              'Class A',
              'Class B',
              'Class C',
              'Class K',
            ],
            correctAnswerIndex: 2,
          ),
          Question(
            id: 'q1_3',
            question: 'What should you NEVER do during a fire evacuation?',
            options: [
              'Use the stairs',
              'Help others evacuate',
              'Use the elevator',
              'Close doors behind you',
            ],
            correctAnswerIndex: 2,
          ),
        ],
      ),
    ),

    // Forklift Safety Module
    SafetyModule(
      id: 'm2',
      title: 'Forklift Safety',
      description: 'Master safe forklift operation, inspection, and handling procedures.',
      iconName: 'forklift',
      submodules: [
        Submodule(
          id: 's2_1',
          title: 'Introduction to Forklift Safety',
          content: '''Forklifts are essential warehouse equipment but can be dangerous if not operated correctly.

Why Forklift Safety Matters:
• Prevents injuries and fatalities
• Protects equipment and inventory
• Ensures smooth warehouse operations
• Required by law and regulations

Statistics: Forklifts are involved in approximately 85 deaths and 34,900 serious injuries annually.''',
          type: SubmoduleType.text,
          order: 1,
        ),
        Submodule(
          id: 's2_2',
          title: 'Pre-use Inspection',
          content: '''Always inspect your forklift before use. This daily check can prevent accidents.

Daily Inspection Checklist:
✓ Check fluid levels (oil, coolant, hydraulic fluid)
✓ Inspect tires for damage or wear
✓ Test brakes and steering
✓ Check lights and horn
✓ Inspect forks and mast for damage
✓ Verify safety devices are working
✓ Check for leaks

Report any defects immediately and do not operate unsafe equipment!''',
          type: SubmoduleType.text,
          order: 2,
        ),
        Submodule(
          id: 's2_3',
          title: 'Safe Driving Practices',
          content: '''Driving a forklift safely requires constant attention and following best practices.

Safe Driving Rules:
• Keep your speed under control
• Sound horn at intersections
• Watch for pedestrians
• Never allow riders on the forklift
• Keep forks low when traveling
• Look in the direction of travel
• Use seatbelt at all times
• Maintain safe distances from edges

Remember: You are responsible for everyone's safety!''',
          type: SubmoduleType.text,
          order: 3,
        ),
        Submodule(
          id: 's2_4',
          title: 'Loading and Unloading',
          content: '''Proper loading techniques prevent accidents and product damage.

Loading Best Practices:
1. Check load weight and capacity
2. Center the load on the forks
3. Tilt the mast back slightly
4. Keep the load low when moving
5. Drive slowly and carefully
6. Never exceed the load capacity
7. Stack loads securely

Unloading:
• Ensure stable footing
• Lower load slowly and smoothly
• Make sure the area is clear
• Use proper stacking techniques''',
          type: SubmoduleType.text,
          order: 4,
        ),
        Submodule(
          id: 's2_5',
          title: 'Emergency Situations',
          content: '''Know how to respond to forklift emergencies.

If the Forklift Tips Over:
• Stay in the cab - DO NOT jump
• Lean away from the impact point
• Brace yourself and hold on tight

Other Emergencies:
🚨 Fire: Stop, turn off, evacuate
🚨 Brake failure: Downshift, use parking brake
🚨 Lost load: Stop, secure area, get help
🚨 Pedestrian collision: Stop, call emergency services

Always report all accidents, no matter how minor!''',
          type: SubmoduleType.text,
          order: 5,
        ),
      ],
      quiz: Quiz(
        id: 'q2',
        moduleId: 'm2',
        passingScore: 80,
        questions: [
          Question(
            id: 'q2_1',
            question: 'What should you do before using a forklift?',
            options: [
              'Start driving immediately',
              'Inspect the forklift first',
              'Ignore warning lights',
              'Drive faster in narrow areas',
            ],
            correctAnswerIndex: 1,
          ),
          Question(
            id: 'q2_2',
            question: 'If a forklift starts to tip over, what should you do?',
            options: [
              'Jump out immediately',
              'Stay in the cab and brace yourself',
              'Try to balance it',
              'Call for help',
            ],
            correctAnswerIndex: 1,
          ),
          Question(
            id: 'q2_3',
            question: 'Where should the forks be positioned when traveling?',
            options: [
              'Raised high',
              'At waist height',
              'Low to the ground',
              'Tilted forward',
            ],
            correctAnswerIndex: 2,
          ),
          Question(
            id: 'q2_4',
            question: 'What is the most important safety device on a forklift?',
            options: [
              'Horn',
              'Lights',
              'Seatbelt',
              'Mirrors',
            ],
            correctAnswerIndex: 2,
          ),
        ],
      ),
    ),

    // Lifting Techniques Module
    SafetyModule(
      id: 'm3',
      title: 'Lifting Techniques',
      description: 'Learn proper lifting methods to prevent back injuries and strain.',
      iconName: 'fitness_center',
      submodules: [
        Submodule(
          id: 's3_1',
          title: 'Why Proper Lifting Matters',
          content: '''Back injuries are one of the most common workplace injuries. Learn to protect yourself!

Facts About Lifting Injuries:
• Back injuries account for 20% of workplace injuries
• Most occur due to improper lifting techniques
• These injuries can cause chronic pain
• Many are completely preventable

Your back health is important - lift smart!''',
          type: SubmoduleType.text,
          order: 1,
        ),
        Submodule(
          id: 's3_2',
          title: 'Proper Lifting Technique',
          content: '''Follow these steps for safe lifting:

Step-by-Step Guide:
1. Plan your lift - check weight and path
2. Stand close to the object
3. Bend at your knees, not your waist
4. Keep your back straight
5. Grip firmly with both hands
6. Lift with your legs, not your back
7. Hold the object close to your body
8. Turn with your feet, not your torso
9. Lower by bending your knees

If it's too heavy, ask for help or use equipment!''',
          type: SubmoduleType.text,
          order: 2,
        ),
        Submodule(
          id: 's3_3',
          title: 'Team Lifting',
          content: '''When an object is too heavy for one person, use team lifting.

Team Lifting Guidelines:
• Choose a team leader to coordinate
• Everyone should understand the plan
• Count together: "Lift on three"
• Move slowly and in sync
• Communicate throughout
• Lower together on command

Teamwork keeps everyone safe!''',
          type: SubmoduleType.text,
          order: 3,
        ),
      ],
      quiz: Quiz(
        id: 'q3',
        moduleId: 'm3',
        passingScore: 70,
        questions: [
          Question(
            id: 'q3_1',
            question: 'When lifting, you should bend at the:',
            options: [
              'Waist',
              'Knees',
              'Back',
              'Shoulders',
            ],
            correctAnswerIndex: 1,
          ),
          Question(
            id: 'q3_2',
            question: 'What should you do if an object is too heavy to lift alone?',
            options: [
              'Try harder',
              'Drag it',
              'Ask for help or use equipment',
              'Lift quickly',
            ],
            correctAnswerIndex: 2,
          ),
        ],
      ),
    ),

    // Emergency Procedures Module
    SafetyModule(
      id: 'm4',
      title: 'Emergency Procedures',
      description: 'Be prepared for emergencies with proper response protocols.',
      iconName: 'emergency',
      submodules: [
        Submodule(
          id: 's4_1',
          title: 'Types of Emergencies',
          content: '''Recognize different types of emergencies and their warning signs.

Common Warehouse Emergencies:
🚨 Fire
🚨 Chemical spills
🚨 Medical emergencies
🚨 Natural disasters
🚨 Power outages
🚨 Security threats
🚨 Equipment failures

Know the emergency procedures for each type!''',
          type: SubmoduleType.text,
          order: 1,
        ),
        Submodule(
          id: 's4_2',
          title: 'Emergency Response Steps',
          content: '''Follow these general steps in any emergency:

R.A.C.E. Protocol:
R - Rescue: Remove yourself and others from danger
A - Alert: Notify emergency services and management
C - Confine: Contain the emergency if safe to do so
E - Evacuate: Leave the area using designated routes

Remember: Your safety comes first!''',
          type: SubmoduleType.text,
          order: 2,
        ),
      ],
      quiz: Quiz(
        id: 'q4',
        moduleId: 'm4',
        passingScore: 70,
        questions: [
          Question(
            id: 'q4_1',
            question: 'What does R.A.C.E. stand for in emergency response?',
            options: [
              'Run, Alert, Call, Exit',
              'Rescue, Alert, Confine, Evacuate',
              'React, Assess, Control, Escape',
              'Remove, Activate, Clear, Exit',
            ],
            correctAnswerIndex: 1,
          ),
        ],
      ),
    ),

    // Warehouse Movement Module
    SafetyModule(
      id: 'm5',
      title: 'Warehouse Movement',
      description: 'Safe movement and navigation in busy warehouse environments.',
      iconName: 'directions_walk',
      submodules: [
        Submodule(
          id: 's5_1',
          title: 'Walking Safely',
          content: '''Warehouse floors can be busy and hazardous. Stay alert!

Safe Walking Tips:
• Use designated walkways
• Watch for forklifts and equipment
• Keep your eyes on the path ahead
• Don't run or rush
• Be aware of your surroundings
• Report hazards immediately
• Stay off mobile devices while walking

Your attention can save your life!''',
          type: SubmoduleType.text,
          order: 1,
        ),
      ],
      quiz: Quiz(
        id: 'q5',
        moduleId: 'm5',
        passingScore: 70,
        questions: [
          Question(
            id: 'q5_1',
            question: 'What should you use when walking in the warehouse?',
            options: [
              'Any path available',
              'Designated walkways',
              'Forklift lanes',
              'Shortcuts between racks',
            ],
            correctAnswerIndex: 1,
          ),
        ],
      ),
    ),

    // Equipment Handling Module
    SafetyModule(
      id: 'm6',
      title: 'Equipment Handling',
      description: 'Safe operation and maintenance of warehouse equipment.',
      iconName: 'handyman',
      submodules: [
        Submodule(
          id: 's6_1',
          title: 'Tool Safety',
          content: '''Proper tool handling prevents injuries.

Tool Safety Rules:
• Use the right tool for the job
• Inspect tools before use
• Keep tools clean and maintained
• Store tools properly
• Report damaged tools
• Wear appropriate PPE
• Never modify tools

A safe worker is a productive worker!''',
          type: SubmoduleType.text,
          order: 1,
        ),
      ],
      quiz: Quiz(
        id: 'q6',
        moduleId: 'm6',
        passingScore: 70,
        questions: [
          Question(
            id: 'q6_1',
            question: 'What should you do before using a tool?',
            options: [
              'Use it immediately',
              'Inspect it first',
              'Modify it if needed',
              'Share it with others',
            ],
            correctAnswerIndex: 1,
          ),
        ],
      ),
    ),
  ];

  List<SafetyModule> getModules() => modules;

  SafetyModule? getModuleById(String id) {
    try {
      return modules.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  double getOverallProgress() {
    if (modules.isEmpty) return 0;
    double totalProgress = 0;
    for (var module in modules) {
      totalProgress += module.progressPercentage;
    }
    return totalProgress / modules.length;
  }

  int getCompletedModulesCount() {
    return modules.where((m) => m.status == ModuleStatus.completed).length;
  }

  void markSubmoduleComplete(String moduleId, String submoduleId) {
    final module = getModuleById(moduleId);
    if (module != null) {
      final submodule = module.submodules.firstWhere((s) => s.id == submoduleId);
      submodule.isCompleted = true;
    }
  }

  void submitQuiz(String moduleId, List<int> userAnswers) {
    final module = getModuleById(moduleId);
    if (module == null) return;

    int correctCount = 0;
    for (int i = 0; i < module.quiz.questions.length; i++) {
      if (userAnswers[i] == module.quiz.questions[i].correctAnswerIndex) {
        correctCount++;
      }
    }

    module.quiz.userScore = correctCount;
    module.quiz.isPassed = module.quiz.scorePercentage >= module.quiz.passingScore;
  }
}
