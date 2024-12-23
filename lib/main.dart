import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/controllers/friend/friend_bloc.dart';
import 'src/controllers/gift/gift_bloc.dart';
import 'src/controllers/guest/guest_bloc.dart';
import 'src/controllers/profile/profile_bloc.dart';
import 'src/database/database.dart';
import 'src/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GiftBloc()..add(GiftGet())),
        BlocProvider(create: (context) => GuestBloc()..add(GuestGet())),
        BlocProvider(create: (context) => ProfileBloc()..add(ProfileGet())),
        BlocProvider(create: (context) => FriendBloc()..add(FriendGet())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          dialogTheme: const DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
