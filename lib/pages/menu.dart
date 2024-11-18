import 'package:flutter/material.dart';
import 'package:mobile_application/pages/mainmenu.dart';
import 'package:mobile_application/pages/order.dart';

class MenuPage extends StatefulWidget {
  final bool isTakeOutSelected;
  final bool showFriesMenu;
  final bool showNewProductsMenu;
  final bool showDrinksDessertMenu;
  final bool showMealMenu;
  final bool showBurgerMenu;
  final bool showHappyMMenu;
  final bool showMnMMenu;

  const MenuPage({
    super.key,
    this.isTakeOutSelected = false,
    this.showFriesMenu = false,
    this.showNewProductsMenu = false,
    this.showDrinksDessertMenu = false,
    this.showMealMenu = false,
    this.showBurgerMenu = false,
    this.showHappyMMenu = false,
    this.showMnMMenu = false,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool isTakeOutSelected = false;
  late bool showFriesMenu;
  late bool showNewProductsMenu;
  late bool showDrinksDessertMenu;
  late bool showMealMenu;
  late bool showBurgerMenu;
  late bool showHappyMMenu;
  late bool showMnMMenu;
  List<Map<String, dynamic>> orders = []; // To store the orders globally

  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    isTakeOutSelected = widget.isTakeOutSelected;
    showFriesMenu = widget.showFriesMenu;
    showNewProductsMenu = widget.showNewProductsMenu;
    showDrinksDessertMenu = widget.showDrinksDessertMenu;
    showMealMenu = widget.showMealMenu;
    showBurgerMenu = widget.showBurgerMenu;
    showHappyMMenu = widget.showHappyMMenu;
    showMnMMenu = widget.showMnMMenu;
  }

  // Show Order Dialog
  void _showOrderDialog(
      BuildContext context, String itemName, String imagePath, double price) {
    int quantity = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    imagePath,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      itemName,
                      style: TextStyle(fontSize: 23, fontFamily: "DM Sans"),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Price: \$${price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 15, fontFamily: "DM Sans"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity:",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "DM Sans",
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 0) quantity--;
                              });
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text(
                            "$quantity",
                            style:
                                TextStyle(fontSize: 15, fontFamily: "DM Sans"),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (quantity > 0) {
                        setState(() {
                          // Add the order to the list
                          orders.add({
                            'itemName': itemName,
                            'imagePath': imagePath,
                            'quantity': quantity,
                            'totalPrice': price * quantity,
                          });

                          // Update the cart item count
                          cartItemCount += quantity;
                        });

                        // Close the dialog
                        Navigator.pop(context);

                        // Navigate to OrderDetails page
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 174, 0, 1),
                    ),
                    child: Text(
                      'Add Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "DM Sans",
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(192, 1, 0, 1),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: const Color.fromRGBO(192, 1, 0, 0.50),
                  height: screenHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        buildMenuButtonmain(screenWidth, screenHeight,
                            'assets/images/menus/mainmenubtn.png',
                            withBorder: true, onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Mainmenu(
                                isTakeOutSelected:
                                    isTakeOutSelected, // Pass for Dine In
                              ),
                            ),
                          );
                        }),
                        buildMenuButtonmain(screenWidth, screenHeight,
                            'assets/images/menus/newprod.png', withBorder: true,
                            onTap: () {
                          setState(() {
                            isTakeOutSelected =
                                isTakeOutSelected; // Can be toggled as per your logic
                            showNewProductsMenu = true;
                            showDrinksDessertMenu = false;
                            showBurgerMenu = false;
                          });
                        }),
                        buildMenuButtonmain(screenWidth, screenHeight,
                            'assets/images/menus/dnd.png', withBorder: true,
                            onTap: () {
                          setState(() {
                            isTakeOutSelected =
                                isTakeOutSelected; // Can be toggled as per your logic
                            showDrinksDessertMenu =
                                true; // New flag to show new products menu
                            showNewProductsMenu = false;
                            showMealMenu = false;
                            showBurgerMenu = false;
                          });
                        }),
                        buildMenuButtonmain(screenWidth, screenHeight,
                            'assets/images/menus/meal.png', withBorder: true,
                            onTap: () {
                          setState(() {
                            isTakeOutSelected =
                                isTakeOutSelected; // Can be toggled as per your logic
                            showMealMenu =
                                true; // New flag to show new products menu
                            showNewProductsMenu = false;
                            showDrinksDessertMenu = false;
                            showBurgerMenu = false;
                          });
                        }),
                        buildMenuButtonmain(screenWidth, screenHeight,
                            'assets/images/menus/burger.png', withBorder: true,
                            onTap: () {
                          setState(() {
                            isTakeOutSelected =
                                isTakeOutSelected; // Can be toggled as per your logic
                            showBurgerMenu =
                                true; // New flag to show new products menu
                            showNewProductsMenu = false;
                            showDrinksDessertMenu = false;
                            showMealMenu = false;
                          });
                        }),
                        buildMenuButtonmain(screenWidth, screenHeight,
                            'assets/images/menus/happymeal.png', onTap: () {
                          setState(() {
                            isTakeOutSelected =
                                isTakeOutSelected; // Can be toggled as per your logic
                            showHappyMMenu =
                                true; // New flag to show new products menu
                            showNewProductsMenu = false;
                            showDrinksDessertMenu = false;
                            showMealMenu = false;
                            showBurgerMenu = false;
                          });
                        }),
                        buildMenuButtonmain(screenWidth, screenHeight,
                            'assets/images/menus/mnm.png', withBorder: true,
                            onTap: () {
                          setState(() {
                            isTakeOutSelected =
                                isTakeOutSelected; // Can be toggled as per your logic
                            showMnMMenu =
                                true; // New flag to show new products menu
                            showNewProductsMenu = false;
                            showDrinksDessertMenu = false;
                            showMealMenu = false;
                            showBurgerMenu = false;
                            showHappyMMenu = false;
                          });
                        }),
                        buildMenuButtonmain(screenWidth, screenHeight,
                            'assets/images/menus/fries&add.png',
                            withBorder: true, onTap: () {
                          setState(() {
                            isTakeOutSelected =
                                isTakeOutSelected; // Can be toggled as per your logic
                            showFriesMenu =
                                true; // New flag to show new products menu
                            showNewProductsMenu = false;
                            showDrinksDessertMenu = false;
                            showMealMenu = false;
                            showBurgerMenu = false;
                            showHappyMMenu = false;
                            showMnMMenu = false;
                          });
                        }),
                        SizedBox(height: 50),
                        SizedBox(height: 50),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  height: screenHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 70),
                        Image.asset("assets/images/logo.png"),
                        const SizedBox(height: 20),
                        Text(
                          showNewProductsMenu
                              ? "New Products"
                              : showDrinksDessertMenu
                                  ? "Drinks & Desserts"
                                  : showMealMenu
                                      ? "Meals"
                                      : showBurgerMenu
                                          ? "Burgers"
                                          : showHappyMMenu
                                              ? "Happy Meal"
                                              : showMnMMenu
                                                  ? "Mix & Match"
                                                  : showMnMMenu
                                                      ? "Fries And Add Ons"
                                                      : "Our Menu",
                          style: TextStyle(
                            fontSize: screenWidth * 0.073,
                            // Adjust the multiplier as needed for your design
                            fontFamily: "DM Sans",
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 50),
                        if (showNewProductsMenu)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildMenuButton(
                                      screenWidth,
                                      screenHeight,
                                      'assets/images/dndbtn.png',
                                      "prid",
                                      4,
                                      ""),
                                  buildMenuButton(
                                      screenWidth,
                                      screenHeight,
                                      'assets/images/mnmbtn.png',
                                      "dfsaf",
                                      564,
                                      ""),
                                ],
                              ),
                            ],
                          )
                        else if (showDrinksDessertMenu)
                          // Default or other menus
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D1.png',
                                    "Coke",
                                    79.00,
                                    'assets/images/addtoc/D1.png'),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D2.png',
                                    "Coke Zero",
                                    75.00,
                                    'assets/images/addtoc/D1.png'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D3.png',
                                    "Coke Mcfloat",
                                    75.00,
                                    'assets/images/addtoc/D3.png'),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D4.png',
                                    "McFlurry",
                                    66.00,
                                    "assets/images/addtoc/D4.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D5.png',
                                    "Hot Fudge",
                                    66.00,
                                    "assets/images/addtoc/D5.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D6.png',
                                    "Hot Caramel",
                                    55.00,
                                    "assets/images/addtoc/D6.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D7.png',
                                    "Vanilla Sundae",
                                    20.00,
                                    "assets/images/addtoc/D7.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D8.png',
                                    "Apple Pie",
                                    43.00,
                                    "assets/images/addtoc/D8.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D9.png',
                                    "McCafe",
                                    67,
                                    "assets/images/addtoc/D9.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/dndmenu/D10.png',
                                    "Orange Juice",
                                    82,
                                    "assets/images/addtoc/D10.png"),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ])
                        else if (showMealMenu)
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mealmenu/M1.png',
                                    "1-pc,Chicken McDo & Fries Meal",
                                    182,
                                    "assets/images/addtoc/M1.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mealmenu/M3.png',
                                    "1-pc. Chicken McDo with Rice",
                                    99,
                                    "assets/images/addtoc/M3.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mealmenu/M4.png',
                                    "McCrispy Chicken Fillet w/ Fries Meal",
                                    156,
                                    "assets/images/addtoc/M4.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mealmenu/M5.png',
                                    "6-pc. Chicken McNuggets w/ Fries Meal",
                                    182,
                                    "assets/images/addtoc/M5.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mealmenu/M6.png',
                                    "McCrispy Chicken Fillet Ala King w/ Fries Meal",
                                    163,
                                    "assets/images/addtoc/M6.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mealmenu/M7.png',
                                    "6-pc. Chicken McNuggets w/ Fries Meal",
                                    203,
                                    "assets/images/addtoc/M7.png"),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ])
                        else if (showBurgerMenu)
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/burgermenu/B1.png',
                                    "Big Mac",
                                    182,
                                    "assets/images/addtoc/B1.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/burgermenu/B2.png',
                                    "Burger McDo",
                                    44,
                                    "assets/images/addtoc/B2.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/burgermenu/B3.png',
                                    "Quarter Pounder",
                                    179,
                                    "assets/images/addtoc/B3.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/burgermenu/B4.png',
                                    "Double",
                                    142,
                                    "assets/images/addtoc/B4.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/burgermenu/B5.png',
                                    "CheeseBurger",
                                    95,
                                    "assets/images/addtoc/B5.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/burgermenu/B6.png',
                                    "McCrispy",
                                    70,
                                    "assets/images/addtoc/B6.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/burgermenu/B7.png',
                                    "McChicken",
                                    70,
                                    "assets/images/addtoc/B7.png"),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ])
                        else if (showHappyMMenu)
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/happymenu/H1.png',
                                    "McSpaghetti with McFries and Juice + the latest Toy",
                                    83,
                                    "assets/images/addtoc/H1.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/happymenu/H2.png',
                                    "Burger McDo with McFries and Juice + the latest Toy",
                                    83,
                                    "assets/images/addtoc/H2.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/happymenu/H3.png',
                                    "Chicken McDo (1 Piece Meal) + the latest Toy",
                                    83,
                                    "assets/images/addtoc/H3.png"),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ])
                        else if (showMnMMenu)
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mnmmenu/MIX1.png',
                                    "McSpaghetti",
                                    0,
                                    "assets/images/addtoc/MIX1.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mnmmenu/MIX2.png',
                                    "Burger McDo",
                                    0,
                                    "assets/images/addtoc/MIX2.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mnmmenu/MIX3.png',
                                    "McCrispy",
                                    0,
                                    "assets/images/addtoc/MIX3.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/mnmmenu/MIX4.png',
                                    "1pc Mushroom Pepper Steak",
                                    0,
                                    "assets/images/addtoc/MIX4.png"),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ])
                        else if (showFriesMenu)
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/famenus/F1.png',
                                    "Medium Fries",
                                    83,
                                    "assets/images/addtoc/F1.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/famenus/F2.png',
                                    "Regular Fries",
                                    45,
                                    "assets/images/addtoc/F2.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/famenus/F3.png',
                                    "BFF Fries",
                                    169,
                                    ""),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/famenus/F4.png',
                                    "Shake Shake Fries",
                                    142,
                                    "assets/images/addtoc/F4.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/famenus/F5.png',
                                    "Spicy Buffallo Sauce",
                                    17,
                                    "assets/images/addtoc/F5.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/famenus/F6.png',
                                    "Ranch Sauce",
                                    17,
                                    "assets/images/addtoc/F6.png"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/famenus/F7.png',
                                    "Sweet N’ Sour Sauce",
                                    17,
                                    "assets/images/addtoc/F7.png"),
                                buildMenuButton(
                                    screenWidth,
                                    screenHeight,
                                    'assets/images/famenus/F8.png',
                                    "Ketchup Paket Sauce",
                                    17,
                                    "assets/images/addtoc/F8.png"),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ])
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height *
                0.05, // Adjust the bottom position dynamically
            left: MediaQuery.of(context).size.width *
                0.04, // Adjust the left position dynamically
            child: GestureDetector(
              onTap: () {
                // Add your button action here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetails(
                      orders: orders, // Pass the orders list
                      isTakeOutSelected:
                          isTakeOutSelected, // Pass the isTakeOutSelected value here
                    ),
                  ),
                );
              },
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
                      width: MediaQuery.of(context).size.width *
                          0.15, // Set width as a percentage of screen width
                      height: MediaQuery.of(context).size.height *
                          0.1, // Set height as a percentage of screen height
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/images/cart.png",
                          height: MediaQuery.of(context).size.height *
                              0.0480, // Scale image height
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
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Poppins",
                            fontSize: MediaQuery.of(context).size.width *
                                0.05, // Scale font size based on screen width
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
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height *
                0.07, // Adjust bottom position dynamically
            right: MediaQuery.of(context).size.width *
                0.04, // Adjust right position dynamically
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
                  child: Text(
                    "DINE IN",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width *
                          0.04, // Scale text size
                    ),
                  ),
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
                  child: Text(
                    "TAKE OUT",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width *
                          0.04, // Scale text size
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildMenuButtonmain(
      double screenWidth, double screenHeight, String imagePath,
      {bool withBorder = false, void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: InkWell(
        splashColor: const Color.fromRGBO(192, 1, 0, 0.5),
        onTap: onTap,
        child: Container(
          width: screenWidth * 0.38,
          height: screenHeight * 0.12,
          decoration: BoxDecoration(
            border: withBorder ? Border.all(color: Colors.red) : null,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.contain,
              onError: (error, stackTrace) {
                debugPrint('Failed to load image: $error');
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuButton(double screenWidth, double screenHeight,
      String imagePath, String itemName, double price, String dialogImagePath) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        splashColor: const Color.fromRGBO(192, 1, 0, 0.5),
        onTap: () {
          // Show the order dialog with the item-specific info (image, name, price, and dialog image)
          _showOrderDialog(context, itemName, dialogImagePath, price);
        },
        child: Container(
          width: screenWidth * 0.38,
          height: screenHeight * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.contain,
              onError: (error, stackTrace) {
                debugPrint('Failed to load image: $error');
              },
            ),
          ),
        ),
      ),
    );
  }
}
