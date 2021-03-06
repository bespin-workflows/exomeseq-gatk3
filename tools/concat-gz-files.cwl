cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: combinefiles.sh
        entry: |
          if [ "$#" -eq 1 ]; then
            cat "$@"
          else
            zcat "$@" | gzip
          fi
baseCommand: bash
arguments: [combinefiles.sh]
inputs:
  files:
    type: File[]
    inputBinding:
      position: 2
      shellQuote: False
  output_filename:
    type: string
stdout: $(inputs.output_filename)
outputs:
  output:
    type: File
    outputBinding:
      glob: $(inputs.output_filename)

