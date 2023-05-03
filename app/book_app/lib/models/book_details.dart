class BookDetails {
  final String id;
  final String title;
  final String? description;
  final int? pageCount;
  final String? previewLink;
  final List<String>? authors;
  final List<String>? categories;
  final String? thumbnail;

  BookDetails({
    required this.id,
    required this.title,
    this.description,
    this.pageCount,
    this.previewLink,
    this.authors,
    this.categories,
    this.thumbnail,
  });
}
