import 'dart:io';

import 'package:adwance_ui/Controller/controller.dart';
import 'package:adwance_ui/Screens/Day%201/Home_Page.dart';
import 'package:adwance_ui/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              GestureDetector(
                  onTap: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? xFile = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    String path = xFile!.path;
                    File fileImage = File(path);
                    chatController.getImg(fileImage);
                  },
                  child: Obx(
                    () => CircleAvatar(
                      radius: 70,
                      backgroundImage: (chatController.ImgPath != null)
                          ? FileImage(chatController.ImgPath!.value)
                          : NetworkImage(chatController.dummyImage.value),
                    ),
                  )),
              SizedBox(
                height: height * 0.02,
              ),
              buildCupertinoTextField(
                  icon: Icons.person, hintText: 'Full Name', context: context, controller: chatController.txtName),
              buildCupertinoTextField(
                  icon: Icons.call, hintText: 'Call', context: context, controller: chatController.txtPhone),
              buildCupertinoTextField(
                  icon: Icons.chat, hintText: 'Chat', context: context, controller: chatController.txtChat),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () async {
                        chatController.selectDate = (await showDatePicker(
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                    primary: Color(0xff386927),
                                    onSurface: Colors.black,
                                    primaryContainer: Colors.black,
                                    surface: color1),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(
                                        0xff386927), // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                          context: context,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        ))!;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.calendar_today,
                          color: Colors.blueAccent,
                        ),
                      )),
                  Text('Date Pick')
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      chatController.selectedTime = (await showTimePicker(
                        builder: (context, child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                      primary: Color(0xff386927),
                                      onSurface: Colors.black,
                                      primaryContainer: Colors.green,
                                      surface: color1)),
                              child: child!);
                        },
                        initialTime: TimeOfDay.now(),
                        context: context,
                      ))!;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Text('Time Pick'),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CupertinoButton(
                color: Colors.blueAccent,
                child: Text(
                  'Save',
                  style: TextStyle(
                    backgroundColor: Colors.blueAccent,
                    // background: Paint(),
                    color: Colors.white,
                    decorationColor: Colors.green,
                  ),
                ),
                onPressed: () {
                  String d1 = chatController.txtName.text;
                  String d2 = chatController.txtPhone.text;
                  String d3 = chatController.txtChat.text;
                  String time = chatController.selectDate.toString();
                  String time2 = chatController.selectedTime.toString();
                  chatController.insertRecord(d1, d2, d3,
                      chatController.ImgPath!.value.path, time, time2);
                  print(chatController.ImgPath!.value.path);

                  chatController.txtName.clear();
                  chatController.txtPhone.clear();
                  chatController.txtChat.clear();
                },
              ),
              // TextButton(
              //     onPressed: () {
              //       String d1 = chatController.txtName.text;
              //       String d2 = chatController.txtPhone.text;
              //       String d3 = chatController.txtChat.text;
              //       String time = chatController.selectDate.toString();
              //       String time2 = chatController.selectedTime.toString();
              //       chatController.insertRecord(
              //           d1,
              //           d2,
              //           d3,
              //           chatController.ImgPath!.value.path,
              //           time,
              //           time2);
              //       print(chatController.ImgPath!.value.path);
              //
              //       chatController.txtName.clear();
              //       chatController.txtPhone.clear();
              //       chatController.txtChat.clear();
              //       // controller.txtAmount.clear();
              //       // controller.txtCategory.clear();
              //     },
              //     child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCupertinoTextField(
    {required String hintText,
    required IconData icon,
    required BuildContext context,required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: CupertinoTextField(
      controller: controller,
      padding: EdgeInsets.all(10),
      maxLines: 1,
      // textInputAction:  TextInputAction.search,
      placeholder: hintText,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          borderRadius: BorderRadius.circular(7)),
      prefix: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.blueAccent,
        ),
      ),

      textDirection: TextDirection.ltr,
    ),
  );
}

class ColumnWidget2 extends StatelessWidget {
  const ColumnWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ChatController chatController = Get.put(ChatController());

