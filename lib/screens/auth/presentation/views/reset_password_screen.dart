import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/common/app/providers/email_provider.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/auth/presentation/adapter/auth_adapter.dart';
import 'package:shop/screens/auth/presentation/adapter/auth_state.dart';
import 'package:shop/utils/constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? newPassword;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    String? email = context.watch<EmailProvider>().email;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reset Password",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: defaultPadding / 2),
              const Text(
                "Please enter your new password.",
              ),
              const SizedBox(height: defaultPadding),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        newPassword = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a new password";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "New Password",
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),

                    const SizedBox(height: defaultPadding * 2),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                        if (state is ResetPasswordSuccess) {
                          // Navigate to the login screen or desired screen after reset
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            logInScreenRoute,
                            ModalRoute.withName(signUpScreenRoute),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        }

                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // Trigger the reset password event
                              context.read<AuthCubit>().resetPassword(newPassword!,email!);
                            }
                          },
                          child: const Text("Reset Password"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
