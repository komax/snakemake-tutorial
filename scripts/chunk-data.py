import numpy as np
import pandas as pd

# Read the csv into a dataframe.
dataset = pd.read_csv(snakemake.input.dataset)
# Chop the dataframe to #chunks pieces
chunks = np.array_split(dataset, snakemake.params.chunks)

# Write these chunks to the output files.
for chunk, filename in zip(chunks, snakemake.output.dataset_chunks):
    chunk.to_csv(filename, index=False)