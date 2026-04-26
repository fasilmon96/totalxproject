class Validation{
  static String? nameValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your name";
    }
    final nameValid = RegExp(r'^[a-zA-Z\s]{5,}$');

    if (!nameValid.hasMatch(value)) {
      if (value.length < 5) {
        return "Name must be at least 5 letters";
      }
      return "Only alphabets are allowed";
    }

    return null;
  }
  static String? ageValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your age";
    }
    if (value.length > 3) {
      return "Age cannot be more than 3 digits";
    }
    final ageRegExp = RegExp(r'^[0-9]+$');
    if (!ageRegExp.hasMatch(value)) {
      return "Please enter a valid number";
    }
    int age = int.parse(value);
    if (age > 120) {
      return "Please enter a valid age (0-120)";
    }

    return null;
  }

  static String? phoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone number";
    }
    final phoneValid = RegExp(r'^[0-9]{10}$');

    if (!phoneValid.hasMatch(value)) {
      return "Please enter a valid 10-digit phone number";
    }

    return null;
  }

}


