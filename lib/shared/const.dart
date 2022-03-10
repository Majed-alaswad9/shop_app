import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMsg({
  required String? msg,
  required colorMsg? color
})=>Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chose(color!),
    textColor:Colors.white,
    fontSize: 16.0
);
enum colorMsg{error ,success ,inCorrect}

Color chose( colorMsg  msg){
  Color color=Colors.green;
  switch(msg)
  {
    case colorMsg.error:
      color=Colors.red;
      break;
    case colorMsg.success:
      color=Colors.green;
      break;
    case colorMsg.inCorrect:
      color=Colors.yellow;
      break;
  }
  return color;
}

void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element)=>print(element.group(0)));
}

/* ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  primary: Colors.white,
                  onPrimary: Colors.grey,
                  elevation: 2,
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: 180,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                    double.infinity,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: Colors.blue[900]),
                                    child: MaterialButton(
                                      color: Colors.blueGrey,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        getImage(ImageSource.camera);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          Icon(
                                            Icons
                                                .photo_camera_outlined,
                                            color: Colors
                                                .white,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          const Text(
                                            'camera',
                                            style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width:
                                    double.infinity,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            5),
                                        color: Colors
                                            .blue[900]),
                                    child: MaterialButton(
                                      color: Colors.blueGrey,
                                      onPressed: () {
                                        Navigator.of(
                                            context)
                                            .pop();
                                        getImage(
                                            ImageSource
                                                .gallery);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          Icon(
                                            Icons
                                                .photo_outlined,
                                            color: Colors
                                                .white,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'gallery',
                                            style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                },
                child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(
                      width: 40,
                    ),
                    Text('Pick Image')
                  ],
                ))*/