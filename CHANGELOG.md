# Version History: exomeseq-gatk3

All notable changes to this workflow will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [4.2.1] - 2019-05-07

- Updates parameters used by VariantRecalibrator to help with `No data found` errors.
- Tweaked fastqc and trim\_galore tools to make them cache-able

## [4.2.0] - 2019-04-04

### Added

- exomeseq-gatk3-joint-genotyping workflow based on exomeseq-gatk3.cwl but stops at the joint_genotyping step.

## [4.1.1] - 2019-04-01

### Changed

- exomeseq-gatk3 workflow migrated from exomeseq.cwl in [bespin-cwl v0.9.5](https://github.com/Duke-GCB/bespin-cwl/releases/tag/v0.9.5)
- Reorganized bespin-types into individual files
- Restructured requirements to support importing one type per file
- Optimize concat-gz-files tool to skip decompression/recompression if only one file

## [4.1.0] - 2019-04-01

### Added

- exomeseq-gatk3-preprocessing workflow migrated from exomeseq-preprocessing.cwl in [bespin-cwl v0.9.4](https://github.com/Duke-GCB/bespin-cwl/releases/tag/v0.9.4)

### Changed

- exomeseq-gatk3 workflow migrated from exomeseq.cwl in [bespin-cwl v0.9.4](https://github.com/Duke-GCB/bespin-cwl/releases/tag/v0.9.4)
- threads value in bwa-mem-samtools is no longer optional
- Removed leftover comments from preprocessing subworkflow

## [4.0.0] - 2019-04-01

### Added

- Adds `FASTQReadPairType`, where each half of the pair can contain multiple files
- Adds steps to combine multiple files per read pair

### Changed

- exomeseq-gatk3 workflow migrated from exomeseq.cwl in [bespin-cwl v0.9.3](https://github.com/Duke-GCB/bespin-cwl/releases/tag/v0.9.3)
- `read_pairs` input is now an array of `FASTQReadPairType`, allowing multiple files per sample read
- Sets threads on qc step to 4

## [3.0.2] - 2019-03-29

### Changed

- exomeseq-gatk3 workflow migrated from exomeseq.cwl in [bespin-cwl v0.9.2.2](https://github.com/Duke-GCB/bespin-cwl/releases/tag/v0.9.2.2)
- Raised memory other steps to try to avoid out-of-memory errors on VM

## [3.0.1] - 2019-03-29

### Changed

- exomeseq-gatk3 workflow migrated from exomeseq.cwl in [bespin-cwl v0.9.2.1](https://github.com/Duke-GCB/bespin-cwl/releases/tag/v0.9.2.1)
- Raised memory in sort and mapping steps to try to avoid out-of-memory errors on VM

## [3.0.0] - 2019-03-29

### Changed

- exomeseq-gatk3 workflow migrated from exomeseq.cwl in [bespin-cwl v0.9.2](https://github.com/Duke-GCB/bespin-cwl/releases/tag/v0.9.2)
- Changed to support xgen capture kit
- Renamed `intervals` -> `target_intervals` and `primary_intervals` -> `bait_intervals`
- Reconfigured some output files to keep recalibrated preprocessing bams

## [2.0.0] - 2019-03-29

### Added

- Adds a subworkflow step to prepare reference data (interval lists)
- Adds a required `study_type` enum field (`Large Population` / `Small Familial`) that causes different annotation sets during variant recalibration

### Changed

- exomeseq-gatk3 workflow migrated from exomeseq.cwl in [bespin-cwl v0.9.1](https://github.com/Duke-GCB/bespin-cwl/releases/tag/v0.9.1)

## [1.0.0] - 2019-03-29

### Added

- Initial release of exomeseq-gatk3 workflow, migrated from exomeseq.cwl in [bespin-cwl v0.9.0](https://github.com/Duke-GCB/bespin-cwl/releases/tag/v0.9.0)

[Unreleased]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v4.2.0...develop
[4.2.0]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v4.1.1...v4.2.0
[4.1.1]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v4.1.0...v4.1.1
[4.1.0]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v4.0.0...v4.1.0
[4.0.0]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v3.0.2...v4.0.0
[3.0.2]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v3.0.1...v3.0.2
[3.0.1]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v3.0.0...v3.0.1
[3.0.0]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/bespin-workflows/exomeseq-gatk3/releases/tag/v1.0.0
