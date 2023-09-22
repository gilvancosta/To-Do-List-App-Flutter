extension DateExtension on DateTime {
  // String get formatDate => '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';

  String get formatDate {
    final String day = this.day.toString().padLeft(2, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String year = this.year.toString();

    return '$day/$month/$year';
  }
}
