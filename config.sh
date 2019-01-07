# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function pip_opts {
    # Extra options for pip
    if [ -n "$IS_OSX" ]; then
        local suffix=scipy_installers
    else
        local suffix=manylinux
    fi
    echo "--only-binary matplotlib --find-links https://nipy.bic.berkeley.edu/$suffix"
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    ASTROPY_INSTALL_DIR=$(dirname $(python -c 'import astropy; print(astropy.__file__)'))

    # Patch test_image file to fix test order bug
    local patch_file=$(abspath ../patches/test_timer.patch)
    (cd $ASTROPY_INSTALL_DIR && patch -p0 < $patch_file)

    # Runs tests on installed distribution from an empty directory
    python --version
    python -c "import sys; import astropy; sys.exit(astropy.test(remote_data='none'))"
}
