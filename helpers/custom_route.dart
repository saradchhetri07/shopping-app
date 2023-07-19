// // import 'package:flutter/material.dart';

// // class CustomRoute<T> extends MaterialPageRoute<T> {
// //   CustomRoute({required WidgetBuilder builder, required RouteSettings settings})
// //       : super(builder: builder, settings: settings);

// //   @override
// //   Widget? buildTransitions(BuildContext context, Animation<double> animation,
// //       Animation<double> secondaryAnimation, Widget child) {
// //     if (settings.isInitialRoute) {
// //       return child;
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';

// class CustomPageTransitionBuilder extends PageTransitionsBuilder {
//   @override
//   Widget buildTransitions<T>(
//       PageRoute<T> route,
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child) {
//     // TODO: implement buildTransitions

//     if (route.isInitialRoute) throw UnimplementedError();
//   }
// }
