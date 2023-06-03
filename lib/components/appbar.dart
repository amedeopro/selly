import 'package:flutter/material.dart';

AppBar appBar({title, subtitle, iconBack, scaffoldKey,scf_context, return_to_home, onPressed}) => AppBar(
      key: scaffoldKey != null ? Key('appBarWithDrawer') : null,
      automaticallyImplyLeading: iconBack,
      iconTheme: iconBack ? IconThemeData(color: Colors.black) : null,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          scaffoldKey != null ? Icons.menu : Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: onPressed == null ? () {
          if (scaffoldKey != null) {
            scaffoldKey.currentState?.openDrawer();
          } else {
            if(return_to_home){
             Navigator.pushNamedAndRemoveUntil(scf_context, '/home', (route) => false);
            } else {
              Navigator.pop(scf_context);
            }
          }
        } : onPressed,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title != "" ? title : "SELLY",
            style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.w900,
                color: Colors.black),
          ),
          Text(
            subtitle != ""
                ? subtitle
                : "Spedizione gratuita per ordini superiori a 50€",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
