import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/auth/domain/data/datasources/auth_remote_data_source.dart';
import 'components/login_form.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black38,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            child: Image.asset(
              "assets/images/caspule-2-1.webp",
              fit: BoxFit.cover,
            ),
          ),

          // Bottom Container
          Align(
            alignment: Alignment.bottomCenter,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Adjust the height to fit content
                  children: [
                    Text(
                      "Welcome back!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    const Text(
                      "Log in with your data that you entered during your registration.",
                    ),
                    const SizedBox(height: defaultPadding),
                    LogInForm(
                      formKey: _formKey,
                    ),
                    Align(
                      child: TextButton(
                        child: const Text("Forgot password"),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, passwordRecoveryScreenRoute);
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height > 700
                          ? size.height * 0.1
                          : defaultPadding,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, signUpScreenRoute);
                          },
                          child: const Text("Sign up"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}