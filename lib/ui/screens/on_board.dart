// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/components/custom_button.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController? _controller;

  List<Map<String, String>> dataSet = [
    {
      "title": "Scan all your documents quickly and easily",
      "data":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took",
    },
    {
      "title": "You can also edit and costumize your scan results",
      "data":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    },
    {
      "title": "Optimize your documents now",
      "data":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
    },
  ];

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller,
          children: [
            for (int i = 0; i < dataSet.length; i++) onBoarding(dataSet[i], i),
          ],
        ),
      ),
    );
  }

  Widget onBoarding(Map<String, String> data, int index) {
    return Padding(
      padding: globalHorizontalPadding(context),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 10),
            Text(
              data['title']!,
              style: TextStyle(
                fontSize: screenHeight(context, 27),
                fontWeight: FontWeight.w700,
                wordSpacing: screenWidth(context, 3),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight(context, 10)),
            Text(
              data['data']!,
              style: TextStyle(
                fontSize: screenHeight(context, 15),
                fontWeight: FontWeight.w400,
                height: screenHeight(context, 1.7),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight(context, 30)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < dataSet.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: screenHeight(context, 5),
                    width: screenWidth(context, index == i ? 20 : 5),
                    margin: EdgeInsets.only(right: screenWidth(context, 5)),
                    decoration: BoxDecoration(
                      color: index == i ? blue : unselectedGrey,
                      borderRadius:
                          BorderRadius.circular(screenWidth(context, 5)),
                    ),
                  ),
              ],
            ),
            SizedBox(height: screenHeight(context, 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  color: lightGrey,
                  onTap: () async {
                    // await _userOnboarded();
                    Navigator.pushNamed(context, "signup");
                    
                  },
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: blue,
                      fontSize: screenHeight(context, 17),
                    ),
                  ),
                ),
                CustomButton(
                  color: blue,
                  onTap: () async {
                    if (index < dataSet.length - 1) {
                      _controller!.animateToPage(
                        index + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubicEmphasized,
                      );
                    } else {
                      // await _userOnboarded();
                      Navigator.pushNamed(context, "login");
                    }
                  },
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: lightGrey,
                      fontSize: screenHeight(context, 17),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  _userOnboarded() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool("on_boarded", true);
  }
}
