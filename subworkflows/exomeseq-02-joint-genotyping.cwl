#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  SchemaDefRequirement:
    types:
      - $import: ../types/ExomeseqStudyType.yml
inputs:
  study_type:
    type: ../types/ExomeseqStudyType.yml#ExomeseqStudyType
  name: string
  intervals: File[]?
  interval_padding: int?
  # NOTE: Should be at least 20 samples for exome
  raw_variants: File[]
  # reference genome, fasta
  reference_genome: File
  # Number of threads to use
  threads: int?
  # GATK
  GATKJar: File
  # Variant calling
  # Variant Recalibration - SNPs
  snp_resource_hapmap: File
  snp_resource_omni: File
  snp_resource_1kg: File
  # Variant Recalibration - Common
  resource_dbsnp: File
  # Variant Recalibration - Indels
  indel_resource_mills: File
outputs:
  joint_raw_variants:
    type: File
    outputSource: joint_genotyping/output_GenotypeGVCFs
    doc: "VCF file from joint genotyping calling"
steps:
  generate_joint_filenames:
    run: ../tools/generate-joint-filenames.cwl
    in:
      name: name
    out:
      - joint_genotype_raw_variants_output_filename
  # TODO: We may want to merge VCFs if we had lots of them
  # See Merge (optional) on https://software.broadinstitute.org/gatk/best-practices/bp_3step.php?case=GermShortWGS&p=2
  joint_genotyping:
    run: ../tools/GATK-GenotypeGVCFs.cwl
    requirements:
      - class: ResourceRequirement
        coresMin: 1
        ramMin: 12288
    in:
      GATKJar: GATKJar
      # https://gatkforums.broadinstitute.org/wdl/discussion/8718/concurrentmodificationexception-in-gatk-3-7-genotypegvcfs
      # Hi all, it looks like some race conditions were introduced in 3.7. Unfortunately we can't devote effort to addressing that since we are moving away from using this type of parallelism altogether
      threads:
        default: 1
      intervals: intervals
      interval_padding: interval_padding
      # NOTE: GATK best practices recommends at least 30 samples for exome - how to deal?
      variants: raw_variants
      reference: reference_genome
      group:
        default: ['StandardAnnotation']
      dbsnp: resource_dbsnp
      outputfile_GenotypeGVCFs: generate_joint_filenames/joint_genotype_raw_variants_output_filename
    out:
      - output_GenotypeGVCFs
