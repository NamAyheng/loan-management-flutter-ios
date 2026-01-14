import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(LoginApp());

// Define borders outside to reuse

final normalBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    color: Colors.white, // normal color
    width: 1,
  ),
);

final focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    color: Color.fromARGB(255, 100, 200, 100), // focus color
    width: 1, // SAME width
  ),
);

final errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    color: Colors.red, // error color
    width: 1, // SAME width
  ),
);

// Define borders outside to reuse

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginAppFul1111());
  }
}

class LoginAppFul1111 extends StatefulWidget {
  const LoginAppFul1111({super.key});

  @override
  State<LoginAppFul1111> createState() => _LoginAppFul1111();
}

class _LoginAppFul1111 extends State<LoginAppFul1111> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? selectedValue;

  Color bgColor = Color.fromARGB(255, 240, 240, 240);
  Color primaryColor = Color.fromARGB(255, 100, 200, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: bgColor,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Loanify",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Trusted by millions of users worldwide",
                  style: TextStyle(fontSize: 12, color: primaryColor),
                ),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 6),
                SizedBox(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.text,

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],

                    decoration: InputDecoration(
                      hint: Text(
                        "Enter your phone number",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),

                      enabledBorder: normalBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      focusedErrorBorder: focusedBorder,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 6),
                SizedBox(
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,

                    decoration: InputDecoration(
                      hint: Text(
                        "Enter your password",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),

                      enabledBorder: normalBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      focusedErrorBorder: focusedBorder,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),

                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      /* side: BorderSide(color: primaryColor), */
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 16,
                        /* fontWeight: FontWeight.bold, */
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: TextStyle(color: primaryColor, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterApp(),
                          ),
                        ); */
                      },

                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
