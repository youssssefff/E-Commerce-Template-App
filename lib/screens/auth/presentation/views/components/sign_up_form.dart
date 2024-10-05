import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/auth/domain/data/datasources/auth_remote_data_source.dart';
import 'package:shop/screens/auth/presentation/adapter/auth_adapter.dart';
import 'package:shop/screens/auth/presentation/adapter/auth_state.dart';
import 'package:shop/utils/constants.dart';

import 'package:http/http.dart' as http;

class SignUpForm extends StatelessWidget {
  SignUpForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (value) {
              email = value!;
            },
            initialValue: "johndoe@example.com",
            validator: emaildValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email address",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Message.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            onSaved: (value) {
              password = value!;
            },
            initialValue: "StrongPassword123",
            validator: passwordValidator.call,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Lock.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
              if (state is LoggedIn) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  entryPointScreenRoute,
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
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    // Trigger login event in the Cubit
                    context.read<AuthCubit>().register(email!, password!);
                  }
                },
                child: const Text("Log in"),
              );
            },
          ),
        ],
      ),
    );
  }
}
