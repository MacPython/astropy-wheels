# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function pip_opts {
    # Extra options for pip
    echo "--only-binary matplotlib --find-links ${MANYLINUX_URL}"
}

function run_tests {

    # Runs tests on installed distribution from an empty directory
    ASTROPY_INSTALL_DIR=$(dirname $(python -c 'import astropy; print(astropy.__file__)'))

    # Patch the test_system_file_never_expired test which is affected by
    # https://github.com/astropy/astropy/issues/9497
    local patch_file=$(abspath ../patches/test_system_file_never_expired.patch)
    (cd $ASTROPY_INSTALL_DIR && patch -p0 < $patch_file)

    local patch_file=$(abspath ../patches/test_output_verify.patch)
    (cd $ASTROPY_INSTALL_DIR && patch -p0 < $patch_file)

    # Runs tests on installed distribution from an empty directory
    python --version
    python -c "import sys; import astropy; sys.exit(astropy.test(remote_data='none'))"
}
