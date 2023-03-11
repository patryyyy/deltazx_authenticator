import 'package:otp/otp.dart';

class GenerateVerificationCode {
  static String verificationCode(String secret) {
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  }
}
