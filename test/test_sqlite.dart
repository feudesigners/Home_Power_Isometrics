import 'dart:ffi';
import 'dart:io';

import 'package:sqlite3/open.dart';

/// Uses the Linux runtime SQLite soname when the unversioned development
/// symlink is not installed. Android tests keep the plugin-provided library.
void configureTestSqlite() {
  if (Platform.isLinux) {
    open.overrideFor(
      OperatingSystem.linux,
      () => DynamicLibrary.open('libsqlite3.so.0'),
    );
  }
}
