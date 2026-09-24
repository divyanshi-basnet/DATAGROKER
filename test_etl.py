import os
import unittest
import pandas as pd

from etl_pipeline import (
    extract_data,
    transform_data,
    load_data,
)


class TestETLPipeline(unittest.TestCase):

    def setUp(self):
        """Create test data before each test."""

        self.input_file = "test_input.csv"
        self.output_file = "test_output.csv"

        self.sample_data = pd.DataFrame({
            "first_name": ["John", "Jane", "John", None],
            "last_name": ["Doe", "Smith", "Doe", "Brown"],
            "age": [25, 30, 25, 22],
            "city": ["New York", "London", "New York", "Paris"]
        })

        self.sample_data.to_csv(
            self.input_file,
            index=False
        )

    def tearDown(self):
        """Remove test files after each test."""

        for file in [self.input_file, self.output_file]:
            if os.path.exists(file):
                os.remove(file)

    def test_extract_data(self):
        """Test that data is correctly extracted."""

        df = extract_data(self.input_file)

        self.assertEqual(len(df), 4)
        self.assertIn("first_name", df.columns)
        self.assertIn("last_name", df.columns)

    def test_extract_missing_file(self):
        """Test behavior when input file doesn't exist."""

        with self.assertRaises(FileNotFoundError):
            extract_data("does_not_exist.csv")

    def test_transform_data(self):
        """Test cleaning and transformation."""

        df = transform_data(self.sample_data)

        # Missing value should be filled
        self.assertFalse(df["first_name"].isnull().any())

        # Duplicate row should be removed
        self.assertEqual(len(df), 3)

        # New column should be created
        self.assertIn("full_name", df.columns)

    def test_load_data(self):
        """Test that transformed data is written correctly."""

        df = transform_data(self.sample_data)

        load_data(df, self.output_file)

        self.assertTrue(os.path.exists(self.output_file))

        loaded_df = pd.read_csv(self.output_file)

        self.assertEqual(len(loaded_df), 3)
        self.assertIn("full_name", loaded_df.columns)


if __name__ == "__main__":
    unittest.main()