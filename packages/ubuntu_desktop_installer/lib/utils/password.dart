import 'package:crypt/crypt.dart';
import 'package:password_strength/password_strength.dart' as pws;

/// The strength of a password.
enum PasswordStrength {
  /// A weak password.
  weak,

  /// A moderate strength password.
  moderate,

  /// A strong password.
  strong,
}

/// Estimates the strength of the given [password].
PasswordStrength estimatePasswordStrength(String password) {
  final strength = pws.estimatePasswordStrength(password);
  if (strength < 0.3) {
    return PasswordStrength.weak;
  } else if (strength < 0.7) {
    return PasswordStrength.moderate;
  } else {
    return PasswordStrength.strong;
  }
}

/// Supported hash algorithms.
enum Hash {
  /// SHA-256
  sha256,

  /// SHA-512
  sha512,
}

/// Encrypts a password.
String encryptPassword(
  String password, {
  Hash algorithm = Hash.sha512,
  String? salt,
}) {
  assert(password.isNotEmpty);
  switch (algorithm) {
    case Hash.sha256:
      return Crypt.sha256(password, salt: salt).toString();
    case Hash.sha512:
      return Crypt.sha512(password, salt: salt).toString();
  }
}