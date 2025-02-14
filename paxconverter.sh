#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Usage: $0 <folder_path> <pax_name or command> [mode]"
    echo "Usage: folder_name - Compresses"
    echo "Usage: '1' - Creates directories"
    echo "Usage: '2' - Verifies correctness"
    exit 1
fi

# Get Command Line variables
folder_path="$1"
pax_name="$2"
mode="$3"


# Checks to see if it exists
# -d checks to see if folder
if [ ! -d "$folder_path" ]; then
    echo "Error: Folder path '$folder_path' does not exist."
    exit 1
fi

# Define the output pax file name
pax_file="${folder_path}/${pax_name}.pax"
pax_file_compress="${pax_file}.Z"

# Move into the folder path
cd "$folder_path" || exit 1

if [ "$pax_name" == "1" ] || [ "$mode" == "1" ]; then
    echo "Creating directories"
    mkdir config data pcaps report source video
    ls
    exit 0
fi

if [ "$pax_name" == "2" ] || [ "$mode" == "2" ]; then
    echo "Validating correctness..."

    # Create validation directory if it doesn't exist
    mkdir -p validation

    # Find the .pax.Z file and move it to validation
    pax_file=$(find . -maxdepth 1 -type f -name "*.pax.Z")

    # Check if a .pax.Z file was found. n checks for non-empty value
    if [ -n "$pax_file" ]; then
        cp "$pax_file" validation/
        echo "Copied $pax_file to validation directory."

        # Change into the validation directory
        cd validation || exit 1

        # Extract the .pax.Z file
        uncompress $pax_file
        decompressed_file="${pax_file##*/}"  # Removes the path, leaving only the filename
        decompressed_file="${decompressed_file%.Z}"  # Remove the .Z extension
        echo "Extracting $decompressed_file..."
        pax -r < "$decompressed_file"

        # List extracted files
        ls -l

        # Iterate through subdirectories and print their contents
        for subdir in */; do
            if [ -d "$subdir" ]; then
                echo "folder: $subdir"
                ls "$subdir"
            fi
        done
    else
        echo "No .pax.Z file found in the directory."
    fi

    exit 0
fi


# Create a pax archive containing all files inside the subdirectories
echo "Creating pax archive..."
pax -w config/ data/ pcaps/ report/ source/ video/ -f "$pax_file"

# Check if the Pax file exists
if [ ! -f "$pax_file" ]; then
    echo "Error: Pax file was not created."
    exit 1
fi

# Now compress the pax file
echo "Compressing with compress..."
compress -f "$pax_file"

echo "Compression complete: ${pax_file}.Z"
