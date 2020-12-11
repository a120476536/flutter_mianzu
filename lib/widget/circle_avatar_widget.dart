import 'dart:io';

import 'package:flutter/material.dart';
///加载本地路径头像，，圆形
class CircleAvatarWidget extends StatelessWidget {
  File _imgPath;
  CircleAvatarWidget(this._imgPath);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30),),
        image: DecorationImage(
            image: FileImage(_imgPath,scale: 1.0),
            fit: BoxFit.cover
        ),
      ),
    );
  }


}
