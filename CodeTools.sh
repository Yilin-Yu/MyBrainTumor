#!/bin/sh

# log file
LOG_FOLDER=./LOG
log_file="LogMysetup.log"


function log_info() {
    printf "%s [INFO] %s\n" "$(date +"%Y-%m-%d %H:%M:%S")" "$1" | (tee -ai "$log_file") 2>&1
}


function log_warn() {
    printf "%s [WARN] %s\n" "$(date +"%Y-%m-%d %H:%M:%S")" "$1" | (tee -ai "$log_file") 2>&1
}


function log_error() {
    printf "%s [ERROR] %s\n" "$(date +"%Y-%m-%d %H:%M:%S")" "$1" | (tee -ai "$log_file") 2>&1
}


function check_log() {
    if [ ! -d $LOG_FOLDER ]; then
        mkdir $LOG_FOLDER
        log_info "Prepare the log folder."
    else
        pwdrm -rf $LOG_FOLDER
        mkdir $LOG_FOLDER
        log_warn "Clean previous log and prepare the log folder."
    fi
}


function sys_check() {
    log_info "System information"
    log_info "OS: $OSTYPE"
    log_info "GPU: $(nvidia-smi --query-gpu=name --format=csv,noheader,nounits)"
    log_info "Cuda: $(nvcc --version | tail -n 1 | awk '{print $2}'| cut -d '/' -f 1)"
    log_info  
}


# check whether folder exists
function check_folder {
    if [ ! -d "$1" ]; then
        log_info "Folder '$1' does not exist."
        return 1
    else
        log_warn "Folder '$1' already exists."
        return 0
    fi
}


function run_next_script() {
    # Check if s1.sh executed successfully
    if [ $? -eq 0 ]; then
        log_info "$1 executed successfully, $2 is ready to begin."
    else
        log_error "$1 failed. $2 will not be executed."
        exit 1
    fi
}