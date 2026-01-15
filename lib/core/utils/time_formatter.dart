String formatDuration(int totalMinutes) {
  if (totalMinutes < 0) return "0m";
  final int hours = totalMinutes ~/ 60;
  final int minutes = totalMinutes % 60;

  if (hours > 0) {
    return "${hours}h ${minutes}m";
  } else {
    return "${minutes}m";
  }
}
