import 'package:boarded/core/common/dateTimePicker.dart';
import 'package:boarded/core/common/loader.dart';
import 'package:boarded/core/constants/my_text.dart';
import 'package:boarded/models/board_games_model.dart';
import 'package:boarded/tabs/rooms/controller/room_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    reverseDuration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
    reverseCurve: Curves.easeIn,
  ));

  final _formKey = GlobalKey<FormState>();
  late DateTime roomDateTime;
  late List<String> boardGamesList;

  final roomNameController = TextEditingController();
  final roomDecriptionController = TextEditingController();
  final roomAddressController = TextEditingController();
  final roomDateController = TextEditingController();
  final _popupCustomValidationKey =
      GlobalKey<DropdownSearchState<BoardGames>>();

  late StreamSubscription<bool> keyboardSubscription;
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        myFocusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    roomNameController.dispose();
    roomDecriptionController.dispose();
    roomAddressController.dispose();
    roomDateController.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  void createRoom() {
    ref.read(roomControllerProvider.notifier).createRoom(
          roomNameController.text.trim(),
          roomDecriptionController.text.trim(),
          boardGamesList,
          roomDateTime,
          roomAddressController.text.trim(),
          context,
        );
  }

  Future<List<BoardGames>> getData(filter) async {
    var boardGamesList =
        await ref.read(roomControllerProvider.notifier).getAllCategory(filter);
    return boardGamesList;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(roomControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a room'),
      ),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Text('Room name'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: roomNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name';
                        } else if (value.length < 5) {
                          return 'The name is too short';
                        } else if (value.length > 20) {
                          return 'The name is too long';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Board evening @ ArtDecoCowork',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('Room description'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: roomDecriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the description';
                        } else if (value.length < 5) {
                          return 'The description is too short';
                        } else if (value.length > 100) {
                          return 'The description is too long';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText:
                            'A fun evening playing Monopoly, bring friends!',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('Board games you want to play'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // If firebase Query:
                    //
                    // StreamBuilder<QuerySnapshot>(
                    //   stream: ref.read(roomControllerProvider.notifier).getBoardGames(),
                    //   builder: (context, snapshot) {
                    //     List<BoardGames> boardGamesItems = [];
                    //     if (!snapshot.hasData) {
                    //       const Loader();
                    //     } else {
                    //       final boardGames = snapshot.data?.docs.toList();
                    //       for (var game in boardGames!) {
                    //         boardGamesItems.add(BoardGames(id: game['id'], name: game['name']));
                    //       }
                    //     }
                    //     return ???; // <- Widget
                    //   },
                    // ),
                    //
                    ////////////////////////////////////////////////////////////////
                    //
                    // Working Dropdown

                    const SizedBox(
                      height: 10.0,
                    ),
                    boardGamesSelector(context),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('Adress'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: roomAddressController,
                      decoration: const InputDecoration(
                        hintText: '5th Avenue, 25',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('Date'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        controller: roomDateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please choose the date';
                          } else if (roomDateTime.compareTo(DateTime.now()) <
                              0) {
                            return 'The date can\'t be earlier than realtime';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Enter Date",
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                        ),
                        readOnly: true,
                        onTap: () async {
                          final now = DateTime.now();
                          DateTime? pickedDate = await showDateTimePicker(
                            context: context,
                            initialDate: now,
                            firstDate: now,
                            lastDate: now.add(const Duration(days: 365)),
                          );
                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                                DateFormat('dd.MM.yyyy @ HH:mm')
                                    .format(pickedDate);
                            print(formattedDate);

                            setState(() {
                              roomDateController.text =
                                  formattedDate; //set foratted date to TextField value.
                              roomDateTime = pickedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          createRoom();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Create'),
                    )
                  ]),
                ),
              ),
            ),
    );
  }

  Widget boardGamesSelector(BuildContext context) {
    return DropdownSearch<BoardGames>.multiSelection(
      key: _popupCustomValidationKey,
      asyncItems: (filter) => getData(filter),
      itemAsString: (BoardGames b) => b.name,
      compareFn: (i, s) => i == s,
      validator: (List<BoardGames>? items) {
        if (items == null || items.isEmpty) {
          return "Please choose at least one game";
        }
        return null;
      },
      onChanged: (List<BoardGames> items) =>
          {boardGamesList = items.map((game) => game.name).toList()},
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
            contentPadding:
                EdgeInsets.symmetric(vertical: 4.sp, horizontal: 16.sp),
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
          animation: _controller,
          padding: EdgeInsets.only(top: 10.h),
        ),
        containerBuilder: (context, popupWidget) {
          return SlideTransition(
            position: _offsetAnimation,
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
                                _popupCustomValidationKey.currentState
                                    ?.popupOnValidate();
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
                                _popupCustomValidationKey.currentState
                                    ?.closeDropDownSearch();
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

  Widget _popupItemBuilder(
      BuildContext context, BoardGames item, bool isSelected) {
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
              : TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp),
        ),

        // subtitle: Text(item.createdAt.toString()),
        // leading: CircleAvatar(
        //   backgroundImage: NetworkImage(item.avatar),
        // ),
      ),
    );
  }
}
