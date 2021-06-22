import 'package:flutter/material.dart';

class KeyboardWiseScroller extends StatelessWidget {
  final Widget child;
  const KeyboardWiseScroller({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: child,
                ),
              ],
            ),
          ),
        ),
        Text("data here yo"),
      ],
    );
  }
}
