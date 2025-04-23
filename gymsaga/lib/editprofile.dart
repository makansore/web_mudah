import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isEditingName = false;
  bool isEditingGoal = false;

  String name = 'Katie';
  String goal = '50.00';
  final String startingWeight = '60.4 kg';

  final nameController = TextEditingController();
  final goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = name;
    goalController.text = goal;
  }

  @override
  void dispose() {
    nameController.dispose();
    goalController.dispose();
    super.dispose();
  }

  Widget buildEditableField({
    required String label,
    required bool isEditing,
    required TextEditingController controller,
    required VoidCallback onToggle,
    bool enabled = true,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/widgets/background/frame.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  if (isEditing) {
                    // Save and exit edit mode
                    setState(() {
                      if (label == 'Name') {
                        name = controller.text;
                        isEditingName = false;
                      } else if (label == 'Weigh Goal') {
                        goal = controller.text;
                        isEditingGoal = false;
                      }
                    });
                  } else {
                    onToggle();
                  }
                },
                child: Image.asset(
                  isEditing
                      ? 'assets/widgets/buttons/button_plus.png'
                      : 'assets/widgets/buttons/edit_button.png',
                  width: 20,
                  height: 20,
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          isEditing
              ? TextField(
                  controller: controller,
                  enabled: enabled,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              : Text(
                  controller.text,
                  style: TextStyle(
                    fontSize: 16,
                    color: enabled ? Colors.black : Colors.grey[600],
                  ),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E4C3),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF7E4C3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          'assets/widgets/buttons/back_button.png',
                          width: 48,
                          height: 48,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Text(
                          'EDIT PROFILE',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'Jersey25',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.black,
                          ),
                        ),
                        const Text(
                          'EDIT PROFILE',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'Jersey25',
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 5),
                                blurRadius: 0,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Avatar
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 38,
                backgroundImage:
                    AssetImage('assets/widgets/images/female_profile.png'),
              ),
            ),

            const SizedBox(height: 24),

            // Editable Name Field
            buildEditableField(
              label: 'Name',
              isEditing: isEditingName,
              controller: nameController,
              onToggle: () {
                setState(() {
                  isEditingName = true;
                });
              },
            ),

            // Non-editable Starting Weight
            buildEditableField(
              label: 'Starting Weight',
              isEditing: false,
              controller: TextEditingController(text: startingWeight),
              onToggle: () {},
              enabled: false,
            ),

            // Editable Goal Field
            buildEditableField(
              label: 'Weigh Goal',
              isEditing: isEditingGoal,
              controller: goalController,
              onToggle: () {
                setState(() {
                  isEditingGoal = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
