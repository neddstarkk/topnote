part of 'notes_cubit.dart';

@immutable
abstract class NotesState {
  const NotesState();
}

class NotesInitial extends NotesState {
  const NotesInitial();
}

class NoteTagsModified extends NotesState {
  final List<Tag> associatedTags;
  NoteTagsModified(this.associatedTags);

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is NoteTagsModified && listEquals(other.associatedTags, associatedTags);
  }

  @override
  int get hashCode => associatedTags.hashCode;
}
