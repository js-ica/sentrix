import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;


  Future<void> registerUser() async {

    if (passwordController.text !=
        confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }


    setState(() {
      isLoading = true;
    });


    try {

      final response = await ApiService.register(
        fullNameController.text.trim(),
        emailController.text.trim(),
        passwordController.text,
      );


      if (response.containsKey("token")) {

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account created successfully"),
            backgroundColor: Colors.green,
          ),
        );


        Navigator.pushReplacementNamed(
          context,
          LoginScreen.routeName,
        );


      } else {

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response["message"] ?? "Registration failed",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }


    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );

    }


    setState(() {
      isLoading = false;
    });

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.white),
      ),


      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 30),

            child: Column(
              children: [

                const SizedBox(height: 20),


                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),

                  child: ClipOval(
                    child: Image.asset(
                      'asset/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                const SizedBox(height: 30),


                const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                const SizedBox(height: 10),


                const Text(
                  "Create your Sentrix account",
                  style: TextStyle(
                    color: Color(0xFFA1A1AA),
                  ),
                ),


                const SizedBox(height: 40),


                buildField(
                  fullNameController,
                  "Full Name",
                  Icons.person_outline,
                ),


                const SizedBox(height: 20),


                buildField(
                  emailController,
                  "Email",
                  Icons.email_outlined,
                ),


                const SizedBox(height: 20),


                buildField(
                  passwordController,
                  "Password",
                  Icons.lock_outline,
                  obscure: obscurePassword,
                  toggle: () {
                    setState(() {
                      obscurePassword =
                          !obscurePassword;
                    });
                  },
                ),


                const SizedBox(height: 20),


                buildField(
                  confirmPasswordController,
                  "Confirm Password",
                  Icons.lock_outline,
                  obscure: obscureConfirmPassword,
                  toggle: () {
                    setState(() {
                      obscureConfirmPassword =
                          !obscureConfirmPassword;
                    });
                  },
                ),


                const SizedBox(height: 30),


                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF7C3AED),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),


                    onPressed:
                        isLoading
                            ? null
                            : registerUser,


                    child:

                        isLoading

                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )

                            : const Text(
                                "CREATE ACCOUNT",
                                style:
                                    TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool obscure = false,
    VoidCallback? toggle,
  }) {

    return TextField(
      controller: controller,
      obscureText: obscure,

      style:
          const TextStyle(color: Colors.white),

      decoration:
          InputDecoration(

        hintText: hint,

        prefixIcon:
            Icon(
          icon,
          color:
              const Color(0xFF7C3AED),
        ),


        suffixIcon:
            toggle == null
                ? null
                : IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: toggle,
                  ),


        filled: true,

        fillColor:
            const Color(0xFF1A1A1A),

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15),

          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}