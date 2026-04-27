import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/admin_model.dart';
import '../repository/auth_repository.dart';

final userProvider = StateProvider<AdminModel?>((ref) => null,);
final authControllerProvider = Provider<AuthController>(
        (ref)=>AuthController(authRepository:ref.watch(authRepositoryProvider),
    )
);
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.authStateChange;

},);

final userDataProvider = StreamProvider.family<AdminModel?, String>((ref, uid) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData(uid);
});

final adminProvider = StateProvider<AdminModel?>((ref) => null,);

class AuthController{
  final AuthRepository _authRepository;
  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    await  _authRepository.signInWithGoogle(context);
  }

  Stream<AdminModel?> getUserData(String uid){
    return _authRepository.getUserData(uid);
  }


  void logout (BuildContext context) {
    _authRepository.logout(context);
  }

}
