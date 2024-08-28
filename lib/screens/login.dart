import 'package:flutter/material.dart';
import 'package:todo_app/data/auth_data.dart';

class LogIN_Screen extends StatefulWidget {
  final VoidCallback show;
   LogIN_Screen(this.show, {super.key});

  @override
  State<LogIN_Screen> createState() => _LogIN_ScreenState();
}

class _LogIN_ScreenState extends State<LogIN_Screen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void initstate() {
    //  super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    //  super.initState();
    _focusNode2.addListener(() {
      setState(() {});
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
            const SizedBox(height: 50),
            textfield(email, _focusNode1, 'Email', Icons.email),
            const SizedBox(height: 20),
            textfield(password, _focusNode2, 'Password', Icons.key),
            const SizedBox(height: 10),
            account(),
            const SizedBox(height: 40),
            login_button()
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
            "Don't have an account?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show,
          //   onTap:() {
          //   Navigator.pushNamed(context, '/sign_up');
          // },
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
          bool isLoggedIn = await AuthenticationRemote()
              .login(email.text, password.text);
          if (isLoggedIn) {
            Navigator.pushNamed(context, '/todo_list');
          } else {
            // Show error message when login fails
            showFailureMessage(context, 'Invalid email or password');
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
            )),
      ),
    );
  }

  Widget textfield(TextEditingController controller, FocusNode focusNode,
      String typename, IconData iconss) {
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
              'Todo App',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),

        //  decoration: BoxDecoration(
        //  image: DecorationImage(
        //    image: AssetImage(''),
        //    ),
        //  ),
      ),
    );
  }
  void showFailureMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
