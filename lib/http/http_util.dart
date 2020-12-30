import 'package:dio/dio.dart';
typedef OnProgessBack(double current);
var dio;
class HttpUtil {
  // 工厂模式
  static HttpUtil get instance => _getInstance();

  static HttpUtil _httpUtil;

  static HttpUtil _getInstance() {
    if (_httpUtil == null) {
      _httpUtil = HttpUtil();
    }
    return _httpUtil;
  }
  getHeaders () {
    return {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'multipart/form-data',
      'Authorization': "**",
      'User-Aagent': "4.1.0;android;6.0.1;default;A001",
      "HZUID": "2",
    };
  }
    HttpUtil() {
    BaseOptions options = BaseOptions(
      headers: getHeaders(),
      connectTimeout: 5000*50,
      receiveTimeout: 5000*50,
    );
    dio = new Dio(options);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print("========================请求数据===================");
      print("url=${options.uri.toString()}");
      print("params_data=${options.data}");
      print("params_queryParameters=${options.queryParameters}");
      print("params_contentType=${options.contentType}");
      dio.lock();
      // await SharePreference.getToken().then((token) {
      //   options.headers[Strings.TOKEN] = token;
      // });
      // await SharePreference.getShareData(Strings.TOKEN).then((token) => {
      //   options.headers[Strings.TOKEN] = token
      // });
      print("options_header=${options.headers}");
      dio.unlock();
      return options;
    }, onResponse: (Response response) {
      print("========================请求结果===================");
      print("code=${response.statusCode}");
      print("response=${response.data}");
      print("response.toString=$response");
      print("response=${response.request.queryParameters}");
    }, onError: (DioError error) {
      print("========================请求错误===================");
      print("message =${error.message}");
    }));
  }
  Future downLoad(String url,String savePath,{Options options,ProgressCallback onReceiveProgress}) async{
    double currentProgress =0.0;
    Response response;
    if(url==null){
      print("下载地址不能为空");
      return;
    }
    if(savePath==null){
      print("保存地址不能为空");
      return;
    }
    response = await dio.download(url, "$savePath/mianzu.apk",onReceiveProgress:(received, total){
      if (total != -1) {
        ///当前下载的百分比例
        print((received / total * 100).toStringAsFixed(0) + "%");
        // CircularProgressIndicator(value: currentProgress,) 进度 0-1
        currentProgress = received / total;
        // onProgessBack(currentProgress);
      }
    });
  }
  Future get(String url, {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response =
      await dio.get(url, queryParameters: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.get(url, queryParameters: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.get(url, options: options);
    } else {
      response = await dio.get(url);
    }
    // return response.data;
    return response;
  }

  Future post(String url, {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    // return response.data;
    return response;
  }
  Future postFormData(String url, {FormData parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    // return response.data;
    return response;
  }
}