#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool


requirements:
- $import: envvar-global.yml
- class: DockerRequirement
  dockerPull: 'dukegcb/gatk-base:3'

hints:
- class: SoftwareRequirement
  packages:
      gatk:
          version: [ "3.8" ]
          s:citation: http://dx.doi.org/10.1038/ng.806

inputs: # position 0, for java args, 1 for the jar, 2 for the tool itself

  GATKJar:
    type: File
    inputBinding:
      position: 1
      prefix: -jar

  variants:
    type: File
    secondaryFiles:
    - .idx
    inputBinding:
      position: 2
      prefix: -input
    doc: The raw input variants to be recalibrated

  threads:
    type: int?
    inputBinding:
      position: 2
      prefix: -nt
    doc: multithreading option

  reference:
    type: File
    secondaryFiles:
    - .fai
    - ^.dict
    inputBinding:
      position: 2
      prefix: -R
    doc: reference genome

  intervals:
    type: File[]?
    inputBinding:
      position: 2
      prefix: --intervals
    doc: One or more genomic intervals over which to operate

  recal_file:
    type: File
    inputBinding:
      position: 2
      prefix: -recalFile
    doc: the recal file generated by VariantRecalibrator

  tranches_file:
    type: File
    inputBinding:
      position: 2
      prefix: -tranchesFile
    doc: the tranches file generated by VariantRecalibrator

  mode:
    type: string
    inputBinding:
      position: 2
      prefix: -mode
    doc: specify if VQSR is called on SNPs or Indels

  ts_filter_level:
    type: float
    default: 99.9
    inputBinding:
      position: 2
      prefix: --ts_filter_level
    doc: filtering level default value is 99.9

  java_mem:
    type: string
    default: -Xmx8g
    inputBinding:
      position: 0

  outputfile_recalibrated_vcf:
    type: string
    inputBinding:
      position: 2
      prefix: -o

outputs:
  output_recalibrated_vcf:
    type: File
    outputBinding:
      glob: $(inputs.outputfile_recalibrated_vcf)
    secondaryFiles:
    - .idx

    doc: The output recalibration VCF file


arguments:
- valueFrom: $(runtime.tmpdir)
  position: 0
  separate: false
  prefix: -Djava.io.tmpdir=
- valueFrom: ApplyRecalibration
  position: 2
  prefix: -T
baseCommand: [java]

$namespaces:
  s: https://schema.org/

$schemas:
 - https://schema.org/docs/schema_org_rdfa.html
