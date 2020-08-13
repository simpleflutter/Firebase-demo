class Employee {
  String name;
  String post;
  int salary;

  Employee({this.name, this.post, this.salary});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['name'] = this.name;
    map['post'] = this.post;
    map['salary'] = this.salary;

    return map;
  }
}
