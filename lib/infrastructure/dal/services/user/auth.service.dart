import 'package:google_sign_in/google_sign_in.dart';

import '../../../../domain/auth/model/user.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    try {
      final auth = await _googleSignIn.signIn();
      final result = await auth!.authentication;
      return User(name: auth.displayName!,
          email: auth.email,
          accToken: result.accessToken!,
          idToken: result.idToken!,
          urlPhoto: auth.photoUrl!,
      );
    } catch (e) {
      throw 'error';
    }
  }

  Future<void> signOutGoogle()async{
    await _googleSignIn.signOut();
  }
}