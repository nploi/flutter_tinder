# flutter_tinder
[![Codemagic build status](https://api.codemagic.io/apps/5e677dcd4ce63c10d9e74405/5e677dcd4ce63c10d9e74404/status_badge.svg)](https://codemagic.io/apps/5e677dcd4ce63c10d9e74405/5e677dcd4ce63c10d9e74404/latest_build)

Tinder clone

## Getting Started
```
flutter run
```

### Release mode
```
flutter build apk ./lib/main.dart && flutter install
```

## Unit test & analyze

### Run unit test
```bash
flutter test
```

### Sqlite test
```bash
# sqlite cannot run on the machine.
flutter run test/database/database_test.dart 
```

### analyze
```bash
# Check coding style
flutter analyze
```