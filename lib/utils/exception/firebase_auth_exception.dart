class MFirebaseAuthException implements Exception {
  //Error code associated with the exception
  final String code;
  //Constructor that takes an error code
  MFirebaseAuthException(this.code);

  //Get the corresponding error message based on the error code

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The Email address is already registered. Please use a different email';
      case 'invalid-email':
        return 'The email address provided is invalid .Please enter a valid email';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance';
      case 'user-not-found':
        return 'Invalid login details. User not found';
      case 'wrong-password':
        return 'Incorrect password .Please check the password and try again';
      case 'invalid-verification-code':
        return 'Invalid Verification Code. Please enter a valid code';
      case 'invalid-verification-id':
        return 'Invalid-Verification-Id. Please request a new verification code';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later';
      case 'provider-already-exist':
        return 'The account already linked with another provider';
      case 'email-already-exist':
        return 'The email address already exist .Please use a different email';
      default:
        return 'This credential is already associated with another';
    }
  }
}
