import '../../features/game_flow/view/game_summary/models/leaderboard.dart';

abstract interface class ILocalStorage {
  List<Leaderboard> loadLeaderboard();
  Future<void> saveLeaderboard(List<Leaderboard> list);
}