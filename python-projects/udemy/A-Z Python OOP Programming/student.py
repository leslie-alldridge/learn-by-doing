class Student:
    def __init__(self, name: str, roll_number: int, marks: int) -> None:
        self.name = name
        self.roll_number = roll_number
        self.marks = marks

    def result(self) -> str:
        return 'Pass' if self.marks > 500 else 'Fail'

student1 = Student('Leslie', 12, 200)
print(student1.result())
