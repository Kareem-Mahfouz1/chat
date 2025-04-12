#!/bin/bash

# Define the base directory for the home feature
FEATURE_NAME="chats"
BASE_DIR="lib/features/$FEATURE_NAME"

# Create necessary directories
mkdir -p $BASE_DIR/presentation/views
mkdir -p $BASE_DIR/presentation/views/widgets
mkdir -p $BASE_DIR/presentation/cubits
mkdir -p $BASE_DIR/data
mkdir -p $BASE_DIR/data/models
mkdir -p $BASE_DIR/data/repos

# Create necessary Dart files
touch $BASE_DIR/presentation/views/${FEATURE_NAME}_view.dart

echo "${FEATURE_NAME} feature structure created successfully!"
