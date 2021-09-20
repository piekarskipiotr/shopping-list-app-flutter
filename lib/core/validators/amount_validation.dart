/*
Amount validation:
    if is null or empty
    if contains others numbers than 0
    if contains special characters
 */

class AmountValidation {
  static bool validate(String? amount) {
    return !(
        (amount == null || amount.isEmpty) ||
        !amount.contains(RegExp("[1-9]")) ||
        amount.contains(RegExp("[^0-9]"))
    );
  }
}