import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/data/entity/note_entity.dart';
import 'package:my_notes/main.dart';
import 'package:my_notes/ui/create_note/create_note_bloc.dart';

import '../common/dialogs.dart';

class CreateNotePage extends StatelessWidget {
  final NoteEntity? noteEntity;

  const CreateNotePage({super.key, this.noteEntity});

  @override
  Widget build(BuildContext context) {
    final bloc = CreateNoteBloc(noteEntity);

    TextEditingController titleController =
        TextEditingController(text: noteEntity?.title);
    TextEditingController descriptionController =
        TextEditingController(text: noteEntity?.description);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm aa, dd MMMM').format(now);

    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(""),
            actions: [
              if (noteEntity != null)
                IconButton(
                    onPressed: () {
                      showConfirmationDialog(
                          context: context,
                          title: "Delete Note",
                          description:
                              "Are you sure you want to delete this note?",
                          onYesPressed: () {
                            context.pop();
                            bloc.add(const DeleteNoteEvent());
                          });
                    },
                    icon: const Icon(
                      Icons.delete_outline_outlined,
                      size: 24,
                    )),
              IconButton(
                  onPressed: () {
                    bloc.add(InsertNoteEvent(titleController.value.text,
                        descriptionController.value.text));
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 26,
                  )),
            ],
          ),
          body: CreateNoteBody(
              titleController: titleController,
              formattedDate: formattedDate,
              descriptionController: descriptionController)),
    );
  }
}

class CreateNoteBody extends StatelessWidget {
  const CreateNoteBody({
    super.key,
    required this.titleController,
    required this.formattedDate,
    required this.descriptionController,
  });

  final TextEditingController titleController;
  final String formattedDate;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateNoteBloc, CreateNoteState>(
      listener: (context, state) {
        if (state is ClosePageState) {
          context.pop(true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Title"),
            ),
            Text(formattedDate),
            const SizedBox(height: 10),
            TextField(
                controller: descriptionController,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Start typing")),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
