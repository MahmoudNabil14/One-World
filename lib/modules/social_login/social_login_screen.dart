import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_login/social_login_cubit/social_login_cubit.dart';
import 'package:social_app/modules/social_login/social_login_cubit/social_login_states.dart';
import 'package:social_app/modules/social_register/social_register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            showToast(message: state.error.toString(), state: toastStates.ERROR);
          }
          else if(state is SocialLoginSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              uId = CacheHelper.getData(key: 'uId');
              navigateAndEnd(context, const SocialLayout());
            });
          }
        },
        builder: (context,state){
          var loginCubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics:  const BouncingScrollPhysics(),
                child: Padding(
                  padding:  const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login into you account',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                         const SizedBox(
                          height: 30.0,
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
                            isPassword: loginCubit.isPassword,
                            text: 'Password',
                            controller: passwordController,
                            prefix: Icons.lock,
                            suffix: loginCubit.suffix,
                            suffixPressed: () {
                              loginCubit.changeSuffix();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password must not be empty';
                              }
                            },
                            onSubmit: (String value) {
                              if (formKey.currentState!.validate()) {
                                // loginCubit.userLogin(
                                //     email: emailController.text,
                                //     password: passwordController.text);
                              }
                            },
                            type: TextInputType.visiblePassword),
                         const SizedBox(
                          height: 15.0,
                        ),
                        Conditional.single(
                          context: context,
                          fallbackBuilder: (BuildContext context) =>  const Center(
                            child: CircularProgressIndicator(),
                          ),
                          conditionBuilder: (BuildContext context) =>true ,
                          widgetBuilder: (BuildContext context) => SizedBox(
                            height: 50.0,
                            width: double.infinity,
                            child: MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  loginCubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child:  const Text(
                                "LOGIN",
                                style:  TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             const Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, SocialRegisterScreen());
                                },
                                child:  const Text('Register now'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
