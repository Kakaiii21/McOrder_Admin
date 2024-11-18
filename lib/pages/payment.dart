import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/pages/end.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic font size scaling
    double fontSize(double size) {
      return size * screenWidth / 390; // Base width set to 390px
    }

    List<String> paymentMethods = ["Cash", "Gcash", "Card"];

    // Retrieve the order data passed from the previous screen
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<Map<String, dynamic>> orders = arguments['orders'];
    final bool isTakeOutSelected =
        arguments['isTakeOutSelected']; // Retrieve isTakeOutSelected

    // Calculate the total price
    double calculateTotal() {
      return orders.fold(
          0, (total, order) => total + (order['totalPrice'] as double));
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(192, 1, 0, 1),
      body: SingleChildScrollView(
        // Allow scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display isTakeOutSelected at the top of the list
              Container(
                margin: EdgeInsets.fromLTRB(
                    screenWidth * 0.00,
                    screenHeight * 0.05,
                    screenWidth * 0.00,
                    screenHeight * 0.00),
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.00,
                    screenHeight * 0.00,
                    screenWidth * 0.00,
                    screenHeight * 0.02),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(
                      235, 235, 235, 1), // Optional background color
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          screenWidth * 0.03,
                          screenHeight * 0.02,
                          screenWidth * 0.03,
                          screenHeight * 0.00),
                      height: screenHeight * 0.08,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 174, 0, 1), // Orange
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          'PAYMENT',
                          style: TextStyle(
                            fontSize: fontSize(screenHeight * 0.0350),
                            fontFamily: "DM Sans",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Add isTakeOutSelected display

                    // List of orders
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.02,
                      ),
                      height: screenHeight * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            isTakeOutSelected
                                ? "Take Out"
                                : "Dine In", // Display based on selection
                            style: TextStyle(
                              fontSize: fontSize(screenHeight * 0.025),
                              fontFamily: "DM Sans",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                final order = orders[index];
                                return ListTile(
                                  leading: Image.asset(order['imagePath'],
                                      width: 50, height: 50),
                                  title: Text(order['itemName']),
                                  subtitle: Text(
                                    'Qty: ${order['quantity']} | \$${order['totalPrice'].toStringAsFixed(2)}',
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Total: \$${calculateTotal().toStringAsFixed(2)}", // Ensure `orders` is passed
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Payment Method Row
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                            ),
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Payment",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "DM Sans",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(1, 0, 20, 0),
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 174, 0, 1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              hint: Text(
                                "Payment Method",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.009,
                                  fontFamily: "DM Sans",
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: paymentMethods.map((name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Center(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.018,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                // Handle payment method change
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Voucher Code Row
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                            ),
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Voucher Code",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "DM Sans",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                              screenWidth * 0.02,
                              0,
                              screenWidth * 0.05,
                              0,
                            ),
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 174, 0, 1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03,
                                vertical: screenHeight * 0.015,
                              ),
                              child: TextField(
                                maxLength: 6,
                                decoration: InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintText: "Enter Code",
                                  hintStyle: TextStyle(
                                    fontSize: screenHeight * 0.013,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Confirm and Cancel Buttons
                    // Confirm and Cancel Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Calculate total amount
                            double totalAmount = calculateTotal();

                            // Send order to Firebase and get the generated order number
                            String orderNumber = await sendOrderToFirebase(
                                orders, totalAmount, isTakeOutSelected);

                            // Navigate to the end page with the order number
                            if (orderNumber.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EndPage(orderNumber: orderNumber),
                                ),
                              );
                            } else {
                              // Handle the error case where orderNumber is empty
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Failed to place order. Please try again.")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(255, 174, 0, 1),
                            shadowColor: Colors.black,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Confirm Payment",
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5), // Add space between buttons
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // Go back to the previous screen on cancel
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.white, // Red color for cancel button
                            shadowColor: Colors.black,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10), // Add space between buttons
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Refactored method to generate the order number inside `sendOrderToFirebase`:
Future<String> sendOrderToFirebase(List<Map<String, dynamic>> orders,
    double totalAmount, bool isTakeOutSelected) async {
  CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');

  String generateOrderNumber() {
    final random = Random();
    return (random.nextInt(500) + 1).toString();
  }

  Future<String> getUniqueOrderNumber() async {
    String orderNumber = generateOrderNumber();
    bool exists = true;

    while (exists) {
      final querySnapshot = await ordersCollection
          .where('orderNumber', isEqualTo: orderNumber)
          .get();
      exists = querySnapshot.docs.isNotEmpty;

      if (exists) {
        orderNumber = generateOrderNumber();
      }
    }
    return orderNumber;
  }

  try {
    String orderNumber = await getUniqueOrderNumber();
    String orderType = isTakeOutSelected ? "Take Out" : "Dine In";

    await ordersCollection.add({
      'orderNumber': orderNumber,
      'orders': orders,
      'totalAmount': totalAmount,
      'orderDate': Timestamp.now(),
      'orderType': orderType,
      'isTakeOutSelected': isTakeOutSelected,
    });

    print("Order placed successfully with Order Number: $orderNumber");

    // Return the order number
    return orderNumber;
  } catch (e) {
    print("Error sending order to Firebase: $e");
    return ''; // Return an empty string in case of error
  }
}
