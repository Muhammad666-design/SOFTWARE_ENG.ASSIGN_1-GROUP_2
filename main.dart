import 'dart:io';

import '../lib/equipment.dart';

final List<Equipment> inventory = [];

void main() {
  runMenu();
}

void runMenu() {
  while (true) {
    _showMenu();
    stdout.write('Select an option: ');
    final selection = stdin.readLineSync()?.trim();

    if (selection == null) {
      print('\nInput ended. Goodbye.');
      return;
    }

    switch (selection) {
      case '1':
        registerEquipment(inventory);
      case '2':
        listEquipment(inventory);
      case '3':
        searchEquipment(inventory);
      case '4':
        markMaintenanceRequired(inventory);
      case '5':
        showInventorySummary(inventory);
      case '0':
        print('Goodbye.');
        return;
      default:
        print('Invalid selection. Enter a number from 0 to 5.');
    }
  }
}

void registerEquipment(List<Equipment> equipmentList) {
  final assetId = _readUniqueAssetId(equipmentList);
  if (assetId == null) {
    print('Registration canceled because input ended.');
    return;
  }

  final name = _readRequiredField('Equipment name: ');
  if (name == null) {
    print('Registration canceled because input ended.');
    return;
  }

  final category = _readRequiredField('Category: ');
  if (category == null) {
    print('Registration canceled because input ended.');
    return;
  }

  final location = _readRequiredField('Location: ');
  if (location == null) {
    print('Registration canceled because input ended.');
    return;
  }

  final condition = _readRequiredField('Condition: ');
  if (condition == null) {
    print('Registration canceled because input ended.');
    return;
  }

  equipmentList.add(
    Equipment(
      assetId: assetId,
      name: name,
      category: category,
      location: location,
      condition: condition,
    ),
  );
  print('Equipment "$name" registered with asset code "$assetId".');
}

void listEquipment(List<Equipment> equipmentList) {
  if (equipmentList.isEmpty) {
    print('No equipment has been registered.');
    return;
  }

  print('\nRegistered equipment (${equipmentList.length}):');
  for (final equipment in equipmentList) {
    _displayEquipment(equipment);
  }
}

void searchEquipment(List<Equipment> equipmentList) {
  stdout.write('Enter an asset code or equipment name: ');
  final query = stdin.readLineSync();
  if (query == null) {
    print('Search canceled because input ended.');
    return;
  }

  final trimmedQuery = query.trim();
  if (trimmedQuery.isEmpty) {
    print('Search term cannot be blank.');
    return;
  }

  final normalizedQuery = trimmedQuery.toLowerCase();
  final matches = equipmentList.where((equipment) {
    return equipment.assetId.toLowerCase() == normalizedQuery ||
        equipment.name.toLowerCase().contains(normalizedQuery);
  }).toList();

  if (matches.isEmpty) {
    print('No equipment found matching "$trimmedQuery".');
    return;
  }

  print('\nSearch results (${matches.length}):');
  for (final equipment in matches) {
    _displayEquipment(equipment);
  }
}

void markMaintenanceRequired(List<Equipment> equipmentList) {
  stdout.write('Enter the asset code requiring maintenance: ');
  final input = stdin.readLineSync();
  if (input == null) {
    print('Maintenance update canceled because input ended.');
    return;
  }

  final assetId = input.trim();
  if (assetId.isEmpty) {
    print('Asset code cannot be blank.');
    return;
  }

  Equipment? matchedEquipment;
  for (final equipment in equipmentList) {
    if (equipment.assetId.toLowerCase() == assetId.toLowerCase()) {
      matchedEquipment = equipment;
      break;
    }
  }

  if (matchedEquipment == null) {
    print('No equipment found with asset code "$assetId".');
    return;
  }

  if (matchedEquipment.maintenanceRequired) {
    print('Asset "${matchedEquipment.assetId}" already requires maintenance.');
    return;
  }

  matchedEquipment.maintenanceRequired = true;
  print('Asset "${matchedEquipment.assetId}" marked for maintenance.');
}

void showInventorySummary(List<Equipment> equipmentList) {
  final maintenanceCount =
      equipmentList.where((equipment) => equipment.maintenanceRequired).length;
  print('Total registered assets: ${equipmentList.length}');
  print('Assets requiring maintenance: $maintenanceCount');
}

void _displayEquipment(Equipment equipment) {
  print(
    'Asset code: ${equipment.assetId} | '
    'Name: ${equipment.name} | '
    'Category: ${equipment.category} | '
    'Location: ${equipment.location} | '
    'Condition: ${equipment.condition} | '
    'Maintenance required: ${equipment.maintenanceRequired ? 'Yes' : 'No'}',
  );
}

String? _readUniqueAssetId(List<Equipment> equipmentList) {
  while (true) {
    final assetId = _readRequiredField('Asset code: ');
    if (assetId == null) {
      return null;
    }

    final isDuplicate = equipmentList.any(
      (equipment) => equipment.assetId.toLowerCase() == assetId.toLowerCase(),
    );
    if (!isDuplicate) {
      return assetId;
    }

    print('An equipment record with that asset code already exists.');
  }
}

String? _readRequiredField(String prompt) {
  while (true) {
    stdout.write(prompt);
    final value = stdin.readLineSync();
    if (value == null) {
      return null;
    }

    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      print('This field is required and cannot be blank.');
      continue;
    }

    return trimmedValue;
  }
}

void _showMenu() {
  print('\nICT Laboratory Equipment Inventory');
  print('1. Register equipment');
  print('2. List equipment');
  print('3. Search equipment');
  print('4. Mark equipment for maintenance');
  print('5. Show inventory summary');
  print('0. Exit');
}
