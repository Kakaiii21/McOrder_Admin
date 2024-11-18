import 'package:flutter/material.dart';
import 'package:mobile_application/services/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final _auth = AuthService();
  bool _isPasswordError = false; // Track if there is a password error

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(192, 1, 0, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(192, 1, 0, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.03,
                  right: screenWidth * 0.02,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Log in to the good stuff",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.055,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/mcOrder_logo.png",
                      height: screenHeight * 0.15,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  left: screenWidth * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.02,
                        0,
                        screenWidth * 0.04,
                        0,
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.02,
                        0,
                        screenWidth * 0.04,
                        0,
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    // Show error message if password is incorrect
                    // Show error message if password is incorrect
                    if (_isPasswordError)
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: Text(
                          "Incorrect password. Please try again.",
                          style: TextStyle(
                            color: Colors
                                .white, // Change error text color to white
                            fontFamily: 'Poppins',
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.033,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Not a member yet?",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontFamily: 'Poppins',
                              fontSize: screenWidth * 0.043,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0),
        child: TextButton(
          onPressed: _login,
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromRGBO(239, 146, 0, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
            child: Text(
              "Log In",
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: Colors.white,
                fontSize: screenWidth * 0.05,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return; // Stop further execution if fields are empty
    }

    try {
      final user = await _auth.loginUserWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      if (user != null) {
        print("User Logged In");
        Navigator.pushNamed(context, '/startup');
      }
    } catch (e) {
      _showErrorDialog(e.toString());
      // Highlight the password field if error occurs
      setState(() {
        _isPasswordError = true;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
