import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/login_bloc.dart';
import 'package:selly/page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/api_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                /*guestButton(),
                SizedBox(
                  height: 10,
                ),*/
                /*TextButton(
                  onPressed: (){},
                  child: Text("Non ricordi la tua password",style: TextStyle(fontSize: 16),),
                ),*/
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    print('Status da login_page: ');
                    print(prefs.getString('status'));
                    Navigator.pushNamed(context, '/registration');
                  },
                  child: Text("Non hai un account",style: TextStyle(fontSize: 16),),
                ),
                SizedBox(height: 50,),
                Text('powered by', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                Container(
                width: MediaQuery.of(context).size.width *0.4,
                    child: Image.network('https://www.mondovision.it/wp-content/uploads/2018/12/logo_DEF_da_oltre_30_anni.png'),
                )
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

  Widget loginButton() =>
      BlocBuilder<LoginBloc, LoginBlocState>(builder: (context, state) {
        var status = (state as LoginBlocStateToken).status;
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
                  BlocProvider.of<LoginBloc>(context).add(LoginSubmitEvent(
                      emailController.value.text,
                      passwordController.value.text));
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
