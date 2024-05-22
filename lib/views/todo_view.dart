import 'package:flutter/material.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/model/todo_model.dart';

class PlanWidget extends StatefulWidget {
  const PlanWidget({super.key});

  @override
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  final _planController = PlanController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF),
      appBar: AppBar(
        title: Text(
          'Plans App',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://motionbgs.com/i/c/960x540/media/1397/goku-ultra-instinct_2.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  prefixIcon: Icon(Icons.next_plan_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.draw_outlined),
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF4479FB)),
              ),
              onPressed: () {
                final plan = Plan(
                  id: _planController.planList.length + 1,
                  title: _titleController.text,
                  description: _descriptionController.text,
                );
                _planController.addPlan(plan);
                _titleController.clear();
                _descriptionController.clear();
                setState(() {});
              },
              child: Text(
                'Add Plan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _planController.planList.length,
                itemBuilder: (context, index) {
                  final plan = _planController.planList[index];
                  return ListTile(
                    title: Text(plan.title),
                    subtitle: Text(plan.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          checkColor: Colors.greenAccent,
                          value: plan.isDone,
                          onChanged: (value) {
                            _planController.togglePlanStatus(plan.id);
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.yellow,
                          ),
                          onPressed: () {
                            _titleController.text = plan.title;
                            _descriptionController.text = plan.description;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Update Plan'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: _titleController,
                                      decoration: InputDecoration(
                                        hintText: 'Plan Title',
                                      ),
                                    ),
                                    TextField(
                                      controller: _descriptionController,
                                      decoration: InputDecoration(
                                        hintText: 'Plan Description',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      final newPlan = Plan(
                                        id: plan.id,
                                        title: _titleController.text,
                                        description:
                                            _descriptionController.text,
                                        isDone: plan.isDone,
                                      );
                                      _planController.updatePlan(
                                          plan.id, newPlan);
                                      _titleController.clear();
                                      _descriptionController.clear();
                                      Navigator.of(context).pop();
                                      setState(() {});
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _planController.deletePlan(plan.id);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Done: ${_planController.planList.where((p) => p.isDone).length}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    'Not Done: ${_planController.planList.where((p) => !p.isDone).length}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
