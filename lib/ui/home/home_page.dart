import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes/main.dart';
import 'package:my_notes/ui/home/home_bloc.dart';
import 'package:my_notes/ui/home/home_event.dart';
import 'package:my_notes/ui/home/home_state.dart';
import 'package:my_notes/ui/home/widget/note_item_widget.dart';

import '../../data/entity/note_entity.dart';
import '../common/dialogs.dart';

class NoteModel {
  final String title, description, date;

  const NoteModel(this.title, this.description, this.date);
}

class HomePage extends StatelessWidget {
  final NoteEntity? noteEntity;

  const HomePage({super.key, this.noteEntity});

  @override
  Widget build(BuildContext context) {
    final bloc = HomeBloc()..add(LoadNotesEvent());
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return AppBar(
                backgroundColor: Colors.white,
                leading: (state is HomeLoadedState && state.isSelecting)
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          bloc.add(const DisableSelectModeEvent());
                        },
                      )
                    : null,
                title: (state is HomeLoadedState && state.isSelecting)
                    ? Text("${state.totalSelected} selected")
                    : const Text("My Notes"),
                actions: [
                  if (state is HomeLoadedState &&
                      state.isSelecting &&
                      state.totalSelected > 0)
                    IconButton(
                        onPressed: () {
                          showConfirmationDialog(
                              context: context,
                              title: "Delete Selected Notes",
                              description:
                                  "Are you sure you want to delete selected notes?",
                              onYesPressed: () {
                                context.pop();
                                bloc.add(const DeleteSelectedNotesEvent());
                              });
                        },
                        icon: const Icon(
                          Icons.delete_outline_outlined,
                          size: 24,
                        ))
                ],
              );
            },
          ),
        ),
        body: const HomeBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            context.push<bool>(Routes.createNote).then((value) {
              bloc.add(const LoadNotesEvent());
            });
          },
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HomeLoadedState) {
          if (state.notes.isEmpty) {
            return const HomeEmpty();
          }

          return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final noteEntity = state.notes[index];
                return NoteItemWidget(
                  noteEntity: noteEntity,
                  isSelecting: state.isSelecting,
                );
              });
        }

        return Container();
      },
    );
  }
}

class HomeEmpty extends StatelessWidget {
  const HomeEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Icon(
            Icons.file_present,
            size: 150,
            color: Colors.black12,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "You don't have any notes!",
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }
}
