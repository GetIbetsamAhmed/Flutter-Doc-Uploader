// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_firebase/screens/home_screen.dart';
// import 'package:flutter_firebase/screens/show_data_screen.dart';
// import 'package:flutter_firebase/screens/sign_in.dart';
// import 'package:flutter_firebase/screens/sign_up.dart';
import 'package:flutter_firebase/ui/screens/home/home.dart';
import 'package:flutter_firebase/ui/screens/signup.dart';
import 'package:flutter_firebase/ui/screens/signin.dart';
import 'package:flutter_firebase/ui/screens/on_board.dart';
import 'package:flutter_firebase/ui/screens/splash.dart';
import 'package:flutter_firebase/ui/screens/upload_image.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DocumentProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'splash',
        routes: routes,
      ),
    );
  }
}

Map<String, WidgetBuilder> routes = {
  // NEW UI
  'splash': (context) => const SplashScreen(),
  'onboarding_screen': (context) => const OnBoardingScreen(),
  'login': (context) => const LoginScreen(),
  'signup': (context) => const SignupScreen(),
  'home': (context) => const Dashboard(),
  'upload': (context) => const UploadImage(),

  // // OLD UI
  // 'welcome_screen': (context) => const WelcomePage(title: 'Welcome'),
  // 'home_screen': (context) => const HomeScreen(),
  // 'sign_up': (context) => const SignUpScreen(),
  // 'sign_in': (context) => const SignInScreen(),
  // 'show_data_screen': (context) => const ShowDataScreen(),
};

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title});
  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'sign_up');
                },
                child: const Text("Sign Up"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'sign_in');
                },
                child: const Text("Sign In"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
