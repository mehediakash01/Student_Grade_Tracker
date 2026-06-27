import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/subject.dart';
import '../../../providers/grade_provider.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _marksController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _marksController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final marks = double.parse(_marksController.text.trim());
      final subject = Subject(name: name, mark: marks);

      Provider.of<GradeProvider>(context, listen: false).addSubject(subject);

      _nameController.clear();
      _marksController.clear();
      FocusScope.of(context).unfocus();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Subject added successfully'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.add_task_rounded,
                size: 64,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Add New Subject',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Subject Name',
                  prefixIcon: Icon(Icons.menu_book_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a subject name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _marksController,
                decoration: const InputDecoration(
                  labelText: 'Marks (0 - 100)',
                  prefixIcon: Icon(Icons.score_rounded),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter marks';
                  }
                  final marks = double.tryParse(value.trim());
                  if (marks == null) {
                    return 'Please enter a valid number';
                  }
                  if (marks < 0 || marks > 100) {
                    return 'Marks must be between 0 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.add),
                label: const Text('Add Subject'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
