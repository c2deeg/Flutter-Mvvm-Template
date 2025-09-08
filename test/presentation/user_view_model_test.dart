import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';
import 'package:mvvm/data/UserModel.dart';
import 'package:mvvm/data/UserRepository.dart';
import 'package:mvvm/ui/getData/UserViewController.dart';
import 'user_view_model_test.mocks.dart';



// Tell Mockito to generate a mock for UserRepository
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;
  late UserViewController viewModel;

  setUp(() {
    mockRepository = MockUserRepository();
    viewModel = UserViewController(repository: mockRepository);
  });

  test('should append users when loadMore is true', () async {
    final fakeUsers1 = [UserModel(id: 1, name: 'John', email: '')];
    final fakeUsers2 = [UserModel(id: 2, name: 'Alice', email: '')];

    when(mockRepository.fetchUsers())
        .thenAnswer((_) async => fakeUsers1);

    await viewModel.getUsers(); // first page

    when(mockRepository.fetchUsers())
        .thenAnswer((_) async => fakeUsers2);

    await viewModel.getUsers(loadMore: true); // second page

    expect(viewModel.users.length, 2); // John + Alice
    expect(viewModel.page, 3);
  });

}
