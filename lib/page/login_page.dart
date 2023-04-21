import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            email(),
            SizedBox(
              height: 20,
            ),
            password(),
            SizedBox(
              height: 10,
            ),
            loginButton(),
            SizedBox(
              height: 10,
            ),
            guestButton(),
            SizedBox(
              height: 10,
            ),
            Text(
              "Non ricordi la tua password",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Non hai un account",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() => AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "SELLY",
          style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.w900,
              color: Colors.black),
        ),
      );

  Widget email() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextFormField(
              controller: emailController,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Inserisci la tua e-mail';
                }
                return null;
              },
            ),
          ),
        ),
      );

  Widget password() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Inserisci la password';
                }
                return null;
              },
            ),
          ),
        ),
      );

  Widget loginButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: MaterialButton(
          onPressed: () {
            //Navigator.pushNamed(context, "/home");
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<LoginBloc>(context).add(LoginSubmitEvent(
                  emailController.value.text, passwordController.value.text));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Controlla i campi')),
              );
            }
          },
          height: 50,
          elevation: 0,
          minWidth: double.infinity,
          color: Colors.yellow.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "Login",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );

  Widget guestButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: MaterialButton(
          onPressed: () {
            //Navigator.pushNamed(context, "/home");
          },
          height: 50,
          elevation: 0,
          minWidth: double.infinity,
          color: Colors.orange.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "Entra come ospite",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}
