import 'package:admin_panel/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'buildings/general_bindings.dart';
import 'data/repository/authentication/authentication_repository.dart';
import 'feature/screens/splash/splash_screen.dart';
import 'utils/theme/theme.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(380, 845),
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // getPages: AppRoutes.pages,
            themeMode: ThemeMode.system,
            title: 'Flutter Demo',
            theme: MAppTheme.lightTheme,
            darkTheme: MAppTheme.darkTheme,
            initialBinding: GeneralBinding(),
            home: const SplashScreen());
      },
    );
  }
}
