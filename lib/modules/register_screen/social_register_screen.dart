import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/register_screen/register_cubit/social_register_cubit.dart';
import 'package:social_app/modules/register_screen/register_cubit/social_register_states.dart';
import 'package:social_app/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterSuccessState) {
            navigateAndEnd(context, SocialLayout());
          }
        },
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Communication is now easier register now to try it',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            text: 'Name',
                            controller: nameController,
                            prefix: Icons.person,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            type: TextInputType.name),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            text: 'Email Address',
                            controller: emailController,
                            prefix: Icons.email_outlined,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'email address must not be empty';
                              }
                            },
                            type: TextInputType.emailAddress),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            isPassword: cubit.isPassword,
                            text: 'Password',
                            controller: passwordController,
                            prefix: Icons.lock,
                            suffix: cubit.suffix,
                            suffixPressed: () {
                              cubit.changeSuffix();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password must not be empty';
                              }
                            },
                            type: TextInputType.visiblePassword),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            text: 'Phone',
                            controller: phoneController,
                            prefix: Icons.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your phone';
                              }
                            },
                            type: TextInputType.phone),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Conditional.single(
                          context: context,
                          fallbackBuilder: (BuildContext context) =>
                              const Center(
                            child: CircularProgressIndicator(),
                          ),
                          conditionBuilder: (BuildContext context) => state is! SocialRegisterLoadingState,
                          widgetBuilder: (BuildContext context) => SizedBox(
                            height: 50.0,
                            width: double.infinity,
                            child: MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit().userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              child: Text(
                                "Register".toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
