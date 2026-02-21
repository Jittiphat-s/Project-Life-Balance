import 'package:pedometer/pedometer.dart';

class StepService {
  Stream<StepCount> stepCountStream = Pedometer.stepCountStream;
  Stream<PedestrianStatus> pedestrianStatusStream = Pedometer.pedestrianStatusStream;
}
