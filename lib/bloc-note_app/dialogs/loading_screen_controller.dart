typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingSreen = bool Function(String);

class LoadinScreenController {
  final CloseLoadingScreen closeLoadingScreen;
  final UpdateLoadingSreen updateLoadingSreen;

  LoadinScreenController(
      {required this.closeLoadingScreen, required this.updateLoadingSreen});
}
