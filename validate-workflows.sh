#!/bin/bash

set -e

for WORKFLOW in *.cwl; do
  cwltool --validate $WORKFLOW
done
