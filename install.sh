#!/bin/bash

if ! command -v stow &> /dev/null
then
    echo "Error: 'stow' package unavailable. Please install it and execute this script again."
    exit 1
fi

stow --adopt matheusbozetti

echo "Installed successfully!"
