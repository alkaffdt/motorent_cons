import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = Provider<String>((ref) {
  return 'Hello from Riverpod!';
});
