import 'package:flutter/material.dart';
import 'package:todo_app/data/auth_data.dart';

class LogIN_Screen extends StatefulWidget {
  final VoidCallback show;
  const LogIN_Screen(this.show, {super.key});

  @override
  State<LogIN_Screen> createState() => _LogIN_ScreenState();
}

class _LogIN_ScreenState extends State<LogIN_Screen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  bool _showPassword = false;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null && args['successMessage'] != null) {
      setState(() {
        _successMessage = args['successMessage'];
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
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
              Login(context),
              const SizedBox(height: 20),
              if (_successMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    _successMessage!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 50),
              textfield(email, _focusNode1, 'Email', Icons.email),
              const SizedBox(height: 20),
              textfield(password, _focusNode2, 'Password', Icons.key,
                  isPassword: true,
                  showPassword: _showPassword,
                  togglePasswordVisibility: _togglePasswordVisibility),
              const SizedBox(height: 10),
              account(),
              const SizedBox(height: 40),
              login_button(),
            ],
          ),
        ),
      ),
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
            "Don't have an account?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show,
            child: const Text(
              "Sign UP",
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

  Widget login_button() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: GestureDetector(
        onTap: () async {
          final errorMessage = await AuthenticationRemote().login(email.text, password.text);
          if (errorMessage == null) {
            Navigator.pushNamed(context, '/todo_list');
          } else {
            showFailureMessage(context, errorMessage);
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
            'Login',
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

  Widget Login(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Center(
          child: SizedBox(
            child: Text(
              'To-Do App',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
      ),
    );
  }

  void showFailureMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        'Wrong Email or Password',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
