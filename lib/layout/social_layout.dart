import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_cubit/social_states.dart';
import 'package:social_app/modules/notifications_screen.dart';
import 'package:social_app/modules/post_screen.dart';
import 'package:social_app/modules/search_screen.dart';
import 'package:social_app/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialAddPostState){
          navigateTo(context,  PostScreen());
        }
      },

      builder: (context, state) {

        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.appBarTitles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){navigateTo(context, const NotificationsScreen());}, icon: const Icon(Icons.notifications)),
              IconButton(onPressed: (){navigateTo(context, const SearchScreen());}, icon: const Icon(Icons.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            onTap: (index){
              cubit.changeBottomNav(index);
            },

            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
              BottomNavigationBarItem(icon: Icon(Icons.location_on_rounded), label: 'Users'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
