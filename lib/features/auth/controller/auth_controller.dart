import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/features/home/screen/home_screen.dart';
import '../../../core/providers/utils..dart';
import '../../../model/user_model.dart';
import '../repository/auth_repository.dart';
final userProvider = StateProvider<UserModel?>((ref) => null,);
final authControllerProvider = Provider<AuthController>(
        (ref)=>AuthController(authRepository:ref.read(authRepositoryProvider),
      ref: ref,
    )
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.authStateChange;

},);

class AuthController{
  final AuthRepository _authRepository;
  AuthController({required AuthRepository authRepository,required Ref ref})
      : _authRepository = authRepository;

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    await  _authRepository.signInWithGoogle();
    showSnackBar(context, "Login Successfully...");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,);
  }

  Stream<UserModel> getUserData(String uid){
    return _authRepository.getUserData(uid);
  }

}
