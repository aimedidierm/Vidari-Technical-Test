# 📋 Technical Test Submission

## 📁 Project Structure

```
Vidari-Technical-Test/
├── Q1/                   # Main Flutter application folder
│   ├── lib/              # Application source code
│   ├── assets/           # Images and translations
│   ├── pubspec.yaml      # Dependencies
│   └── ...               # Other Flutter files
├── Q2.pdf                # Question 2
└── Q3.pdf                # Question 3
```

## 1. Mini Flutter App (Main Task) Vidari Todo App

A clean and efficient Flutter todo application with custom branding, localization, and version management.

## ✨ Features

- **Custom Branding**: Vidari-themed name and logo
- **Task Management**: Add, complete, and delete tasks
- **Local Storage**: Tasks persist between app launches using `shared_preferences`
- **Multi-language Support**: English and Kinyarwanda (rw) localization
- **Clean UI**: Minimalist design with green and orange branding
- **State Management**: Provider pattern
- **Version Control**: FVM for consistent Flutter versioning
- **Responsive Design**: Works on all screen sizes

## 📂 Folder Structure

```
assets/
├── images/
│   └── logo.png
└── translations/
    ├── en.json
    └── rw.json

lib/
├── localisation/
│   └── kinyarwanda_fallback_delegate.dart
├── main.dart
├── screens/
│   ├── home_screen.dart
│   └── add_task_screen.dart
├── widgets/
│   └── task_tile.dart
├── models/
│   └── task.dart
└── providers/
    └── task_provider.dart
```

## 🛠️ Prerequisites

- Flutter SDK (v3.0 or later) - Recommended: FVM with version 3.32.1
- Android Studio/VSCode with Flutter plugins

## 🚀 Installation with FVM

1. **Install FVM**:

   ```bash
   dart pub global activate fvm
   ```

2. **Clone the repository**:

   ```bash
   git clone https://github.com/aimedidierm/Vidari-Technical-Test.git
   cd /Vidari-Technical-Test/Q1
   ```

3. **Setup Flutter version**:

   ```bash
   fvm install 3.32.1
   fvm use 3.32.1
   ```

4. **Install dependencies**:

   ```bash
   fvm flutter pub get
   ```

5. **Run the app**:
   ```bash
   fvm flutter run
   ```

## 🌍 Localization Setup

The app supports two languages with custom Vidari branding:

- English (en)
- Kinyarwanda (rw)

To add new translations:

1. Add new JSON files in `assets/translations/`
2. Update the localization delegate
3. Run with specific locale:
   ```bash
   fvm flutter run --dart-define=LOCALE=rw
   ```

## 🎨 Custom Branding

- **App Name**: Changed from default to "Vidari Todo"
- **App Logo**: Custom `logo.png` in assets
- **Color Scheme**:
  - Primary: Green (#388E3C)
  - Secondary: Orange (#F57C00)
  - Accent: White

## ❓ Additional Questions

### 1. Localization Implementation

- JSON-based localization system
- Custom fallback to Kinyarwanda
- Automatic device locale detection
- Easy to add new languages

### 2. Folder Structure Justification

- Clear separation of concerns
- `assets/` for all static resources
- Dedicated `localisation/` folder
- Logical component grouping

## 📝 Technical Implementation

- **State Management**: Provider pattern
- **Persistence**: `shared_preferences`
- **Navigation**: Basic routing
- **UI**: Custom Material Design
- **Localization**: JSON-based system
- **Versioning**: FVM 3.32.1
- **Branding**: Custom name and logo

## 🏆 Bonus Features Implemented

1. Custom app name and logo
2. Comprehensive localization system
3. FVM version management
4. Clean architecture implementation

## 2. 🧠 Dart Logic Challenge Solutions (Optional Bonus Task)

### 1. Reversing a String

```dart
String reverseString(String input) {
  return input.split('').reversed.join();
}

// Usage: reverseString("hello") → "olleh"
```

### 2. Filtering a List for Unique Values

```dart
List<T> uniqueValues<T>(List<T> input) {
  return input.toSet().toList();
}

// Usage: uniqueValues([1, 2, 2, 3]) → [1, 2, 3]
```

### 3. Bonus: Complete Task Counter

```dart
int countCompletedTasks(List<Task> tasks) {
  return tasks.where((task) => task.isCompleted).length;
}

// Usage: Counts how many tasks are marked complete
```

## 3. 🔍 Code Review: User List Screen Bugs

Sorted by severity from critical to minor issues:

### Critical Bugs

1. **Null Safety Violation**

   - **Issue**: `selectedUser` accessed when null
   - **Effect**: Crashes when displaying selected user
   - **Fix**: Initialize `String selectedUser = ''`

2. **Unbounded ListView**

   - **Issue**: ListView without height constraints
   - **Effect**: "Unbounded height" runtime error
   - **Fix**: Wrap with `Expanded`

3. **Search Data Loss**
   - \*\*Issue`: Original list overwritten during search
   - **Effect**: Permanent data loss after search
   - **Fix**: Maintain separate `_allUsers` list

### Functional Bugs

4. **Delete Operation Inconsistency**

   - **Issue**: Deletes only affect filtered list
   - **Effect**: Deleted users reappear after search
   - **Fix**: Remove from both `_allUsers` and filtered list

5. **Add User Inconsistency**
   - **Issue**: New users only added to filtered list
   - **Effect**: New users disappear after search
   - **Fix**: Add to both lists

### UI/UX Issues

6. **Missing Empty State**

   - **Issue**: No handling for empty lists
   - **Effect**: Blank space when no users
   - **Fix**: Add empty state widget

7. **FloatingActionButton Placement**
   - **Issue**: FAB inside Column
   - **Effect**: Poor positioning
   - **Fix**: Move to Scaffold's FAB property

### Best Practice Violations

8. **Missing List Keys**

   - **Issue**: No keys for list items
   - **Effect**: Potential rendering bugs
   - **Fix**: Add `ValueKey` to ListTiles

9. **Direct State Mutation**
   - **Issue**: Modifying lists directly
   - **Effect**: Harder debugging
   - **Fix**: Create new lists before setState

### Fixed Version Highlights

```dart
// Key fixes implemented:
List<String> _allUsers = ['Alice', 'Bob']; // Original list
List<String> users = []; // Filtered list

@override
void initState() {
  super.initState();
  users = _allUsers;
}

// Safe user selection
String selectedUser = '';

// Proper list constraints
Expanded(
  child: ListView.builder(
    itemCount: users.isEmpty ? 1 : users.length,
    itemBuilder: (context, index) {
      if (users.isEmpty) return _buildEmptyState();
      return ListTile(
        key: ValueKey(users[index]),
        // ...
      );
    },
  ),
)
```
