import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/social_register/social_register_cubit/social_register_states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit () : super (SocialRegisterInitialState());
  static SocialRegisterCubit get(context)=> BlocProvider.of(context);
  bool isPassword =true ;
  IconData suffix  = Icons.visibility_outlined;


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone
  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name,email: email,phone: phone,uId: value.user!.uid);
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String phone
}){
    SocialUserModel userModel = SocialUserModel( name, email, uId, phone, false);
    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value) {
      emit(SocialUserCreateSuccessState());
    }).catchError((error){
      emit(SocialUserCreateErrorState());
    });
  }

  void changeSuffix(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangeRegisterSuffixState());
  }
}