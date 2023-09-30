import 'package:boarded/core/constants/my_text.dart';
import 'package:boarded/models/board_games_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget boardGamesSelector(
  BuildContext context,
  List<String> boardGamesList,
  Function getData,
  FocusNode myFocusNode,
  AnimationController controller,
  Animation<Offset> offsetAnimation,
) {
  final popupCustomValidationKey = GlobalKey<DropdownSearchState<BoardGames>>();
  return DropdownSearch<BoardGames>.multiSelection(
    key: popupCustomValidationKey,
    asyncItems: (filter) => getData(filter),
    itemAsString: (BoardGames b) => b.name,
    compareFn: (i, s) => i == s,
    validator: (List<BoardGames>? items) {
      if (items == null || items.isEmpty) {
        return "Please choose at least one game";
      }
      return null;
    },
    onChanged: (List<BoardGames> items) => {boardGamesList = items.map((game) => game.name).toList()},
    popupProps: PopupPropsMultiSelection.modalBottomSheet(
      fit: FlexFit.loose,
      selectionWidget: (context, item, isSelected) {
        return Checkbox(
            fillColor: MaterialStatePropertyAll(Colors.black),
            value: isSelected,
            onChanged: (newVal) => isSelected = newVal!);
      },

      constraints: BoxConstraints(maxHeight: double.infinity),
      //scrollbarProps: ScrollbarProps(thickness: 100),
      searchFieldProps: TextFieldProps(
        focusNode: myFocusNode,
        cursorColor: Color.fromARGB(31, 116, 115, 115),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 16.sp),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 122, 120, 120),
              width: 2,
            ),
          ),
          hintText: "Find your games",
        ),
      ),
      isFilterOnline: true,
      showSelectedItems: true,
      showSearchBox: true,
      itemBuilder: _popupItemBuilder,
      modalBottomSheetProps: ModalBottomSheetProps(
        backgroundColor: Colors.transparent,
        elevation: 0,
        enableDrag: true,
        animation: controller,
        padding: EdgeInsets.only(top: 10.h),
      ),
      containerBuilder: (context, popupWidget) {
        return SlideTransition(
          position: offsetAnimation,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 20.h,
              left: 10.w,
              right: 10.w,
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(12.0.r),
                          child: GestureDetector(
                            child: MyText(
                              "Save",
                              style: TextStyle(
                                color: Color.fromRGBO(94, 157, 98, 1),
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              popupCustomValidationKey.currentState?.popupOnValidate();
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(12.0.r),
                          child: GestureDetector(
                            child: MyText(
                              "Cancel",
                              style: TextStyle(
                                color: Color.fromRGBO(217, 29, 19, 1),
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              popupCustomValidationKey.currentState?.closeDropDownSearch();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 15,
                  child: Container(
                    child: popupWidget,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      validationWidgetBuilder: (context, item) {
        return Container();
      },
    ),
  );
}

Widget _popupItemBuilder(BuildContext context, BoardGames item, bool isSelected) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    //decoration: !isSelected
    //    ? null
    //    : BoxDecoration(
    //        border: Border.all(color: Theme.of(context).primaryColor),
    //        borderRadius: BorderRadius.circular(5),
    //        color: Colors.white,
    //      ),
    child: ListTile(
      selected: isSelected,
      title: MyText(
        item.name,
        style: !isSelected
            ? TextStyle(color: Colors.black, fontSize: 13.sp)
            : TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13.sp),
      ),

      // subtitle: Text(item.createdAt.toString()),
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(item.avatar),
      // ),
    ),
  );
}
