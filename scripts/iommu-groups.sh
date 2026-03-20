#!/bin/env bash
shopt -s nullglob
for g in `find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V`; do
    echo -e "\nIOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo "  - $(lspci -nns ${d##*/})"
    done;
done;
