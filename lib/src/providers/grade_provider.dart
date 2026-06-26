import 'package:flutter/foundation.dart';

import '../models/subject.dart';

/// App-wide state container for the list of [Subject]s and derived
/// statistics. Uses [ChangeNotifier] so widgets react to changes via
/// `Consumer<GradeProvider>` or `context.watch<GradeProvider>()`.
///
/// No `setState` is used anywhere — all UI updates flow from this notifier.
class GradeProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  /// Read-only view of the currently tracked subjects.
  List<Subject> get subjects => List.unmodifiable(_subjects);

  /// Number of subjects currently tracked.
  int get totalSubjects => _subjects.length;

  /// Arithmetic mean of all subject marks, or `0` when the list is empty.
  double get average {
    if (_subjects.isEmpty) return 0;
    final total = _subjects.fold<double>(0, (sum, s) => sum + s.mark);
    return total / _subjects.length;
  }

  /// Adds a new [Subject] and notifies listeners.
  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  /// Removes the subject at [index] (no-op if out of range).
  void removeSubjectAt(int index) {
    if (index < 0 || index >= _subjects.length) return;
    _subjects.removeAt(index);
    notifyListeners();
  }

  /// Replaces the subject at [index] with [subject].
  void updateSubjectAt(int index, Subject subject) {
    if (index < 0 || index >= _subjects.length) return;
    _subjects[index] = subject;
    notifyListeners();
  }

  /// Removes every subject from the list.
  void clear() {
    if (_subjects.isEmpty) return;
    _subjects.clear();
    notifyListeners();
  }
}
