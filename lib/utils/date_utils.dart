String getTodayDate() {
  final now = DateTime.now();
  return '${now.day.toString().padLeft(2, '0')} '
      '${monthName(now.month)} '
      '${now.year}';
}

String monthName(int month) {
  const months = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
  ];
  return months[month];
}
