import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('News Feed'),
          ),
          body: BuildCondition(
            condition: SocialCubit.get(context).userModel != null,
            builder: (context)=> Column(
              children: [
                Container(
                  color: Colors.red.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [

                        const Icon(Icons.info_outline),

                        const SizedBox(width: 10.0,),

                        const Text('please verify your email'),

                        const Spacer(),

                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.currentUser!.sendEmailVerification();
                            },
                            child: const Text('send',style: TextStyle(fontSize: 18.0),)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            fallback: (context)=>  const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
