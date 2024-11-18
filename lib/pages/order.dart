import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final List<Map<String, dynamic>> orders;
  final bool isTakeOutSelected; // Add this line

  const OrderDetails(
      {Key? key, required this.orders, required this.isTakeOutSelected})
      : super(key: key); // Modify constructor

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  // Calculate the total price of all orders
  double calculateTotal() {
    return widget.orders.fold(
      0,
      (total, order) => total + (order['totalPrice'] as double),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic font size scaling
    double fontSize(double size) {
      return size * screenWidth / 390; // Base width set to 390px
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(192, 1, 0, 1), // Red background
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Order Details Container
            Container(
              margin: EdgeInsets.fromLTRB(
                screenWidth * 0.06,
                screenHeight * 0.1,
                screenWidth * 0.06,
                screenHeight * 0.05,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(235, 235, 235, 1), // Light gray
                borderRadius: BorderRadius.circular(50),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  // Title: Order Details
                  Container(
                    margin: EdgeInsets.all(screenWidth * 0.04),
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 174, 0, 1), // Orange
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        'ORDER DETAILS',
                        style: TextStyle(
                          fontSize: fontSize(30),
                          fontFamily: "DM Sans",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Order List
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      screenWidth * 0.04,
                      0,
                      screenWidth * 0.04,
                      screenHeight * 0.03,
                    ),
                    height: screenHeight * 0.4,
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
                        // Display Takeout or Dine-in based on the selection
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenWidth * .02,
                              screenHeight * 0.001,
                              screenWidth * .02,
                              screenHeight * 0.00),
                          child: Text(
                            widget.isTakeOutSelected ? 'Take-Out' : 'Dine-In',
                            style: TextStyle(
                              fontSize: fontSize(18),
                              fontFamily: "DM Sans",
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // Display the orders if available
                        Expanded(
                          child: widget.orders.isNotEmpty
                              ? ListView.builder(
                                  itemCount: widget.orders.length,
                                  itemBuilder: (context, index) {
                                    final order = widget.orders[index];
                                    return ListTile(
                                      leading: Image.asset(
                                        order['imagePath'],
                                        width: 50,
                                        height: 50,
                                      ),
                                      title: Text(
                                        order['itemName'],
                                        style: TextStyle(
                                          fontSize: fontSize(18),
                                          fontFamily: "DM Sans",
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Qty: ${order['quantity']} | \$${order['totalPrice'].toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: fontSize(14),
                                          fontFamily: "DM Sans",
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    'No orders available.',
                                    style: TextStyle(
                                      fontSize: fontSize(18),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),

                  // Total Price Display
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Total: \$${calculateTotal().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fontSize(25),
                          fontFamily: "DM Sans",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Confirm Button
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.2,
                      top: screenHeight * 0.02,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Assuming `widget.orders` contains the order details and `widget.isTakeOutSelected` holds the selected state
                        Navigator.pushNamed(
                          context,
                          '/payment',
                          arguments: {
                            'orders': widget.orders, // Pass the order details
                            'isTakeOutSelected': widget
                                .isTakeOutSelected, // Pass isTakeOutSelected
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(
                            255, 174, 0, 1), // Orange background
                        shadowColor: Colors.black,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.01,
                        ),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Cancel Button
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.2,
                      top: screenHeight * 0.02,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.01,
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 174, 0, 1),
                            fontSize: fontSize(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
