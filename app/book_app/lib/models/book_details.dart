// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookDetails {
  final String id;
  final String title;
  final String? description;
  final int? pageCount;
  final Uri? previewLink;
  final List<String>? authors;
  final List<String>? categories;
  final String? language;
  final String? publisher;
  final String? publishedDate;
  final String? thumbnail;

  BookDetails({
    required this.id,
    required this.title,
    this.description,
    this.pageCount,
    this.previewLink,
    this.authors,
    this.categories,
    this.language,
    this.publisher,
    this.publishedDate,
    this.thumbnail,
  });
}
