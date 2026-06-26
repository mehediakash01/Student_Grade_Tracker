import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/grade_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradeProvider = context.watch<GradeProvider>();
    final subjects = gradeProvider.subjects;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (subjects.isEmpty) {
      return Center(
        child: Text(
          'No subjects added yet.',
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return Dismissible(
          key: ValueKey('${subject.name}_$index'),
          direction: DismissDirection.horizontal,
          background: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: colorScheme.error,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.delete, color: colorScheme.onError),
                Icon(Icons.delete, color: colorScheme.onError),
              ],
            ),
          ),
          onDismissed: (direction) {
            context.read<GradeProvider>().deleteSubject(index);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${subject.name} deleted')),
            );
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shadowColor: colorScheme.shadow.withOpacity(0.2),
            color: colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                subject.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Mark: ${subject.mark.toStringAsFixed(1)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              trailing: CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  subject.grade,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
