import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // To validate the form

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Keeps the button at the bottom
      backgroundColor: Color.fromRGBO(192, 1, 0, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(192, 1, 0, 1),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/mcOrder_logo.png',
                        height: screenHeight * 0.150,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Personal Details",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.075,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      "Please fill in your login details",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: screenWidth * 0.04,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    // Form for validation
                    Form(
                      key: _formKey, // Attach form key
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'First Name',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth * 0.05,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.01),
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: _firstNameController.text.isEmpty
                                        ? Colors
                                            .red // Red color for empty input
                                        : Colors
                                            .blue, // Blue color for filled input
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: _firstNameController.text.isEmpty
                                        ? Colors
                                            .red // Red color for empty input
                                        : Colors
                                            .grey, // Default color when not focused
                                    width: 2.0,
                                  ),
                                ),
                                errorStyle: TextStyle(
                                  color: Colors
                                      .white, // White color for error text
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Last Name',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth * 0.05,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.01),
                            child: TextFormField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: _lastNameController.text.isEmpty
                                        ? Colors
                                            .red // Red color for empty input
                                        : Colors
                                            .blue, // Blue color for filled input
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: _lastNameController.text.isEmpty
                                        ? Colors
                                            .red // Red color for empty input
                                        : Colors
                                            .grey, // Default color when not focused
                                    width: 2.0,
                                  ),
                                ),
                                errorStyle: TextStyle(
                                  color: Colors
                                      .white, // White color for error text
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Already Have an Account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/loginpage');
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontFamily: 'Poppins',
                              fontSize: screenWidth * 0.043,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ), // Space for the button at the bottom
                  ],
                ),
              ),
            ),
            // Button fixed at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate the form
                    if (_formKey.currentState?.validate() ?? false) {
                      // If form is valid, navigate to the next page
                      Navigator.pushNamed(context, '/signup2');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                    backgroundColor: Color.fromRGBO(239, 146, 0, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
