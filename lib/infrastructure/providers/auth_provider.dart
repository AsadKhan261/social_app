import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:social_app/infrastructure/providers/error_provider.dart';
import 'package:social_app/infrastructure/providers/sign_up_provider.dart';


enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthServices with ChangeNotifier {
  FirebaseAuth _auth;
  late User? _user;
  Status _status = Status.Uninitialized;

  AuthServices.instance() : _auth = FirebaseAuth.instance {
    _auth.idTokenChanges().listen(_onAuthStateChanged);
  }

  ///Using Stream to listen to Authentication State
  Stream<User?> get authState => _auth.idTokenChanges();

  ///It will use to set the login State
  void setState(Status status) {
    _status = status;
    notifyListeners();
  }

  ///It will give the current user login State
  Status get status => _status;

  ///It will give the current firebase user.
  User? get user => _user;

  // ///This will method will authenticate users from Firebase.
  // Future<User?> signIn(BuildContext context,
  //     {required String email, required String password}) async {
  //   try {
  //     setState(Status.Authenticating);
  //     UserCredential user = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     setState(Status.Authenticated);
  //     return user.user;
  //   } on FirebaseAuthException catch (e) {
  //     setState(Status.Unauthenticated);
  //     Provider.of<ErrorString>(context, listen: false)
  //         .saveErrorString(e.message!);
  //     return null;
  //   }
  // }







  ///This method will register user to firebase.
  Future<User?> signUp(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } on FirebaseAuthException catch (e) {
      Provider.of<ErrorString>(context, listen: false)
          .saveErrorString(e.message!);
      Provider.of<SignUpProvider>(context, listen: false)
          .setState(SignUpStatus.Failed);
      return null;
    }
  }







  //
  // ///This method will reset the password.
  // Future forgotPassword(BuildContext context, {required String email}) async {
  //   try {
  //     setState(Status.Authenticating);
  //     await _auth.sendPasswordResetEmail(email: email);
  //     setState(Status.Authenticated);
  //   } on FirebaseAuthException catch (e) {
  //     Provider.of<ErrorString>(context, listen: false)
  //         .saveErrorString(e.message!);
  //     setState(Status.Unauthenticated);
  //     return null;
  //   }
  // }
  //
  // ///Use to signOut user from firebase.
  // Future signOut() async {
  //   _auth.signOut();
  //   _status = Status.Unauthenticated;
  //   notifyListeners();
  //   return Future.delayed(Duration.zero);
  // }
  //
  // ///Constantly check for the users whether he loggedIn or loggedOut
  Future<User?> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
  }




  //
  // Future<void> changePassword(BuildContext context,
  //     {required String currentPassword, required String newPassword}) async {
  //   Provider.of<AppState>(context, listen: false)
  //       .stateStatus(StateStatus.IsBusy);
  //   final user = FirebaseAuth.instance.currentUser;
  //
  //   try {
  //     final cred = EmailAuthProvider.credential(
  //         email: user!.email!, password: currentPassword);
  //     await user.reauthenticateWithCredential(cred).then((value) async {
  //       await user.updatePassword(newPassword).then((_) {
  //         Provider.of<AppState>(context, listen: false)
  //             .stateStatus(StateStatus.IsFree);
  //       });
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     Provider.of<ErrorString>(context, listen: false)
  //         .saveErrorString(e.message!);
  //     setState(Status.Unauthenticated);
  //     Provider.of<AppState>(context, listen: false)
  //         .stateStatus(StateStatus.IsError);
  //     return null;
  //   }
  // }
}
