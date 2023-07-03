import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

class Paginator extends StatefulWidget {
  const Paginator({super.key});

  @override
  State<Paginator> createState() => _PaginatorState();
}

class _PaginatorState extends State<Paginator> {
  int selectedPage = 1;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Pagination(
      numOfPages: 10,
      selectedPage: selectedPage,
      pagesVisible: 3,
      onPageChanged: (page) {
        setState(() {
          selectedPage = page;
        });
      },
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
