import 'package:afalagi/core/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:afalagi/core/widgets/button.dart';
import 'package:afalagi/core/theme/theme.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              
              CustomImages.appLogo(height: 55),

              const SizedBox(height: 20),

              const Text(
                "Create Account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "Enter your details to begin your journey.",
              ),

              const SizedBox(height: 20),

        Text(
                  "FULL NAME",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),      
                SizedBox(height: 10),
              TextField(
        
                decoration: InputDecoration(
                  hintText: "Kaleab Mulugeta",
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                  "EMAIL ADDRESS",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),      
                SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "kalili@gmail.com",
                  prefixIcon: const Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                  "PASSWORD",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),      
                SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "********",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children:  [
                  Checkbox(value: false, onChanged: null),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "I agree to the ",
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          TextSpan(text: "."),
                        ],
                      ),
                    ),
                    ),
                ],
              ),

              const SizedBox(height: 10),

              
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Sign Up",
                  onPressed: () {
                    
                  },
                ),
              ),

              const SizedBox(height: 15),

              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}