// class Initializer {
//   final int id;
//   final String description;
//   final String image;
//   Initializer(this.id, this.description, {required this.image});
// }

class Initializer {
  final int id;
  final String title;
  final String description1;
  final String description2;

  final String image;

  Initializer(
    this.id, {
    required this.title,
    required this.description1,
    required this.description2,
    required this.image,
  });
}

final List<Initializer> Initials = [
  Initializer(1,
      title: "Fast and Secure Quizer",
      description1: "Expand your knowledge with quizzes and challenges",
      description2: "Test yourself with our diverse range of topics",
      image: 'assets/first_preview1.png'),
  Initializer(2,
      title: "Numerous Free Quizes",
      description1: "Feed your curiosity, Explore countless free quizzes",
      description2: "Satisfy your hunger for knowledge ",
      image: 'assets/second_preview1.png'),
  Initializer(3,
      title: "Available anytime",
      description1: "Discover helpful quizzes tailored to your interests",
      description2: "Delightful knowledge through sweet quizzes.",
      image: 'assets/third_preview1.png'),
];
