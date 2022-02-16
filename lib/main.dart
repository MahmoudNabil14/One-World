import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_cubit/social_cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_login/social_login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

Future<void> onBackgroundMessageHandler(RemoteMessage message)async {

  print(message.data.toString());
  showToast(message: 'Haaaaaaaaaaacker', state: toastStates.ERROR);

}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token = FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event) { 
    print(event.data.toString());
    showToast(message: 'on message', state: toastStates.ERROR);
  });
  
  FirebaseMessaging.onMessageOpenedApp.listen((event) { 
    print(event.data.toString());
    showToast(message: 'on message opened app', state: toastStates.ERROR);
  });
  
  FirebaseMessaging.onBackgroundMessage((message) => onBackgroundMessageHandler(message));
  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');

  late Widget widget;

  if(uId != null){
    widget = const SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }

  runApp(MyApp(startWidget: widget));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> SocialCubit()..getUserData()..getPosts())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}

