abstract class IRepository<T> {
  void add(T item);
  void remove(T item);
  List<T> getAll();
}

// Implémentation générique
class Repository<T> implements IRepository<T> {
  final List<T> _items = [];

  @override
  void add(T item) => _items.add(item);

  @override
  void remove(T item) => _items.remove(item);

  @override
  List<T> getAll() => _items;
}
