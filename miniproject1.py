def get_letter_grade(percentage):
    if percentage >= 90:
        return 'A+'
    elif percentage >= 80:
        return 'A'
    elif percentage >= 70:
        return 'B'
    elif percentage >= 60:
        return 'C'
    elif percentage >= 50:
        return 'D'
    else:
        return 'F'

def main():
    print("================================")
    print("  CLI Student Grade Calculator ")
    print("================================\n")

    student_name = input("Enter student name: ").strip()
    
    while True:
        try:
            num_subjects = int(input("Enter number of subjects: "))
            if num_subjects > 0:
                break
            print("Please enter a number greater than 0.")
        except ValueError:
            print("Invalid input. Please enter an integer.")

    subjects = {}
    print("\n Enter Subject Marks (Out of 100)")
    
    for i in range(1, num_subjects + 1):
        name = input(f"Subject {i} name: ").strip() or f"Subject {i}"
        while True:
            try:
                score = float(input(f"Score for {name}: "))
                if 0 <= score <= 100:
                    subjects[name] = score
                    break
                print("Score must be between 0 and 100.")
            except ValueError:
                print("Invalid input. Please enter a valid number.")

    total_score = sum(subjects.values())
    max_score = num_subjects * 100
    percentage = (total_score / max_score) * 100
    overall_grade = get_letter_grade(percentage)

    print(f" PERFORMANCE REPORT: {student_name.upper()}")
    print(f"{'Subject':<20} | {'Score':<10}")
    print("-" * 33)
    
    for sub, score in subjects.items():
        print(f"{sub:<20} | {score:<10.2f}")
        
    print("-" * 33)
    print(f"Total Marks: {total_score:.2f} / {max_score}")
    print(f"Percentage : {percentage:.2f}%")
    print(f"Final Grade: {overall_grade}")
    print("====================================")

if __name__ == "__main__":
    main()