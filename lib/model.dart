import 'dart:convert';

class SpacesModel {
  final int? count;
  final String? next;
  final dynamic previous;
  final List<Results>? results;

  SpacesModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory SpacesModel.fromJson(Map<String, dynamic> json) {
    return SpacesModel(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'],
      results: (json['results'] as List?)
          ?.map((dynamic e) =>
          Results.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'next': next,
    'previous': previous,
    'results': results?.map((e) => e.toJson()).toList()
  };
}

class Results {
  final int? id;
  final String? title;
  final String? url;
  final String? imageUrl;
  final String? newsSite;
  final String? summary;
  final String? publishedAt;
  final String? updatedAt;
  final bool? featured;
  final List<dynamic>? launches;
  final List<dynamic>? events;

  Results({
    this.id,
    this.title,
    this.url,
    this.imageUrl,
    this.newsSite,
    this.summary,
    this.publishedAt,
    this.updatedAt,
    this.featured,
    this.launches,
    this.events,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'] as int?,
      title: utf8.decode(json['title'].toString().codeUnits),
      url: json['url'] as String?,
      imageUrl: json['image_url'] as String?,
      newsSite: json['news_site'] as String?,
      summary: utf8.decode(json['summary'].toString().codeUnits),
      publishedAt: json['published_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      featured: json['featured'] as bool?,
      launches: json['launches'] as List?,
      events: json['events'] as List?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'url': url,
    'image_url': imageUrl,
    'news_site': newsSite,
    'summary': summary,
    'published_at': publishedAt,
    'updated_at': updatedAt,
    'featured': featured,
    'launches': launches,
    'events': events
  };
}