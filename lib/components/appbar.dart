import 'package:flutter/material.dart';

AppBar appBar({title, subtitle, iconBack, scaffoldKey, context}) => AppBar(
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
        onPressed: () {
          if (scaffoldKey != null) {
            scaffoldKey.currentState?.openDrawer();
          } else {
            Navigator.pop(context);
          }
        },
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
