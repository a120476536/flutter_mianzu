# 免租租房
##### 项目起源
idea起源于蛋壳暴雷事件,
相信绝大部分打工人都绕不开的一个话题就是租房,
然而现在绝大部分房源市场都把持在中介手中,
那么你是否曾经有过被中介支配的恐惧,
二房东,
中介费？
同时作为房东其实也很无奈，
发布房源,
无端被中介骚扰,
经历租客看房,
最终被放鸽子,
等等例子不胜枚举
善待各路打工人,从免租开始.

![效果预览](http://mianzu.eatandshow.com/support/mianzu.gif)

##### 代码地址
```
码云 ： https://gitee.com/qobn/mianzu_flutter.git
github ： https://github.com/a120476536/flutter_mianzu.git

Api接口文档地址：https://www.showdoc.com.cn/mianzu
```
##### 项目依赖
  - flutter_swiper: ^1.1.6
  - dio: ^3.0.10
  - flutter_spinkit: ^3.1.0
  - event_bus: ^1.1.0
  - flutter_html: ^0.10.4
  - flutter_screenutil: ^0.5.3
  - fluttertoast: ^3.1.0
  - shared_preferences: ^0.5.3+4
  - fluro: ^1.6.3
  - provider: ^3.0.0+1
  - city_pickers: ^0.1.30
  - flutter_easyrefresh: ^2.0.3
  - flutter_webview_plugin: ^0.3.11
  - cached_network_image: ^2.0.0
  - flutter_stack_trace: ^1.0.1
  - toast: ^0.1.5
  - share: ^0.6.5+4
  - flutter_bmflocation: ^1.0.2
  - flutter_bmfmap:  ^1.0.2
  - flutter_bmfutils: ^1.0.2
  - image_picker: ^0.6.7+14
  - cupertino_icons: ^1.0.0
  - 同时用到androidStudio对象快速生成插件JsonToDartBeanAction,需自行前往as插件市场安装
##### 项目目录
- main.dart 入口文件
- api 接口目录
- constant 常量
- entity 对象 JsonToDartBeanAction 生成
- generated JsonToDartBeanAction 搭配生成
- http 网络请求
- page 页面
 -- house 房源相关
 -- login 登录相关
 -- main 首页相关
 -- my 我的相关
 -- register 注册相关
 -- rent 求租相关
 -- square 广场相关
 -- welcome 欢迎页相关
- router 路由相关
- utils 工具类相关
- widget 部分控件
##### 项目接口
    - BASE_URL 'http://mianzu.eatandshow.com';
    - IMG_URL 'http://mianzu.eatandshow.com/';
    - 用户注册 '/admin.php/Admin/register';
    - 用户登录 '/admin.php/Admin/tologin';
    - 更新用户信息 '/admin.php/Admin/updateuser';
    - 获取用户信息 '/admin.php/Admin/getuserinfo';
    - 房东发布house '/admin.php/House/sendHouse';
    - 查询所有house列表 '/admin.php/House/findhouse';
    - 热度值最高前三house '/admin.php/House/hothouse';
    - 招租详情 '/admin.php/House/houseDetail';
    - 租客意向房源 '/admin.php/Rent_House/intentionhouse';
    - 喜欢房间 '/admin.php/Rent_House/find_like_house';
    - 租客发布求租意向 '/admin.php/Rent_House/sendRentHouse';
    - 查询租客发布 '/admin.php/Rent_House/find_rent_house';
    - 查询租客发布前三热门 '/admin.php/Rent_House/top_three_hot_rent_house';
    - 查询租客意向单详情 '/admin.php/Rent_House/rent_house_detail';
    - 首页banner+icon '/admin.php/Main_Home/mainContent';
    - 我的房源 '/admin.php/House/myHouse';
    - 是否喜欢求租者 '/admin.php/Rent_House/likeRentUser';
    - 所有租房技能标签 '/admin.php/Skill/skill';
    - 反馈 '/admin.php/Feed_Back/feedback';
##### Api地址提供
- 作者：有点凉了
- QQ：1677156127
- 微信：qblitter
- 邮箱：1677156127@qq.com
#### 相关后台接口代码仓库：
- 基于TP5框架进行开发
```
https://gitee.com/qobn/mianzu_php.git
```
# 觉得对你有帮助打赏作者一杯咖啡吧
![支付宝打赏](http://mianzu.eatandshow.com/support/alipay.jpg)
![微信打赏](http://mianzu.eatandshow.com/support/wechat.jpg)

