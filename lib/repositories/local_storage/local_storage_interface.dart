abstract interface class ILocalStorage {
  String? getUsername();
  Future<void> saveUsername(String username);
}