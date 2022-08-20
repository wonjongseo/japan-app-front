class Api {
  static final String baseUrl = "http://localhost:4000";
  // static final String baseUrl = "https://japan-voca.herokuapp.com";

  static String getWords = baseUrl + "/words";
  static String getWordsByJlptLevel = baseUrl + '/words/level';

  static String getRelatedWords = baseUrl + '/related/level';

  static String getAllWordsAndCnt = baseUrl + "/all-words";

  // static String getRealtedWords = baseUrl + "/word";

  //get all by levels

  //get levels by stesp
  static String getJapansByKangiId = baseUrl + '/related';
}

/*

ㄱ꾸짖을 갈
마를갈 
느낄 감
헤아리 감
견딜 감
*/