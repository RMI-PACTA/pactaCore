
This document guides contributors. It extends
[README](https://github.com/2DegreesInvesting/pactaCore/blob/main/README.md)
focusing on how this R package differs form a standard one.

-   Some environment variables are convenient or required. A good place
    to set them is in a project-specific .Renviron file, e.g.:

<!-- -->

    PACTA_SKIP_SLOW_TESTS=FALSE
    PACTA_DATA=/home/mauro/git/pacta-data

-   Snapshots are ignored to avoid leaking private data. Re-include
    public snapshots in .gitignore, e.g.:

<!-- -->

    !tests/testthat/_snaps/run_pacta.md
