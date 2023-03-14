import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
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
    if (pref.getBool("on_boarded") == null) {
      if (pref.getString("uid") == null) {
        _navigateToOnBoarding();
      } else if (pref.getString('uid') != null) {
        _navigateToHome();
      }
    } else if (pref.getBool("on_boarded")!) {
      if (pref.getString("uid") == null) {
        _navigateToLogin();
      } else if (pref.getString('uid') != null) {
        _navigateToHome();
      }
    }
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
    return Scaffold(
      body: SafeArea(
        child: Center(
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
