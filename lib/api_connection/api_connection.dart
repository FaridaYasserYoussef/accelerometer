class API{
  // connection to api service
  static const hostConnect = "http://192.168.1.14:8000";
  static const appName = "api";
  static const classifyFunc = "receive-accelerometer-data";
  static const addTemplateFunc = "add_AccelerometerData";
  static const addGyroData = "add_GyroscopeData";


  static const hostConnectClassify = "$hostConnect/$appName/$classifyFunc/";
  static const hostConnectAddTemplate = "$hostConnect/$appName/$addTemplateFunc/";
  static const hostConnectAddGyroData = "$hostConnect/$appName/$addGyroData/";

}