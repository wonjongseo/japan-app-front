class Api {
  static final String baseUrl = "http://localhost:4000";
  // static final String baseUrl = "https://japan-voca.herokuapp.com";

  static String getKangisByJlptLevel = baseUrl + '/kangis/level';
  static String getJapansByKangiId = baseUrl + '/japans';
}
