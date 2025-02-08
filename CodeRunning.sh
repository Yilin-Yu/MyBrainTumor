#!/bin/sh

source ./CodeTools.sh
log_file=./LOG/CodeRunning.log
check_log

sys_check

# Define Scripts
SCRIPT1="CodeDownload.sh"
SCRIPT2="CodeModify.sh"

log_info "Running CodeDownload.sh to download original code"
bash "$SCRIPT1"

run_next_script $SCRIPT1 $SCRIPT2

bash "$SCRIPT2"