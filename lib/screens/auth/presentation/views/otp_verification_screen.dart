import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/common/app/providers/email_provider.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/auth/presentation/adapter/auth_adapter.dart';
import 'package:shop/screens/auth/presentation/adapter/auth_state.dart';
import 'package:shop/utils/constants.dart';

class OtpVerificationScreen extends StatefulWidget {

  const OtpVerificationScreen({super.key,});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? otp;

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
              const SizedBox(height: defaultPadding * 4),
              Text(
                "Verify OTP",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: defaultPadding / 2),
              const Text(
                "We have sent a 6-digit OTP to your email address. Please enter it below to verify.",
              ),
              const SizedBox(height: defaultPadding),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        otp = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the OTP";
                        } else if (value.length != 6) {
                          return "OTP must be 6 digits";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        hintText: "Enter 6-digit OTP",
                        counterText: '',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                        if (state is OTPVerified) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            newPasswordScreenRoute,
                            ModalRoute.withName(logInScreenRoute),
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
                              // Trigger OTP verification event
                              context.read<AuthCubit>().verifyResetOtp(email!, otp!);
                            }
                          },
                          child: const Text("Verify OTP"),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding * 2),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Resend OTP action
                    context.read<AuthCubit>().forgotPassword(email!);
                  },
                  child: const Text("Resend OTP"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
