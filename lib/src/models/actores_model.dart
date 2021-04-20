//movie/{movie_id}/credits

// https://api.themoviedb.org/3/movie/583083/credits?api_key=ec790c78f61b73fbbe086c1a6987a1f5

class Cast {
  List<Actor> items = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }

    jsonList.forEach((element) {
      final actor = Actor.fromJsonMap(element);
      items.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;

  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id']; //.cast<int>();
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender']; //.cast<int>();
    id = json['id']; //.cast<int>();
    name = json['name'];
    order = json['order']; //.cast<int>();
    profilePath = json['profile_path'];
  }

  getPosterImg() {
    if (profilePath == null) {
      return 'https://www.risimaging.com/wp-content/uploads/2015/06/staff-no-avatar-male.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
