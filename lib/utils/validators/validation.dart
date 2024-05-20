class MValidator {
  //Empty Text Validation
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == '' || value!.isEmpty) {
      return "$fieldName is required.";
    }
    return null; //if value is not empty then return null
  }

  static String? validateEmail(String? value) {
    if (value == '' || value!.isEmpty) {
      return "Email is required.";
    }

    //Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == '' || value!.isEmpty) {
      return 'Password is required.';
    }
    //Check for minimum password length
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }

    //Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    //Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    //Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special characters.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == '' || value!.isEmpty) {
      return 'Phone number is required.';
    }
    //Regular Expression for phone number validation (assuming a 10-digit US phone number formate)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format(10 digit required).';
    }
    return null;
  }
}
