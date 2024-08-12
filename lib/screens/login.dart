import 'package:flutter/material.dart';

class LogIN_Screen extends StatefulWidget {
  final VoidCallback show;
  const LogIN_Screen(this.show,{super.key});

  @override
  State<LogIN_Screen> createState() => _LogIN_ScreenState();
}

class _LogIN_ScreenState extends State<LogIN_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void initstate() {
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Login(context),
            SizedBox(height: 50),
            textfield(email, _focusNode1, 'Email', Icons.email),
            SizedBox(height: 20),
            textfield(password, _focusNode2, 'Password', Icons.key),
            SizedBox(height: 10),
            account(),
            SizedBox(height: 40),
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
          Text(
            "Don't have an account?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show,
            child: Text(
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
        horizontal: 300,
      ),
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 89, 58, 113),
            borderRadius: BorderRadius.circular(120),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget textfield(TextEditingController _controller, FocusNode _focusNode,
      String typename, IconData iconss) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 43, 50, 71),
          borderRadius: BorderRadius.circular(120),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(iconss),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: typename,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
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
      child: Container(
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
}
