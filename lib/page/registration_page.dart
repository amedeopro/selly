import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/registration_bloc.dart';
import '../resources/api_provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<LoginBloc, LoginBlocState>(builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitWidth,
                ),
                name(),
                SizedBox(
                  height: 20,
                ),
                email(),
                SizedBox(
                  height: 20,
                ),
                password(),
                SizedBox(
                  height: 20,
                ),
                passwordConfirmation(),
                SizedBox(
                  height: 10,
                ),
                registrationButton(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        }),
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

  Widget name() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextFormField(
          controller: nameController,
          decoration:
          InputDecoration(border: InputBorder.none, hintText: 'Il tuo nome / Ragione Sociale'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Inserisci Il tuo nome o la tua Ragione Sociale';
            }
            return null;
          },
        ),
      ),
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
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
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

  Widget passwordConfirmation() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextFormField(
          controller: passwordConfirmationController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Conferma Password',
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Inserisci la password';
            } else if(passwordController.value.text != value){
              return 'Le password devono essere uguali';
            }
            return null;
          },
        ),
      ),
    ),
  );

  Widget registrationButton() =>
      BlocBuilder<RegistrationBloc, RegistrationBlocState>(builder: (context, state) {
        var status = (state as RegistrationBlocStateToken).status;
        if (status == 'true') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          });

          return SizedBox(
            width: 10,
            height: 10,
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: MaterialButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                //Navigator.pushNamed(context, "/home");
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<RegistrationBloc>(context).add(RegistrationSubmitEvent(
                      nameController.value.text,
                      emailController.value.text,
                      passwordController.value.text,
                      passwordConfirmationController.value.text
                  ));
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
                "Registrati",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          );
        }
      });

  /*Widget guestButton() => Padding(
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
      );*/
}
