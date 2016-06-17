# Define custom utilities
# If on OSX, this check will work
# if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then ..

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    python -c 'import sys; import astropy; sys.exit(astropy.test())'
}
