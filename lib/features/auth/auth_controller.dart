import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:vinnovatelabz_app/features/auth/auth_model.dart';
import 'package:vinnovatelabz_app/utils/validators_and_extenstions.dart';



/// A change notifier class to facilitate and abstract view class from functional implementation regarding to authentication feature.

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  User? get user => _user;
  bool isLoading = false;

  AuthController() {
    _user = FirebaseAuth.instance.currentUser;
    debugPrint('isUserLoggedIn ${_user != null}');
    notifyListeners();
  }

  Future<dynamic> loginUser(LoginModel loginCredentials) async {
    try {
      isLoading = true;
      notifyListeners();

      final userLoginRes = await _auth.signInWithEmailAndPassword(
        email: loginCredentials.email,
        password: loginCredentials.password,
      );
      _user = userLoginRes.user;
      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseException catch (exc, stack) {
      debugPrint('ExceptionCaughtWhileUserLogin $exc\n $stack');
      final errorMessage = getErrorMessageFromErrorCode(exc.code);
      isLoading = false;
      notifyListeners();
      return errorMessage;
    }
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.currentUser?.reload();
      FirebaseAuth.instance.authStateChanges().listen((user) {
        debugPrint('login state change identified $user');
        _user = user;
        notifyListeners();
        // _initialScreen(user);
      });
      notifyListeners();
      return true;
    } catch (exc, stack) {
      debugPrint('ExceptionCaughtWhileLoggingOut $exc \n $stack');
      return false;
    }
  }
}
