library(ggplot2)

# Load my data to R.
my_data <- read.csv(snakemake@input[[1]])

# Generate a histogram with ggplot2.
ggplot(data = my_data, mapping = aes(abundances, fill=country)) + geom_histogram()

# Save the histogram as png.
ggsave(snakemake@output[[1]])
