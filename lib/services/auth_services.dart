part of 'services.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;

  Future<String> signIn({
    @required String phone,
    @required BuildContext context,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+62$phone',
        verificationCompleted: (phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        },
        verificationFailed: (FirebaseAuthException error) {
          return error.message;
        },
        codeSent: (verificationId, [forceResendingToken]) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        timeout: Duration(seconds: 60),
      );
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<SignInSignUpResult> verifyOTP({
    @required String smsCode,
    @required BuildContext context,
  }) async {
    final AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      User user = userCredential.user;

      return SignInSignUpResult(user: user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-verification-code':
          return SignInSignUpResult(message: 'Invalid OTP!');
          break;
        default:
          return SignInSignUpResult(message: 'Something went wrong!');
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UpdateResult> updateEmail({@required String email}) async {
    try {
      await _auth.currentUser.updateEmail(email);
      return UpdateResult(status: 'success');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          return UpdateResult(
            status: 'error',
            message: 'Need login again!',
          );
          break;
        default:
          return UpdateResult(
            status: 'error',
            message: 'Something went wrong!',
          );
      }
    }
  }

  Future<UpdateResult> updatePhone({@required String phone}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+62$phone',
        verificationCompleted: null,
        verificationFailed: (FirebaseAuthException error) {
          return error.message;
        },
        codeSent: (verificationId, [forceResendingToken]) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        timeout: Duration(seconds: 60),
      );
      return UpdateResult(status: 'success');
    } on FirebaseAuthException catch (e) {
      return UpdateResult(status: 'error', message: e.message);
    }
  }

  Future<UpdateResult> verifyPhoneOTP({@required String smsCode}) async {
    final AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    try {
      await _auth.currentUser.updatePhoneNumber(phoneAuthCredential);

      return UpdateResult(status: 'success');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-verification-code':
          return UpdateResult(
            status: 'error',
            message: 'Invalid OTP!',
          );
          break;
        default:
          return UpdateResult(
            status: 'error',
            message: 'Something went wrong!',
          );
      }
    }
  }

  Future<UpdateResult> updatePassword({@required String password}) async {
    try {
      await _auth.currentUser.updatePassword(password);
      return UpdateResult(status: 'success');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          return UpdateResult(
            status: 'error',
            message: 'Need login again!',
          );
          break;
        default:
          return UpdateResult(
            status: 'error',
            message: 'Something went wrong!',
          );
      }
    }
  }

  Stream<User> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}

class UpdateResult {
  final String status;
  final String message;

  UpdateResult({this.status, this.message});
}
