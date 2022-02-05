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
          onPressed: () => suffixPressed!(),
          icon: Icon(suffix)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
  );
}

AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
})=> AppBar(
      leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: (){Navigator.pop(context);},),
  title: Text(title!),
  titleSpacing: 5.0,
  actions: actions);

Widget defaultTextButton({
  required String label,
  Function? onPressed
})=>TextButton(child: Text(label.toUpperCase(),style: const TextStyle(color: Colors.white, fontSize: 16.0),), onPressed: () => onPressed!() ,  );


