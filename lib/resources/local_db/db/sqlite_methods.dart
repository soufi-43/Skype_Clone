import 'package:skypeclone/models/log.dart';
import 'package:skypeclone/resources/local_db/interface/log_interface.dart';

class SqliteMethods implements LogInterface{
  @override
  addLogs(Log log) {
    print('add values to sqlite db');

    return null;
  }

  @override
  close() {
    // TODO: implement close
    return null;
  }

  @override
  deleteLogs(int logId) {
    // TODO: implement deleteLogs
    return null;
  }

  @override
  Future<List<Log>> getLogs() {
    // TODO: implement getLogs
    return null;
  }

  @override
  init() {
    print('initialzed sqlite db');

    return null;
  }

}