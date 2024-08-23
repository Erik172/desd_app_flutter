String generateId({required String path, required List<String> models}) {
  String id = '${path.replaceAll('\\', '_!1_')}__(';
  for (final model in models) {
    id += '$model,';
  }
  id = id.substring(0, id.length - 1);
  id += ')';

  return id;
}
