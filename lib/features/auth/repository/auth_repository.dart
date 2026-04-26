import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalxproject/core/common/error_text.dart';
import 'package:totalxproject/core/constants/firebase_constants.dart';
import 'package:totalxproject/core/constants/image_constants.dart';
import '../../../core/providers/providers.dart';
import '../../../core/providers/utils..dart';
import '../../../model/admin_model.dart';

final authRepositoryProvider = Provider(
      (ref) => AuthRepository(
      firestore: ref.read(fireStoreProvider),
      auth: ref.read(authProvider),
      googleSignIn: ref.read(
        googleSignInProvider,
      )),
);


class AuthRepository{
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  AuthRepository({
    required FirebaseAuth auth, required FirebaseFirestore firestore, required GoogleSignIn googleSignIn}) :
        _auth = auth, _firestore = firestore, _googleSignIn = googleSignIn;

  CollectionReference get _admin => _firestore.collection(FirebaseConstants.adminCollection);
  Stream<User?> get authStateChange => _auth.authStateChanges();
  Future<AdminModel> signInWithGoogle(BuildContext context) async {
    try {
      UserCredential userCredential;
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();


      if (googleUser == null) {
        throw 'Google Sign-In cancelled';
      }

        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      userCredential = await _auth.signInWithCredential(credential);
      AdminModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = AdminModel(
            uid: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? "No Name",
            profilePic: userCredential.user!.photoURL ?? AppImages.avatarImage,
        );
        await _admin.doc(userCredential.user!.uid).set(userModel.toJson());
        if (context.mounted) {
          showSnackBar(context, "Login Successfully...");
        }
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return userModel;
    } catch(e){
      throw ErrorText(error: e.toString());
    }
  }


  Stream<AdminModel> getUserData(String uid) {
    return _admin.doc(uid).snapshots().map(
          (event) => AdminModel.fromJson(event.data() as Map<String, dynamic>),
    );
  }



}