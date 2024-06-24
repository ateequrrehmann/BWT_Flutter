import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_4_todo_app_using_sqlite/Database/DBHelperClass.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late String _priorityController = "1";
  late String _statusController = "Pending";
  final TextEditingController _completionDateController = TextEditingController();
  bool isChecked = false;
  TextEditingController _timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> _tasks = [];
  List<Map<String, dynamic>> _pendingTasks = [];
  List<Map<String, dynamic>> _completedTasks = [];
  bool _isLoading = true;

  void _refreshTasks() async {
    final data = await SQLHelper.getTasks();
    setState(() {
      _isLoading = false;
      _tasks = data;
      _pendingTasks = _tasks.where((task) => task['status'] == 'Pending').toList();
      _completedTasks = _tasks.where((task) => task['status'] == 'Completed').toList();
      print(_tasks);
      print("...number of items ${_tasks.length}");
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Index',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _pendingTasks.length,
              itemBuilder: (context, index) => Card(
                color: Color(0xFF363636),
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Text(
                    _pendingTasks[index]['title'],
                    style: TextStyle(color: Color(0xDEFFFFFF), fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _pendingTasks[index]['completionDate'],
                        style: TextStyle(color: Color(0xDEFFFFFF)),
                      ),
                      Text(
                        _pendingTasks[index]['time'],
                        style: TextStyle(color: Color(0xDEFFFFFF)),
                      ),
                    ],
                  ),
                  leading: Checkbox(
                    shape: CircleBorder(),
                    activeColor: Colors.white,
                    side: BorderSide(color: Colors.white),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _statusController = "Completed";
                          _titleController.text = _pendingTasks[index]['title'];
                          _descriptionController.text = _pendingTasks[index]['description'];
                          _updateTask(_pendingTasks[index]['id']);
                        } else {
                          _statusController = "Pending";
                          _updateTask(_pendingTasks[index]['id']);
                        }
                      });
                    },
                    value: _pendingTasks[index]['status'] == "Completed",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.flag_fill,
                            color: Color(0xFFE8E8E8),
                            size: 20,
                          ),
                          SizedBox(width: 2),
                          Text(
                            _pendingTasks[index]['priority'],
                            style: TextStyle(color: Color(0xFFE8E8E8)),
                          ),
                        ],
                      ),
                      SizedBox(width: 6),
                      IconButton(
                        onPressed: () => taskForm(_pendingTasks[index]['id']),
                        icon: Icon(
                          Icons.edit,
                          color: Color(0xDEFFFFFF),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(width: 0),
                      IconButton(
                        onPressed: () => _deleteItem(_pendingTasks[index]['id']),
                        icon: Icon(
                          CupertinoIcons.delete_solid,
                          color: Color(0xDEFFFFFF),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_completedTasks.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Completed Tasks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _completedTasks.length,
              itemBuilder: (context, index) => Card(
                color: Color(0xFF363636),
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Text(
                    _completedTasks[index]['title'],
                    style: TextStyle(color: Color(0xDEFFFFFF), fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _completedTasks[index]['completionDate'],
                        style: TextStyle(color: Color(0xDEFFFFFF)),
                      ),
                      Text(
                        _completedTasks[index]['time'],
                        style: TextStyle(color: Color(0xDEFFFFFF)),
                      ),
                    ],
                  ),
                  leading: Checkbox(
                    shape: CircleBorder(),
                    activeColor: Colors.white,
                    side: BorderSide(color: Colors.white),
                    onChanged: null,
                    value: true,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.flag_fill,
                            color: Color(0xFFE8E8E8),
                            size: 20,
                          ),
                          SizedBox(width: 2),
                          Text(
                            _completedTasks[index]['priority'],
                            style: TextStyle(color: Color(0xFFE8E8E8)),
                          ),
                        ],
                      ),
                      SizedBox(width: 6),
                      IconButton(
                        onPressed: () => taskForm(_completedTasks[index]['id']),
                        icon: Icon(
                          Icons.edit,
                          color: Color(0xDEFFFFFF),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(width: 0),
                      IconButton(
                        onPressed: () => _deleteItem(_completedTasks[index]['id']),
                        icon: Icon(
                          CupertinoIcons.delete_solid,
                          color: Color(0xDEFFFFFF),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,

      floatingActionButton: FloatingActionButton(
        onPressed: () => taskForm(null),
        child: Icon(CupertinoIcons.add),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF8687E7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        tooltip: 'Add Task',
      ),
    );
  }

  void taskForm(int? id) async {
    if (id != null) {
      final existingTasks = _tasks.firstWhere((element) => element['id'] == id);
      _titleController.text = existingTasks['title'];
      _descriptionController.text = existingTasks['description'];
      _priorityController = existingTasks['priority'];
      _completionDateController.text = existingTasks['completionDate'];
      _timeController.text = existingTasks['time'];
    }
    showModalBottomSheet<dynamic>(
      backgroundColor: Color(0xFF363636),
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.8, // Takes half of the screen
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                        color: Color(0xDEFFFFFF),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title can\'t be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle:
                              TextStyle(color: Color(0xDEFFFFFF), fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          enabledBorder: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color(0xDEFFFFFF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle:
                              TextStyle(color: Color(0xDEFFFFFF), fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          enabledBorder: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color(0xDEFFFFFF),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: _showTimePicker,
                          icon: Icon(
                            CupertinoIcons.timer,
                            color: Color(0xDEFFFFFF),
                          ),
                        ),
                        IconButton(
                          onPressed: _selectData,
                          icon: Icon(
                            CupertinoIcons.tag,
                            color: Color(0xDEFFFFFF),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xFF363636),
                                      title: Text(
                                        'Task Priority',
                                        style:
                                            TextStyle(color: Color(0xDEFFFFFF)),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: 10,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                            ),
                                            itemBuilder: (context, index) {
                                              int priority = index + 1;
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _priorityController =
                                                        priority.toString();
                                                    print(
                                                        'Selected Priority: $_priorityController');
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: priority
                                                                .toString() ==
                                                            _priorityController
                                                        ? CupertinoColors
                                                            .systemBlue
                                                        : CupertinoColors
                                                            .systemGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      // crossAxisAlignment:
                                                      //     CrossAxisAlignment
                                                      //         .center,
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .flag_fill,
                                                          color: priority
                                                                      .toString() ==
                                                                  _priorityController
                                                              ? CupertinoColors
                                                                  .white
                                                              : CupertinoColors
                                                                  .black,
                                                        ),
                                                        Text(
                                                          '$priority',
                                                          style: TextStyle(
                                                            color: priority
                                                                        .toString() ==
                                                                    _priorityController
                                                                ? CupertinoColors
                                                                    .white
                                                                : CupertinoColors
                                                                    .black,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Close the dialog
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text('Save'),
                                          onPressed: () {
                                            // _priorityController =
                                            //     priority.toString();
                                            // Handle save action if needed
                                            print('Saved Priority: $_priorityController');
                                            Navigator.pop(
                                                context); // Close the dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          icon: Icon(
                            CupertinoIcons.flag_fill,
                            color: Color(0xDEFFFFFF),
                          ),
                        ),
                        SizedBox(
                          width: 135,
                        ),
                        IconButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if(id==null){
                                await _addTask();
                                Navigator.pop(context);
                                _messageForm("Task Added Successfully");
                                _titleController.text='';
                                _descriptionController.text='';
                              }
                              if(id!=null){
                                await _updateTask(id);
                                Navigator.pop(context);
                                _messageForm("Task Updated Successfully");
                                _titleController.text='';
                                _descriptionController.text='';
                              }

                            }
                          },
                          icon: Icon(
                            CupertinoIcons.arrowtriangle_right_fill,
                            color: Color(0xDEFFFFFF),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showTimePicker() async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        final formattedTime = value.format(context);
        setState(() {
          _timeController.text = formattedTime;
          print(_timeController.text);
        });
      }
    });
  }

  Future<void> _selectData() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        _completionDateController.text = _picked.toString().split(" ")[0];
        print(_completionDateController.text);
      });
    }
  }

  Future<void> _addTask() async{
    await SQLHelper.createTasks(_titleController.text, _descriptionController.text, _completionDateController.text, _timeController.text, _priorityController, _statusController);
    _refreshTasks();
    print("...number of items ${_tasks.length}");

  }

  Future<void> _updateTask(int id) async{
    await SQLHelper.updateTasks(id, _titleController.text, _descriptionController.text, _completionDateController.text, _timeController.text, _priorityController, _statusController);
    _refreshTasks();
  }

  void _deleteItem(int id) async{
    await SQLHelper.deleteTasks(id);
    _messageForm("Successfully deleted the task");
    _refreshTasks();
  }

  void _messageForm(String? message){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (context, setState){
                return AlertDialog(
                  title: Text('$message', style: TextStyle(color: Color(0xDEFFFFFF)),),
                  backgroundColor: Color(0xFF363636),
                  actions: [
                    ElevatedButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.pop(
                            context); // Close the dialog
                      },
                    ),
                  ],
                );

              }
          );
        }
    );
  }
}
