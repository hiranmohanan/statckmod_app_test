import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:statckmod_app/constants/constants.dart';
import 'package:statckmod_app/feature/home/provider/home_provider.dart';
import 'package:statckmod_app/services/firebase_services.dart';
import 'package:statckmod_app/widgets/widgets.dart';

import '../../../models/models.dart';
import '../../../utl/utl.dart';
import '../../tasks/view/task_view.dart';

part 'widgets/dashboard_element.dart';
part 'widgets/add_task.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().initialize();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(Kstrings.home),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          Switch.adaptive(
              value: context.watch<ThemeProvider>().isDarkMode,
              onChanged: (value) {
                context.read<ThemeProvider>().setThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
              }),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuthService().signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => AddTask());
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<HomeProvider>(builder: (context, provider, child) {
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            provider.initialize();
          },
          child: ListView(
            children: [
              Text(
                Kstrings.dashboard,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              vSizedBox1,
              _buildDashboardCard(
                context,
                title: Kstrings.taskPending,
                count: provider.pendingTask.length.toString(),
                color: Colors.orange,
                icon: Icons.pending_actions,
                task: provider.pendingTask,
              ),
              _buildDashboardCard(
                context,
                title: Kstrings.taskCompleted,
                count: provider.completedTask.length.toString(),
                color: Colors.green,
                icon: Icons.check_circle,
                task: provider.completedTask,
              ),
              _buildDashboardCard(context,
                  title: Kstrings.taskInProgress,
                  count: provider.inCompletedTask.length.toString(),
                  color: Colors.blue,
                  icon: Icons.work,
                  task: provider.pendingTask),
              _buildDashboardCard(
                context,
                title: Kstrings.taskOverdue,
                count: provider.dueTask.length.toString(),
                color: Colors.red,
                icon: Icons.error,
                task: provider.dueTask,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [],
                ),
              ),
              vSizedBox1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Kstrings.tasks,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Checkbox.adaptive(
                      value: provider.tasks == provider.completedTask,
                      onChanged: (v) {
                        provider.setTaksList(v: v!, tasks: provider.tasks);
                      })
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Kstrings.filterByDate,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (selectedDate != null) {
                          provider.filterTasksByDate(selectedDate);
                        }
                      },
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    return taskTile(
                      task: provider.tasks[index],
                      context: context,
                      val: false,
                    );
                  }),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required String count,
    required Color color,
    required IconData icon,
    required List<Task> task,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TaskView(
            title: title,
            count: count,
            color: color,
            icon: icon,
            taks: task,
          );
        }));
      },
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            key: ValueKey(title),
            tag: title,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 40),
                SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  count,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
