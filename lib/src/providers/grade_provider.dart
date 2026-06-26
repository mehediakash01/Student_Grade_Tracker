import 'package:flutter/foundation.dart';

import '../models/subject.dart';

class GradeProvider extends ChangeNotifier {
  final List<Subject> _subjects = <Subject>[];

  List<Subject> get subjects => List<Subject>.unmodifiable(_subjects);

  int get totalSubjects => _subjects.length;

  int get passingSubjects =>
      _subjects.where((Subject s) => s.mark >= 50).length;

  double get averageMark {
    if (_subjects.isEmpty) return 0;
    final double total = _subjects
        .map((Subject s) => s.mark)
        .reduce((double a, double b) => a + b);
    return total / _subjects.length;
  }

  String get overallGrade {
    final double avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void deleteSubject(int index) {
    if (index < 0 || index >= _subjects.length) return;
    _subjects.removeAt(index);
    notifyListeners();
  }
}
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
