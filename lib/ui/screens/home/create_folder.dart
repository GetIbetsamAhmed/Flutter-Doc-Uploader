import 'package:flutter/material.dart';

showCreateFolderDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => const AlertDialog(content: Text("Center")),
  );
}
