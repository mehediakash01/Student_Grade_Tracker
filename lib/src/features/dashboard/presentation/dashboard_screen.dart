import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardNavigationState extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardNavigationState(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  static const List<Widget> _screens = [
    AddSubjectScreen(),
    SubjectListScreen(),
    SummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final navState = context.watch<DashboardNavigationState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(
              colorScheme.brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              // TODO: connect to real ThemeProvider
              // context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: navState.currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navState.currentIndex,
        onTap: (index) => context.read<DashboardNavigationState>().setIndex(index),
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
        backgroundColor: colorScheme.surface,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            activeIcon: Icon(Icons.list),
            label: 'Subjects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}

// Placeholders

class AddSubjectScreen extends StatelessWidget {
  const AddSubjectScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Add Subject',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Subject List',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Summary',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
