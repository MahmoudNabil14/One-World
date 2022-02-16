import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/components/components.dart';

class ChatDetailsScreen extends StatelessWidget {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  SocialUserModel receiverUserModel;
  SocialUserModel? myUserModel;
  bool sendMessageBtnEnabled = false;
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  ChatDetailsScreen(this.receiverUserModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: receiverUserModel.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.0,
                      backgroundImage: NetworkImage(receiverUserModel.image),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      receiverUserModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              body: BuildCondition(
                condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (context) {
                  scrollToEndOfList(scrollController);
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: ListView.separated(
                                controller: scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  myUserModel =
                                      SocialCubit.get(context).userModel!;
                                  MessageModel message =
                                      SocialCubit.get(context).messages[index];
                                  if (myUserModel!.uId == message.senderId) {
                                    return buildSentMessage(message, context);
                                  } else {
                                    return buildReceivedMessage(
                                        message, context);
                                  }
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 15.0),
                                itemCount:
                                    SocialCubit.get(context).messages.length),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: textController,
                                  keyboardType: TextInputType.text,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    filled: true,
                                    fillColor: Colors.blue,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 0.0, color: Colors.blue),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 0.0, color: Colors.blue),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    hintText: "Message",
                                  ),
                                  onChanged: (String value) {
                                    sendMessageBtnEnabled = value.isNotEmpty;
                                    if (value.length == 1) {
                                      SocialCubit.get(context).emit(
                                          SocialChangeIconDependOnFormField());
                                    } else if (value.isEmpty) {
                                      SocialCubit.get(context).emit(
                                          SocialChangeIconDependOnFormField());
                                    }
                                  },
                                ),
                              ),
                              IconButton(
                                  onPressed: sendMessageBtnEnabled
                                      ? () {
                                          SocialCubit.get(context).sendMessage(
                                              receiverId: receiverUserModel.uId,
                                              dateTime: dateFormat
                                                  .add_jm()
                                                  .format(DateTime.now())
                                                  .toString(),
                                              text: textController.text);
                                          textController.text = '';
                                          sendMessageBtnEnabled = false;
                                        }
                                      : null,
                                  icon: Icon(
                                    Icons.send,
                                    size: 28.0,
                                    color: sendMessageBtnEnabled
                                        ? Colors.blue
                                        : Colors.grey,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (context) => Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, right: 20.0, left: 20.0, bottom: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(

                            style: const TextStyle(color: Colors.white),
                            controller: textController,
                            keyboardType: TextInputType.text,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.blue,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0.0, color: Colors.blue),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0.0, color: Colors.blue),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              hintText: "Message",
                            ),
                            onChanged: (String value) {
                              sendMessageBtnEnabled = value.isNotEmpty;
                              if (value.length == 1) {
                                SocialCubit.get(context)
                                    .emit(SocialChangeIconDependOnFormField());
                              } else if (value.isEmpty) {
                                SocialCubit.get(context)
                                    .emit(SocialChangeIconDependOnFormField());
                              }
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: sendMessageBtnEnabled
                              ? () {
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: receiverUserModel.uId,
                                      dateTime: dateFormat
                                          .add_jm()
                                          .format(DateTime.now())
                                          .toString(),
                                      text: textController.text);
                                  textController.text = '';
                                  sendMessageBtnEnabled = false;
                                }
                              : null,
                          icon: Icon(
                            Icons.send,
                            size: 28.0,
                            color: sendMessageBtnEnabled
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      );
    });
  }

  Widget buildReceivedMessage(MessageModel model, context) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.grey[300]!,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              color: Colors.grey[300]),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              model.text,
              style: const TextStyle(fontSize: 15.0),
            ),
            Text(model.dateTime.substring(19, 27),
                style:
                    Theme.of(context).textTheme.caption!.copyWith(height: 0.5))
          ]),
        ),
      ); //Received Messages

  Widget buildSentMessage(MessageModel model, context) => Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.blue[300]!,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              color: Colors.blue[300]),
          child: Text(
            model.text,
            style: const TextStyle(fontSize: 15.0),
          ),
        ),
      );
}
