import 'package:flutter/material.dart';

import '../models/task.dart';
import '../theme/taskflow_theme.dart';
import '../widgets/taskflow_components.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({
    super.key,
    required this.task,
    required this.onBack,
    required this.onEdit,
    required this.onDelete,
    required this.onUpdate,
  });
  final Task task;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<Task> onUpdate;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(
      text: widget.task.description,
    );
    selectedDate = _parseDate(widget.task.date);
    selectedTime = _parseTime(widget.task.time);
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
    final match = RegExp(
      r'^(\d{1,2}):(\d{2})\s*(AM|PM)?$',
      caseSensitive: false,
    ).firstMatch(value.trim());
    if (match == null) return const TimeOfDay(hour: 14, minute: 30);

    int hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final period = match.group(3)?.toUpperCase();
    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

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

  void _updateTask() {
    final task = widget.task;
    task.title = titleController.text.trim().isEmpty
        ? 'Untitled task'
        : titleController.text.trim();
    task.description = descriptionController.text.trim();
    task.date = _formatDate(selectedDate);
    task.time = _formatTime(selectedTime);
    widget.onUpdate(task);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: AppHeader(back: true, title: 'Task Details'),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  TextButton.icon(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(Icons.delete_outline, color: red),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              UiCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TITLE',
                      style: TextStyle(
                        fontSize: 12,
                        color: muted,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: pale,
                        hintText: 'Task title',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'DESCRIPTION',
                      style: TextStyle(
                        fontSize: 12,
                        color: muted,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: pale,
                        hintText: 'Add description',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime.now().subtract(
                                  const Duration(days: 3650),
                                ),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 3650),
                                ),
                              );
                              if (pickedDate != null) {
                                setState(() => selectedDate = pickedDate);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: pale,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'DATE',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: muted,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _formatDate(selectedDate),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                              if (pickedTime != null) {
                                setState(() => selectedTime = pickedTime);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: pale,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'TIME',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: muted,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _formatTime(selectedTime),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _updateTask,
                        icon: const Icon(Icons.update),
                        label: const Text('Update Task'),
                        style: FilledButton.styleFrom(
                          backgroundColor: primary,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

// class Subtasks extends StatelessWidget {
//   const Subtasks({super.key, required this.done, required this.onChanged});
//   final List<bool> done;
//   final ValueChanged<int> onChanged;

//   @override
//   Widget build(BuildContext context) => Container(
//     padding: const EdgeInsets.all(14),
//     decoration: BoxDecoration(
//       color: pale,
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Column(
//       children: [
//         Row(
//           children: [
//             const Icon(Icons.checklist, color: primary),
//             const SizedBox(width: 8),
//             const Text(
//               'Subtasks',
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),
//             const Spacer(),
//             Text('${done.where((x) => x).length} of 4 done'),
//           ],
//         ),
//         const SizedBox(height: 10),
//         LinearProgressIndicator(
//           value: done.where((x) => x).length / 4,
//           color: green,
//           backgroundColor: blue,
//         ),
//         const SizedBox(height: 10),
//         ...[
//           'Audit WCAG AA contrast for dark mode',
//           'Export design token JSON schema',
//           'Review PR with frontend lead',
//           'Update Figma shared library',
//         ].asMap().entries.map(
//           (entry) => Material(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             child: CheckboxListTile(
//               value: done[entry.key],
//               onChanged: (_) => onChanged(entry.key),
//               dense: true,
//               contentPadding: EdgeInsets.zero,
//               title: Text(
//                 entry.value,
//                 style: TextStyle(
//                   decoration: done[entry.key]
//                       ? TextDecoration.lineThrough
//                       : null,
//                 ),
//               ),
//               controlAffinity: ListTileControlAffinity.leading,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
