import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';


class RememberMe extends StatefulWidget {
  final Function onTap;
  const RememberMe({
    super.key,
    required this.onTap,
  });

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool check = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        check = !check;
        widget.onTap();
        setState(() {});
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
                color: check ? blue : Colors.transparent,
                border: !check ? Border.all(color: blue) : null,
                borderRadius: BorderRadius.circular(screenHeight(context, 8)),
              ),
              child: Center(
                child: check
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
    );
  }
}
