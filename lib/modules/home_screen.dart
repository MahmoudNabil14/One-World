import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/models/post_user_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  bool sendCommentBtnEnabled = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialAddPostState) {
          SocialCubit.get(context).postPhoto = null;
        }
      },
      builder: (context, state) {
        return BuildCondition(
          condition: SocialCubit.get(context).posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 0.0,
              ),
              itemCount: SocialCubit.get(context).posts.length,
              itemBuilder: (context, index) => buildPostItem(
                  SocialCubit.get(context).posts[index], context, index),
            ),
          ),
          fallback: (context) =>
             const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 27.0,
                          backgroundImage: SocialCubit.get(context).userModel!.uId==model.uId?NetworkImage(
                            SocialCubit.get(context).userModel!.image,
                          ):NetworkImage(
                            model.profileImage,
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    model.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(height: 1.3),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 16.0,
                                  ),
                                ],
                              ),
                              Text(
                                model.dateTime,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(height: 1.3),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz),
                        ),
                      ],
                    ), //UserInfo
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ), //Separator
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.postText,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(height: 1.4, fontSize: 15.0),
                              ), //PostText
                              const SizedBox(
                                height: 8.0,
                              ),
                              if (model.postImage != '')
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0),
                                  child: Image(
                                    image: NetworkImage(model.postImage),
                                    height: 300.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ), //PostImage
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            SocialCubit.get(context).likePosts(
                                SocialCubit.get(context).postsID[index], index);
                          },
                          child: SocialCubit.get(context).postsLikes[index] == 0
                              ? const Icon(
                                  Icons.favorite_border,
                                  size: 28.0,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  size: 28.0,
                                  color: Colors.red,
                                ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            '${SocialCubit.get(context).postsLikes[index]} Likes',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.grey[700]),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.message,
                                color: Colors.grey,
                                size: 28.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '0 Comments',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.share,
                            color: Colors.grey,
                            size: 28.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '0 Shares',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0, bottom: 10.0),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ), //Separator
                    Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 18.0,
                                backgroundImage: NetworkImage(
                                  SocialCubit.get(context).userModel!.image,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: TextFormField(
                                  maxLines: null,
                              onChanged: (String value) {
                                sendCommentBtnEnabled = value.isNotEmpty;
                                if (value.length == 1) {
                                  SocialCubit.get(context).emit(
                                      SocialChangeIconDependOnFormField());
                                } else if (value.isEmpty) {
                                  SocialCubit.get(context).emit(
                                      SocialChangeIconDependOnFormField());
                                }
                              },
                              controller: controller,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  hintStyle: TextStyle(
                                      fontSize: 14.0, color: Colors.grey[500]),
                                  hintText: 'Have a comment?? Write it now...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  )),
                            )),
                            const SizedBox(
                              width: 10.0,
                            ),
                            IconButton(
                                onPressed: sendCommentBtnEnabled ? () {} : null,
                                icon: Icon(
                                  Icons.send,
                                  color: sendCommentBtnEnabled
                                      ? Colors.blue
                                      : Colors.grey,
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 4.0,
          )
        ],
      ),
    );
  }
}
