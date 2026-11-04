const _months = [
  'janvier',
  'février',
  'mars',
  'avril',
  'mai',
  'juin',
  'juillet',
  'août',
  'septembre',
  'octobre',
  'novembre',
  'décembre',
];

String formatDueDate(DateTime date) {
  return '${date.day} ${_months[date.month - 1]} ${date.year}';
}
