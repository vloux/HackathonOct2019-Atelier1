#!/usr/bin/env nextflow
/*
========================================================================================
                         mmannonf-test
========================================================================================
 mmannonf-test Analysis Pipeline.
 #### Homepage / Documentation
 
----------------------------------------------------------------------------------------
*/

def helpMessage() {
    //log.info nfcoreHeader()
    log.info"""
    Usage:
    The typical command for running the pipeline is as follows:
    nextflow run mmannonf-test --input  'read_locations.tsv' -profile slurm
    Mandatory arguments:
      --input                       Path to tsv file with read locations (must be surrounded with quotes)
      --profile                      Configuration profile to use.
    """.stripIndent()
}

// Show help emssage
if (params.help){
    helpMessage()
    exit 0
}

/*
------------------------------------------------------------------------------
                       C O N F I G U R A T I O N
------------------------------------------------------------------------------
*/

// Show help messange when not correct input
if (params.help) exit 0, helpMessage()
if (!params.input) exit 0, helpMessage()

// Set values from parameters:
sampleFile = file(params.input)

// Setup channels
data=Channel.create()

// Set hybrid or 100%ONT execution flag
hybridmode = checkHybridMode(sampleFile)

// Import data
data = extractFastq(sampleFile)

// duplicate channel
data.into { data1; data2; data3 }

data2.println{ "Sample : " + it }

/* 
------------------------------------------------------------------------------
                           P R O C E S S E S 
------------------------------------------------------------------------------
*/

process seqkit1 {
// Do seqkit stats on all files
    label "seqkit"
    tag{id}
    publishDir "${params.outdir}/seqkit1", mode: 'copy'

    input:
    set id, file(reads) from data1

    output:
    set id, file("${id}_seqkit_stats.txt")

    script:
    """
    seqkit stats --all ${reads} > "${id}_seqkit_stats.txt"
    """
}

process mergefastq {
    tag{id}
    publishDir "${params.outdir}/merged_fastq", mode: 'copy'

    input:
    set id, file(reads) from data3

    output:
    set id, file("${id}_merged.fastq") into out_mergefastq_ch

    "cat ${reads} > ${id}_merged.fastq"
}

process seqkit2 {
// Do seqkit stats on all files
    label "seqkit"
    tag{id}
    publishDir "${params.outdir}/seqkit2", mode: 'copy'

    input:
    set id, file(reads) from out_mergefastq_ch

    output:
    set id, file("${id}_seqkit_stats.txt")

    script:
    """
    seqkit stats --all ${reads} > "${id}_seqkit_stats.txt"
    """
}

/*
------------------------------------------------------------------------------
                      Input file handling functions
------------------------------------------------------------------------------ 
*/

def returnFile(it) {
// Return file if it exists
    inputFile = file(it)
    if (!file(inputFile).exists()) exit 1, "The following file from the TSV file was not found: ${inputFile}, see --help for more information"
    return inputFile
}

def extractFastq(tsvFile) {
  // Extracts Read Files from TSV
  Channel.from(tsvFile)
  .ifEmpty {exit 1, log.info "Cannot find path file ${tsvFile}"}
  .splitCsv(sep:'\t')
  .map { row ->
    if (hybridmode) {
        // hybrid mode long read + short reads
        def id = row[0]
        def lr = returnFile(row[1])
        def r1 = returnFile(row[2])
        def r2 = returnFile(row[3])
        [id, [lr, r1, r2]]

    } else {
        // long read only
        def id = row[0]
        def lr = returnFile(row[1])
        [id, [lr]]
        }
    }
}

def checkHybridMode(tsvFile) {
  // Checks if tsv files contains long read + short read or only long read
  row = tsvFile.readLines().get(0)
  ncol = row.split('\t').size()
  if (ncol > 2) {
    true
  } else {
    false
  }
}


