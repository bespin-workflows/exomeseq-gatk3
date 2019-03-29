# Version History: exomeseq-gatk3

All notable changes to this workflow will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v3.0.0...release-3.0
[3.0.1]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v3.0.1...v3.0.0
[3.0.0]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v3.0.0...v2.0.0
[2.0.0]: https://github.com/bespin-workflows/exomeseq-gatk3/compare/v2.0.0...v1.0.0
[1.0.0]: https://github.com/bespin-workflows/exomeseq-gatk3/releases/tag/v1.0.0
