String getRank(int score) {
  if (score < 50) return 'Newbie';
  if (score <= 100) return 'Fan';
  if (score <= 200) return 'Expert';
  return 'Legend';
}