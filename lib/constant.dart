import 'package:flutter/material.dart';

const style = TextStyle();
const primaryColor = Color(0xfff02828);
const noConnection = 'No Internet Connection';
const somethingWentWrong = 'Something went wrong';
const unknownError = 'Unknown Error';

const lightGreen = Color(0xff47E690);
const boldTextColor = Color(0xff052715);
ShapeBorder textFieldDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: primaryColor, width: 1.8));

const bottomSheetDecoration = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15), topRight: Radius.circular(15)));

Widget divider() => const Divider(thickness: 1.8);

void showSnackbar(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue.shade800),
            const SizedBox(width: 8),
            Expanded(child: Text(text))
          ],
        )));

// String dateFormatter(DateTime date) => DateFormat.yMMMd().format(date);

// String formattedAmount(String value) {
//   if (value.isEmpty) {
//     return '';
//   }
//   final amount = num.tryParse(value);
//   return '₦' + NumberFormat().format(amount);
// }

Future<void> push(BuildContext context, Widget child) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => child));

Future<void> pushReplacement(BuildContext context, Widget child) =>
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => child));

Future<void> pushAndRemoveUntil(BuildContext context, Widget child) =>
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => child), (c) => false);
