import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateAndEnd(context, Widget widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void navigateTo(context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void showToast({required String message, required toastStates state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum toastStates { SUCCESS, ERROR, WARNING }


Color toastColor(toastStates state) {
  Color color;
  switch (state) {
    case toastStates.SUCCESS:
      color = Colors.green;
      break;
    case toastStates.ERROR:
      color = Colors.red;
      break;
    case toastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget defaultFormField({
  required String text,
  isPassword = false,
  required TextEditingController controller,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  required Function? validate,
  Function? onSubmit,
  required TextInputType type,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    onFieldSubmitted: (value) {
      return onSubmit!(value);
    },
    validator: (value) {
      return validate!(value);
    },
    keyboardType: type,
    decoration: InputDecoration(
      labelText: text,
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(
          onPressed: () {
            return suffixPressed!();
          },
          icon: Icon(suffix)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
  );
}