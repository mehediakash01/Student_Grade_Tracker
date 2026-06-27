import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/grade_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<GradeProvider>(
      builder: (context, gradeProvider, _) {
        final subjects = gradeProvider.subjects;

        if (subjects.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.inbox_rounded,
                  size: 64,
                  color: colorScheme.outlineVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'No subjects added yet.',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return Dismissible(
              key: ValueKey('${subject.name}_$index'),
              direction: DismissDirection.endToStart,
              background: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24.0),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: colorScheme.onErrorContainer,
                  size: 32,
                ),
              ),
              onDismissed: (_) {
                gradeProvider.deleteSubject(index);
              },
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                ),
                color: colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      subject.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.score,
                            size: 16,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Mark: ${subject.mark.toStringAsFixed(1)}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: subject.grade == 'F'
                            ? colorScheme.errorContainer
                            : colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        subject.grade,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: subject.grade == 'F'
                              ? colorScheme.onErrorContainer
                              : colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
