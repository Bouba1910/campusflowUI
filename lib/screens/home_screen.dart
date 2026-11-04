import 'package:flutter/material.dart';

import '../data/sample_tasks.dart';
import '../models/task.dart';
import '../utils/date_format.dart';
import 'task_detail_screen.dart';
import 'task_form_screen.dart';

const _tabletBreakpoint = 840.0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = List.of(sampleTasks);
  int _tabIndex = 0;
  int? _selectedTaskId;

  bool get _showCompleted => _tabIndex == 1;

  List<Task> get _visibleTasks =>
      _tasks.where((task) => task.isCompleted == _showCompleted).toList();

  Task? get _selectedTask {
    for (final task in _tasks) {
      if (task.id == _selectedTaskId) {
        return task;
      }
    }
    return null;
  }

  int get _nextTaskId =>
      _tasks.fold(0, (max, task) => task.id > max ? task.id : max) + 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CampusFlow')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= _tabletBreakpoint;
          return isTablet ? _buildTabletLayout() : _buildTaskList(false);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        tooltip: 'Nouvelle échéance',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (index) {
          setState(() {
            _tabIndex = index;
            _selectedTaskId = null;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'À faire',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'Terminées',
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    final selectedTask = _selectedTask;
    return Row(
      children: [
        Expanded(flex: 2, child: _buildTaskList(true)),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 3,
          child: selectedTask == null
              ? const _NoSelection()
              : TaskDetailView(
                  task: selectedTask,
                  onMarkCompleted: selectedTask.isCompleted
                      ? null
                      : () => _markCompletedFromTablet(selectedTask.id),
                ),
        ),
      ],
    );
  }

  Widget _buildTaskList(bool isTablet) {
    final tasks = _visibleTasks;
    if (tasks.isEmpty) {
      return Center(
        child: Text(
          _showCompleted ? 'Aucune échéance terminée.' : 'Aucune échéance.',
        ),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final theme = Theme.of(context);
        final titleStyle = task.isCompleted
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                color: theme.colorScheme.onSurfaceVariant,
              )
            : null;

        return Column(
          children: [
            ListTile(
              selected: isTablet && task.id == _selectedTaskId,
              title: Text(task.title, style: titleStyle),
              subtitle: Text('À rendre le ${formatDueDate(task.dueDate)}'),
              onTap: () => _openTask(task, isTablet),
            ),
            if (index < tasks.length - 1) const Divider(height: 1),
          ],
        );
      },
    );
  }

  void _openTask(Task task, bool isTablet) {
    if (isTablet) {
      setState(() {
        _selectedTaskId = task.id;
      });
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => TaskDetailScreen(
          task: task,
          onCompleted: _markCompleted,
        ),
      ),
    );
  }

  Future<void> _openForm() async {
    final task = await Navigator.of(context).push<Task>(
      MaterialPageRoute<Task>(
        builder: (context) => TaskFormScreen(nextId: _nextTaskId),
      ),
    );
    if (task == null || !mounted) {
      return;
    }
    setState(() {
      _tasks.add(task);
      _tabIndex = 0;
      _selectedTaskId = task.id;
    });
    _showMessage('Échéance ajoutée.');
  }

  void _markCompleted(int id) {
    setState(() {
      final index = _tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        _tasks[index] = _tasks[index].copyWith(isCompleted: true);
      }
    });
  }

  void _markCompletedFromTablet(int id) {
    _markCompleted(id);
    _showMessage('Échéance terminée.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _NoSelection extends StatelessWidget {
  const _NoSelection();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Aucune échéance sélectionnée.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
