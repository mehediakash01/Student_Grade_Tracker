import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/grade_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<GradeProvider>(
      builder: (context, gradeProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Academic Summary',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _SummaryCard(
                title: 'Total Subjects',
                value: gradeProvider.totalSubjects.toString(),
                icon: Icons.library_books_rounded,
                colorScheme: colorScheme,
                textTheme: theme.textTheme,
              ),
              const SizedBox(height: 16),
              _SummaryCard(
                title: 'Average Mark',
                value: gradeProvider.averageMark.toStringAsFixed(1),
                icon: Icons.calculate_rounded,
                colorScheme: colorScheme,
                textTheme: theme.textTheme,
              ),
              const SizedBox(height: 16),
              _SummaryCard(
                title: 'Overall Grade',
                value: gradeProvider.overallGrade,
                icon: Icons.workspace_premium_rounded,
                colorScheme: colorScheme,
                textTheme: theme.textTheme,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primaryContainer.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.onPrimaryContainer.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 36,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
