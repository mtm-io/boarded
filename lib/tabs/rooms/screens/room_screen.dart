// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:boarded/core/common/dateTimePicker.dart';
import 'package:boarded/core/common/error_text.dart';
import 'package:boarded/core/common/loader.dart';
import 'package:boarded/core/constants/my_text.dart';
import 'package:boarded/models/board_games_model.dart';
import 'package:boarded/models/room_model.dart';
import 'package:boarded/tabs/rooms/controller/room_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class RoomScreen extends ConsumerStatefulWidget {
  final String name;
  const RoomScreen({
    required this.name,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomScreenState();
}

class _RoomScreenState extends ConsumerState<RoomScreen> with SingleTickerProviderStateMixin {
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

  late String name = widget.name;
  final _formKey = GlobalKey<FormState>();
  final roomNameController = TextEditingController();
  final roomDescriptionController = TextEditingController();
  final roomDateController = TextEditingController();
  final roomAddressController = TextEditingController();
  bool isEditing = false;
  late DateTime roomDateTime;
  late List<String> boardGamesList;

  bool isDefault = true;

  final _popupCustomValidationKey = GlobalKey<DropdownSearchState<BoardGames>>();

  late StreamSubscription<bool> keyboardSubscription;
  FocusNode myFocusNode = FocusNode();

  Future<List<BoardGames>> getData(filter) async {
    var boardGamesList = await ref.read(roomControllerProvider.notifier).getAllCategory(filter);
    return boardGamesList;
  }

  void save(Room room) {
    ref.read(roomControllerProvider.notifier).editRoom(
          name: roomNameController.text.trim(),
          description: roomDescriptionController.text.trim(),
          city: roomAddressController.text.trim(),
          address: roomAddressController.text.trim(),
          games: boardGamesList,
          startDateTime: roomDateTime,
          context: context,
          room: room,
        );
  }

  void cancel() {
    Routemaster.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        myFocusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    roomNameController.dispose();
    roomDescriptionController.dispose();
    roomAddressController.dispose();
    roomDateController.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    //final user = ref.watch(userProvider)!;
    //print(user);
    print('room screen');
    final isLoading = ref.watch(roomControllerProvider);
    return Container(
        child: ref.watch(getRoomByNameProvider(name)).when(
              data: (room) => Scaffold(
                appBar: AppBar(title: Text(room.name)),
                body: isLoading
                    ? const Loader()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    readOnly: !isEditing,
                                    controller: (() {
                                      if (isDefault) {
                                        roomNameController.text = room.name;
                                        roomDescriptionController.text = room.description;
                                        roomDateController.text =
                                            DateFormat('dd.MM.yyyy @ HH:mm').format(room.startDateTime);
                                        roomDateTime = room.startDateTime;
                                        roomAddressController.text = room.address;
                                        boardGamesList = room.games;
                                        isDefault = false;
                                      }
                                      return roomNameController;
                                    }()),
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
                                      fillColor: Color.fromARGB(255, 255, 255, 255),
                                      filled: true,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: roomDescriptionController,
                                    readOnly: !isEditing,
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
                                      hintText: 'A fun evening playing Monopoly, bring friends!',
                                      fillColor: Color.fromARGB(255, 255, 255, 255),
                                      filled: true,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('Board games you want to play'),
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
                                  TextFormField(
                                    controller: roomAddressController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the adress';
                                      } else if (value.length < 5) {
                                        return 'The adress is too short';
                                      } else if (value.length > 100) {
                                        return 'The adress is too long';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: '6th Avenue, 68, OAE',
                                      fillColor: Color.fromARGB(255, 255, 255, 255),
                                      filled: true,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text('Date'),
                                  TextFormField(
                                      controller: roomDateController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please choose the date';
                                        } else if (roomDateTime.compareTo(DateTime.now()) < 0) {
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
                                        if (isEditing) {
                                          final now = DateTime.now();
                                          DateTime? pickedDate = await showDateTimePicker(
                                            context: context,
                                            initialDate: now,
                                            firstDate: now,
                                            lastDate: now.add(const Duration(days: 365)),
                                          );
                                          if (pickedDate != null) {
                                            print(pickedDate);
                                            String formattedDate = DateFormat('dd.MM.yyyy @ HH:mm').format(pickedDate);
                                            print(formattedDate);

                                            setState(() {
                                              roomDateController.text =
                                                  formattedDate; //set foratted date to TextField value.
                                              roomDateTime = pickedDate;
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        }
                                      }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  isEditing
                                      ? ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              if (roomNameController.text.trim() != room.name ||
                                                  roomDescriptionController.text.trim() != room.description ||
                                                  roomDateTime != room.startDateTime ||
                                                  room.games != boardGamesList) {
                                                save(room);
                                              } else {
                                                cancel();
                                              }
                                            }
                                          },
                                          child: const Text('Save'),
                                        )
                                      : ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isEditing = true;
                                            });
                                          },
                                          child: const Text('Edit'),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            ));

  }

  Widget boardGamesSelector(BuildContext context) {
    return DropdownSearch<BoardGames>.multiSelection(
      enabled: isEditing,
      key: _popupCustomValidationKey,
      asyncItems: (filter) => getData(filter),
      itemAsString: (BoardGames b) => b.name,
      selectedItems: boardGamesList.map((gameName) => BoardGames(name: gameName)).toList(),
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
                                _popupCustomValidationKey.currentState?.popupOnValidate();
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
                                _popupCustomValidationKey.currentState?.closeDropDownSearch();
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
}
