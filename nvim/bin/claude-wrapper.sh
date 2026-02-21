#!/bin/bash
# Wrapper script for claudecode.nvim to call the custom claude function
# This enables claudecode.nvim to work with the Makefile-based claude session

# Get the working directory (where nvim was started or current file location)
WORK_DIR="${WORK_DIR:-$PWD}"

# Get the makefile directory
MAKEFILE_DIR="${MAKEFILE_DIR:-/Users/stefan.heller/Work/repos/auth0-bedrock/tools/claude}"

# Check if claude is installed
if ! command -v claude &> /dev/null; then
    echo "Claude CLI not found!"
    echo "Please install it first: cd $MAKEFILE_DIR && make install"
    exit 1
fi

# Run the claude session via make with proper working directory and args
cd "$MAKEFILE_DIR" && make WORK_DIR="$WORK_DIR" CLAUDE_ARGS="$*" session
#!/bin/bash
# Wrapper script for claudecode.nvim to call the custom claude function
# This enables claudecode.nvim to work with the Makefile-based claude session

# Get the working directory (where nvim was started or current file location)
WORK_DIR="${WORK_DIR:-$PWD}"

# Get the makefile directory
MAKEFILE_DIR="${MAKEFILE_DIR:-/Users/stefan.heller/Work/repos/auth0-bedrock/tools/claude}"

# Check if claude is installed
if ! command -v claude &> /dev/null; then
    echo "Claude CLI not found!"
    echo "Please install it first: cd $MAKEFILE_DIR && make install"
    exit 1
fi

# Run the claude session via make with proper working directory and args
cd "$MAKEFILE_DIR" && make WORK_DIR="$WORK_DIR" CLAUDE_ARGS="$*" session
