import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/shared/components/components.dart';

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);

  bool createPostBtnEnabled = false;
  var postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialAddPostState) {
          SocialCubit.get(context).postPhoto = null;
          print(SocialCubit.get(context).postPhoto);
        }
      },
      builder: (context, state) {
        var postPhoto = SocialCubit.get(context).postPhoto;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Create New Post",
            actions: [
              postPhoto != null || postTextController.text.isNotEmpty
                  ? defaultTextButton(
                      label: "Create",
                      color: Colors.blue,
                      onPressed: () {
                        if (postPhoto != null) {
                          SocialCubit.get(context).createPostWithPhotos(
                              text: postTextController.text);
                        } else {
                          SocialCubit.get(context).createPostWithoutPhotos(
                              text: postTextController.text);
                        }
                        Navigator.pop(context);
                        postTextController.text = '';
                        postPhoto = null;
                      })
                  : Center(
                      child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Create'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16.0,
                          )),
                    )),
            ],
          ),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, top: 14.0, right: 14.0, bottom: 5.0),
                  child: Column(
                    children: [
                      if (state is SocialCreatePostWithoutPhotoLoadingState ||
                          state is SocialCreatePostWithPhotoLoadingState)
                        const LinearProgressIndicator(
                          minHeight: 5.0,
                        ),
                      if (state is SocialCreatePostWithoutPhotoLoadingState ||
                          state is SocialCreatePostWithPhotoLoadingState)
                        const SizedBox(
                          height: 10.0,
                        ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 27.0,
                            backgroundImage: NetworkImage(
                              SocialCubit.get(context).userModel!.image,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                            child: Text(
                              'Mahmoud Nabil',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(height: 1.3),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (String value) {
                            createPostBtnEnabled = value.isNotEmpty;
                            if (value.length == 1) {
                              SocialCubit.get(context)
                                  .emit(SocialChangeIconDependOnFormField());
                            } else if (value.isEmpty) {
                              SocialCubit.get(context)
                                  .emit(SocialChangeIconDependOnFormField());
                            }
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: postTextController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'What is on your mind?'),
                        ),
                      ),
                      if (postPhoto != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 300.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                    image: FileImage(postPhoto!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 20.0,
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).removePostPhotos();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 22.0,
                                  )),
                            )
                          ],
                        ),
                      if (postPhoto != null)
                        const SizedBox(
                          height: 10.0,
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  SocialCubit.get(context).getPostPhotos();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.photo),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text('Add Photos'),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('# Tags'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
