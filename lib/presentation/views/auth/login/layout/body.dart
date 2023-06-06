import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/infrastructure/models/user_model.dart';
import 'package:social_app/infrastructure/providers/app_state.dart';
import 'package:social_app/infrastructure/providers/sign_up_provider.dart';

class LoginBody extends StatelessWidget {
  LoginBody({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignUpProvider signUp = Provider.of<SignUpProvider>(context);
    var user = Provider.of<User?>(context);
    return Container(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                _signuUser(context: context, signUp: signUp, user: user);
              },
              child: Text('data'))
        ],
      ),
    );
  }

  _signuUser(
      {required BuildContext context,
      required SignUpProvider signUp,
      required User? user}) {
    ///This function will start loading when tap the button
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);

    signUp
        .registerNewUser(
            email: emailController.text,
            password: pwdController.text,
            userModel: UserModel(name: 'Test Name', email: 'emaiController'),
            context: context,
            user: user)
        .then((value) {
      Provider.of<AppState>(context, listen: false)
          .stateStatus(StateStatus.IsFree);

      ///after that navigate to next screen
    });
  }
}
