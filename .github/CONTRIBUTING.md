
This document helps you develop or contribute to pactaCore. It document
the few things that make this project different form a standard R
package.

-   Some environment variables are convenient or required. A good place
    to set them is in a project-specific .Renviron file, e.g.:

<!-- -->

    PACTA_SKIP_SLOW_TESTS=FALSE
    PACTA_DATA=/home/mauro/git/pacta-data

-   Snapshots are ignored to avoid leaking private data. Re-include
    public snapshots in .gitignore, e.g.:

<!-- -->

    !tests/testthat/_snaps/run_pacta.md
