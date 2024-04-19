import 'package:flutter/services.dart';


/// Methods to validates form fields against the input

String getErrorMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case 'invalid-credential':
      return 'Invalid credentials';
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'user-disabled':
      return 'Your account has been disabled. Please contact support.';
    case 'user-not-found':
      return 'No account found with this email.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    case 'weak-password':
      return 'The password is too weak. Please choose a stronger one.';
    case 'email-already-in-use':
      return 'An account already exists with this email.';
    case 'operation-not-allowed':
      return 'This operation is not allowed.';
    case 'requires-recent-login':
      return 'Please logout and log in again to continue';
    case 'too-many-requests':
      return 'Too many requests. Please try again later.';
    case 'network-request-failed':
      return 'Network error. Please check your internet connection.';
    default:
      return 'An unknown error occurred. Please try again.';
  }
}


extension PasswordValidation on String {
  String? get invalidPasswordReason {
    if (isEmpty) return "Password can't be empty";
    if (length < 5) return "Password must be at least 5 characters long";
    if (length > 8) return "Password must be at most 8 characters long";
    if (contains(' ')) return "Password should not contain spaces";
    return null;
  }
}

class PasswordInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp noSpace = RegExp(r'^[^ ]*$');

    if (newValue.text.isEmpty) {
      return const TextEditingValue(); // Allow empty text
    } else if (newValue.text.length > 8) {
      // Return old value if the new value is too long
      return oldValue.copyWith(text: oldValue.text);
    } else if (!noSpace.hasMatch(newValue.text)) {
      // Return old value if the new value contains spaces
      return oldValue.copyWith(text: oldValue.text);
    } else {
      // Allow the new value
      return newValue;
    }
  }
}

extension EmailValidation on String {
  String? get invalidEmailReason {
    if (isEmpty) return "Email can't be empty";
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(this)) {
      return "Invalid email format";
    }
    return null;
  }
}

class EmailInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final regExp = RegExp(r'^[a-zA-Z0-9.@_-]+$');

    if (regExp.hasMatch(newValue.text)) {
      return newValue; // Return the new value if it matches the email pattern
    } else {
      // Return the old value if the new value doesn't match the pattern
      return oldValue;
    }
  }
}


extension NameValidation on String {
  String? validateName() {
    // Check if the value is empty
    if (isEmpty) {
      return 'Please enter your name';
    }
    // Define your regex pattern for the name
    final regExp = RegExp(r'^[a-zA-Z\s]+$');
    // Check if the value matches the regex pattern
    if (!regExp.hasMatch(this)) {
      return 'Please enter a valid name';
    }
    // If the value passes all checks, return null indicating no error
    return null;
  }

  String? validateRegisterNumber() {
    if (isEmpty) {
      return 'Please enter the register number';
    }
    // Define your regex pattern for the register number
    final regExp = RegExp(r'^[a-zA-Z0-9]+$');
    // Check if the value matches the regex pattern
    if (!regExp.hasMatch(this)) {
      return 'Please enter a valid register number';
    }
    // If the value passes all checks, return null indicating no error
    return null;
  }

  String? validateAddress() {
    if (isEmpty) {
      return 'Please enter your address';
    }
    // Additional validation rules can be added here
    return null;
  }

  String? validatePhoneNumber() {
    if (isEmpty) {
      return 'Please enter your phone number';
    }
    // Define your regex pattern for the phone number
    final regExp = RegExp(r'^[0-9]+$');
    // Check if the value matches the regex pattern
    if (!regExp.hasMatch(this)) {
      return 'Please enter a valid phone number';
    }
    // If the value passes all checks, return null indicating no error
    return null;
  }

  String? validateWebsite() {
    if (isEmpty) {
      return 'Please enter a website';
    }
    // Additional validation rules can be added here
    return null;
  }

}


final List<TextInputFormatter> nameInputFormatter = [
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
];