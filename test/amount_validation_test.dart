import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app_flutter/core/validators/amount_validation.dart';

void main() {
  test('empty amount returns false', () {
    var result = AmountValidation.validate("");
    expect(result, false);
  });

  test('amount that contains only 0 returns false', () {
    var result = AmountValidation.validate("00");
    expect(result, false);
  });

  test('amount that contains special characters returns false', () {
    var result = AmountValidation.validate("123.");
    expect(result, false);
  });

  test('example amount that returns true', () {
    var result = AmountValidation.validate("7");
    expect(result, true);
  });
}