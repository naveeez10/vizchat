import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vizchat/pages/auth/login_page.dart';
import 'package:vizchat/pages/auth/register_page.dart';
import 'package:vizchat/pages/home_page.dart';
import 'package:vizchat/service/auth_service.dart';
import 'package:vizchat/shared/constants.dart';
import '../../widgets/widgets.dart';
import 'package:vizchat/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email = "";
  String password = "";
  String fullname = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 80,
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "VizChat",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Create your account now to chat explore!",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Image.asset("assets/register.png"),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "Full Name",
                          prefix: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            fullname = val!;
                          });
                        },
                        validator: (val) {
                          if (val != "") {
                            return null;
                          } else {
                            return "Full name cannot be blank";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "Email",
                          prefix: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            email = val!;
                          });
                        },
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Enter a Valid Email";
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          labelText: "Password",
                          prefix: Icon(
                            Icons.key,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password can't be less then 6 characters long";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: constants().primarycolor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text("Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                          onPressed: () {
                            register();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text.rich(TextSpan(
                        text: "Already have an account?  ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Sign in here",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, const LoginPage());
                                })
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formkey.currentState!.validate()) {
                setState(() {
                  _isLoading = true;
                });
                await authService
                    .registerUserWithEmailandPassword(fullname, email, password)
                    .then((value) async {
                  if(value == true) {
                    await HelperFunctions.saveUserLoggedInStatus(true);
                    await HelperFunctions.saveUserEmailSF(email);
                    await HelperFunctions.saveUsernameSF(fullname);
                    nextScreenreplace(context, const HomePage());
                  }
                  else {
                    showSnackBar(context,value,Colors.red);
              setState(() {
                _isLoading = false;
              });
            }
      });
    }
  }
}
