abstract class LocaleDbRepository {
  Future<int> setDatabase(String tableName, Map<String, dynamic> toMap);
  Future<List> getDatabase(String tableName);
  Future<void> deleteRowFromDatabase(String tableName, String id);
  Future<int> updateRowFromDatebase(
      String tableName, int id, Map<String, dynamic> toMap);
}
