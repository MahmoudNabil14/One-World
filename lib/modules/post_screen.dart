import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/shared/components/components.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postTextController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Create Post",
            actions: [
              defaultTextButton(
                  label: "Create",
                  onPressed: () {
                    if (SocialCubit.get(context).postPhoto != null) {
                      SocialCubit.get(context)
                          .createPostWithPhotos(text: postTextController.text);
                    } else {
                      SocialCubit.get(context).createPostWithoutPhotos(
                          text: postTextController.text);
                    }
                    postTextController.text = '';
                  })
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 14.0, top: 14.0, right: 14.0, bottom: 5.0),
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState ||
                      state is SocialCreatePostWithPhotoLoadingState)
                    const LinearProgressIndicator(
                      minHeight: 5.0,
                    ),
                  if (state is SocialCreatePostLoadingState ||
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
                  TextFormField(
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                    controller: postTextController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What is on your mind?'),
                  ),
                  if (SocialCubit.get(context).postPhoto != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 250.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image: FileImage(
                                    SocialCubit.get(context).postPhoto!),
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
                  if (SocialCubit.get(context).postPhoto != null)
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
        );
      },
    );
  }
}
