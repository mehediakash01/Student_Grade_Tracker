import 'package:flutter/material.dart';

/// Manages the app's [ThemeMode] state.
///
/// Wraps [ChangeNotifier] so any `Consumer<ThemeProvider>` or
/// `context.watch<ThemeProvider>()` rebuilds when [toggleTheme] or
/// [setThemeMode] is invoked.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  /// The current [ThemeMode] consumed by [MaterialApp.themeMode].
  ThemeMode get themeMode => _themeMode;

  /// True when the active theme should be the dark variant.
  bool get isDark => _themeMode == ThemeMode.dark;

  /// Toggles between [ThemeMode.light] and [ThemeMode.dark].
  ///
  /// If the current mode is [ThemeMode.system], it resolves to the
  /// opposite of the current platform brightness.
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  /// Explicitly sets the [ThemeMode]. No-op if the mode is unchanged.
  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }
}
