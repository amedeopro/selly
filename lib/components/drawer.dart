import 'package:flutter/material.dart';
import 'package:selly/page/login_page.dart';
import 'package:selly/resources/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _provider = ApiProvider();

Future logout() {
  return _provider.userLogout();
}

Drawer drawer([BuildContext? context, String userName = '']) => Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Flexible(
                        child: Text(
                          '${userName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          softWrap: true,
                        ),
                      ),
                    )
                    ),
                ListTile(
                  title: const Text('I miei ordini'),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context!, "/orders", (route) => false);
                  },
                ),
                ListTile(
                  title: const Text('Catalogo premi'),
                  onTap: () {
                    //Navigator.pop(context!);
                    Navigator.pushNamedAndRemoveUntil(
                        context!, "/catalog", (route) => false);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () async {
              await logout();

              SharedPreferences prefs = await SharedPreferences.getInstance();

              await prefs.setString('token', '');
              await prefs.setString('status', '');

              await Future.delayed(Duration(seconds: 2));
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                    context!, '/login', (route) => false);
              });

              Navigator.pop(context!);
            },
          ),
        ],
      ),
    );
