import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "../../../FirebaseCredentials/firebase_environment.dart";
import "../../General/loader.dart";

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
      errorMessage = "Please fill in all the fields";
    } else if (_controllerConfirmPassword.text != _controllerPassword.text) {
      errorMessage = "Passwords do not match";
    } else {
      try {
        isLoading = true;
        await AuthHandler().createUserWithEmailAndPassword(
            username: _controllerUsername.text,
            email: _controllerEmail.text,
            password: _controllerPassword.text);
      } on FirebaseAuthException catch (e) {
        print(e.message);
        setState(() {
          errorMessage = "Registraation unsuccessful. Please try again.";
        });
        isLoading = false;
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
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(151, 0, 0, 1),
            ),
            child: Text(errorMessage == '' ? '' : '$errorMessage',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)));
  }

  Widget _submitButton() {
    return Container(
        // width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: isLogin
                ? signInWithEmailAndPassword
                : createUserWithEmailAndPassword,
            child: Text(
                style: TextStyle(color: Colors.white),
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
          });
        },
        child: Text(
            style: TextStyle(color: Colors.black87),
            isLogin
                ? "Don't have an account? Register here!"
                : "Already have an account? Sign in here!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Text("GreenQuest",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Color.fromRGBO(15, 108, 0, 1))),
                      isLogin
                          ? Container()
                          : _entryField(
                              'Username*', _controllerUsername, false),
                      SizedBox(height: 10),
                      _entryField('Email*', _controllerEmail, false),
                      SizedBox(height: 10),
                      _entryField('Password*', _controllerPassword, true),
                      SizedBox(height: 10),
                      isLogin
                          ? Container()
                          : _entryField('Confirm Password*',
                              _controllerConfirmPassword, true),
                      SizedBox(height: 10),
                      _submitButton(),
                      SizedBox(height: 10),
                      _ToggleLoginRegister(),
                      SizedBox(height: 10),
                      _errorMessage()
                    ])));
  }
}
