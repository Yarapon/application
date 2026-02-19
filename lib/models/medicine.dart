class Medicine {
  final String name;
  final String dose;
  final List<String> times;
  final String note;

  Medicine({
    required this.name,
    required this.dose,
    required this.times,
    this.note = '',
  });
}
