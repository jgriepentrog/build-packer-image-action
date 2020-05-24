#!/bin/sh -l

echo "Building template $1..."
time=$(date)
echo "::set-output name=time::$time"