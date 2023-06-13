import 'package:flutter/material.dart';
import 'package:flutter_firebase/database_service.dart';
import 'package:flutter_firebase/ui/components/home/document_tile.dart';
import 'package:flutter_firebase/ui/components/loader_popup.dart';
import 'package:flutter_firebase/ui/responsiveness/screen_size.dart';
import 'package:flutter_firebase/ui/shared/colors.dart';
import 'package:flutter_firebase/ui/shared/extensions.dart';
import 'package:flutter_firebase/ui/shared/global_padding.dart';
import 'package:flutter_firebase/ui/state_management/provder_util.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final TextEditingController searchController;
  const SearchScreen({
    super.key,
    required this.searchController,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
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
                Container(width: screenWidth(context, 40)),
                SizedBox(
                  height: screenHeight(context, 60),
                  width: screenWidth(context, 300),
                  child: TextFormField(
                    cursorHeight: screenHeight(context, 25),
                    controller: widget.searchController,
                    cursorColor: blue,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        docProvider.search(val);
                      } else {
                        docProvider.clearSearchList();
                        widget.searchController.clear();
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
                    docProvider.setSearchTapped(false);
                    widget.searchController.clear();
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
