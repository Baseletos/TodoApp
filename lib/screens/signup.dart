import 'package:flutter/material.dart';
import 'package:todo_app/data/auth_data.dart';

class SignUP_Screen extends StatefulWidget {
  final VoidCallback show;
  const SignUP_Screen(this.show, {super.key});

  @override
  State<SignUP_Screen> createState() => _SignUP_ScreenState();
}

class _SignUP_ScreenState extends State<SignUP_Screen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  @override
  void initstate() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Register(context),
            const SizedBox(height: 50),
            textfield(email, _focusNode1, 'Email', Icons.email),
            const SizedBox(height: 20),
            textfield(password, _focusNode2, 'Password', Icons.key,
                isPassword: true,
                showPassword: _showPassword,
                togglePasswordVisibility: _togglePasswordVisibility),
            const SizedBox(height: 20),
            textfield(
                passwordConfirm, _focusNode3, 'Confirm Password', Icons.key,
                isPassword: true,
                showPassword: _showPassword,
                togglePasswordVisibility: _togglePasswordVisibility),
            const SizedBox(height: 10),
            account(),
            const SizedBox(height: 40),
            signup_button()
          ],
        ),
      )),
    );
  }

  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Do you have an account?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show,
            child: const Text(
              "Log In",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget signup_button() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 100),
    child: GestureDetector(
      onTap: () async {
        try {
          final errorMessage = await AuthenticationRemote().register(
            email.text,
            password.text,
            passwordConfirm.text,
          );

          if (errorMessage != null) {
            // Show an error message to the user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          Navigator.pushReplacementNamed(
            context,
            '/login',
            arguments: {'successMessage': 'Sign up successful! Please log in.'},
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An error occurred: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 89, 58, 113),
          borderRadius: BorderRadius.circular(120),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

  Widget textfield(TextEditingController controller, FocusNode focusNode,
      String typename, IconData iconss,
      {bool isPassword = false,
      bool showPassword = false,
      VoidCallback? togglePasswordVisibility}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 43, 50, 71),
          borderRadius: BorderRadius.circular(120),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          obscureText: isPassword && !showPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(iconss),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: typename,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: togglePasswordVisibility,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget Register(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Center(
          child: SizedBox(
            child: Text(
              'Create Account',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
      ),
    );
  }
}
