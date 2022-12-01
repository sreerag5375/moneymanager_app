import 'package:flutter/material.dart';

class IncomeListWidget extends StatelessWidget {
  const IncomeListWidget(
      {super.key,
      required this.leading,
      required this.title,
      required this.subtitle,
      required this.trailing});
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
