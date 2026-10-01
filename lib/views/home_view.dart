import 'package:flutter/material.dart';

import '../models/task.dart';
import '../theme/taskflow_theme.dart';
import '../widgets/taskflow_components.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({
    super.key,
    required this.tasks,
    required this.onTaskTap,
    required this.onAdd,
    required this.onToggle,
  });
  final List<Task> tasks;
  final ValueChanged<Task> onTaskTap;
  final VoidCallback onAdd;
  final ValueChanged<Task> onToggle;

  @override
  Widget build(BuildContext context) {
    final pending = tasks.where((task) => !task.completed).toList();
    final completed = tasks.where((task) => task.completed).toList();
    final totalCount = tasks.length;
    final completedCount = completed.length;
    final pendingCount = pending.length;
    final completionPercent = totalCount == 0
        ? 0
        : ((completedCount / totalCount) * 100).round();
    final workCount = tasks
        .where((task) => task.category.toLowerCase() == 'work')
        .length;
    final personalCount = tasks
        .where((task) => task.category.toLowerCase() == 'personal')
        .length;

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: AppHeader()),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(26, 8, 26, 110),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning, Sarah',
                          style: TextStyle(fontSize: 26, color: ink),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Let's get things done today.",
                          style: TextStyle(fontSize: 16, color: muted),
                        ),
                      ],
                    ),
                  ),
                  // const UiPill(
                  //   icon: Icons.dark_mode_outlined,
                  //   label: 'Focus',
                  //   color: blue,
                  // ),
                ],
              ),
              const SizedBox(height: 22),
              ProgressCard(
                totalCount: totalCount,
                completedCount: completedCount,
                pendingCount: pendingCount,
                completionPercent: completionPercent,
              ),
              const SizedBox(height: 22),
              FilterRow(
                totalCount: totalCount,
                todayCount: totalCount,
                workCount: workCount,
                personalCount: personalCount,
              ),
              const SizedBox(height: 20),
              ...pending.map(
                (task) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TaskCard(
                    task: task,
                    onTap: () => onTaskTap(task),
                    onToggle: () => onToggle(task),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'COMPLETED TODAY',
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 1.1,
                      color: ink,
                    ),
                  ),
                  Text(
                    '${completed.length} archived',
                    style: const TextStyle(
                      color: green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...completed.map(
                (task) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TaskCard(
                    task: task,
                    onTap: () => onTaskTap(task),
                    onToggle: () => onToggle(task),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.completedCount,
    required this.pendingCount,
    required this.totalCount,
    required this.completionPercent,
  });

  final int completedCount;
  final int pendingCount;
  final int totalCount;
  final int completionPercent;

  @override
  Widget build(BuildContext context) {
    final progressValue = totalCount == 0 ? 0.0 : completedCount / totalCount;

    return UiCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 43,
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(Icons.trending_up, color: primary),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "TODAY'S PROGRESS",
                    style: TextStyle(fontSize: 13, letterSpacing: 1),
                  ),
                  Text.rich(
                    TextSpan(
                      text: '$completedCount of $totalCount ',
                      style: const TextStyle(fontSize: 25, color: ink),
                      children: const [
                        TextSpan(
                          text: 'completed',
                          style: TextStyle(fontSize: 16, color: muted),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '($completionPercent%)',
                    style: const TextStyle(color: muted),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 13,
              backgroundColor: blue,
              color: const Color(0xff47cfa2),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DotLabel(color: primary, text: '$pendingCount Pending tasks'),
              DotLabel(
                color: const Color(0xff47cfa2),
                text: '$completedCount Completed',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    required this.totalCount,
    required this.todayCount,
    required this.workCount,
    required this.personalCount,
  });

  final int totalCount;
  final int todayCount;
  final int workCount;
  final int personalCount;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        UiPill(label: 'All  $totalCount', color: primary, lightText: true),
        const SizedBox(width: 10),
        UiPill(label: 'Today  $todayCount', color: blue),
        const SizedBox(width: 10),
        UiPill(label: 'Work  $workCount', color: blue),
        const SizedBox(width: 10),
        UiPill(label: 'Personal  $personalCount', color: blue),
      ],
    ),
  );
}

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggle,
  });
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final priorityColor = task.priority == Priority.high
        ? red
        : task.priority == Priority.medium
        ? primary
        : muted;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: UiCard(
        color: task.completed ? pale : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onToggle,
              child: Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: task.completed ? green : blue,
                ),
                child: task.completed
                    ? const Icon(Icons.check, size: 18, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 21,
                            height: 1.35,
                            color: task.completed ? muted : ink,
                            decoration: task.completed
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      if (!task.completed)
                        StatusPill(
                          text:
                              task.priority.name[0].toUpperCase() +
                              task.priority.name.substring(1),
                          color: task.priority == Priority.high
                              ? const Color(0xffffdad6)
                              : blue,
                          foreground: priorityColor,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, color: muted),
                  ),
                  if (!task.completed) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 17),
                        const SizedBox(width: 5),
                        Text(
                          task.date.isNotEmpty && task.time.isNotEmpty
                              ? '${task.date} • ${task.time}'
                              : task.time.isNotEmpty
                              ? task.time
                              : task.date,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 10),
                        StatusPill(
                          text: task.category,
                          color: pale,
                          foreground: primary,
                        ),
                      ],
                    ),
                  ] else ...[
                    const SizedBox(height: 6),
                    Text(task.category, style: const TextStyle(color: muted)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
