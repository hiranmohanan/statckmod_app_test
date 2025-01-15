import 'package:flutter/material.dart';
import 'package:statckmod_app/constants/constants.dart';
import 'package:statckmod_app/models/models.dart';

import '../../../widgets/widgets.dart';

class TaskView extends StatelessWidget {
  const TaskView({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
    required this.taks,
  });

  final String title;
  final String count;
  final Color color;
  final IconData icon;
  final List<Task> taks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Hero(
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
          vSizedBox1,
          ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: taks.length,
              itemBuilder: (context, index) {
                return taskTile(
                    task: taks[index], context: context, val: false);
              })
        ],
      ),
    );
  }
}
