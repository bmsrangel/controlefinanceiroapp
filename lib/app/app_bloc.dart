import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controlefinanceiroapp/app/shared/services/secure_storage_service.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  final SecureStorageService storage;

  BehaviorSubject<bool> isLogged = BehaviorSubject<bool>();
  Stream<bool> get outIsLogged => isLogged.stream;
  Sink<bool> get inIsLogged => isLogged.sink;

  AppBloc(this.storage) {
    _init();
  }

  _init() async {
    String uid = await storage.getUid();
    DateTime expirationTime = await storage.getExpirationTime();
    int timeDiff = expirationTime != null
        ? expirationTime.millisecondsSinceEpoch -
            DateTime.now().millisecondsSinceEpoch
        : null;
    if (uid == null || timeDiff == null || timeDiff < 0) {
      isLogged.sink.add(false);
    } else {
      isLogged.sink.add(true);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    isLogged.close();
    super.dispose();
  }
}
