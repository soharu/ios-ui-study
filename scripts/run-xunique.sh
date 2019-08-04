#!/bin/bash

SCRIPT_PATH=$(dirname $(realpath $0))
PROJECT_NAME="Samples"

xunique $SCRIPT_PATH/../$PROJECT_NAME.xcodeproj
