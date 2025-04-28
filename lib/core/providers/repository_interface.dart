/// Interface for building REST based repositories.
abstract class RepositoryInterface<T> {
  const RepositoryInterface();

  Future<List<T>> getAll();
  Future<T> get(dynamic id);
  Future<void> add(T name);
  Future<void> update(T name);
  Future<void> remove(T name);
  Future<void> removeAll();
}

/// Interface for building Real-time repositories (for example Firestore).
abstract class RealTimeRepositoryInterface<T> {
  const RealTimeRepositoryInterface();

  Stream<List<T>> getAll();
  Stream<T> get(dynamic id);
  Future<void> add(T name);
  Future<void> update(T name);
  Future<void> remove(T name);
  Future<void> removeAll();
}
