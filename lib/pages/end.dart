import 'package:flutter/material.dart';

class EndPage extends StatelessWidget {
  final String orderNumber; // Accept order number as a parameter

  const EndPage({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(192, 1, 0, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4, // Adjust height
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                border: Border.all(
                  color: const Color.fromRGBO(255, 174, 0, 1),
                  width: 10.0,
                ),
              ),
              child: Center(
                child: Text(
                  orderNumber, // Display the passed order number
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: "DM Sans",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: Text(
                'Thank you! Please Proceed to the Counter to Pay for your order.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/mainmenu'); // Navigate to main menu
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 174, 0, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
