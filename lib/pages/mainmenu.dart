import 'package:flutter/material.dart';

import 'menu.dart';

class Mainmenu extends StatefulWidget {
  final bool isTakeOutSelected;
  const Mainmenu({super.key, required this.isTakeOutSelected});

  @override
  State<Mainmenu> createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> {
  int cartItemCount = 0;
  bool isTakeOutSelected = false;

  @override
  void initState() {
    super.initState();
    isTakeOutSelected = widget.isTakeOutSelected;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(192, 1, 0, 1),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  Image.asset(
                    "assets/images/mcOrder_logo.png",
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.13,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Main Menu",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "DM Sans",
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildMenuButton(
                              screenWidth,
                              screenHeight,
                              'assets/images/newprobtn.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                      isTakeOutSelected: isTakeOutSelected,
                                      showNewProductsMenu:
                                          true, // Enable Fries Menu
                                    ),
                                  ),
                                );
                              },
                            ),
                            buildMenuButton(
                              screenWidth,
                              screenHeight,
                              'assets/images/dndbtn.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                      isTakeOutSelected: isTakeOutSelected,

                                      showDrinksDessertMenu:
                                          true, // Enable Fries Menu
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildMenuButton(
                              screenWidth,
                              screenHeight,
                              'assets/images/mealsbtn.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                      isTakeOutSelected: isTakeOutSelected,

                                      showMealMenu: true, // Enable Fries Menu
                                    ),
                                  ),
                                );
                              },
                            ),
                            buildMenuButton(
                              screenWidth,
                              screenHeight,
                              'assets/images/burgesbtn.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                      isTakeOutSelected: isTakeOutSelected,

                                      showBurgerMenu: true, // Enable Fries Menu
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildMenuButton(
                              screenWidth,
                              screenHeight,
                              'assets/images/happymeal.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                      isTakeOutSelected: isTakeOutSelected,

                                      showHappyMMenu: true, // Enable Fries Menu
                                    ),
                                  ),
                                );
                              },
                            ),
                            buildMenuButton(
                              screenWidth,
                              screenHeight,
                              'assets/images/mnmbtn.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                      isTakeOutSelected: isTakeOutSelected,

                                      showMnMMenu: true, // Enable Fries Menu
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildMenuButton(
                              screenWidth,
                              screenHeight,
                              'assets/images/friesnAbtn.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                      isTakeOutSelected: isTakeOutSelected,

                                      showFriesMenu: true, // Enable Fries Menu
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 25,
                      offset: const Offset(2, 9),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/images/cart.png",
                          height: 38,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 25,
                          minHeight: 25,
                        ),
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.red,
                            fontFamily: "Poppins",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              right: 16,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTakeOutSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isTakeOutSelected
                          ? Colors.white
                          : const Color.fromRGBO(255, 174, 0, 1),
                      foregroundColor:
                          isTakeOutSelected ? Colors.black : Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(20)),
                      ),
                    ),
                    child: const Text("DINE IN"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTakeOutSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isTakeOutSelected
                          ? const Color.fromRGBO(255, 174, 0, 1)
                          : Colors.white,
                      foregroundColor:
                          isTakeOutSelected ? Colors.white : Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.horizontal(right: Radius.circular(20)),
                      ),
                    ),
                    child: const Text("TAKE OUT"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(
    double screenWidth,
    double screenHeight,
    String imagePath, {
    VoidCallback? onTap, // Optional callback
  }) {
    return InkWell(
      splashColor: const Color.fromRGBO(192, 1, 0, 0.50),
      onTap: onTap, // Trigger the callback when tapped
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Container(
          width: screenWidth * 0.4,
          height: screenHeight * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Ink.image(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