    return Scaffold(
      body: Obx(
        () => ListView.builder(
            itemBuilder: (context, index) => ListTile(
                  onLongPress: () {
                    chatController.removeRecords(
                      int.parse(
                        chatController.DataList[index]['id'].toString(),
                      ),
                    );
                    // chatController.DataList[index]['id'];
                  },

                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          "Update your record",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    XFile? xFile = await imagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    String path = xFile!.path;
                                    File fileImage = File(path);
                                    chatController.getImg(fileImage);
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: FileImage(
                                      File(
                                        chatController.DataList[index]['img'],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                cursorColor: Colors.grey,
                                controller: chatController.txtName,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: chatController.DataList[index]
                                          ['Name']
                                      .toString(),
                                  labelStyle: const TextStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                cursorColor: Colors.grey,
                                controller: chatController.txtPhone,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: chatController.DataList[index]
                                          ['Phone']
                                      .toString(),
                                  labelStyle: const TextStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                cursorColor: Colors.grey,
                                controller: chatController.txtChat,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: chatController.DataList[index]
                                          ['Chat']
                                      .toString(),
                                  labelStyle: const TextStyle(),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        // chatController.selectDate = data.toString();
                                        chatController.selectDate =
                                            (await showDatePicker(
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                    primary: Color(0xff386927),
                                                    onSurface: Colors.black,
                                                    primaryContainer:
                                                        Colors.black,
                                                    surface: color1),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: const Color(
                                                        0xff386927), // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                          context: context,
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime.now(),
                                        ))!;
                                        // String hi = data.toString();
                                        // chatController.selectDate =
                                        //     hi;
                                      },
                                      child: const Icon(
                                        Icons.calendar_today,
                                      )),
                                  Text(
                                    '  ${chatController.selectDate.day}/${chatController.selectDate.month}/${chatController.selectDate.year}',
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        chatController.selectedTime =
                                            (await showTimePicker(
                                          builder: (context, child) {
                                            return Theme(
                                                data: Theme.of(context).copyWith(
                                                    colorScheme:
                                                        ColorScheme.light(
                                                            primary:
                                                                const Color(
                                                                    0xff386927),
                                                            onSurface:
                                                                Colors.black,
                                                            primaryContainer:
                                                                Colors.green,
                                                            surface: color1)),
                                                child: child!);
                                          },
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        ))!;
                                      },
                                      child: const Icon(
                                        Icons.watch_later_outlined,
                                      )),
                                  Text(
                                    '  ${chatController.selectedTime.hour}:${chatController.selectedTime.minute}',
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // txtController.clear();
                            },
                            child: const Text('Cancel'),
                          ),
                          MaterialButton(
                            onPressed: () {
                              String time =
                                  chatController.selectDate.toString();
                              String time2 =
                                  chatController.selectedTime.toString();
                              chatController.updateRecords(
                                chatController.DataList[index]['id'],
                                chatController.txtName.text,
                                chatController.txtChat.text,
                                chatController.txtPhone.text,
                                chatController.ImgPath!.value.path,
                                time,
                                time2,
                              );

                              print('${chatController.txtName.text} ');

                              chatController.txtName.clear();
                              chatController.txtPhone.clear();
                              chatController.txtChat.clear();
                              // controller.txtAmount.clear();
                              // controller.txtCategory.clear();
                              Navigator.of(context).pop();
                              // controller.isIncome.value = false;
                              // txtController.clear();/
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    );
                  },
                  leading: Obx(
                    () => CircleAvatar(
                      backgroundImage: FileImage(
                        File(
                          chatController.DataList[index]['img'],
                        ),
                      ),
                    ),
                  ),
                  title:
                      Text(chatController.DataList[index]['Name'].toString()),
                  subtitle:
                      Text(chatController.DataList[index]['Chat'].toString()),
                  // subtitle: InkWell(
                  //     onTap: () {
                  //       chatController.removeRecords(
                  //         int.parse(
                  //           chatController.DataList[index]['id']
                  //               .toString(),
                  //         ),
                  //       );
                  //       // chatController.DataList[index]['id'];
                  //     },
                  //     child: Icon(Icons.delete)),
                  trailing: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width: width * 0.175,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          chatController.DataList[index]['Time'],
                        ),
                        // child:Column(
                        //   children: [
                        //     Text(
                        //       overflow: TextOverflow.ellipsis,
                        //       chatController.DataList[index]['Time'],
                        //     ),
                        //     Text(
                        //       // overflow: TextOverflow.ellipsis,
                        //       chatController.DataList[index]['Time2'],
                        //     ),
                        //   ],
                        // )
                      ),
                      Container(
                        width: width * 0.3,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          chatController.DataList[index]['Time2'],
                        ),
                      )
                    ],
                  ),
                ),
            itemCount: chatController.DataList.length),
      ),
    );
  }
}

