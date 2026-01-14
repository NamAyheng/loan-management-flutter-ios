import 'package:flutter/material.dart';

import 'package:flutter_loan_management/admin/main_admin/main_admin_screen.dart';
import 'package:flutter_loan_management/customer/main_customer/main_customer_screen.dart';
import 'package:flutter_loan_management/signin-signup/signup.dart';
import 'package:flutter_loan_management/theme/colors.dart';

final normalBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.grey, width: 1),
);

final focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: ThemeColors.primary1, width: 2),
);

final errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.red, width: 2),
);

// =====================================================

class SignInAppFul extends StatefulWidget {
  const SignInAppFul({super.key});

  @override
  State<SignInAppFul> createState() => _SignInAppFulState();
}

class _SignInAppFulState extends State<SignInAppFul> {
  String selectedRole = "Customer";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: ThemeColors.bgcolor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ), */
      body: Container(
        alignment: Alignment.center,
        color: ThemeColors.bgcolor,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Loanify.png", height: 70),
            const SizedBox(height: 30),
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text("Sign in to continue to Loanify"),

            const SizedBox(height: 40),

            const Align(alignment: Alignment.centerLeft, child: Text("Email")),
            const SizedBox(height: 4),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 14, right: 8),
                  child: Icon(Icons.email, color: Colors.grey),
                ),
                hintText: "Enter your email",
                enabledBorder: normalBorder,
                focusedBorder: focusedBorder,
                errorBorder: errorBorder,
              ),
            ),

            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Password"),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 14, right: 8),
                  child: Icon(Icons.lock, color: Colors.grey),
                ),
                hintText: "Enter your password",
                enabledBorder: normalBorder,
                focusedBorder: focusedBorder,
                errorBorder: errorBorder,
              ),
            ),

            /* 
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Sign in as"),
            ),
            const SizedBox(height: 4),

            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: normalBorder,
                focusedBorder: focusedBorder,
              ),
              items: const [
                DropdownMenuItem(
                  value: "Customer",
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey),
                      SizedBox(width: 10),
                      Text("Customer"),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: "Admin",
                  child: Row(
                    children: [
                      Icon(Icons.admin_panel_settings, color: Colors.grey),
                      SizedBox(width: 10),
                      Text("Admin"),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() => selectedRole = value!);
              },
            ), */
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(color: ThemeColors.primary1),
                ),
              ),
            ),

            const SizedBox(height: 50),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                /* onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainAdminScreen(),
                    ),
                  );
                }, */
                onPressed: () {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  const adminEmail = 'admin';
                  const adminPassword = '12345';

                  if (email == adminEmail && password == adminPassword) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainAdminScreen(),
                      ),
                      (route) => false,
                    );
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainCustomerScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.primary1,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpAppFul()),
                    );
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      color: ThemeColors.primary1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
