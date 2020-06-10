#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: 'dukegcb/fastqc:0.11.4'
  - class: SoftwareRequirement
    packages:
      fastqc:
        version: [ "0.11.4" ]
        s:citation: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/

requirements:
  # Place input file into output directory, because fastqc
  # will by default write to the same directory as the input.
  # While fastqc does have a -o option for specifying the
  # output directory, it causes the command-line to change
  # from one run to the next, and therefore cannot be cached.
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_fastq_file)
  - class: InlineJavascriptRequirement
inputs:
  input_fastq_file:
    type: File
    inputBinding:
      position: 4
      valueFrom: $(self.basename)

  noextract:
    type: boolean
    default: true
    inputBinding:
      prefix: "--noextract"
      position: 2
  format:
    type: string
    default: "fastq"
    inputBinding:
      position: 3
      prefix: "--format"
  threads:
    type: int
    default: 1
    doc: The number of threads to use. The fastqc wrapper script requests 250MB of memory per thread, so keep this in line with any CWL ResourceRequirement
    inputBinding:
      position: 5
      prefix: "--threads"

outputs:
  output_qc_report:
    type: File
    outputBinding:
      glob: "*_fastqc.zip"

baseCommand: fastqc
arguments:
  - valueFrom: $('/tmp')
    prefix: "--dir" # Temp directory to use when writing report images
    position: 5

$namespaces:
  s: https://schema.org/

$schemas:
 - https://schema.org/version/latest/schema.rdf
