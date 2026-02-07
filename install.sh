#!/usr/bin/env bash

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
cd "$script_dir"

scripts=($(find ./runs -maxdepth 1 -mindepth 1 -executable -type f -exec basename {} \; | sort))

if [ ${#scripts[@]} -eq 0 ]; then
    echo "No executable scripts found in runs/ folder"
    exit 1
fi

echo "Available scripts:"
for i in "${!scripts[@]}"; do
    printf "  %2d) %s\n" $((i+1)) "${scripts[$i]}"
done
echo

read -p "Enter script numbers to run (space-separated, e.g., '1 2 4'): " input

if [ -z "$input" ]; then
    echo "No input. Exiting."
    exit 0
fi

selected_indices=()
seen_numbers=()

for num in $input; do
    if [[ ! "$num" =~ ^[0-9]+$ ]]; then
        echo "Invalid selection: $num (not a number)"
        continue
    fi
    
    if [[ " ${seen_numbers[*]} " =~ " ${num} " ]]; then
        echo "Skipping duplicate: $num"
        continue
    fi
    
    if [ "$num" -lt 1 ] || [ "$num" -gt ${#scripts[@]} ]; then
        echo "Invalid selection: $num (must be 1-${#scripts[@]})"
        continue
    fi
    
    seen_numbers+=("$num")
    selected_indices+=($((num-1)))
done

if [ ${#selected_indices[@]} -eq 0 ]; then
    echo "No valid selections. Exiting."
    exit 0
fi

echo
echo "Will run in this order:"
for index in "${selected_indices[@]}"; do
    printf "  %2d) %s\n" $((index+1)) "${scripts[$index]}"
done
echo

read -p "Proceed? [y/N]: " confirm

if [[ ! "$confirm" =~ ^[yY]$ ]]; then
    echo "Cancelled. Exiting."
    exit 0
fi

echo
for index in "${selected_indices[@]}"; do
    script_name="${scripts[$index]}"
    script_path="./runs/$script_name"
    
    echo "Running $script_name..."
    "$script_path"
    exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        echo "[ ✓ $script_name completed ]"
    else
        echo "[ ✗ $script_name failed (exit code: $exit_code) ]"
    fi
done

echo
echo "Done."
