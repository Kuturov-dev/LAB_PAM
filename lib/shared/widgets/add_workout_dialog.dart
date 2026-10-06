import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/fitness_models.dart';

class AddWorkoutDialog extends StatefulWidget {
  final ValueChanged<WorkoutProgramItem> onWorkoutAdded;

  const AddWorkoutDialog({super.key, required this.onWorkoutAdded});

  @override
  State<AddWorkoutDialog> createState() => _AddWorkoutDialogState();
}

class _AddWorkoutDialogState extends State<AddWorkoutDialog> {
  final _titleController = TextEditingController();
  final _caloriesController = TextEditingController(text: '250');
  final _durationController = TextEditingController(text: '45');
  String _selectedCategory = 'cardio';
  bool _isPro = false;

  final Map<String, String> _categories = const {
    'cardio': 'Cardio',
    'yoga': 'Yoga',
    'pilates': 'Pilates',
    'boxing': 'Boxing',
  };

  @override
  void dispose() {
    _titleController.dispose();
    _caloriesController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a workout title.')),
      );
      return;
    }

    final calories = int.tryParse(_caloriesController.text) ?? 200;
    final duration = int.tryParse(_durationController.text) ?? 30;

    String imageAsset = 'assets/images/Cardio Training running.jpg';
    if (_selectedCategory == 'yoga') {
      imageAsset = 'assets/images/Yoga  Yoga Flow.jpg';
    } else if (_selectedCategory == 'boxing') {
      imageAsset = 'assets/images/Boxing Basics.jpg';
    } else if (_selectedCategory == 'pilates') {
      imageAsset = 'assets/images/Arm Strengthening.jpg';
    }

    final newProgram = WorkoutProgramItem(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      calories: calories,
      durationMinutes: duration,
      isPro: _isPro,
      imageUrl: imageAsset,
      caloriesIconUrl: 'https://api.iconify.design/mdi/fire.svg?color=%23FFFFFF&width=18',
      durationIconUrl: 'https://api.iconify.design/mdi/clock-outline.svg?color=%23FFFFFF&width=18',
    );

    widget.onWorkoutAdded(newProgram);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.add_task_rounded, color: kGreen),
          SizedBox(width: 8),
          Text('Add Custom Workout Widget', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Workout Name',
                hintText: 'e.g. Morning Core HIIT',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: _categories.entries.map((e) {
                return DropdownMenuItem(value: e.key, child: Text(e.value));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategory = val);
              },
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _caloriesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Calories (kcal)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Duration (min)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Pro Badge'),
              value: _isPro,
              activeColor: kGreen,
              onChanged: (val) => setState(() => _isPro = val),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: kGrey)),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: kGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Add Widget'),
        ),
      ],
    );
  }
}
