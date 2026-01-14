import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loan_management/admin/main_admin/main_admin_screen.dart';
import 'package:flutter_loan_management/signin-signup/signin.dart';
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

class SignUpAppFul extends StatefulWidget {
  const SignUpAppFul({super.key});

  @override
  State<SignUpAppFul> createState() => _SignUpAppFulState();
}

class _SignUpAppFulState extends State<SignUpAppFul> {
  String selectedRole = "Customer";

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
              "Create Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text("Join Loanify and manage your loans easily."),

            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Full Name"),
            ),
            const SizedBox(height: 4),
            TextField(
              keyboardType: TextInputType.text,

              inputFormatters: [
                LengthLimitingTextInputFormatter(25),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 14, right: 8),
                  child: Icon(Icons.person, color: Colors.grey),
                ),
                hintText: "Enter your full name",
                enabledBorder: normalBorder,
                focusedBorder: focusedBorder,
                errorBorder: errorBorder,
              ),
            ),

            const SizedBox(height: 20),
            const Align(alignment: Alignment.centerLeft, child: Text("Email")),
            const SizedBox(height: 4),
            TextField(
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
            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Phone Number"),
            ),
            const SizedBox(height: 4),
            TextField(
              keyboardType: TextInputType.text,

              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 14, right: 8),
                  child: Icon(Icons.phone, color: Colors.grey),
                ),
                hintText: "Enter your phone number",
                enabledBorder: normalBorder,
                focusedBorder: focusedBorder,
                errorBorder: errorBorder,
              ),
            ),

            /* 
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Register as"),
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
            const SizedBox(height: 50),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainAdminScreen(),
                    ),
                  );
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
                  "Create Account",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInAppFul()),
                    );
                  },
                  child: const Text(
                    "Sign In",
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
