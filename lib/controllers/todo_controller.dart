import 'package:todo_app/model/todo_model.dart';

class PlanController {
  final List<Plan> _planList = [];

  void addPlan(Plan plan) {
    _planList.add(plan);
  }

  void updatePlan(int id, Plan newPlan) {
    final plan = _findPlanById(id);
    plan.title = newPlan.title;
    plan.description = newPlan.description;
    plan.isDone = newPlan.isDone;
  }

  void deletePlan(int id) {
    final plan = _findPlanById(id);
    _planList.remove(plan);
  }

  void togglePlanStatus(int id) {
    final plan = _findPlanById(id);
    plan.isDone = !plan.isDone;
  }

  List<Plan> get planList => _planList;

  Plan _findPlanById(int id) {
    return _planList.firstWhere((p) => p.id == id);
  }
}