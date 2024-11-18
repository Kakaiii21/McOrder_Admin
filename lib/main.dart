import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const McOrderApp());
}

class McOrderApp extends StatelessWidget {
  const McOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Fetch orders from Firestore as a stream and sort them by order date
  Stream<List<Map<String, dynamic>>> fetchOrders() {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('orderDate',
            descending: true) // Sort by orderDate in descending order
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  // Widget to display order item details
  Widget buildOrderItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            item['imagePath'] ?? '',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['itemName'] ?? 'N/A',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Quantity: ${item['quantity'] ?? 0}"),
                Text("Price: \$${item['totalPrice'] ?? 0}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to display the order card
  Widget buildOrderCard(Map<String, dynamic> order) {
    final items = order['orders'] as List<dynamic>? ?? [];
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Number: ${order['orderNumber'] ?? 'N/A'}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text("Order Type: ${order['orderType'] ?? 'N/A'}"),
            Text(
                "Take Out: ${order['isTakeOutSelected'] ?? false ? 'Yes' : 'No'}"),
            Text("Order Date: ${order['orderDate'] ?? 'N/A'}"),
            const SizedBox(height: 10),
            const Text("Items:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ...items.map((item) => buildOrderItem(item)).toList(),
            const Divider(),
            Text(
              "Total Amount: \$${order['totalAmount'] ?? 0}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(192, 1, 0, 1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.05,
              ),
              child: Image.asset(
                'assets/images/mcOrder_logo.png',
                width: screenWidth * 0.6,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: fetchOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "No orders found.",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  final orders = snapshot.data!;

                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return buildOrderCard(order);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
