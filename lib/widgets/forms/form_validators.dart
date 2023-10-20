String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty || !value.contains('@')) {
    return 'Please enter valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty || value.trim().length < 6) {
    return 'Please enter your password (must be atleast 6 characters long)';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please provide your Name';
  }
  return null;
}

String? validateSurname(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please provide your Surname';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty || value.trim().length > 10) {
    return 'Please provide a valid phone number';
  }
  return null;
}

String? validatePetName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your pet\'s name ';
  }
  return null;
}

String? validatePetage(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter valid pet age ';
  }
  return null;
}
