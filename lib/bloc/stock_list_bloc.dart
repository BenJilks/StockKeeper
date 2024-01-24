import 'package:stock_keeper/data/stock_item.dart';
import 'package:stock_keeper/data/stock_repository.dart';

class StockListBloc {
  final StockRepository repository;
  StockListBloc({ required this.repository });

  Stream<List<StockItem>> get stock => repository.stock;

  void updateCount(StockItem item, int count) {
    repository.update(item.update(count: count));
  }
}