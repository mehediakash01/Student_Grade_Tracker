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
            child: Text(
              'No subjects added yet.',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return Dismissible(
              key: ValueKey('${subject.name}_$index'),
              direction: DismissDirection.endToStart,
              background: Container(
                color: colorScheme.error,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.delete,
                  color: colorScheme.onError,
                ),
              ),
              onDismissed: (_) {
                gradeProvider.deleteSubject(index);
              },
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: Text(
                    subject.name,
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                  subtitle: Text(
                    'Mark: ${subject.mark.toStringAsFixed(1)}',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      subject.grade,
                      style: TextStyle(
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
      },
    );
  }
}
