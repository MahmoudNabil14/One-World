import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats_screen.dart';
import 'package:social_app/modules/home_screen.dart';
import 'package:social_app/modules/post_screen.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/modules/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const ChatsScreen(),
    const PostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> appBarTitles = [
    'Home',
    'Chats',
    'Add Post',
    'Users',
    'Settings'
  ];

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void changeBottomNav(index) {
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();

  Future<void> getProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) async {
    updateUser(name: name, bio: bio, phone: phone);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future<void> getCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) async {
    updateUser(name: name, bio: bio, phone: phone);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  String profileImageUrl = '';
   void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
    required BuildContext context
  }) {
     emit(SocialUserUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Profile Images/ ${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        profileImageUrl = value;
        updateUser(phone: phone,name: name,bio: bio);
        profileImage = null;
        coverImage = null;
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String coverImageUrl = '';
  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
    required BuildContext context
  }) {
    emit(SocialUserUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Cover Images/ ${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        coverImageUrl = value;
        updateUser(phone: phone,name: name,bio: bio);
        profileImage = null;
        coverImage = null;
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }


  void updateUser({
  required String name,
  required String bio,
  required String phone,
}){
    SocialUserModel updateUserModel = SocialUserModel(
        name,
        userModel!.email,
        phone,
        userModel!.uId,
        profileImageUrl.isEmpty ?userModel!.image: profileImageUrl,
        coverImageUrl.isEmpty ?userModel!.cover: coverImageUrl,
        bio,
        false);
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update(updateUserModel.toMap()).then((value) {
      getUserData();
    }).catchError((error){
      emit(SocialUserUpdateErrorState());
    });
  }
}
