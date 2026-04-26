import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalxproject/core/common/error_text.dart';
import 'package:totalxproject/core/constants/firebase_constants.dart';
import 'package:totalxproject/core/constants/image_constants.dart';
import '../../../core/providers/providers.dart';
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

  CollectionReference get _users => _firestore.collection(FirebaseConstants.adminCollection);
  Stream<User?> get authStateChange => _auth.authStateChanges();
  Future<UserModel> signInWithGoogle() async {
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
      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            uid: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? "No Name",
            profilePic: userCredential.user!.photoURL ?? AppImages.avatarImage,
        );
        await _users.doc(userCredential.user!.uid).set(userModel.toJson());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return userModel;
    } catch(e){
      throw ErrorText(error: e.toString());
    }
  }


  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
          (event) => UserModel.fromJson(event.data() as Map<String, dynamic>),
    );
  }



}