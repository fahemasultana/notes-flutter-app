import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes/data/entity/note_entity.dart';
import 'package:my_notes/main.dart';

import '../home_bloc.dart';
import '../home_event.dart';

class NoteItemWidget extends StatelessWidget {
  final NoteEntity noteEntity;
  final bool isSelecting;

  const NoteItemWidget(
      {super.key, required this.noteEntity, required this.isSelecting});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onLongPress: () {
          context.read<HomeBloc>().add(SelectNoteEvent(
              id: noteEntity.id!, selected: true));
        },
        onTap: () {
          context.push(Routes.createNote, extra: noteEntity);
        },
        child: Container(
            width: double.maxFinite,
            padding:
                const EdgeInsets.only(left: 10, right: 16, bottom: 16, top: 10),
            decoration: BoxDecoration(
                color: Colors.black12.withAlpha(8),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isSelecting)
                  Checkbox(
                      value: noteEntity.selected,
                      onChanged: (checked) {
                        context.read<HomeBloc>().add(SelectNoteEvent(
                            id: noteEntity.id!, selected: checked ?? false));
                      }),
                const SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    if (noteEntity.title?.isNotEmpty == true)
                      Text(
                        noteEntity.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    Text(
                      noteEntity.description,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(noteEntity.getFormattedDate()),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
