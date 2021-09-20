/*
Name validation:
    if is null or empty
    if contains at least one letter
    if contains special characters ('space' is allowed)
 */

class NameValidation {
  static bool validate(String? name) {
   return !(
       (name == null || name.isEmpty) ||
       !name.contains(RegExp("[A-Za-z\\p{L}\\p{N}_]")) ||
       name.contains(RegExp("[^A-Za-z0-9\\s\\p{L}\\p{N}_]"))
   );
  }
}