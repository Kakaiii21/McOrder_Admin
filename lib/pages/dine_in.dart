import 'package:flutter/material.dart';
import 'package:mobile_application/pages/mainmenu.dart';

class DineInOut extends StatelessWidget {
  const DineInOut({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(192, 1, 0, 1),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.01),
            child: Image.asset(
              "assets/images/mcOrder_logo.png",
              width: screenWidth * 0.6,
              height: screenHeight * 0.3,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            "CHOOSE WHERE TO EAT",
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: screenWidth * 0.06,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dine In Button
                Column(
                  children: [
                    InkWell(
                      splashColor: const Color.fromRGBO(192, 1, 0, 0.50),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mainmenu(
                              isTakeOutSelected: false, // Pass for Dine In
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Ink.image(
                          image: const AssetImage('assets/images/dinebtn.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Dine In",
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: screenWidth * 0.055,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // Take Out Button
                Column(
                  children: [
                    InkWell(
                      splashColor: const Color.fromRGBO(192, 1, 0, 0.50),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mainmenu(
                              isTakeOutSelected: true, // Pass for Take Out
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Ink.image(
                          image:
                              const AssetImage('assets/images/takeoutbtn.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Take Out",
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: screenWidth * 0.055,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.05),
            child: Text(
              "@McDo Inc.",
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: screenWidth * 0.04,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
