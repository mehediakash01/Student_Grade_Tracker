import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/features/dashboard/presentation/dashboard_screen.dart';
import 'src/providers/grade_provider.dart';
import 'src/providers/theme_provider.dart';
import 'src/theme/app_theme.dart';

void main() {
  runApp(const StudentGradeTrackerApp());
}

/// Root widget. Sets up [MultiProvider] for app-wide state and wires
/// the active [ThemeMode] from [ThemeProvider] into [MaterialApp].
class StudentGradeTrackerApp extends StatelessWidget {
  const StudentGradeTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<GradeProvider>(
          create: (_) => GradeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Student Grade Tracker',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            home: const DashboardScreen(),
          );
        },
      ),
    );
  }
}
