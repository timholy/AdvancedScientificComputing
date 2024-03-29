---
title: "Advanced scientific computing: producing better code"
author: Bio 5989, Washington University in St. Louis
date: Jan 22, 2023
geometry: margin=1in
output: pdf_document
---

# Course rationale and goals

Welcome to "Advanced scientific computing: producing better code"!

Many scientists are self-taught coders and struggle to learn the skills that best support collaboration, rigor and reproducibility, good design, extensibility, and wide community adoption.  Like so many other aspects of being a scientist, these are all skills that can be taught and learned via practice.

This nanocourse focuses primarily on tools and habits that make it easier to succeed in writing robust, flexible, and widely-adopted code.  Process-oriented topics include Git and GitHub, test-driven development, the workflow of continuous integration, and documentation and software releases.  More conceptual topics include principles of good design and the mechanisms for writing high-performance code.  Students will be introduced to all these issues via the [Julia programming language](https://julialang.org/), although some lessons will apply broadly.

This course is aimed at people who are comfortable in at least one programming language; it is not suitable for programming beginners.  Participants should plan to allocate several hours each week for homework assignments.

# Syllabus (6 sessions)

All sessions will run on Mondays from 10:30am-noon.  There is a two week gap between the second session and the third to allow participants some time to start getting comfortable with Julia.

The linked materials may include a mix of current and previous course years, and are likely to be updated for the current year's course shortly before each session. **Students should wait to download the homework until after the lecture.**

Note: The links below are operable on the [course GitHub repository](https://github.com/timholy/AdvancedScientificComputing), but not from a PDF file.

1. Jan 23: Open source culture, Julia packages, git, and GitHub: [lecture materials](../lectures/pkgs_git_github/pkgs_git_github.ipynb), [video](https://www.youtube.com/watch?v=cquJ9kPkwR8), and [homework](../homeworks/pkgs_git_github.md).
2. Jan 30: "Why Julia?" and a brief tour: [lecture materials](../lectures/intro/intro-julia.ipynb), [video](https://youtu.be/x4oi0IKf52w), and [homework1](../homeworks/learning_julia1.md) and [homework2](../homeworks/learning_julia2.md). The two week gap between the first lecture and the remainder of the course is to allow participants to learn and become comfortable with Julia.
3. Feb 13: Testing & principles of design: [lecture materials](../lectures/tdd/Testing_and_design.ipynb), [video](https://youtu.be/yYqaosGFwAc), and [homework](../homeworks/tdd.md).
4. Feb 20: Continuous integration, documentation, package versioning, and releases: [lecture materials](../lectures/ci_docs/CIandDocs.ipynb), [video](https://youtu.be/unXzO6amVoQ), and [homework](../homeworks/docs_ci_semver.md)
5. Feb 27: High performance computing on your laptop I: inference, compilation, and performance measurement: [lecture materials](../lectures/perf1/perf1.ipynb), [video](https://youtu.be/_oRRbuuxnjY), and [homework as a "template repository" for GitHub Classroom](https://github.com/AdvancedScientificComputingInJuliaWashU/Performance.jl).
6. Mar 6: High performance computing on your laptop II: algorithms, memory, and parallelism: [lecture materials](../lectures/perf2/perf2.ipynb) and [video](https://youtu.be/MbJykT-QjlI) (see the previous session for applicable homework).

# Assignments

Each lecture is coupled to a homework assignment, which is due at the beginning of the next class (10:30am).  The final lecture's homework will be due a week after the final lecture. **Students taking the course for credit must complete at least 4 of the 6 "full" homeworks** and do reasonably well.
*Note that one homework, "Learn Julia," has been split into two weeks, but this only counts as one homework.* Depending on class size, either the instructor, assistants, auto-, or peer-grading will be used. If instructors/assistants grade assignments, it will be only for enrolled students.

As is presumably obvious, people auditing the class are not required to do the homeworks. But if you are not already familiar with the content and want to learn, the assignments are highly recommended. It is very hard to learn these things "passively."

Some assignments will use [Github classroom](https://classroom.github.com/).

## Getting the assignments

For those enrolled in the course at WashU, the first assignment is available in PDF form on Canvas.
This homework includes instructions for installing `git` and how to clone repositories on GitHub.
After the first homework, you can either keep downloading the PDF from canvas, or (now that you know `git`) you can `clone` [the course GitHub site](https://github.com/timholy/AdvancedScientificComputing) and issue a pull-request to refresh your copy of the repository before getting started on each new homework. As a reminder, students should make sure to wait until the corresponding lecture, as homeworks may be updated until shortly before the lecture introducing the topic.
