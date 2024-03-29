import 'package:flutter/material.dart';
import 'package:path/path.dart';

PreferredSize getCustomAppBar(String title) {
  if (title == '일본어 단어' || title == '사전순') {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.settings,
            ),
          )
        ],
      ),
    );
  }

  return PreferredSize(
    preferredSize: Size.fromHeight(40),
    child: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.white,
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          padding: EdgeInsets.zero,
        );
      }),
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.settings,
          ),
        )
      ],
    ),
  );
}
