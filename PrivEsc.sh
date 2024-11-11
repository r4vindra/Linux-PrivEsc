#!/bin/bash

# Set colors for output
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

BANNER=$(figlet r4vindra)
echo -e "${MAGENTA} ${BANNER} ${RESET}"
echo -e "${GREEN}Starting basic privilege escalation checks...${RESET}"

# Check for Sudo Privileges
echo -e "${YELLOW}[+] Check for Sudo Permissions${RESET}"
CURRENT_USER=$(whoami)

if groups "$CURRENT_USER" | grep -qw "sudo"; then
    echo "User ${CURRENT_USER} has Permission to run as sudo."
else
    echo "User ${CURRENT_USER} cannot run sudo command."
fi
echo "----------------------------------------------------------------------"
echo ""

# Check for Writable Directories
echo -e "${YELLOW}[+] Checking for world-writable directories${RESET}"
WRITABLE_DIRS=$(find / -type d -perm -o+w 2>/dev/null)
if [ -n "$WRITABLE_DIRS" ]; then
    echo -e "${GREEN}World-writable directories found:${RESET}"
    echo "$WRITABLE_DIRS"
else
    echo -e "${RED}No world-writable directories found.${RESET}"
fi
echo "----------------------------------------------------------------------"
echo ""

# Check for SUID Binaries
echo -e "${YELLOW}[+] Checking for SUID binaries${RESET}"
SUID_BINARIES=$(find / -type f -perm -4000 2>/dev/null)
if [ -n "$SUID_BINARIES" ]; then
    echo -e "${GREEN}SUID binaries found:${RESET}"
    echo "$SUID_BINARIES"
else
    echo -e "${RED}No SUID binaries found.${RESET}"
fi
echo "----------------------------------------------------------------------"
echo ""

# Check for Sensitive Information in Environment Variables
echo -e "${YELLOW}[+] Checking for sensitive information in environment variables${RESET}"
ENV_VARS=$(env | grep -Ei 'pass|key|token|secret')
if [ -n "$ENV_VARS" ]; then
    echo -e "${GREEN}Potential sensitive information found in environment variables:${RESET}"
    echo "$ENV_VARS"
else
    echo -e "${RED}No sensitive information found in environment variables.${RESET}"
fi
echo "----------------------------------------------------------------------"
echo ""

# Check for Cron Jobs
echo -e "${YELLOW}[+] Checking for cron jobs${RESET}"
CRON_JOBS=$(ls -l /etc/cron* 2>/dev/null)
if [ -n "$CRON_JOBS" ]; then
    echo -e "${GREEN}Cron jobs found:${RESET}"
    echo "$CRON_JOBS"
else
    echo -e "${RED}No cron jobs found.${RESET}"
fi

echo -e "${GREEN}Basic privilege escalation check complete.${RESET}"

