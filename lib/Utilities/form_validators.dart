class FormValidators {

    String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,7}$',
    ).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

     String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  

}