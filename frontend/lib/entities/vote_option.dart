class VoteOption {
  final String id;
  final String text;
  int voteCount;

  VoteOption({
    required this.id,
    required this.text,
    this.voteCount = 0,
  });
}
