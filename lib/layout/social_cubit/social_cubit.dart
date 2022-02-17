import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_user_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats_screen.dart';
import 'package:social_app/modules/home_screen.dart';
import 'package:social_app/modules/post_screen.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/modules/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  late TextEditingController controller;

  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  PostModel? postModel;

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    const ChatsScreen(),
    PostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> appBarTitles = [
    'One World',
    'Chats',
    'Add New Post',
    'Users',
    'Settings'
  ];

  getUserData() async {
    emit(SocialGetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void changeBottomNav(index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  var picker = ImagePicker();

  File? profileImage;

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

  File? coverImage;

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

  uploadProfileImage(
      {required String name,
      required String bio,
      required String phone,
      required BuildContext context}) async {
    emit(SocialUserUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'Profile Images/ ${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        profileImageUrl = value;
        updateUser(
          phone: phone,
          name: name,
          bio: bio,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage(
      {required String name,
      required String bio,
      required String phone,
      required BuildContext context}) {
    emit(SocialUserUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Cover Images/ ${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        coverImageUrl = value;
        updateUser(phone: phone, name: name, bio: bio);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  Future<void> updateUser({
    required String name,
    required String bio,
    required String phone,
  }) async {
    SocialUserModel updateUserModel = SocialUserModel(
        name: name,
        email:userModel!.email,
        phone:phone,
        uId:userModel!.uId,
        image:profileImageUrl.isEmpty ? userModel!.image : profileImageUrl,
        cover:coverImageUrl.isEmpty ? userModel!.cover : coverImageUrl,
        bio:bio,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(updateUserModel.toMap())
        .then((value) async {
      await getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postPhoto;

  Future<void> getPostPhotos() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postPhoto = File(pickedFile.path);
      emit(SocialPostPhotoPickedSuccessState());
    } else {
      emit(SocialPostPhotoPickedErrorState());
    }
  }

  void createPostWithoutPhotos({
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostWithoutPhotoLoadingState());
    postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      dateTime: DateFormat.yMd().add_jm().format(DateTime.now()).toString(),
      postImage: postImage ?? '',
      profileImage: userModel!.image,
      postText: text,
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .add(postModel!.toMap())
        .then((value) {
      postPhoto = null;
      posts.add(postModel!);
      postsID.add(value.id);
      value.collection('likes').get().then((value) {
        postsLikes.add(value.docs.length);
        emit(SocialCreatePostWithoutPhotoSuccessState());
      });
    }).catchError((error) {
      emit((SocialCreatePostWithoutPhotoErrorState()));
    });
  }

  void createPostWithPhotos({
    required String text,
  }) {
    emit(SocialCreatePostWithPhotoLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Posts Photos/ ${Uri.file(postPhoto!.path).pathSegments.last}')
        .putFile(postPhoto!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPostWithoutPhotos(text: text, postImage: value);
        postPhoto = null;
        emit(SocialCreatePostWithPhotoSuccessState());
      }).catchError((error) {
        emit((SocialCreatePostWithPhotoErrorState()));
      });
    }).catchError((error) {
      emit((SocialCreatePostWithPhotoErrorState()));
    });
  }

  void removePostPhotos() {
    postPhoto = null;
    emit(SocialRemovePostPhotos());
  }

  List<PostModel> posts = [];
  List<MessageModel> messages = [];
  List<SocialUserModel> allUsers = [];
  List<String> postsID = [];
  List<int> postsLikes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          postsLikes.add(value.docs.length);
          postsID.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostsSuccessState());
        });
      }
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void getAllUsers() {
    if (allUsers.isEmpty) {
      emit(SocialGetAllUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId) {
            allUsers.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void likePosts(String postID, index) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postID)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      FirebaseFirestore.instance
          .collection('Posts')
          .doc(postID)
          .collection('likes')
          .get()
          .then((value) {
        postsLikes[index] = (value.docs.length);
        emit(SocialLikePostSuccessState());
      }).catchError((error) {
        emit(SocialLikePostErrorState(error.toString()));
      });
    }).catchError((error) {});
  }

  void changeLikeButton(String postID) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postID)
        .collection('likes')
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.data().values;
      }
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
        dateTime: dateTime,
        receiverId: receiverId,
        text: text,
        senderId: userModel!.uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessagesSuccessState());
    });
  }


}
