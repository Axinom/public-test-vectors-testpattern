# public-test-vectors-testpattern

Generator for test pattern videos used for some of the Axinom public test vectors.

# Output

All combinations of:

* Two test patterns: A and B.
* Four visual variations: neutral, red-emphasis, green-emphasis, blue-emphasis.
* Three quality levels: 360p, 1080p, 2160p
* Four durations: 1 minute, 1 hour, 3 hours, 24 hours

With one exception: 24 hour variants not generated for 2160p in order to save disk space.

Test pattern B is visually much simpler and requires less disk space (and bitrate) to present at reasonable quality.

# Prerequisites

FFmpeg

# Usage

Execute Generate.ps1 using PowerShell.

It will take a few days to generate all the videos.
