import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final Widget leading;
  final void Function()? onTap;

  const DrawerTile({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          leading: leading,
          onTap: () {
            Navigator.pop(context);
            if (onTap != null) {
              onTap!();
            }
          },
        ),
      ),
    );
  }
}
