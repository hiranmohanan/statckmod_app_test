part of 'widgets.dart';

taskTile(
    {required Task task,
    Function? onTap,
    required BuildContext context,
    required bool val}) {
  final provider = Provider.of<HomeProvider>(context, listen: false);
  return CheckboxListTile.adaptive(
      onChanged: (value) {},
      value: val,
      title: Text(task.title),
      subtitle: Column(
        children: [
          RichText(
              text: TextSpan(
            text: 'Due Date: ',
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: task.dueDate,
                style: TextStyle(color: Colors.grey),
              ),
              TextSpan(
                text: '\nStatus: ${task.status}',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(text: '\nPriority ${task.priority}')
            ],
          )),
          ElevatedButton(
              onPressed: () {
                provider.updateTask(task.copyWith(
                  status: 'completed',
                ));
              },
              child: Text(Kstrings.taskCompleted))
        ],
      ));
}
