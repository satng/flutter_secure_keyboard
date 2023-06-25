import 'package:flutter_secure_keyboard/src/secure_keyboard_key.dart';
import 'package:flutter_secure_keyboard/src/secure_keyboard_key_action.dart';
import 'package:flutter_secure_keyboard/src/secure_keyboard_key_type.dart';

/// A class responsible for key generation of the secure keyboard.
class SecureKeyboardKeyGenerator {
  SecureKeyboardKeyGenerator._internal();

  static final instance = SecureKeyboardKeyGenerator._internal();

  final List<List<String>> _numericKeyRows = [
    const ['1', '2', '3'],
    const ['4', '5', '6'],
    const ['7', '8', '9'],
    const [],
  ];

  final List<List<String>> _alphanumericKeyRows = [
    const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
    const ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
    const ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
    const ['z', 'x', 'c', 'v', 'b', 'n', 'm'],
    const [],
  ];

  final List<List<String>> _specialCharsKeyRows = [
    const ['!', '@', '#', '\$', '%', '^', '&', '*', '(', ')'],
    const ['-', '=', '+', '{', '}', '[', ']', '\\', ':', ';'],
    const ['\"', '\'', '<', '>', ',', '.', '/', '?', '|'],
    const ['~', '`', '_', '\₩', '#', '@', '!'],
    const [],
  ];

  /// Returns a list of numeric key rows.
  List<List<SecureKeyboardKey>> getNumericKeyRows(bool shuffle) {

    return List.generate(_numericKeyRows.length, (int rowNum) {
      List<SecureKeyboardKey> rowKeys = [];

      switch (rowNum) {
        case 3:
          rowKeys.add(_buildStringKey("0"));
          rowKeys.add(_backspaceActionKey(20));
          rowKeys.add(_clearActionKey());
          rowKeys.add(_doneActionKey());
          break;
        default:
          rowKeys = _buildStringKeyRow(_numericKeyRows, rowNum);
          if (shuffle) {
            rowKeys.shuffle();
          }
      }

      return rowKeys;
    });
  }

  /// Returns a list of alphanumeric key rows.
  List<List<SecureKeyboardKey>> getAlphanumericKeyRows(bool shuffle) {

    return List.generate(_alphanumericKeyRows.length, (int rowNum) {
      List<SecureKeyboardKey> rowKeys = [];

      switch (rowNum) {
        case 3:
          rowKeys.add(_shiftActionKey(30));
          rowKeys.addAll(_buildStringKeyRow(_alphanumericKeyRows, rowNum));
          rowKeys.add(_backspaceActionKey(30));
          break;
        case 4:
          rowKeys.add(_specialCharsActionKey());
          rowKeys.add(_clearActionKey());
          rowKeys.add(_doneActionKey());
          break;
        default:
          rowKeys = _buildStringKeyRow(_alphanumericKeyRows, rowNum);
          if (rowNum == 0 && shuffle) {
            rowKeys.shuffle();
          }
          if (rowNum == 2) {
            rowKeys.add(_blankActionKey(10));
            rowKeys.insert(0, _blankActionKey(10));
          }
      }

      return rowKeys;
    });
  }

  /// Returns a list of special characters key rows.
  List<List<SecureKeyboardKey>> getSpecialCharsKeyRows() {

    return List.generate(_specialCharsKeyRows.length, (int rowNum) {
      List<SecureKeyboardKey> rowKeys = [];

      switch (rowNum) {
        case 3:
          rowKeys.add(_shiftActionKey(30));
          rowKeys.addAll(_buildStringKeyRow(_specialCharsKeyRows, rowNum));
          rowKeys.add(_backspaceActionKey(30));
          break;
        case 4:
          rowKeys.add(_specialCharsActionKey());
          rowKeys.add(_clearActionKey());
          rowKeys.add(_doneActionKey());
          break;
        default:
          rowKeys = _buildStringKeyRow(_specialCharsKeyRows, rowNum);
          if (rowNum == 2) {
            rowKeys.add(_blankActionKey(10));
            rowKeys.insert(0, _blankActionKey(10));
          }
      }

      return rowKeys;
    });
  }

  // Create a string type key row.
  List<SecureKeyboardKey> _buildStringKeyRow(List<List<String>> keyRows, int rowNum) {
    String key;
    return List.generate(keyRows[rowNum].length, (int keyNum) {
      key = keyRows[rowNum][keyNum];
      return SecureKeyboardKey(text: key, type: SecureKeyboardKeyType.STRING);
    });
  }

  // Create a string type key.
  SecureKeyboardKey _buildStringKey(String key) {
    return SecureKeyboardKey(text: key, type: SecureKeyboardKeyType.STRING);
  }

  // Build a blank action key.
  SecureKeyboardKey _blankActionKey(int flex) {
    return SecureKeyboardKey(type: SecureKeyboardKeyType.ACTION, action: SecureKeyboardKeyAction.BLANK, flex: flex);
  }

  // Create a backspace action key.
  SecureKeyboardKey _backspaceActionKey(int flex) {
    return SecureKeyboardKey(type: SecureKeyboardKeyType.ACTION, action: SecureKeyboardKeyAction.BACKSPACE, flex: flex);
  }

  // Build a done action key.
  SecureKeyboardKey _doneActionKey() {
    return SecureKeyboardKey(type: SecureKeyboardKeyType.ACTION, action: SecureKeyboardKeyAction.DONE);
  }

  // Build a clear action key.
  SecureKeyboardKey _clearActionKey() {
    return SecureKeyboardKey(type: SecureKeyboardKeyType.ACTION, action: SecureKeyboardKeyAction.CLEAR);
  }

  // Build a shift action key.
  SecureKeyboardKey _shiftActionKey(int flex) {
    return SecureKeyboardKey(type: SecureKeyboardKeyType.ACTION, action: SecureKeyboardKeyAction.SHIFT, flex: flex);
  }

  // Build a special characters action key.
  SecureKeyboardKey _specialCharsActionKey() {
    return SecureKeyboardKey(type: SecureKeyboardKeyType.ACTION, action: SecureKeyboardKeyAction.SPECIAL_CHARACTERS);
  }
}
