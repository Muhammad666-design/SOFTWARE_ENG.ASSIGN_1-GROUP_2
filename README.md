# ICT Laboratory Equipment Inventory and Maintenance Management System

A small Dart console application prototype for managing ICT laboratory equipment.
It is an academic demonstration and is not connected to any university equipment
records.

## Requirements

- Dart SDK 3.0.0 or newer, below 4.0.0

## Run

From the project directory, run:

```text
dart run
```

The named entry point is `bin/ict_laboratory_inventory.dart`; the application
menu is implemented in `bin/main.dart`.

The current version allows equipment registration with trimmed, non-empty
required fields and rejects duplicate asset codes without regard to letter case.
It can list all registered equipment and search by case-insensitive exact asset
code or by a case-insensitive partial equipment name. Records are held in memory
for the duration of the program. A registered asset can be marked as requiring
maintenance by asset code, and the summary reports total assets and assets
requiring maintenance.

## Project structure

- `bin/ict_laboratory_inventory.dart` - default Dart command-line entry point.
- `bin/main.dart` - console menu and inventory operations.
- `lib/equipment.dart` - equipment data model.
- `pubspec.yaml` - package metadata and Dart SDK constraint.

## Limitations

- This is an in-memory prototype; data is not saved when the program exits.
- It is not connected to institutional equipment records.
- It has no authentication, database, network interface, or automated test suite.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for
details.

## Future improvements

- Add automated tests for validation and inventory operations.
- Add an approved persistent storage option if a later project phase requires it.
- Improve search filters and allow maintenance status to be cleared.
