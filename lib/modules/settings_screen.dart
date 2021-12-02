import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, states){},
      builder: (context, states){
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
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
                      child: Container(
                        height: 170.0,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4.0),topRight: Radius.circular(4.0)),
                          image: DecorationImage(image:NetworkImage(
                            "${userModel!.cover}",),
                              fit: BoxFit.cover ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 68.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: const CircleAvatar(
                        radius: 64.0,
                        backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/photo-positive-european-female-model-makes-okay-gesture-agrees-with-nice-idea_273609-25629.jpg',
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 10.0,),
              Text(userModel.name,style: Theme.of(context).textTheme.headline6,),
              const SizedBox(height: 8.0,),
              Text(userModel.bio,style: Theme.of(context).textTheme.bodyText2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle2,),
                          Text('posts',style: Theme.of(context).textTheme.subtitle2,),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle2,),
                          Text('posts',style: Theme.of(context).textTheme.subtitle2,),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle2,),
                          Text('posts',style: Theme.of(context).textTheme.subtitle2,),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle2,),
                          Text('posts',style: Theme.of(context).textTheme.subtitle2,),

                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );

  }
}
