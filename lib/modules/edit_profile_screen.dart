import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool updateUserBtnEnabled =false ;

  @override
  Widget build(BuildContext context) {
    var editUserModel = SocialCubit.get(context).userModel;
    nameController.text = editUserModel!.name;
    bioController.text = editUserModel.bio;
    phoneController.text = editUserModel.phone;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        File? coverImage = SocialCubit.get(context).coverImage;
        var profileImage = SocialCubit.get(context).profileImage;

        return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                updateUserBtnEnabled || profileImage!=null ||coverImage!=null?
                defaultTextButton(
                    color: Colors.blue,
                    label: "Update",
                    onPressed: () {
                      if (profileImage != null && coverImage == null) {
                        SocialCubit.get(context).uploadProfileImage(
                            bio: bioController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            context: context);
                        Navigator.pop(context);
                      } else if (coverImage != null && profileImage == null) {
                        SocialCubit.get(context).uploadCoverImage(
                            bio: bioController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            context: context);
                        Navigator.pop(context);
                      } else if (coverImage != null && profileImage != null) {
                        SocialCubit.get(context).uploadProfileImage(
                            bio: bioController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            context: context);
                        SocialCubit.get(context).uploadCoverImage(
                            bio: bioController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            context: context);
                        Navigator.pop(context);
                      } else {
                        SocialCubit.get(context).updateUser(
                            name: nameController.text,
                            bio: bioController.text,
                            phone: phoneController.text);
                      }
                      if (formKey.currentState!.validate()) {}
                    }
                ):Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Update'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16.0,
                          )),
                    )),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 230.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 170.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0)),
                                    image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage(
                                                editUserModel.cover,
                                              )
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context).getCoverImage(
                                            bio: bioController.text,
                                            name: nameController.text,
                                            phone: phoneController.text);
                                      },
                                      icon: const Icon(
                                        Icons.camera,
                                        size: 22.0,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 68.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 64.0,
                                  backgroundImage: profileImage == null
                                      ? AssetImage(
                                          editUserModel.image,
                                        )
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getProfileImage(
                                          bio: bioController.text,
                                          name: nameController.text,
                                          phone: phoneController.text);
                                    },
                                    icon: const Icon(
                                      Icons.camera,
                                      size: 22.0,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultFormField(
                              onSubmit: (value) {},
                              onChanged: (value){
                                if(nameController.text != editUserModel.name) {
                                  updateUserBtnEnabled = true;
                                }
                                if(nameController.text == editUserModel.name){
                                  updateUserBtnEnabled = false;
                                }
                                if(value.length == editUserModel.name.length+1 || value.length == editUserModel.name.length-1 ||value.length == editUserModel.name.length) {
                                  SocialCubit.get(context).emit(SocialChangeIconDependOnFormField());
                                }
                              },
                              suffixPressed: () {},
                              label: 'Name',
                              controller: nameController,
                              prefix: Icons.person,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Name mustn\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              type: TextInputType.name),
                          const SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                              onSubmit: (value) {},
                              onChanged: (value){
                                if(bioController.text != editUserModel.bio) {
                                  updateUserBtnEnabled = true;
                                }
                                if(bioController.text == editUserModel.bio){
                                  updateUserBtnEnabled = false;
                                }
                                if(value.length == editUserModel.bio.length+1 || value.length == editUserModel.bio.length-1 ||value.length == editUserModel.bio.length) {
                                  SocialCubit.get(context).emit(SocialChangeIconDependOnFormField());
                                }
                              },
                              suffixPressed: () {},
                              label: 'Bio',
                              controller: bioController,
                              prefix: Icons.info,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Bio mustn\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              type: TextInputType.text),
                          const SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                              onSubmit: (value) {},
                              onChanged: (String value){
                                if(phoneController.text != editUserModel.phone) {
                                  updateUserBtnEnabled = true;
                                }
                                if(phoneController.text == editUserModel.phone){
                                  updateUserBtnEnabled = false;
                                }
                                if(value.length == editUserModel.phone.length+1 || value.length == editUserModel.phone.length-1 ||value.length == editUserModel.phone.length) {
                                  SocialCubit.get(context).emit(SocialChangeIconDependOnFormField());
                                }
                              },
                              suffixPressed: () {},
                              label: 'Phone Number',
                              controller: phoneController,
                              prefix: Icons.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Phone Number mustn\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              type: TextInputType.phone),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
