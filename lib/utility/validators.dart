String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }

  RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  if (!regex.hasMatch(value)) {
    return 'Please provide a valid email address';
  }

  // If the email is valid, return null
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  // Check if the password meets your criteria
  // For example, you can enforce a minimum length
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }

  // You can add more password validation criteria as needed

  // If the password is valid, return null
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    print('please enter name');
    return 'Please enter your name';
  }
  return null;
}
