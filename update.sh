#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display a message box
# Function to display an error message
show_error() {
    echo -e "${RED}$1${NC}"
}

# Main function
main() {
    show_progress &
    progress_pid=$!
    
    # Perform the tasks
    echo -e "${BLUE}Wellcome Developer! Starting Ollama on DarkWaves${NC}"
    echo -e "${BLUE}Updating and building...${NC}"
    git stash &>/dev/null
    if [ $? -ne 0 ]; then
        show_error "Error: Unable to stash changes."
        exit 1
    fi
    echo -e "${BLUE}Stashing changes...${NC}"
    
    git pull &>/dev/null
    if [ $? -ne 0 ]; then
        show_error "Error: Unable to pull latest changes."
        exit 1
    fi
    echo -e "${BLUE}Pulling latest changes...${NC}"
    
    npm install --force &>/dev/null
    if [ $? -ne 0 ]; then
        show_error "Error: Unable to install npm packages."
        exit 1
    fi
    echo -e "${BLUE}Installing npm packages...${NC}"
    
    echo -e "${BLUE}Building project... and starting server...${NC}"
    npm run build | while IFS= read -r line; do
        echo -e "${YELLOW}${line}${NC}"
    done
    if [ $? -ne 0 ]; then
        show_error "Error: Build failed."
        exit 1
    fi
    
    npm run start | while IFS= read -r line; do
        echo -e "${YELLOW}${line}${NC}"
    done
    
    echo -e "${GREEN}Update and build process complete.${NC}"
    
    # Kill progress dialog
    kill $progress_pid
    
    }

# Execute main function
main
