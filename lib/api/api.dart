class Api {
  // static final String baseUrl = "http://localhost:4000";
  static final String baseUrl = "https://japan-voca.herokuapp.com";

  static String getWords = baseUrl + "/words";
  static String getKangisByJlptLevel = baseUrl + '/words/level';

  static String getRelatedWords = baseUrl + '/related/level';

  // static String getRealtedWords = baseUrl + "/word";

  //get all by levels

  //get levels by stesp
  static String getJapansByKangiId = baseUrl + '/related';
}
