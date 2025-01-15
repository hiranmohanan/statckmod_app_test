part of '../home_view.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  late final HomeProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<HomeProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _taskController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return Container(
      padding: EdgeInsets.all(16.sp),
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
        return Form(
          key: formkey,
          child: Column(
            children: [
              appTextFields(
                controller: _taskController,
                hintText: Kstrings.tasks,
                icon: Icons.task,
                obscureText: false,
                onChanged: (value) {
                  provider.setTaksTitle(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Kstrings.taskTitleIsEmpty;
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              appTextFields(
                controller: _taskDescriptionController,
                hintText: Kstrings.taskDescription,
                icon: Icons.description,
                obscureText: false,
                onChanged: (value) {
                  provider.setTaskDescription(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Kstrings.taskDescriptionIsEmpty;
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: TextEditingController()
                  ..text = provider.dueDate.toString().split(' ')[0],
                decoration: InputDecoration(
                  hintText: Kstrings.taskDueDate,
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  counterText: '',
                  icon: Icon(Icons.date_range),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Kstrings.taskDueDateIsEmpty;
                  }
                  return null;
                },
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2022),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2026),
                  );
                  if (date != null) {
                    _taskController.text =
                        date.toLocal().toString().split(' ')[0];
                  }
                  provider.setDueDate(date ?? DateTime.now());

                  debugPrint(date.toString());
                },
              ),
              vSizedBox0,
              Text(Kstrings.taskPriority),
              vSizedBox0,
              DropdownButton(
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: TaskPriority.low,
                      child: Text(Kstrings.low),
                    ),
                    DropdownMenuItem(
                      value: TaskPriority.medium,
                      child: Text(Kstrings.medium),
                    ),
                    DropdownMenuItem(
                      value: TaskPriority.high,
                      child: Text(Kstrings.high),
                    ),
                  ],
                  onChanged: (value) {
                    provider.setPriority(value!);
                  },
                  value: provider.priority),
              CheckboxListTile.adaptive(
                value: provider.status == TaskStatus.completed,
                onChanged: (value) {
                  provider.setStatus();
                },
                title: Text(Kstrings.taskStatus),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate() &&
                      provider.priority != null &&
                      provider.status != null) {
                    await provider.addTask(
                      Task(
                        title: provider.taskName!,
                        description: provider.taskDescription!,
                        dueDate: provider.dueDate!.toString(),
                        priority: provider.priority!.name,
                        status: provider.status!.name,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(Kstrings.addTask),
              )
            ],
          ),
        );
      }),
    );
  }
}
