import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

import '../../../../utils/constants/text_strings.dart';

import 'app_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // ChangeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.error,
      body: Center(
        child: Column(children: [
          const Align(
            alignment: Alignment.topLeft,
            // child: Image.asset(
            //   MImage.icSplashBg,
            //   width: 300,
            //   // height: 200,
            //   fit: BoxFit.cover,
            // )
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 300,
          ),
          applogoWidget(),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 5,
          ),
          const Text(
            MTexts.appname,
            style: TextStyle(
                fontFamily: MTexts.bold1, fontSize: 22, color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(MTexts.appversion, style: TextStyle(color: Colors.white)),
          const Spacer(), //use for responsive height ,Creates a flexible space to insert into a [Flexible] widget.
          const Text(MTexts.credits,
              style:
                  TextStyle(fontFamily: MTexts.semibold, color: Colors.white)),
          const SizedBox(
            height: 30,
          )
          //our splash screen ui is completed
        ]),
      ),
    );
  }
}
