import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xandr_android/src/messages.g.dart';

@GenerateNiceMocks([MockSpec<XandrHostApi>()])
import 'xandr_android_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockXandrHostApi api;

  setUp(() {
    api = MockXandrHostApi();
  });

  test('init', () async {
    when(
      api.init(memberId: 123456),
    ).thenAnswer((_) async => true);
    final success = await api.init(memberId: 123456);
    expect(success, true);
  });
}
