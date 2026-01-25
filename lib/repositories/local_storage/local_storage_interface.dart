import '../../features/game_flow/models/leaderboard.dart';

abstract interface class ILocalStorage {
  List<Leaderboard> loadLeaderboard();
  Future<void> saveLeaderboard(List<Leaderboard> list);
}