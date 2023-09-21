import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@entity
class NoteEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String? title;
  String description;
  int date;

  @ignore
  bool selected = false;

  NoteEntity(
      {this.id, this.title, required this.description, required this.date});

  String getFormattedDate(){
    DateTime now = DateTime.fromMillisecondsSinceEpoch(date);
    String formattedDate = DateFormat('hh:mm aa, dd MMMM').format(now);
    return formattedDate;
  }

  @override
  String toString() {
    return 'NoteEntity{id: $id, title: $title, description: $description, date: $date, selected: $selected}';
  }
}
