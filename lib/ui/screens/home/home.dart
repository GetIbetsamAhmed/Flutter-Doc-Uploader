// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/screens/home/drawer.dart';
import 'package:flutter_firebase/ui/screens/home/home_widget.dart';
import 'package:flutter_firebase/ui/screens/home/rename_widget.dart';
import 'package:flutter_firebase/ui/screens/home/will_pop_function.dart';
import 'package:flutter_firebase/ui/screens/search_screen.dart';
import 'package:flutter_firebase/ui/screens/upload_image.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController? renameController, searchController;
  @override
  void initState() {
    renameController = TextEditingController();
    searchController = TextEditingController();
    _fetchAllDocuments();
    super.initState();
  }

  _fetchAllDocuments() async {
    var provider = context.read<DocumentProvider>();
    if (provider.rememberMe) {
      _saveUserCredentials(provider);
    }
    await DatabaseService().getAllDocuments(provider);
  }

  _saveUserCredentials(DocumentProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("email", provider.getUserEmail);
  }

  @override
  void dispose() {
    renameController!.dispose();
    searchController!.dispose();
    super.dispose();
  }

  Duration animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final double drawerWidth = screenWidth(context, 276);
    return SafeArea(
      child: Consumer<DocumentProvider>(
        builder: (context, docProvider, _) => WillPopScope(
          onWillPop: () async =>
              onWillPop(docProvider, context, searchController!),
          child: Scaffold(
            body: Consumer<DocumentProvider>(
              builder: (context, docProvider, child) {
                return GestureDetector(
                  onTap: () {
                    docProvider.hideRenameContainer();
                    primaryFocus!.unfocus();
                  },
                  child: Stack(
                    children: [
                      // Base of the app
                      SizedBox(
                        height: context.height,
                        width: context.width,
                      ),

                      // Search Screen
                      AnimatedPositioned(
                        top: docProvider.isSearchTapped ? 0 : -context.height,
                        left: docProvider.getAnimateSearchToLeft
                            ? -context.width
                            : 0,
                        duration: animationDuration,
                        child: SearchScreen(
                          searchController: searchController!,
                        ),
                      ),
                      // main dash board or home screen
                      AnimatedPositioned(
                        left: docProvider.isDrawerTapped
                            ? drawerWidth
                            : docProvider.isFloatingTapped
                                ? -context.width
                                : 0,
                        top: docProvider.isSearchTapped ? context.height : 0,
                        duration: animationDuration,
                        child: homeScreen(docProvider, context),
                      ),

                      // Floating action button that will navigate to UploadImageScreen
                      AnimatedPositioned(
                        right: docProvider.isFloatingTapped
                            ? context.width
                            : docProvider.isDrawerTapped
                                ? -context.width
                                : screenHeight(context, 20),
                        bottom: docProvider.showRenameWidget ||
                                docProvider.isSearchTapped
                            ? -100
                            : screenHeight(context, 20),
                        duration: animationDuration,
                        child: _addDocumentButton(docProvider),
                      ),

                      // Upload Image Screen
                      AnimatedPositioned(
                        left: docProvider.isFloatingTapped ? 0 : context.width,
                        duration: animationDuration,
                        child: const UploadImage(),
                      ),

                      // A widget that will only appear when the user will go for renaming a document
                      AnimatedPositioned(
                        bottom:
                            docProvider.showRenameWidget ? 0 : -context.height,
                        duration: animationDuration,
                        child: renameWidget(
                          context,
                          renameController!,
                          docProvider,
                        ),
                      ),

                      // A widget that will be overlayed to the remaining part of the drawer
                      AnimatedPositioned(
                        duration: animationDuration,
                        left: docProvider.isDrawerTapped
                            ? drawerWidth
                            : context.width,
                        child: InkWell(
                          onTap: () => docProvider.setDrawerTappedCheck(false),
                          child: Container(
                            height: context.height,
                            width: context.width,
                            color: black.withOpacity(0.4),
                          ),
                        ),
                      ),

                      // Drawer of the app
                      AnimatedPositioned(
                        left: docProvider.isDrawerTapped ? 0 : -context.width,
                        duration: animationDuration,
                        child: drawer(
                          width: drawerWidth,
                          provider: docProvider,
                          context: context,
                        ),
                      ),

                      // Menu Button
                      AnimatedPositioned(
                        left: docProvider.isFloatingTapped
                            ? context.width
                            : docProvider.isDrawerTapped
                                ? screenWidth(context, 210)
                                : 0,
                        top: screenHeight(context, 05),
                        duration: animationDuration,
                        child: IconButton(
                          icon: Icon(
                            docProvider.isDrawerTapped
                                ? Icons.close
                                : Icons.menu,
                            size: screenHeight(context, 35),
                            color: docProvider.isDrawerTapped ? white : blue,
                          ),
                          onPressed: () {
                            docProvider.setDrawerTappedCheck(
                                !docProvider.isDrawerTapped);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _addDocumentButton(DocumentProvider docProvider) {
    return FloatingActionButton(
      onPressed: () {
        docProvider.setFloatingTappedCheck(!docProvider.isFloatingTapped);
      },
      foregroundColor: black,
      // radius: screenHeight(context, 33),
      backgroundColor: blue,
      child: Icon(
        Icons.add,
        color: white,
        size: screenHeight(context, 26),
      ),
    );
  }
}
