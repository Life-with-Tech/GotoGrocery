class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateName(String? value) {
    // Check if the name is empty
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }

    // Check if the name is too short
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    // Check if the name contains only letters (optional)
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Name must contain only letters';
    }

    return null; // Validation passed
  }
}
