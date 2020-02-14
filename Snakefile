
CHUNKS = 4


rule all:
    input:
        "plots/abundance_histogram.png"
    run:
        print("Done with executing the workflow.")
        print("The results are stored here: ")


rule generate_data:
    output:
        "data/my_dataset.csv"
    script:
        "scripts/generate-data.py"


rule chunk_dataset:
    input:
        dataset="data/my_dataset.csv"
    params:
        chunks=CHUNKS
    output:
        dataset_chunks=expand("data/blocks/subset_{chunk}.csv", chunk=range(CHUNKS))
    script:
        "scripts/chunk-data.py"


rule add_country:
    input:
        "data/blocks/subset_{chunk}.csv"
    output:
        "results/blocks/datasubset_w_country_{chunk}.csv"
    script:
        "scripts/add-country.R"


rule merge_results:
    input:
        expand("results/blocks/datasubset_w_country_{chunk}.csv", chunk=range(CHUNKS))
    output:
        "results/dataset_results.csv"
    shell:
        "xsv cat rows {input} > {output}"


rule plot_results:
    input:
        "results/dataset_results.csv"
    output:
        "plots/abundance_histogram.png"
    script:
        "scripts/plot-abundances.R"


rule hello:
    run:
        print("hello world")


rule clean:
    run:
        shell("rm -rf data results plots")
