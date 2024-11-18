import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // Set up the timer to change pages automatically
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    // Listen to changes in the page to update _currentPage
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });

    // Keep the system UI visible
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(192, 1, 0, 1),
          ),
          child: SafeArea(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // Automatic Image Slider
                  PageView(
                    controller: _pageController,
                    children: const [
                      Image(
                        image: AssetImage('assets/images/startup.png'),
                        fit: BoxFit.cover,
                      ),
                      Image(
                        image: AssetImage('assets/images/startup2.png'),
                        fit: BoxFit.cover,
                      ),
                      Image(
                        image: AssetImage('assets/images/startup3.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                  // Conditionally render the logo image
                  Positioned(
                    top: 65,
                    child: const Image(
                      height: 100,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  // Text overlay
                  if (_currentPage == 0 || _currentPage == 2)
                    Positioned(
                      bottom: 100, // Fixed position from the bottom
                      child: const Text(
                        "love ko 'to",
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  // Button at the bottom
                  Positioned(
                    bottom: MediaQuery.of(context)
                        .viewInsets
                        .bottom, // Fixed position from the bottom
                    child: GestureDetector(
                      onTap: () {
                        print("Button clicked!");
                      },
                      child: Container(
                        width: MediaQuery.of(context)
                            .size
                            .width, // Set the container width to the screen width
                        padding: const EdgeInsets.fromLTRB(0, 20, 25, 0),
                        color: const Color.fromRGBO(255, 174, 0, 1),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 1), // Move the text upward
                            child: TextButton(
                              onPressed: () {
                                print("Tap Here to Order clicked!");
                                Navigator.pushNamed(context, '/dinepage');
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: const Text(
                                  "   Tap Here to Order",
                                  style: TextStyle(
                                    fontFamily: 'DMSans',
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
