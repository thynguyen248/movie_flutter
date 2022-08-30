import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowCard extends StatelessWidget {
  final Widget child;

  const ShadowCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: child,
      ),
    );
  }
}
