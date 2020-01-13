import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controlefinanceiroapp/app/shared/repositories/auth_repository.dart';
import 'package:controlefinanceiroapp/app/shared/services/secure_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthBloc extends BlocBase {
  final AuthRepository authRepository;
  final SecureStorageService secureStorage;

  AuthBloc(this.authRepository, this.secureStorage);

  TextEditingController email$ = TextEditingController();
  TextEditingController password$ = TextEditingController();

  void _storeUserData(FirebaseUser user) async {
    String uid = user.uid;
    IdTokenResult token = await user.getIdToken(refresh: true);
    print(token.expirationTime);
    secureStorage.storeUid(uid);
    secureStorage.storeToken(token.token);
    secureStorage.storeExpirationTime(token.expirationTime);
  }

  Future<FirebaseUser> signInEmail(String email, String password) async {
    FirebaseUser user = await authRepository.handleSignIn(email, password);
    _storeUserData(user);
    return user;
  }

  Future<FirebaseUser> signInGoogle() async {
    FirebaseUser user = await authRepository.handleGoogleSignIn();
    _storeUserData(user);
    return user;
  }

  Future<FirebaseUser> registerUser(String email, String password) async {
    FirebaseUser user = await authRepository.registerUser(email, password);
    _storeUserData(user);
    return user;
  }

  void resetPassword(String email) {
    authRepository.forgotPassword(email);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
