import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:web_longman/ui/webview_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';  // ADD



class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  // Add from here...
  late final WebViewController controller;
  int onPop = 0;
  bool onPopBool = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://www.ldoceonline.com/#google_vignette'),
      );
  }
  // ...to here.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff314089),
        title: const Text('Longman web',style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.white
        ),),
      ),
      body: PopScope(
          canPop: onPopBool,
          onPopInvoked: (value){
            if (onPop < 2) {
              Future.delayed(const Duration(seconds: 1)).then((value) {
                onPop = 0;
              });
              onPop += 1;
              onPopBool = true;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Color(0xff314089),
                    content: Text("Ikki marta bosing"))
              );
            } else if (onPop == 2) {
              onPopBool = false;
              onPop = 0;
            }
            setState(() {});
          },
          child: WebViewStack(controller: controller)),
      bottomNavigationBar: GNav(
          backgroundColor: Color(0xff314089),
          rippleColor: Colors.grey, // tab button ripple color when pressed
          hoverColor: Colors.grey, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          curve: Curves.easeOutExpo, // tab animation curves
          duration: const Duration(milliseconds: 900), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.white, // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 24, // tab button icon size
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
          tabs: [
            GButton(
              onPressed: ()async{
                final messenger = ScaffoldMessenger.of(context);
                if (await controller.canGoBack()) {
                await controller.goBack();
                } else {
                messenger.showSnackBar(
                const SnackBar(
                    backgroundColor: Color(0xffffffff),
                    content: Text('No back history item',style: TextStyle(
                      color: Color(0xff314089),
                    ),)),
                );
                return;
                }
              },
              icon: Icons.arrow_back_ios,
              text: 'Home',
            ),
            GButton(
              onPressed: (){
                controller.reload();
              },
              icon: Icons.replay,
              text: 'Refresh',
            ),
            GButton(
              onPressed: ()async{
                final messenger = ScaffoldMessenger.of(context);
                if (await controller.canGoForward()) {
                await controller.goForward();
                } else {
                messenger.showSnackBar(
                const SnackBar(
                    backgroundColor: Color(0xffffffff),
                    content: Text('No forward history item',style: TextStyle(
                      color: Color(0xff314089),
                    ),)),
                );
                return;
                }
              },
              icon: Icons.arrow_forward_ios,
              text: 'Back',
            ),

          ]
      )// MODIFY
    );
  }
}

/*
*  BottomNavigationBar(
        backgroundColor: const Color(0xff314089),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
           BottomNavigationBarItem(
             label: "Back",
             icon: IconButton(onPressed: ()async{
               final messenger = ScaffoldMessenger.of(context);
               if (await controller.canGoBack()) {
               await controller.goBack();
               } else {
               messenger.showSnackBar(
               const SnackBar(content: Text('No back history item')),
               );
               return;
               }
             }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,))
           ),
           BottomNavigationBarItem(
              label: "Back",
              icon: IconButton(onPressed: ()async {
                controller.reload();
              },
                icon: const Icon(Icons.replay,color: Colors.white,),
              )),
           BottomNavigationBarItem(
             label: "Back",
             icon:  IconButton(
               icon: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
               onPressed: () async {
                 final messenger = ScaffoldMessenger.of(context);
                 if (await controller.canGoForward()) {
                   await controller.goForward();
                 } else {
                   messenger.showSnackBar(
                     const SnackBar(content: Text('No forward history item')),
                   );
                   return;
                 }
               },
             ),
           ),

        ],
      ),
* */