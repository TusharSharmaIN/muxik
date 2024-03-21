import '../../domain/entities/song.dart';

class SongModel extends Song {
  SongModel({
    required super.id,
    required super.title,
    required super.album,
    required super.url,
    required super.imageUrl,
  });

  static List<SongModel> songs = [
    SongModel(
      id: '101-Jhoome Jo',
      title: 'Jhoome Jo',
      album: 'Pathan',
      url: 'https://musicapi.x007.workers.dev/fetch?id=2a37574c32aec09eb7c27a374077fbe406ef2057c0e8954c1fdd06b71929428a',
      imageUrl: 'https://hls-server.vercel.app/img/bda83bc724a5cef6ae1ba1dfbdedb17dd2e5babb1a78bf42d19626f871fcc3ed5604495ab49e2b6c65ea0648a3b77637b0998fd8ef17afd184405bf4709fa3e78200cfab268d039f8bc3f757bbf78f0853c38bf46ae5b8c7b1b98fd14388e0619cb720fc9e759807adc69af1b03c0f40a9da5eba7369c3ace7ac3485001f33c6994a681a4cefbc90f67e1849ce4dcdc5',
    ),
    SongModel(
      id: '102-Iktaara',
      title: 'Iktaara',
      album: 'Wake Up Sid!',
      url: 'https://musicapi.x007.workers.dev/fetch?id=1932545d4cfa71d338198e0d7378011a65b0b0dbfec51d447751886e948f49d8',
      imageUrl: 'https://hls-server.vercel.app/img/bda83bc724a5cef6ae1ba1dfbdedb17dd2e5babb1a78bf42d19626f871fcc3edf4da7b89f5ad6eb5074b75bbad3d8d382baeacd1373b52240bcf77a802d911c3fe57319bdead221ffebc2cc38ff0184988bd889c6041b40ba360375ce37a29b54d62dbe10f105bb12db2253f188c27d03358c7f8ddda22578a50927b0029619a05503e6ddb9d7fb29c3cb625698542d5',
    ),
    SongModel(
      id: '103-Matargashti',
      title: 'Matargashti',
      album: 'Tamasha',
      url: 'https://musicapi.x007.workers.dev/fetch?id=44c3e546058472f4cfabd6f69a9716b310fa03817e46df1cf70ad71237721b41',
      imageUrl: 'https://hls-server.vercel.app/img/bda83bc724a5cef6ae1ba1dfbdedb17dd2e5babb1a78bf42d19626f871fcc3edeb01fd85a1063171954a079dd0d609e826faa329e01869fe2481e7fe6f0352d2bbad3b301908d858c08d6f0cee9a4393787559726ae6d2ec5a54040647c126885304dddc0d55f77952e6acc54297805e148a6b4f6909151ca245a80b3687ae20ba6f54166dbaa96b015b7718a7b175c0',
    )
  ];

  Map<String, dynamic> toJson() {
    //  todo: can be added language an singer field here
    return <String, dynamic>{
      'id': id,
      'title': title,
      'album': album,
      'url': url,
      'imageUrl': imageUrl,
    };
  }

  factory SongModel.fromJson(Map<String, dynamic> json) {
    //  todo: can be added language an singer field here
    return SongModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      album: json['album'] ?? "",
      url: json['url'] ?? "",
      imageUrl: json['image_url'] ?? "",
    );
  }
}
