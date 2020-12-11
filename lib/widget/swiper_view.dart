import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/string_text.dart';
import 'package:flutter_mianzu/entity/banner/banner_bean.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class SwiperView extends StatelessWidget {
  List<BannerBean> bannerData = new List();
  int size;
  double viewHeight;

  SwiperView(this.bannerData, this.size, this.viewHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: viewHeight,
      width: double.infinity,
      child: bannerData == null || bannerData.length == 0
          ? Container(
              height: ScreenUtil.instance.setHeight(400.0),
              color: Colors.grey,
              alignment: Alignment.center,
              child: Text(StringText.NO_DATA_TEXT),
            )
          : Swiper(
              itemCount: bannerData.length,
              scrollDirection: Axis.horizontal,
              loop: true,
              index: 0,
              autoplay: false,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    NavigatorUtil.goRentFindHouseDetailPage(context, bannerData[index].id);
                  },
                  child: Stack(children: [
                    CachedImageView(
                        double.infinity,
                        double.infinity,
                        bannerData[index].url == null ? "https://goss.cfp.cn/creative/vcg/800/new/VCG211165042753.jpg" : !bannerData[index].url.contains("http")?Api.IMG_URL + bannerData[index].url.replaceAll("\\", "/"):bannerData[index].url),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(alignment: Alignment.bottomRight,child: Text('热度值:${bannerData[index].hot}',style: TextStyle(color: Colors.white),),),
                    ),
                  ],),
                );
              },
              duration: 1000,
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                    size: 8.0,
                    color: Colors.white,
                    activeColor: Colors.deepOrangeAccent),
              ),
            ),
    );
  }
}
