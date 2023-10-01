import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../FirebaseFeatures/authentication.dart';
import "../../General/loader.dart";
import 'package:lottie/lottie.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? errorMessage = '';
  bool isLogin = true;
  bool isLoading = false;

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });

      await AuthHandler()
          .signInWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text)
          .then((res) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, '/home');
      }).catchError((onError) {
        setState(() {
          isLoading = false;
          errorMessage = "Login unsuccessful. Please try again.";
        });
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);

      setState(() {
        errorMessage = "Login unsuccessful. Please try again.";
        isLoading = false;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    if (_controllerUsername.text == '' ||
        _controllerEmail.text == '' ||
        _controllerPassword.text == '' ||
        _controllerConfirmPassword.text == '') {
      setState(() {
        errorMessage = "Please fill in all the fields";
      });
    } else if (_controllerConfirmPassword.text != _controllerPassword.text) {
      setState(() {
        errorMessage = "Passwords do not match";
      });
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        await AuthHandler().createUserWithEmailAndPassword(
            username: _controllerUsername.text,
            email: _controllerEmail.text,
            password: _controllerPassword.text);
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        print(e.message);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _title() {
    return const Text("Login");
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
    bool isMasked,
  ) {
    return TextField(
        obscureText: isMasked,
        controller: controller,
        decoration: InputDecoration(labelText: title));
  }

  Widget _errorMessage() {
    return errorMessage == ''
        ? Container()
        : Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(151, 0, 0, 1),
            ),
            child: Text(errorMessage == '' ? '' : '$errorMessage',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)));
  }

  Widget _submitButton() {
    return Container(
        // width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: isLogin
                ? signInWithEmailAndPassword
                : createUserWithEmailAndPassword,
            child: Text(
                style: const TextStyle(color: Colors.white),
                isLogin ? "Sign In" : "Register")));
  }

  Widget _ToggleLoginRegister() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
            errorMessage = "";
            _controllerEmail.text = "";
            _controllerPassword.text = "";
            _controllerUsername.text = "";
            _controllerConfirmPassword.text = "";
          });
        },
        child: Text(
            style: const TextStyle(color: Colors.black87),
            isLogin
                ? "Don't have an account? Register here!"
                : "Already have an account? Sign in here!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: isLoading == true
            ? Loader(title: isLogin ? "Logging in..." : "Registering...")
            : Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Lottie.asset(
                        'assets/animation_ln3bcryl.json', // Path to Lottie animation JSON file
                        width: 200,
                        height: 200,
                        repeat: true, // Set to true to loop the animation
                        reverse: false, // Set to true to reverse the animation
                        animate: true, // Set to false to pause the animation
                      ),
                      const Text("GreenQuest",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Color.fromRGBO(15, 108, 0, 1))),
                      isLogin
                          ? Container()
                          : _entryField(
                              'Username*', _controllerUsername, false),
                      const SizedBox(height: 10),
                      _entryField('Email*', _controllerEmail, false),
                      const SizedBox(height: 10),
                      _entryField('Password*', _controllerPassword, true),
                      const SizedBox(height: 10),
                      isLogin
                          ? Container()
                          : _entryField('Confirm Password*',
                              _controllerConfirmPassword, true),
                      const SizedBox(height: 10),
                      _submitButton(),
                      const SizedBox(height: 10),
                      _ToggleLoginRegister(),
                      const SizedBox(height: 10),
                      _errorMessage()
                    ])));
  }
}
