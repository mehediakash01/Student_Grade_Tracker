import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/grade_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradeProvider = context.watch<GradeProvider>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Academic Summary',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildSummaryCard(
            context: context,
            title: 'Total Subjects',
            value: gradeProvider.totalSubjects.toString(),
            icon: Icons.library_books,
          ),
          const SizedBox(height: 16),
          _buildSummaryCard(
            context: context,
            title: 'Average Mark',
            value: gradeProvider.averageMark.toStringAsFixed(1),
            icon: Icons.percent,
          ),
          const SizedBox(height: 16),
          _buildSummaryCard(
            context: context,
            title: 'Overall Grade',
            value: gradeProvider.overallGrade,
            icon: Icons.grade,
            isHighlight: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    bool isHighlight = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final bgColor = isHighlight ? colorScheme.primaryContainer : colorScheme.surface;
    final fgColor = isHighlight ? colorScheme.onPrimaryContainer : colorScheme.onSurface;

    return Card(
      elevation: isHighlight ? 4 : 1,
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isHighlight ? colorScheme.primary : colorScheme.outline.withOpacity(0.2),
          width: isHighlight ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isHighlight ? colorScheme.primary : colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isHighlight ? colorScheme.onPrimary : colorScheme.onSecondaryContainer,
                size: 28,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: fgColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: fgColor,
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
