from etl_pipeline import run_pipeline


if __name__ == "__main__":
    input_file = "input.csv"
    output_file = "output.csv"

    run_pipeline(input_file, output_file)

    print("ETL pipeline completed successfully!")