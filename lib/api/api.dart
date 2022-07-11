class Api {
  static final String baseUrl = "http://localhost:4000";
  // static final String baseUrl = "https://japan-voca.herokuapp.com";

  static String getKangisAll = baseUrl + "/kangis/all";
  //get all by levels
  static String getKangisByJlptLevel = baseUrl + '/kangis/levels';

  //get levels by stesp
  static String getKangiByJlptLevel = baseUrl + '/kangis/level';
  static String getJapansByKangiId = baseUrl + '/japans';
}
