import 'package:flutter/material.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';

class ShowImgPage extends StatefulWidget {
  var imgUrl;

  ShowImgPage(this.imgUrl);

  @override
  _ShowImgPageState createState() => _ShowImgPageState();
}

class _ShowImgPageState extends State<ShowImgPage> {
  var imgUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgUrl = widget.imgUrl;
  }
  @override
  Widget build(BuildContext context) {
    print('图片地址$imgUrl');
    return Scaffold(
      appBar: AppBar(title: Text('图片详情'),centerTitle: true,),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Hero(
          tag: imgUrl,
          child: CachedImageView(double.infinity,double.infinity,imgUrl),
        ),
      ),
    );
  }
}

// class ShowImgPage extends StatelessWidget {
//   var imgUrl;
//
//   ShowImgPage(this.imgUrl);
//
//   @override
//   Widget build(BuildContext context) {
//     print('图片地址$imgUrl');
//     return Scaffold(
//       appBar: AppBar(title: Text('1'),),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: Hero(
//           tag: 'tag',
//           child: CachedImageView(double.infinity,double.infinity,imgUrl),
//         ),
//       ),
//     );
//   }
// }
