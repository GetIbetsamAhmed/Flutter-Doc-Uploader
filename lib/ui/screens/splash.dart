// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool shouldNavigate = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 02)).whenComplete(() {
      _navigate();
    });
    super.initState();
  } 

  _navigate() async {
    final pref = await SharedPreferences.getInstance();
    final provider = context.read<DocumentProvider>();
    // if (pref.getBool("on_boarded") == null) {
    //   if (pref.getString("uid") == null) {
    //     _navigateToOnBoarding();
    //   } else if (pref.getString('uid') != null) {
    //     provider.setUid(pref.getString('uid')!);
    //     _navigateToHome();
    //   }
    // } else if (pref.getBool("on_boarded")!) {
    //   if (pref.getString("uid") == null) {
    //     _navigateToLogin();
    //   } else if (pref.getString('uid') != null) {
    //     provider.setUserEmail(pref.getString("email") ?? "");
    //     _navigateToHome();
    //   }
    // }
    if(pref.getString('uid') != null){
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 4),
              Text(
                "Splash",
                style: TextStyle(
                  fontSize: screenHeight(context, 25),
                ),
              ),
              SizedBox(height: screenHeight(context, 200)),
              const CircularProgressIndicator(strokeWidth: 3, color: blue),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
