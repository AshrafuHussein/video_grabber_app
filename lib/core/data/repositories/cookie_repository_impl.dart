import '../../domain/repositories/cookie_repository.dart';
import '../datasources/cookie_storage_data_source.dart';

class CookieRepositoryImpl implements CookieRepository {
  final CookieStorageDataSource dataSource;

  CookieRepositoryImpl(this.dataSource);

  @override
  Future<String?> getInstagramCookiePath() {
    return dataSource.getCookiePath();
  }

  @override
  Future<void> saveInstagramCookies(List<dynamic> webviewCookies) async {
    await dataSource.saveCookiesToNetscape(webviewCookies);
  }
}
