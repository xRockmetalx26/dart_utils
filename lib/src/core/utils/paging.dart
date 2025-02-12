// Package imports:
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// Project imports:
import 'package:dart_utils/src/core/data/models/listing.dart';
import 'package:dart_utils/src/core/utils/lists.dart';
import 'package:dart_utils/src/core/utils/debouncer.dart';

final class Paging<T> {
  Paging({
    required this.count,
    int delayMilliseconds = 500,
  }) : _debouncer = Debouncer(milliseconds: delayMilliseconds);

  // Controller
  final controller = PagingController<int, T>(
    firstPageKey: 1,
    invisibleItemsThreshold: 2,
  );

  // Control
  final int count;
  var page = 1;
  var _isLastPage = false;
  final Debouncer _debouncer;

  // Core
  bool get isEmpty => controller.itemList?.isEmpty ?? true;
  bool get isNotEmpty => controller.itemList?.isNotEmpty ?? false;
  List<T>? get values => controller.itemList;

  // Querys
  var _criteria = '';
  String get criteria => _criteria;
  set criteria(String criteria) {
    if (criteria == _criteria) return;

    _criteria = criteria;
    page = 1;

    _debouncer.run(() => controller.refresh());
  }

  String _sort = '';
  String get sort => _sort;
  set sort(String sort) {
    if (sort == _sort) return;

    _sort = sort;
    page = 1;

    _debouncer.run(() => controller.refresh());
  }

  String _filter = '';
  String get filter => _filter;
  set filter(String filter) {
    if (filter == _filter) return;

    _filter = filter;
    page = 1;

    _debouncer.run(() => controller.refresh());
  }

  void dispose() {
    _debouncer.cancel();
    controller.dispose();
  }

  /// Agrega un `Listing<T>` a la paginación.
  void addPage({required Listing<T> listing}) {
    _isLastPage = listing.length < count;
    page++;

    if (_isLastPage) {
      controller.appendLastPage(listing.values);
    } else {
      controller.appendPage(listing.values, page);
    }
  }

  void addPageRequestListener(void Function(int) listener) =>
      controller.addPageRequestListener(listener);

  /// Agrega un valor en memoria [item], pero no lo agrega de forma remota.
  void add(T item) {
    controller.itemList = [
      item,
      if (controller.itemList is List) ...controller.itemList!,
    ];
  }

  /// Reemplaza un valor en memoria [oldItem] con [newItem],
  /// pero no lo reemplaza de forma remota.
  bool replace(T oldItem, T newItem) {
    if (controller.itemList.isBlank) return false;

    final index = controller.itemList!.indexOf(oldItem);
    if (index == -1) return false;

    controller.itemList![index] = newItem;
    return true;
  }

  /// Elimina un valor en memoria [item], pero no lo reemplaza de forma remota,
  /// para usar este método, debes asegurarte de enviar el parametro [remoteChange] = `true`.
  bool delete(T item) {
    if (controller.itemList.isBlank) return false;

    final deleted = controller.itemList!.remove(item);
    return deleted;
  }

  /// Refresca completamente la paginación.
  ///
  /// [resetQuerys] = `true` para resetear los querys.
  void refresh({bool resetQuerys = false}) {
    page = 1;

    if (resetQuerys) {
      _criteria = '';
      _sort = '';
      _filter = '';
    }

    controller.refresh();
  }
}
