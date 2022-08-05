import 'dart:async';

import 'package:flutter/material.dart';

import 'loading_screen_controller.dart';


class LoadingScreen {
  LoadingScreen._shares();
  static LoadingScreen shared = LoadingScreen._shares();
  factory LoadingScreen.instance() => shared;

  LoadinScreenController? _controller;

  void show({required BuildContext context, required String text}){
    if(_controller?.updateLoadingSreen(text)  ?? false){
      return;
    }
    _controller = _showOverLay(context: context, text: text);
  }

  void hide(){
    _controller?.closeLoadingScreen();
    _controller = null;
  }

  LoadinScreenController? _showOverLay(
      {required BuildContext context, required String text}) {
    
    final textStream = StreamController<String>();
    textStream.add(text);

    //get the size for overlay
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
        builder: (context) => Material(
              color: Colors.black45,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: size.width * 0.8,
                      maxWidth: size.height * 0.8,
                      minWidth: size.width * 0.5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<String>(
                                stream: textStream.stream,
                                builder: (context, snapshot) => Text(
                                      snapshot.data ?? '',
                                      textAlign: TextAlign.center,
                                    ))
                          ])),
                ),
              ),
            ));
    state?.insert(overlay);

    return LoadinScreenController(
      closeLoadingScreen: () {
        textStream.close();
        overlay.remove();
        return true;
      },
      updateLoadingSreen: (txt) {
        textStream.add(txt);
        return true;
      },
    );
  }
}
