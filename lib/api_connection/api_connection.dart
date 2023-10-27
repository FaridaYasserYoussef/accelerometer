class API{
  // connection to api service
  static const hostConnect = "http://ec2-52-90-141-43.compute-1.amazonaws.com";
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