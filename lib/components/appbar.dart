import 'package:flutter/material.dart';

AppBar appBar({title, subtitle, iconBack}) => AppBar(
      automaticallyImplyLeading: iconBack,
      iconTheme: iconBack ? IconThemeData(color: Colors.black) : null,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
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
