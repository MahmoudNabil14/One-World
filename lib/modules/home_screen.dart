import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/models/post_user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
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
                padding: const EdgeInsets.only(
                  left: 8.0,
                  bottom: 8.0,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 27.0,
                          backgroundImage: NetworkImage(
                            model.profileImage,
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                                    .copyWith(
                                        height: 1.4, fontSize: 15.0),
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
                            SocialCubit.get(context).likePosts(SocialCubit.get(context).postsID[index]);
                          },
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 28.0,
                          ),
                        ),
                        const SizedBox(width: 5.0,),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            '${SocialCubit.get(context).postsLikes[index]}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 12,color: Colors.grey[700]),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: (){},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.message,
                                color: Colors.green,
                                size: 28.0,
                              ),
                              const SizedBox(width: 5.0,),
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
                          width: 5.0,),
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
                      padding:
                          const EdgeInsets.only(top: 3.0, bottom: 10.0),
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
                                  SocialCubit.get(context)
                                      .userModel!
                                      .image,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    'Have a comment? Write it ...',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2,
                                  ),
                                ),
                              ),
                            ),
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
