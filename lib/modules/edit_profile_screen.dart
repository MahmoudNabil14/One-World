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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        var editUserModel = SocialCubit.get(context).userModel;
        File? coverImage = SocialCubit.get(context).coverImage;
        var profileImage = SocialCubit.get(context).profileImage;
        nameController.text = editUserModel!.name;
        bioController.text = editUserModel.bio;
        phoneController.text = editUserModel.phone;

        return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(label: "Update", onPressed: ()  {

                  if(profileImage != null && coverImage ==null) {
                    SocialCubit.get(context).uploadProfileImage(bio: bioController.text,name: nameController.text, phone: phoneController.text,context: context);
                    Navigator.pop(context);
                  }
                  else if(coverImage !=null && profileImage ==null) {
                    SocialCubit.get(context).uploadCoverImage(bio: bioController.text,name: nameController.text, phone: phoneController.text,context: context);
                    Navigator.pop(context);
                  }
                  else if(coverImage !=null && profileImage !=null){
                    SocialCubit.get(context).uploadProfileImage(bio: bioController.text,name: nameController.text, phone: phoneController.text,context: context);
                    SocialCubit.get(context).uploadCoverImage(bio: bioController.text,name: nameController.text, phone: phoneController.text, context: context);
                    Navigator.pop(context);
                  }
                  else{
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text);
                  }
                  if (formKey.currentState!.validate()){}
                }),
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
                                        image: coverImage == null ? NetworkImage(
                                          editUserModel.cover,
                                        ): FileImage(coverImage) as ImageProvider ,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                      onPressed: () {SocialCubit.get(context).getCoverImage(bio: bioController.text,name: nameController.text, phone: phoneController.text);},
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
                                  backgroundImage: profileImage == null ? NetworkImage(
                                    editUserModel.image,
                                  ): FileImage(profileImage) as ImageProvider,
                                ),
                              ),
                              CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    onPressed: () {SocialCubit.get(context).getProfileImage(bio: bioController.text,name: nameController.text, phone: phoneController.text);},
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
                              onSubmit: (value){},
                              suffixPressed: (){},
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
                              onSubmit: (value){},
                              suffixPressed: (){},
                              label: 'Bio',
                              controller: bioController,
                              prefix: Icons.info,
                              validate: (String value){
                                if(value.isEmpty){
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
                              onSubmit: (value){
                              },
                              suffixPressed: (){},
                              label: 'Phone Number',
                              controller: phoneController,
                              prefix: Icons.phone,
                              validate: (String value){
                                if(value.isEmpty){
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
