/// Immutable model representing a school subject with an associated mark.
///
/// The mark is stored in a private [_mark] field and exposed only through
/// a public [mark] getter. The letter [grade] is derived from the mark.
class Subject {
  /// Display name of the subject (e.g. "Mathematics").
  final String name;

  final double _mark;

  /// Creates a [Subject] with a [name] and numeric [mark].
  ///
  /// [mark] is expected to be on a 0-100 scale.
  const Subject({required this.name, required double mark}) : _mark = mark;

  /// The numeric mark achieved for this subject (0-100).
  double get mark => _mark;

  /// The letter grade derived from [mark]:
  /// `A` for marks >= 80, `B` for >= 65, `C` for >= 50, otherwise `F`.
  String get grade {
    if (_mark >= 80) return 'A';
    if (_mark >= 65) return 'B';
    if (_mark >= 50) return 'C';
    return 'F';
  }

  @override
  String toString() => 'Subject(name: $name, mark: $_mark, grade: $grade)';
}
