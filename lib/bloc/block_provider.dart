import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  const BlocProvider({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);
  
  static BlocProvider of(BuildContext context) {
    // NOTE: Can we assume not null here?
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
