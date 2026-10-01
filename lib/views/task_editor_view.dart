import 'package:flutter/material.dart';

import '../models/task.dart';
import '../theme/taskflow_theme.dart';
import '../widgets/taskflow_components.dart';

String _formatDate(DateTime date) {
  const monthNames = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${monthNames[date.month - 1]} ${date.day}, ${date.year}';
}

String _formatTime(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final suffix = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $suffix';
}

class TaskEditor extends StatefulWidget {
  const TaskEditor({
    super.key,
    this.task,
    required this.onCancel,
    required this.onSave,
  });
  final Task? task;
  final VoidCallback onCancel;
  final void Function(String, String, String, Priority, String, String) onSave;

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  late final title = TextEditingController(text: widget.task?.title ?? '');
  late final description = TextEditingController(
    text: widget.task?.description ?? '',
  );
  Priority priority = Priority.high;
  String category = 'Work';
  bool reminder = true;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    priority = widget.task?.priority ?? Priority.high;
    category = widget.task?.category ?? 'Work';
    selectedDate = _parseDate(widget.task?.date ?? DateTime.now().toString());
    selectedTime = _parseTime(widget.task?.time ?? '2:30 PM');
  }

  DateTime _parseDate(String value) {
    if (value.isEmpty) return DateTime.now();

    try {
      return DateTime.parse(value);
    } catch (_) {
      try {
        final parts = value.replaceAll(',', '').split(' ');
        if (parts.length >= 3) {
          const monthNames = <String>[
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec',
          ];
          final monthIndex = monthNames.indexOf(parts[0]);
          if (monthIndex >= 0) {
            return DateTime(
              int.parse(parts[2]),
              monthIndex + 1,
              int.parse(parts[1]),
            );
          }
        }
      } catch (_) {}
    }

    return DateTime.now();
  }

  TimeOfDay _parseTime(String value) {
    if (value.isEmpty) return const TimeOfDay(hour: 14, minute: 30);

    final cleaned = value.trim();
    final match = RegExp(
      r'^(\d{1,2}):(\d{2})\s*(AM|PM)?$',
      caseSensitive: false,
    ).firstMatch(cleaned);

    if (match != null) {
      int hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final period = match.group(3)?.toUpperCase();
      if (period == 'PM' && hour != 12) hour += 12;
      if (period == 'AM' && hour == 12) hour = 0;
      return TimeOfDay(hour: hour, minute: minute);
    }

    return const TimeOfDay(hour: 14, minute: 30);
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: AppHeader(
          back: true,
          title: widget.task == null ? 'New Task' : 'Edit Task',
          onBack: widget.onCancel,
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(26, 10, 26, 30),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: widget.onCancel,
                  child: const Text('Cancel'),
                ),
                // Container(
                //   padding: const EdgeInsets.all(4),
                //   decoration: BoxDecoration(
                //     color: blue,
                //     borderRadius: BorderRadius.circular(24),
                //   ),
                //   child: const Text('New Task    Edit Task'),
                // ),
                TextButton(
                  onPressed: () {
                    title.clear();
                    description.clear();
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FormCard(
              label: 'TASK TITLE',
              child: TextField(
                controller: title,
                maxLength: 80,
                decoration: const InputDecoration(
                  hintText: 'e.g., Finalize mobile design guideline',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: pale,
                  counterText: '',
                ),
              ),
            ),
            const SizedBox(height: 18),
            FormCard(
              label: 'DESCRIPTION & NOTES',
              child: Column(
                children: [
                  TextField(
                    controller: description,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Add context, subtasks, notes, or links...',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: pale,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ActionChip(
                        avatar: const Icon(Icons.checklist, size: 17),
                        label: const Text('Checklist'),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      ActionChip(
                        avatar: const Icon(Icons.attach_file, size: 17),
                        label: const Text('Attachment'),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      ActionChip(
                        avatar: const Icon(Icons.link, size: 17),
                        label: const Text('Link'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: FormCard(
                    label: 'DUE DATE',
                    child: InkWell(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now().subtract(
                            const Duration(days: 365),
                          ),
                          lastDate: DateTime.now().add(
                            const Duration(days: 3650),
                          ),
                        );
                        if (pickedDate != null) {
                          setState(() => selectedDate = pickedDate);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: primary),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _formatDate(selectedDate),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormCard(
                    label: 'TIME',
                    child: InkWell(
                      onTap: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (pickedTime != null) {
                          setState(() => selectedTime = pickedTime);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.schedule, color: primary),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _formatTime(selectedTime),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            FormCard(
              label: 'PRIORITY LEVEL',
              child: Row(
                children: Priority.values
                    .map(
                      (p) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: ChoiceChip(
                            label: Text(
                              p.name[0].toUpperCase() + p.name.substring(1),
                            ),
                            selected: priority == p,
                            onSelected: (_) => setState(() => priority = p),
                            selectedColor: p == Priority.high
                                ? const Color(0xffffdad6)
                                : blue,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 18),
            FormCard(
              label: 'CATEGORY / PROJECT',
              child: Wrap(
                spacing: 8,
                children: ['Work', 'Personal', 'Design', 'Finance']
                    .map(
                      (name) => ChoiceChip(
                        label: Text(name),
                        selected: category == name,
                        onSelected: (_) => setState(() => category = name),
                        selectedColor: primary,
                        labelStyle: TextStyle(
                          color: category == name ? Colors.white : ink,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 18),
            UiCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xffe2dfff),
                        child: Icon(Icons.notifications_active, color: primary),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reminder Alert',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '15 minutes before',
                              style: TextStyle(color: muted),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: reminder,
                        onChanged: (value) => setState(() => reminder = value),
                        activeThumbColor: primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: pale,
                    child: const Row(
                      children: [
                        Icon(Icons.vibration, size: 18),
                        SizedBox(width: 8),
                        Text('Haptic alert enabled'),
                        Spacer(),
                        Text(
                          'STANDARD',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: pale,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: primary),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Pro-tip: Press Enter in the description to instantly generate structured sub-steps.',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => widget.onSave(
                  title.text.isEmpty ? 'Untitled task' : title.text,
                  description.text,
                  category,
                  priority,
                  _formatDate(selectedDate),
                  _formatTime(selectedTime),
                ),
                icon: const Icon(Icons.check),
                label: const Text('Save Task'),
                style: FilledButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ]),
        ),
      ),
    ],
  );
}
