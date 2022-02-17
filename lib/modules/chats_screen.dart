import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: SocialCubit.get(context).allUsers.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildChatItem(
                  SocialCubit.get(context).allUsers[index], context),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 3.0, bottom: 10.0),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ), //Separator
              itemCount: SocialCubit.get(context).allUsers.length),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(model));
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 27.0,
              backgroundImage: model.image.contains("https")?NetworkImage(
                model.image,
              ):AssetImage(model.image) as ImageProvider,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              model.name,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.3),
            ),
          ],
        ),
      ),
    ); //UserInfo
  }
}
