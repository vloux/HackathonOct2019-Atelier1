#!/usr/bin/bash
snakemake --dag |dot -T pdf > out/graph.pdf