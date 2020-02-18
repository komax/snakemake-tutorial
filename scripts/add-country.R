# Be reproducible by fixing a random seed. 
set.seed(42)

print("Adding countries...")

# The countries of which we sample.
countries <- c("Iceland", "Australia", "Germany", "US", "Japan", "Canada", "South Africa", "China")

# Read the csv into a dataframe.
my_data <- read.csv(snakemake@input[[1]])

# Create a country sample for each row.
country_samples <- sample(countries, nrow(my_data), replace = TRUE)

# Add the samples to the dataframe.
my_data$country <- country_samples

# Output the dataframe with the country samples.
paste("Done with file =", snakemake@output[[1]])
write.csv(my_data, file = snakemake@output[[1]])