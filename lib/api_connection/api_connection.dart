class API{
  // connection to api service
  static const hostConnect = "http://192.168.1.4:8000";
  static const appName = "api";
  static const classifyFunc = "receive-accelerometer-data";
  static const addTemplateFunc = "add_template";

  static const hostConnectClassify = "$hostConnect/$appName/$classifyFunc/";
  static const hostConnectAddTemplate = "$hostConnect/$appName/$addTemplateFunc/";

}