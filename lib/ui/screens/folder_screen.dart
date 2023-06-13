import 'package:flutter/material.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:flutter_firebase/models/folder_model.dart';
import 'package:flutter_firebase/ui/components/folder_screen/add_image_container.dart';
import 'package:flutter_firebase/ui/components/home/document_tile.dart';
import 'package:flutter_firebase/ui/components/loader_popup.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FolderScreen extends StatefulWidget {
  final FolderModel folder;
  const FolderScreen({
    super.key,
    required this.folder,
  });

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  Duration animationDuration = const Duration(milliseconds: 400);
  Curve animationCurve = Curves.fastOutSlowIn;
  TextEditingController? searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DocumentProvider docProvider = Provider.of(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => _onFolderScreenPop(docProvider),
        child: Scaffold(
          body: Stack(
            children: [
              // Folder Screen
              AnimatedPositioned(
                duration: animationDuration,
                curve: animationCurve,
                top: docProvider.getFolderSearch ? context.height : 0,
                child: _folderScreen(context, docProvider),
              ),

              // Search Screen
              AnimatedPositioned(
                duration: animationDuration,
                curve: animationCurve,
                top: docProvider.getFolderSearch ? 0 : -context.height,
                child: _searchWidget(searchController!),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _onFolderScreenPop(DocumentProvider provider) {
    if (provider.getFolderSearch) {
      provider.setFolderSearch(false);
      searchController!.clear();
      primaryFocus!.unfocus();
      return false;
    }
    return true;
  }

  Widget _folderScreen(BuildContext context, DocumentProvider docProvider) {
    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight,
          width: context.width,
          // padding: globalHorizontalPadding(context),
          child: Row(
            children: [
              SizedBox(width: screenWidth(context, 15)),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                      top: screenHeight(context, 05),
                      bottom: screenHeight(context, 05),
                      left: screenHeight(context, 05)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: screenHeight(context, 25),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Text(
                widget.folder.folderName.length > 25
                    ? "${widget.folder.folderName.substring(0, 22)}..."
                    : widget.folder.folderName,
                style: TextStyle(
                  color: black,
                  fontSize: screenHeight(context, 25),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(flex: 10),
              // GestureDetector(
              //   onTap: () {
              //     docProvider.setFolderSearch(true);
              //   },
              //   child: Icon(
              //     Icons.search,
              //     color: blue,
              //     size: screenHeight(context, 35),
              //   ),
              // ),
              // SizedBox(width: screenWidth(context, 15)),
              // GestureDetector(
              //   // onTap: () => showSortingSettingOption(context, docProvider),
              //   child: Icon(
              //     Icons.sort_rounded,
              //     color: blue,
              //     size: screenHeight(context, 30),
              //   ),
              // ),
              // SizedBox(width: screenWidth(context, 15)),
              // GestureDetector(
              //   onTap: () => showGridSizeSettingOption(context, docProvider),
              //   child: Icon(
              //     Icons.grid_view,
              //     color: blue,
              //     size: screenHeight(context, 30),
              //   ),
              // ),
              // SizedBox(width: screenWidth(context, 10)),
            ],
          ),
        ),
        SizedBox(
          height: context.height - kToolbarHeight,
          width: context.width,
          child: docProvider.imageList.isEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(flex: 2),
                    Image.asset(
                      'assets/on_boarding/folder.png',
                      height: screenHeight(context, 175),
                    ),
                    Text(
                      "Your SnapBase is Empty",
                      style: TextStyle(
                        color: textGrey,
                        fontSize: screenHeight(context, 20),
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                )
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  children: [
                    SizedBox(height: screenHeight(context, 10)),
                    StaggeredGrid.count(
                      crossAxisCount: docProvider.getStaggeredCrossCount,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: [
                        StaggeredGridTile.count(
                          crossAxisCellCount: 6,
                          mainAxisCellCount: 6,
                          child: AddImageContainer(provider: docProvider),
                        ),
                        for (int i = 0; i < docProvider.imageList.length; i++)
                          StaggeredGridTile.count(
                            crossAxisCellCount:
                               docProvider.getCallCount[(i + 1) % docProvider.getCallCount.length]
                                    ['crossAxis']!,
                            mainAxisCellCount:
                                docProvider.getCallCount[(i + 1) % docProvider.getCallCount.length]
                                    ['mainAxis']!,
                            child: Image.network(
                              docProvider.imageList[i],
                              fit: BoxFit.fill,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    // child: CircularProgressIndicator(
                                    //     color: textGrey, strokeWidth: 1), 
                                    child: Image.asset('assets/images/loader.gif', height: screenHeight(context, 30),),
                                  );
                                }
                              },
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
          // crossAxisCount: docProvider.getGridCrossAxisCount,
          // docProvider.imageList.map((e) => Image.network(
          //       e,
          // loadingBuilder: (context, child, loadingProgress) {
          //   if (loadingProgress == null) {
          //     return child;
          //   } else {
          //     return const Center(
          //       child: CircularProgressIndicator(
          //           color: textGrey, strokeWidth: 1),
          //     );
          //   }
          // },
          //     ))
          // for (int i = 0; i < docProvider.imageList.length; i++)
          //   Image.network(
          //     docProvider.imageList[i],
          //     loadingBuilder: (context, child, loadingProgress) {
          //       if (loadingProgress == null) {
          //         return child;
          //       } else {
          //         return const Center(
          //           child: CircularProgressIndicator(
          //               color: textGrey, strokeWidth: 1),
          //         );
          //       }
          //     },
          //   )
          // ],
          // ),
        ),
      ],
    );
  }

    

  Widget _searchWidget(TextEditingController searchController) {
    return Consumer<DocumentProvider>(
      builder: (context, docProvider, _) => Column(
        children: [
          Container(
            height: screenHeight(context, 80),
            width: context.width,
            padding: globalHorizontalPadding(context).copyWith(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: screenHeight(context, 60),
                  width: context.width - screenWidth(context, 80),
                  child: TextFormField(
                    cursorHeight: screenHeight(context, 25),
                    controller: searchController,
                    cursorColor: blue,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        docProvider.search(val);
                      } else {
                        docProvider.clearSearchList();
                        searchController.clear();
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Search by title",
                      focusColor: blue,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blue),
                      ),
                      hintStyle: TextStyle(
                        color: textGrey,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    docProvider.setFolderSearch(false);
                    searchController.clear();
                    primaryFocus!.unfocus();
                  },
                  icon: Icon(
                    Icons.close,
                    color: blue,
                    size: screenHeight(context, 35),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: context.height - kToolbarHeight,
            width: context.width,
            child: docProvider.searchList.isEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(flex: 2),
                      Image.asset(
                        'assets/on_boarding/folder.png',
                        height: screenHeight(context, 175),
                      ),
                      Text(
                        "No Searched Found",
                        style: TextStyle(
                          color: textGrey,
                          fontSize: screenHeight(context, 20),
                        ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  )
                : ListView.builder(
                    itemCount: docProvider.searchList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => DocumentTile(
                      document: docProvider.searchList[index],
                      onTap: () {},
                      onDeletePress: () async {
                        Loader.show(context);
                        DatabaseService().deletteDocument(index, docProvider);
                        Loader.disposeLoader(context);
                      },
                      index: index,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
