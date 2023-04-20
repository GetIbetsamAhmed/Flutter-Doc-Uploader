import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({
    super.key,
  });

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentProvider>(
      builder: (context, provider, _) => GestureDetector(
        onTap: () {
          provider.changeRememberMe();
        },
        child: Container(
          height: screenHeight(context, 30),
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenHeight(context, 22),
                width: screenWidth(context, 22),
                decoration: BoxDecoration(
                  color: provider.rememberMe ? blue : Colors.transparent,
                  border: !provider.rememberMe ? Border.all(color: blue) : null,
                  borderRadius: BorderRadius.circular(screenHeight(context, 8)),
                ),
                child: Center(
                  child: provider.rememberMe
                      ? const Icon(
                          Icons.done,
                          size: 15,
                          color: lightGrey,
                        )
                      : null,
                ),
              ),
              SizedBox(width: screenWidth(context, 10)),
              Text(
                "Remember me",
                style: TextStyle(
                  color: black,
                  fontSize: screenHeight(context, 16),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
