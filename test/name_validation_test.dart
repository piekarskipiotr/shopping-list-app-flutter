import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app_flutter/core/validators/name_validation.dart';

void main() {
  test('empty name returns false', () {
    var result = NameValidation.validate("");
    expect(result, false);
  });

  test('name with no letters returns false', () {
    var result = NameValidation.validate("777");
    expect(result, false);
  });

  test('name with at least one letter returns true', () {
    var result = NameValidation.validate("1l");
    expect(result, true);
  });

  test('name with special characters returns false', () {
    var result = NameValidation.validate("name&");
    expect(result, false);
  });

  test('name with space character returns true', () {
    var result = NameValidation.validate("say my name");
    expect(result, true);
  });
}