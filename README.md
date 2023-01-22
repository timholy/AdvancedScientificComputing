# Advanced Scientific Computing: producing better code

This course is taught as a 6-session "nanocourse" at Washington University in St. Louis.
See [the course summary](summary_and_syllabus.md) for a general introduction.

For anyone participating remotely via the YouTube videos, you probably want the Fall 2021 edition of the course (see below).

# Current course (Spring 2023)

After the first lecture, students should start with the [setup](setup.md) instructions.

Homeworks and lectures are linked in the [schedule](schedule/schedule_2023.md).
Most of the learning will occur via the homework (both reading and problems); do not expect to get much out of this course if you don't do them.

The `main` branch of this repository will follow the latest iteration of the course.

# Fall 2021 edition

Course videos from fall 2021 are hosted in my YouTube account in a dedicated playlist: https://www.youtube.com/playlist?list=PL-G47MxHVTewUm5ywggLvmbUCNOD2RbKA. These may be useful in later years, too.

For the exact lectures and homeworks that correspond to the YouTube videos, you can check out the `Fall2021` branch of this repository. Lectures (videos and presentation materials) and homeworks are linked in the [schedule](schedule/schedule_2021.md).

# General tips

## Similar courses

See [related resources](resources.md) for other courses and workshops with similar aims to this one.

## Building PDFs from the Markdown files

If you have `pandoc` installed, you can build PDFs from the
Markdown files using a script with contents

    #! /bin/bash
    pandoc -V colorlinks --highlight-style zenburn $1.md -o $1.pdf

Example: `buildmd setup` where the script above is called `buildmd`.
