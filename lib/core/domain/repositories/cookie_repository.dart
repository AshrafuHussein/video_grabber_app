abstract class CookieRepository {
  Future<String?> getInstagramCookiePath();
  Future<void> saveInstagramCookies(List<dynamic> webviewCookies);
}