class ColumnWidget3 extends StatelessWidget {
  const ColumnWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ChatController chatController = Get.put(ChatController());
    return Scaffold(
      body: Obx(
        () => ListView.builder(
            itemBuilder: (context, index) => ListTile(
                onLongPress: () {
                  chatController.removeRecords(
                    int.parse(
                      chatController.DataList[index]['id'].toString(),
                    ),
                  );
                  // chatController.DataList[index]['id'];
                },
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Update your record",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? xFile = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  String path = xFile!.path;
                                  File fileImage = File(path);
                                  chatController.getImg(fileImage);
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: FileImage(
                                    File(
                                      chatController.DataList[index]['img'],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              cursorColor: Colors.grey,
                              controller: chatController.txtName,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: chatController.DataList[index]['Name']
                                    .toString(),
                                labelStyle: const TextStyle(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              cursorColor: Colors.grey,
                              controller: chatController.txtPhone,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: chatController.DataList[index]
                                        ['Phone']
                                    .toString(),
                                labelStyle: const TextStyle(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              cursorColor: Colors.grey,
                              controller: chatController.txtChat,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: chatController.DataList[index]['Chat']
                                    .toString(),
                                labelStyle: const TextStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () async {
                                      // chatController.selectDate = data.toString();
                                      chatController.selectDate =
                                          (await showDatePicker(
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                  primary: Color(0xff386927),
                                                  onSurface: Colors.black,
                                                  primaryContainer:
                                                      Colors.black,
                                                  surface: color1),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: const Color(
                                                      0xff386927), // button text color
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                        context: context,
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime.now(),
                                      ))!;
                                      // String hi = data.toString();
                                      // chatController.selectDate =
                                      //     hi;
                                    },
                                    child: const Icon(
                                      Icons.calendar_today,
                                    )),
                                Text('Dtae Pick')
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () async {
                                      chatController.selectedTime =
                                          (await showTimePicker(
                                        builder: (context, child) {
                                          return Theme(
                                              data: Theme.of(context).copyWith(
                                                  colorScheme:
                                                      ColorScheme.light(
                                                          primary: const Color(
                                                              0xff386927),
                                                          onSurface:
                                                              Colors.black,
                                                          primaryContainer:
                                                              Colors.green,
                                                          surface: color1)),
                                              child: child!);
                                        },
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      ))!;
                                    },
                                    child: const Icon(
                                      Icons.watch_later_outlined,
                                    )),
                                Text('Pick Time')
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // txtController.clear();
                          },
                          child: const Text('Cancel'),
                        ),
                        MaterialButton(
                          onPressed: () {
                            String time = chatController.selectDate.toString();
                            String time2 =
                                chatController.selectedTime.toString();
                            chatController.updateRecords(
                              chatController.DataList[index]['id'],
                              chatController.txtName.text,
                              chatController.txtChat.text,
                              chatController.txtPhone.text,
                              chatController.ImgPath!.value.path,
                              time,
                              time2,
                            );

                            print('${chatController.txtName.text} ');

                            chatController.txtName.clear();
                            chatController.txtPhone.clear();
                            chatController.txtChat.clear();
                            // controller.txtAmount.clear();
                            // controller.txtCategory.clear();
                            Navigator.of(context).pop();
                            // controller.isIncome.value = false;
                            // txtController.clear();/
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
                leading: Obx(
                  () => CircleAvatar(
                    backgroundImage: FileImage(
                      File(
                        chatController.DataList[index]['img'],
                      ),
                    ),
                  ),
                ),
                title: Text(chatController.DataList[index]['Name'].toString()),
                subtitle:
                    Text(chatController.DataList[index]['Chat'].toString()),
                // subtitle: InkWell(
                //     onTap: () {
                //       chatController.removeRecords(
                //         int.parse(
                //           chatController.DataList[index]['id']
                //               .toString(),
                //         ),
                //       );
                //       // chatController.DataList[index]['id'];
                //     },
                //     child: Icon(Icons.delete)),
                trailing: Icon(
                  Icons.call,
                  size: 30,
                  color: Colors.green,
                )),
            itemCount: chatController.DataList.length),
      ),
    );
  }
}

class ColumnWidget4 extends StatelessWidget {
  const ColumnWidget4({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ChatController chatController = Get.put(ChatController());
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '  Profile',
                  style: TextStyle(fontSize: 25),
                ),
                Obx(
                  () => CupertinoSwitch(
                    // onFocusChange: v,
                    value: pr.value,
                    onChanged: (value) {
                      pr.value = !pr.value;
                    },
                  ),
                )
              ],
            ),
            (pr.value)
                ? Container(
              width: width * 0.5,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      im != im;
                      ImagePicker imagePicker = ImagePicker();
                      XFile? xFile = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      String path = xFile!.path;
                      File fileImage = File(path);
                      // print(fileImage);
                      chatController.getImg1(fileImage);
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: (chatController.ImgPath1 != null)
                          ? FileImage(chatController.ImgPath1!.value)
                          : NetworkImage(chatController.dummyImage.value),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: TextField(
                      controller: chatController.name,
                      decoration: InputDecoration(
                          helperText: 'Name',
                          hintText: (chatController.name == ' ')
                              ? 'hiii'
                              : '${chatController.name.text}'),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: TextField(
                      controller: chatController.bio,
                      decoration: InputDecoration(
                          helperText: 'Bio',
                          hintText: (chatController.bio == ' ')
                              ? 'hiii'
                              : '${chatController.bio.text}'),
                    ),
                  ),
                  SizedBox(height: height * 0.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {}, child: Text('Save')),
                      TextButton(
                          onPressed: () {
                            chatController.bio.clear();
                            chatController.name.clear();
                          },
                          child: Text('Clear'))
                    ],
                  )
                ],
              ),
            )
                : Column(
                    children: [],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '  Theme',
                  style: TextStyle(fontSize: 25),
                ),
                Obx(
                  () => CupertinoSwitch(
                    // onFocusChange: v,
                    value: theme1.value,
                    onChanged: (value) {
                      theme1.value = !theme1.value;
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
