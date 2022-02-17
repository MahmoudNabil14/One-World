import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/social_register/social_register_cubit/social_register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  var radioValue;

  IconData suffix = Icons.visibility_outlined;

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone,
      }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid,);
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel userModel = SocialUserModel(
        name: name,
        email: email,
        phone:  phone,
        uId: uId,
        image:radioValue == 'female'?'assets/images/female_profile.png':'assets/images/male_profile.png',
        cover: 'assets/images/cover.png',
        bio: 'write your bio...',
        isEmailVerified:  false,
        gender: radioValue);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialUserCreateSuccessState(uId));
    }).catchError((error) {
      emit(SocialUserCreateErrorState());
    });
  }

  void changeSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangeRegisterSuffixState());
  }

  void clearButton(
      {TextEditingController? controller1,
      TextEditingController? controller2,
      TextEditingController? controller3,
      TextEditingController? controller4,
      String? radioValue}) {
    controller1!.text = '';
    controller2!.text = '';
    controller3!.text = '';
    controller4!.text = '';
    radioValue = '';
    emit(SocialClearButtonState());
  }
}
