#!/bin/bash
OS_TYPE=$(uname -s)
if [[ "$OS_TYPE" == "Darwin" ]]; then
    echo "Running macOS diagnostics..."
    sudo ../macos/diagnostic.sh
elif [[ "$OS_TYPE" =~ ^CYGWIN|MINGW ]]; then
    echo "Running Windows diagnostics..."
    powershell.exe -File ../windows/diagnostic.ps1
else
    echo "Unsupported OS: $OS_TYPE"
    exit 1
fi
