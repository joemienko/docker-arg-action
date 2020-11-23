#!/bin/sh -l

echo "Docker build completed!"
time=$(date)
echo "::set-output name=time::$time"