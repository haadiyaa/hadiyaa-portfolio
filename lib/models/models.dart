class Stat {
  final String value, label;
  const Stat(this.value, this.label);
}

class Job {
  final String role, org, when;
  final List<String> points;
  const Job(this.role, this.org, this.when, [this.points = const []]);
}

class Project {
  final String name, kind, desc;
  final List<String> tags;
  const Project(this.name, this.kind, this.desc, this.tags);
}

class StackGroup {
  final String label;
  final List<String> items;
  const StackGroup(this.label, this.items);
}
