import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xandr_ios/src/messages.g.dart';

@GenerateNiceMocks([MockSpec<XandrHostApi>()])
import 'xandr_ios_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockXandrHostApi api;

  setUp(() {
    api = MockXandrHostApi();
  });

  test('initXandrSdk', () async {
    when(
      api.initXandrSdk(memberId: 123456),
    ).thenAnswer((_) async => true);
    final success = await api.initXandrSdk(memberId: 123456);
    expect(success, true);
  });
}
