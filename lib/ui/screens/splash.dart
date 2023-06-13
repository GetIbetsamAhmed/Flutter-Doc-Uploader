// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool shouldNavigate = false;
  bool animate = false, animateText = false;
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 100))
        .whenComplete(() => setState(() {
              animate = true;
            }));
    Future.delayed(const Duration(microseconds: 100))
        .whenComplete(() => setState(() {
              animateText = true;
            }));
    
    Future.delayed(const Duration(seconds: 02)).whenComplete(() {
      _navigate();
    });
    super.initState();
  }

  _navigate() async {
    final pref = await SharedPreferences.getInstance();
    final provider = context.read<DocumentProvider>();

    if (pref.getBool("on_boarded") == null) {
      if (pref.getString("uid") == null) {
        _navigateToOnBoarding();
      } else if (pref.getString('uid') != null) {
        provider.setUid(pref.getString('uid')!);
        _navigateToHome();
      }
    } else if (pref.getBool("on_boarded")!) {
      if (pref.getString("uid") == null) {
        _navigateToLogin();
      } else if (pref.getString('uid') != null) {
        provider.setUserEmail(pref.getString("email") ?? "");
        _navigateToHome();
      }
    }

    if (pref.containsKey("gridCrossAxisCount")) {
      provider.setGridCrossAxisCount(pref.getInt("gridCrossAxisCount")!);
    } else {
      provider.setGridCrossAxisCount(3);
    }
    if (pref.containsKey("folderSortingOrder")) {
      provider.setFolderOrder(pref.getInt("folderSortingOrder")!);
    } else {
      provider.setFolderOrder(1);
    }
    if (pref.getString('uid') != null) {
      provider.setUid(pref.getString('uid')!);
    }
    if (pref.getBool('on_boarded') == null) {
      _navigateToOnBoarding();
    } else if (pref.getBool('on_boarded')!) {
      if (pref.getString('email') != null) {
        provider.setUserEmail(pref.getString("email")!);
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    }

    DatabaseService().getAppDetails(provider);
  }

  _navigateToOnBoarding() {
    Navigator.pushReplacementNamed(context, 'onboarding_screen');
  }

  _navigateToLogin() {
    Navigator.pushReplacementNamed(context, 'login');
  }

  _navigateToHome() {
    Navigator.pushReplacementNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // AnimatedPositioned(
            //   duration: const Duration(seconds: 1),
            //   right: -250,
            //   top: -294,
            //   child: Transform.rotate(
            //     angle: 1,
            //     child: Container(
            //       height: context.height,
            //       width: 605,
            //       color: textGrey.withOpacity(0.2),
            //     ),
            //   ),
            // ),
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              right: context.width/2 - 300,
              top: animate? -210 : -1000,
              child: Transform.rotate(
                angle: pi/4,
                child: Container(
                  height: 600,
                  width: 600,
                  color: blue,
                ),
              ),
            ),
            _content(context),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(flex: 4),
          AnimatedOpacity(
            opacity: animateText? 1: 0,
            duration: const Duration(microseconds: 1000),
            child: Text(
              "Snapbase",
              style: TextStyle(
                fontSize: screenHeight(context, 40),
                color: white.withOpacity(0.95), 
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(height: screenHeight(context, 200)),
          // const CircularProgressIndicator(strokeWidth: 3, color: blue),
          Image.asset(
            'assets/images/loader.gif',
            height: screenHeight(context, 60),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
