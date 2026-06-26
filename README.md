# Student Grade Tracker

A clean, modern Flutter application for tracking student subjects, marks, and overall academic performance. Built with a focus on simplicity, maintainability, and clean architecture.

## Features

- **Dashboard Navigation:** Seamlessly switch between screens using a minimal `BottomNavigationBar` and `IndexedStack`.
- **Add Subjects:** Form with validation to add subjects and their numeric marks (0-100).
- **Subject List:** View all added subjects. Features a clean card UI with swipe-to-delete functionality.
- **Academic Summary:** Real-time calculation of total subjects, average mark, and overall letter grade.
- **Dark/Light Mode:** Inherits app theme settings dynamically with a quick toggle option.

## Architecture

- **State Management:** Uses the `provider` package (`ChangeNotifierProvider`, `GradeProvider`) to handle state across the app.
- **Zero `setState` Approach:** UI components are primarily `StatelessWidget` or `StatefulWidget` (used strictly for lifecycle hooks like disposing controllers). State updates are driven entirely by Provider for optimal separation of concerns.

## Project Structure

- `lib/src/models/`: Contains data models like `Subject`.
- `lib/src/providers/`: Contains state providers like `GradeProvider`.
- `lib/src/features/dashboard/`: Contains the main shell, navigation state, and tab configuration.
- `lib/src/features/add_subject/`: UI and logic for the subject entry form.
- `lib/src/features/subject_list/`: UI for displaying and managing the list of subjects.
- `lib/src/features/summary/`: UI for the real-time academic summary.

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   ```bash
   flutter run
   ```
