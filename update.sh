#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# login to the vps without password prompt
sudo -n true
if [ $? -ne 0 ]; then
    echo -e "${RED}Passwordless sudo is not configured. Please configure passwordless sudo for the current user.${NC}"
    exit 1
fi

# Function to display progress using whiptail
show_progress() {
    {
        sleep 1
        echo "10"
        sleep 1
        echo "30"
        sleep 1
        echo "60"
        sleep 1
        echo "80"
        sleep 1
        echo "100"
    } | whiptail --gauge "${BLUE}Updating and Building${NC}" 6 50 0
}

# Function to display a message box
show_message() {
    whiptail --title "${GREEN}Message${NC}" --msgbox "$1" 8 50
}

# Main function
main() {
    show_progress &
    progress_pid=$!
    
    # Perform the tasks
    echo -e "${BLUE}Wellcome Developer! Starting Ollama on DarkWaves${NC}"
    echo -e "${BLUE}Updating and building...${NC}"
    git stash &>/dev/null
    echo -e "${BLUE}Stashing changes...${NC}"
    git pull &>/dev/null
    echo -e "${BLUE}Pulling latest changes...${NC}"
    npm install --force &>/dev/null
    echo -e "${BLUE}Installing npm packages...${NC}"
    rm -rf dist &>/dev/null
    echo -e "${BLUE}Removing 'dist' directory...${NC}"
    echo -e "${BLUE}Building project... and starting server...${NC}"
    npm run preview
    echo -e "${BLUE}Update and build process complete.${NC}"
    
    # Kill progress dialog
    kill $progress_pid
    
    # Display completion message
    show_message "${GREEN}Update and build process complete.${NC}"
}

# Execute main function
main
