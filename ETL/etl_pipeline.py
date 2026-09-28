import os
import pandas as pd


def extract_data(file_path: str) -> pd.DataFrame:
    """Extract data from a CSV file."""
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"File not found: {file_path}")

    return pd.read_csv(file_path)


def transform_data(df: pd.DataFrame) -> pd.DataFrame:
    """Clean and transform the data."""

    df = df.copy()

    # Fill missing values
    numeric_columns = df.select_dtypes(include=["int64", "float64"]).columns
    categorical_columns = df.select_dtypes(include=["object"]).columns

    for col in numeric_columns:
        df[col] = df[col].fillna(df[col].mean())

    for col in categorical_columns:
        if not df[col].empty:
            df[col] = df[col].fillna(df[col].mode()[0])

    # Remove duplicate rows
    df = df.drop_duplicates()

    # Create full_name if first_name and last_name exist
    if "first_name" in df.columns and "last_name" in df.columns:
        df["full_name"] = (
            df["first_name"].astype(str)
            + " "
            + df["last_name"].astype(str)
        )

    return df


def load_data(df: pd.DataFrame, output_path: str) -> None:
    """Load transformed data into a CSV file."""
    df.to_csv(output_path, index=False)


def run_pipeline(input_path: str, output_path: str) -> None:
    """Execute the complete ETL pipeline."""
    data = extract_data(input_path)
    transformed_data = transform_data(data)
    load_data(transformed_data, output_path)