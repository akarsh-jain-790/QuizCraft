import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:quiz_craft/screens/generateQuiz/generate_quiz.dart';

class Paginator extends ConsumerWidget {
  final void Function(dynamic) paginatorEvent;

  const Paginator({super.key, required this.paginatorEvent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Pagination(
      numOfPages: 10,
      selectedPage: ref.watch(pageCountProvider),
      pagesVisible: 3,
      onPageChanged: paginatorEvent,
      nextIcon: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).primaryColor,
        size: 14,
      ),
      previousIcon: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).primaryColor,
        size: 14,
      ),
      activeTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      activeBtnStyle: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          ),
        ),
      ),
      inactiveBtnStyle: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(38),
        )),
      ),
      inactiveTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
