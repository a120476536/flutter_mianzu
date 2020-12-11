class Api{
  // static const String IMG_URL = 'http://192.168.1.46/';
  // static const String BASE_URL = 'http://192.168.1.46';
  static const String IMG_URL = 'http://mianzu.eatandshow.com/';
  static const String BASE_URL = 'http://mianzu.eatandshow.com';
  static const String REGISTER_URL=BASE_URL+'/admin.php/Admin/register';//用户注册
  static const String LOGIN_URL=BASE_URL+'/admin.php/Admin/tologin';//用户登录
  static const String UPDATEUSER=BASE_URL+'/admin.php/Admin/updateuser';//更新用户信息
  static const String GETUSERINFO=BASE_URL+'/admin.php/Admin/getuserinfo';//获取用户信息
  static const String SENDHOUSE=BASE_URL+'/admin.php/House/sendHouse';//房东发布house
  static const String FINDHOUSE=BASE_URL+'/admin.php/House/findhouse';//查询所有house列表
  static const String HOTHOUSE=BASE_URL+'/admin.php/House/hothouse';//热度值最高前三house
  static const String HOUSEDETAIL=BASE_URL+'/admin.php/House/houseDetail';//房间招租详情
  static const String INTENTIONHOUSE=BASE_URL+'/admin.php/Rent_House/intentionhouse';//租客意向房源
  static const String FIND_LIKE_HOUSE=BASE_URL+'/admin.php/Rent_House/find_like_house';//喜欢房源
  static const String SENDRENTHOUSE=BASE_URL+'/admin.php/Rent_House/sendRentHouse';//租客发布求租意向
  static const String FIND_RENT_HOUSE=BASE_URL+'/admin.php/Rent_House/find_rent_house';//查询租客发布
  static const String TOP_THREE_HOT_RENT_HOUSE=BASE_URL+'/admin.php/Rent_House/top_three_hot_rent_house';//查询租客发布前三热门
  static const String RENT_HOUSEDETAIL=BASE_URL+'/admin.php/Rent_House/rent_house_detail';//查询租客意向单详情
  static const String MAINCONTENT=BASE_URL+'/admin.php/Main_Home/mainContent';//首页banner+icon
  static const String MYHOUSE=BASE_URL+'/admin.php/House/myHouse';//我的房源
  static const String LIKERENTUSER=BASE_URL+'/admin.php/Rent_House/likeRentUser';//是否喜欢求租者
  static const String ALL_SKILL=BASE_URL+'/admin.php/Skill/skill';//所有租房技能标签
  static const String FEEDBACK=BASE_URL+'/admin.php/Feed_Back/feedback';//反馈
}