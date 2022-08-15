class AppState {
  final List<String> cities;
  final String? onDoneMessage;
  AppState.empty()
      : cities = [],
        onDoneMessage = null;
  AppState({
    required this.cities,
    this.onDoneMessage,
  });

 AppState copyWith({List<String>? cities, String? onDoneMessage}) {
    return AppState(
        cities: cities ?? this.cities,
        onDoneMessage: onDoneMessage ?? this.onDoneMessage);
  }
}
