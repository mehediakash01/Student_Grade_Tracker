import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/grade_provider.dart';
import '../../providers/theme_provider.dart';

/// Entry-point screen for the app.
///
/// Demonstrates theming via [Theme.of] and reactivity to [ThemeProvider]
/// without ever calling `setState`.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Grade Tracker'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) => IconButton(
              tooltip: themeProvider.isDark
                  ? 'Switch to light theme'
                  : 'Switch to dark theme',
              icon: Icon(
                themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: themeProvider.toggleTheme,
            ),
          ),
        ],
      ),
      body: Consumer<GradeProvider>(
        builder: (context, gradeProvider, _) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: 96,
                    color: colors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Track ${gradeProvider.totalSubjects} subjects · '
                    'Average ${gradeProvider.average.toStringAsFixed(1)}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
