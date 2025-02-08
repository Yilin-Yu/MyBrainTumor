#!/bin/sh

source ./CodeTools.sh
log_file=./LOG/CodeDownload.log

SOURCE_CODE="SourceCode"
EXE_CODE="nnUNet"


# Clean unneeded repository: Just for personal usage.
function clean_git_repository {
    # remove .github 
    if [ -d "$1/.github" ]; then
        rm -rf "$1/.github"
        log_info "Removed '$1/.github' successfully."
    else
        log_warn "No '.github' folder found in '$1'."
    fi

    # remove .gitignore
    if [ -f "$1/.gitignore" ]; then
        rm -f "$1/.gitignore"
        log_info "Removed '$1/.gitignore' successfully."
    else
        log_warn "No '.gitignore' file found in '$1'."
    fi
}


# check SOURCE_CODE 
check_folder "$SOURCE_CODE"
if [ $? -eq 1 ]; then
    
    log_info "Downloading source code..."
    git clone https://github.com/MIC-DKFZ/nnUNet.git -b v2.5.1 "$SOURCE_CODE"

    if [ $? -ne 0 ]; then
        log_error "Failed to clone the repository."
        exit 1
    fi

    clean_git_repository "$SOURCE_CODE"

fi


# check EXE_CODE
check_folder "$EXE_CODE"
if [ $? -eq 1 ]; then
    cp -r "$SOURCE_CODE" "$EXE_CODE"
    if [ $? -ne 0 ]; then
        log_error "Failed to copy files to '$EXE_CODE'."
        exit 1
    fi

    clean_git_repository "$EXE_CODE"

    if [ $? -ne 0 ]; then
        log_error "Failed to clean '$EXE_CODE' directory."
        exit 1
    fi
fi


log_info "Code download and copy completed successfully."
