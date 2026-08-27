/// Fake data local — chưa cần API hay state management.
class ProfileData {
  const ProfileData({
    required this.name,
    required this.email,
    required this.job,
    required this.posts,
    required this.followers,
    required this.following,
    required this.bio,
  });

  final String name;
  final String email;
  final String job;
  final int posts;
  final int followers;
  final int following;
  final String bio;
}

const fakeProfile = ProfileData(
  name: 'Alex Nguyen van a',
  email: 'alex@example.com',
  job: 'Flutter Learner',
  posts: 42,
  followers: 10000000,
  following: 180,
  bio: 'Dang hoc Flutter layout: Row, Column, Stack, Expanded. Dang hoc Flutter layout: Row, Column, Stack, Expanded. Dang hoc Flutter layout: Row, Column, Stack, Expanded.',
);
