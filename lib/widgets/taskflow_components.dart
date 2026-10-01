import 'package:flutter/material.dart';

import '../theme/taskflow_theme.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.back = false,
    this.title = 'TaskFlow',
    this.onBack,
  });
  final bool back;
  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) => Container(
    height: 68,
    padding: const EdgeInsets.symmetric(horizontal: 26),
    decoration: const BoxDecoration(
      color: canvas,
      border: Border(bottom: BorderSide(color: Color(0x0d0b1c30))),
    ),
    child: Row(
      children: [
        if (back)
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, color: ink),
          ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 11),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: ink,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.dark_mode_outlined, color: ink),
        ),
        const CircleAvatar(
          radius: 19,
          backgroundColor: blue,
          child: Text(
            'SJ',
            style: TextStyle(color: primary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

class UiCard extends StatelessWidget {
  const UiCard({super.key, required this.child, this.color = Colors.white});
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0b0b1c30),
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

class UiPill extends StatelessWidget {
  const UiPill({
    super.key,
    this.icon,
    required this.label,
    required this.color,
    this.lightText = false,
  });
  final IconData? icon;
  final String label;
  final Color color;
  final bool lightText;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Icon(icon, size: 18, color: lightText ? Colors.white : primary),
        if (icon != null) const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            color: lightText ? Colors.white : ink,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.text,
    required this.color,
    required this.foreground,
  });
  final String text;
  final Color color;
  final Color foreground;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: foreground,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class DotLabel extends StatelessWidget {
  const DotLabel({super.key, required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 7),
      Text(text, style: const TextStyle(color: ink)),
    ],
  );
}

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: Icon(icon),
    style: IconButton.styleFrom(backgroundColor: pale, foregroundColor: ink),
  );
}

class Meta extends StatelessWidget {
  const Meta({super.key, required this.label, required this.value, this.icon});
  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: pale,
      borderRadius: BorderRadius.circular(9),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) Icon(icon, color: primary, size: 19),
        Text(label, style: const TextStyle(fontSize: 11, letterSpacing: 1)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class Metric extends StatelessWidget {
  const Metric({
    super.key,
    required this.value,
    required this.label,
    this.color = ink,
  });
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: pale,
      borderRadius: BorderRadius.circular(9),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 34,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(label, style: const TextStyle(color: muted)),
      ],
    ),
  );
}

class FormCard extends StatelessWidget {
  const FormCard({super.key, required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => UiCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, letterSpacing: 1, color: ink),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

class SelectBox extends StatelessWidget {
  const SelectBox({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: pale,
      borderRadius: BorderRadius.circular(9),
    ),
    child: Row(
      children: [
        Icon(icon, color: primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
