import 'package:flutter/material.dart';


class CircleCachedImg extends StatelessWidget {
  double width;
  double height;
  String url;

  CircleCachedImg(this.width, this.height, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30),),
      ),
      child: ClipOval(
        child: Image.network(this.url,fit: BoxFit.cover,width: this.width,height: this.height,),
      ),
    );
  }
}
