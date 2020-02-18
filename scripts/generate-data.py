import random
import pandas as pd

# Columns in the dataset.
my_columns = ['site', 'species', 'abundances']

# Fix the random seed to have reproducible results. 
random.seed(42)

print("Generating a new dataset...")

def generate_data():
    """
    Generate entries for the dataset.
    """
    for site_no in range(1, 5):
        site = f"site_A{site_no}"
        for species_code in range(0, 11):
            subspecies = chr(97 + int(species_code))
            species = f"genus sp.{subspecies}"

            abundance = random.randint(0, 42)
            print(f"Added observation: (site={site}, species={species}, abundance={abundance})")
            yield((site, species, abundance))


# Transform the generated data to a dataframe.
species_site_data_frame = pd.DataFrame(generate_data(), columns=my_columns)

# Dump the generated data to the output.
species_site_data_frame.to_csv(snakemake.output[0], index=False)
print("Completed saving dataset as CSV.")

