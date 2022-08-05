class Note {
  final String title;
  const Note({required this.title});

  static final List<Note> _notes = [];
  static List<Note> get notes => _notes.isNotEmpty
      ? _notes
      : List.generate(10, (index) => Note(title: 'Note - ${index + 1}'));

  @override
  String toString() {
    return 'Instance of Note - title : $title';
  }
}


