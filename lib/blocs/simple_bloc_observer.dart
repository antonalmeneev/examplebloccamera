import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    print(error);

    super.onError(bloc, error, stackTrace);
  }
  // void onError(Cubit cubit, Object error, StackTrace stackTrace) {
  //   print(error);
  //   super.onError(cubit, error, stackTrace);
  // }
}