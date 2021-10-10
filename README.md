# Advanced Scientific Computing: producing better code

This course is taught as a 6-session "nanocourse" at Washington University in St. Louis.
See [the course summary](summary_and_syllabus.md) for a general introduction.

Anyone following this should start with the [setup](setup.md) instructions.
Next, lectures (videos and presentation materials) and homeworks are linked in the [schedule](schedule/schedule_2021.md).
Most of the learning will occur via the reading and homeworks; do not expect to get much out of this course if you don't do them.

All course videos will be hosted in my YouTube account in a dedicated playlist: https://www.youtube.com/playlist?list=PL-G47MxHVTewUm5ywggLvmbUCNOD2RbKA

*Tip*: if you have `pandoc` installed, you can build PDFs from the
Markdown files using a script with contents

    #! /bin/bash
    pandoc -V colorlinks --highlight-style zenburn $1.md -o $1.pdf

Example: `buildmd setup` where the script above is called `buildmd`.

