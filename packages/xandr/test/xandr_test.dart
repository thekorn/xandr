import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xandr_platform_interface/src/method_channel.dart';

@GenerateNiceMocks([MockSpec<MethodChannelXandr>()])
import 'xandr_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockMethodChannelXandr api;

  setUp(() {
    api = MockMethodChannelXandr();
  });

  test('init', () async {
    when(api.init(123456)).thenAnswer((_) async => true);
    final success = await api.init(123456);
    expect(success, true);
  });
}
