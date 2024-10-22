enum NavEnum {
  search('search_bold'),
  sms('chat'),
  home('home'),
  favorite('like'),
  profile('user');

  final String icon;

  const NavEnum(this.icon);
}

extension NavEnumX on NavEnum {
  bool get isSearch => this == NavEnum.search;
  bool get isSms => this == NavEnum.sms;
  bool get isHome => this == NavEnum.home;
  bool get isFavorite => this == NavEnum.favorite;
  bool get isProfile => this == NavEnum.profile;
}
