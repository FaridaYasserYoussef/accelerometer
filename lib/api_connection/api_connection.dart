class API{
  // connection to api service
  static const hostConnect = "http://192.168.1.14:8000";
  static const appName = "api";
  static const classifyFunc = "classifyTemplate";
  static const addTemplateFunc = "add_AccelerometerData";
  static const addGyroData = "add_GyroscopeData";
  static const addMagnetoData = "add_MagnetometerData";


  static const hostConnectClassify = "$hostConnect/$appName/$classifyFunc/";
  static const hostConnectAddTemplate = "$hostConnect/$appName/$addTemplateFunc/";
  static const hostConnectAddGyroData = "$hostConnect/$appName/$addGyroData/";
  static const hostConnectAddMagnetoData = "$hostConnect/$appName/$addMagnetoData/";

}