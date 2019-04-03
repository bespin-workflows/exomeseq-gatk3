#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
label: exomeseq-gatk3-joint-genotyping/v4.1.1
doc: Whole Exome Sequence analysis that stops at joing genotyping using GATK3 - v4.1.1
requirements:
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  SchemaDefRequirement:
    types:
    - $import: types/ExomeseqStudyType.yml
    - $import: types/FASTQReadPairType.yml
inputs:
  study_type:
    type: types/ExomeseqStudyType.yml#ExomeseqStudyType
  # Intervals should come from capture kit (target intervals) bed format
  target_intervals: File[]?
  # Intervals should come from capture kit (bait intervals) bed format
  bait_intervals: File[]?
  interval_padding: int?
  # Named read pairs in FASTQ format
  read_pairs:
      type: types/FASTQReadPairType.yml#FASTQReadPairType[]
  # reference genome, fasta
  reference_genome:
    type: File
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .pac
    - .sa
    - .fai
    - ^.dict
  # Number of threads to use
  threads: int?
  # Read Group annotation
  # Can be the project name
  library: string
  # e.g. Illumina
  platform: string
  # GATK
  GATKJar:
    type: File
  knownSites:
    type: File[] # vcf files of known sites, with indexing
    secondaryFiles:
    - .idx
  # Variant Recalibration - SNPs
  snp_resource_hapmap:
    type: File
    secondaryFiles:
    - .idx
  snp_resource_omni:
    type: File
    secondaryFiles:
    - .idx
  snp_resource_1kg:
    type: File
    secondaryFiles:
      - .idx
  # Variant Recalibration - Common
  resource_dbsnp:
    type: File
    secondaryFiles:
    - .idx
  # Variant Recalibration - Indels
  indel_resource_mills:
    type: File
    secondaryFiles:
    - .idx
outputs:
  fastqc_reports_dir:
    type: Directory
    outputSource: organize_directories/fastqc_reports_dir
  trim_reports_dir:
    type: Directory
    outputSource: organize_directories/trim_reports_dir
  raw_variants_dir:
    type: Directory
    outputSource: organize_directories/raw_variants_dir
  hs_metrics_dir:
    type: Directory
    outputSource: organize_directories/hs_metrics_dir
  bams_markduplicates_dir:
    type: Directory
    outputSource: organize_directories/bams_markduplicates_dir
    doc: "BAM and bai files from markduplicates"
  bams_recalibrated_dir:
    type: Directory
    outputSource: organize_directories/bams_recalibrated_dir
    doc: "BAM files containing recalibrated reads"
  joint_raw_variants:
    type: File
    outputSource: joint_genotyping/joint_raw_variants
    doc: "GVCF file from joint genotyping calling"
steps:
  prepare_reference_data:
    run: subworkflows/exomeseq-00-prepare-reference-data.cwl
    in:
      target_intervals: target_intervals
      bait_intervals: bait_intervals
      reference_genome: reference_genome
    out:
      - target_interval_list
      - bait_interval_list
  preprocessing:
    run: subworkflows/exomeseq-01-preprocessing.cwl
    scatter: read_pair
    in:
      intervals: target_intervals
      target_interval_list: prepare_reference_data/target_interval_list
      bait_interval_list: prepare_reference_data/bait_interval_list
      interval_padding: interval_padding
      read_pair: read_pairs
      reference_genome: reference_genome
      threads: threads
      library: library
      platform: platform
      GATKJar: GATKJar
      knownSites: knownSites
      resource_dbsnp: resource_dbsnp
    out:
      - fastqc_reports
      - trim_reports
      - markduplicates_bam
      - recalibration_table
      - recalibrated_reads
      - raw_variants
      - hs_metrics
  joint_genotyping:
    run: subworkflows/exomeseq-02-joint-genotyping.cwl
    in:
      study_type: study_type
      name: library
      intervals: target_intervals
      interval_padding: interval_padding
      raw_variants: preprocessing/raw_variants
      reference_genome: reference_genome
      threads: threads
      GATKJar: GATKJar
      snp_resource_hapmap: snp_resource_hapmap
      snp_resource_omni: snp_resource_omni
      snp_resource_1kg: snp_resource_1kg
      resource_dbsnp: resource_dbsnp
      indel_resource_mills: indel_resource_mills
    out:
      - joint_raw_variants
  organize_directories:
    run: subworkflows/exomeseq-03-organizedirectories.cwl
    in:
      fastqc_reports: preprocessing/fastqc_reports
      trim_reports: preprocessing/trim_reports
      hs_metrics: preprocessing/hs_metrics
      bams_markduplicates: preprocessing/markduplicates_bam
      raw_variants: preprocessing/raw_variants
      bams_recalibrated: preprocessing/recalibrated_reads
    out:
      - fastqc_reports_dir
      - trim_reports_dir
      - hs_metrics_dir
      - bams_markduplicates_dir
      - raw_variants_dir
      - bams_recalibrated_dir
