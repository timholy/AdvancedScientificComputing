---
title: "Advanced scientific computing: producing better code"
author: Bio 5989, Washington University in St. Louis
date: Sep 2, 2021
geometry: margin=1in
output: pdf_document
---

Many scientists are self-taught coders and struggle to learn the skills that best support collaboration, rigor and reproducibility, good design, extensibility, and wide community adoption.  Like so many other aspects of being a scientist, these are all skills that can be taught and learned via practice.

This nanocourse focuses primarily on tools and habits that make it easier to succeed in writing robust, flexible, and widely-adopted code.  Process-oriented topics include Git and GitHub, test-driven development, the workflow of continuous integration, and documentation and software releases.  More conceptual topics include principles of good design and the mechanisms for writing high-performance code.  Students will be introduced to all these issues via the [Julia programming language](https://julialang.org/), although some lessons will apply broadly.

This course is aimed at people who are comfortable in at least one programming language; it is not suitable for programming beginners.  Participants should plan to allocate several hours each week for homework assignments.

# Syllabus (3 weeks, 6 sessions)

All sessions will run on Mondays and Wednesdays from 10am-11:30am.  There is a two week gap between the first session and the next to allow participants some time to start getting comfortable with Julia.

1. Oct. 4: Introduction to the course: "why Julia?" and a brief tour: [lecture materials](../lectures/intro/intro-julia.ipynb), [video](https://youtu.be/x4oi0IKf52w), and [homework1](../homeworks/learning_julia1.md) and [homework2](../homeworks/learning_julia2.md). The two week gap between the first lecture and the remainder of the course is to allow participants to learn and become comfortable with Julia.
2. Oct. 18: Open source culture, Julia packages, git, and GitHub: [lecture materials](../lectures/pkgs_git_github/pkgs_git_github.ipynb), [video](https://www.youtube.com/watch?v=cquJ9kPkwR8), and [homework](../homeworks/pkgs_git_github.md).
3. Oct. 20: Testing & principles of design: [lecture materials](../lectures/tdd/Testing_and_design.ipynb), [video](https://youtu.be/yYqaosGFwAc), and [homework](../homeworks/tdd.md).
4. Oct. 25: Continuous integration, documentation, package versioning, and releases: [lecture materials](../lectures/ci_docs/CIandDocs.ipynb), [video](https://youtu.be/unXzO6amVoQ), and [homework](../homeworks/docs_ci_semver.md)
5. Oct. 27: High performance computing on your laptop I: inference, compilation, and performance measurement: [lecture materials](../lectures/perf1/perf1.ipynb), [video](https://youtu.be/_oRRbuuxnjY), and [homework as a "template repository" for GitHub Classroom](https://github.com/AdvancedScientificComputingInJuliaWashU/Performance.jl).
6. Nov. 3: High performance computing on your laptop II: algorithms, memory, and parallelism: [lecture materials](../lectures/perf2/perf2.ipynb) and [video](https://youtu.be/MbJykT-QjlI) (see the previous session for applicable homework).

# Assignments

Each lecture is coupled to a homework assignment, which is due at the beginning of the next class (10am).  The final lecture's homework will be due Nov. 8, 10am. **Students taking the course for credit must complete at least 4 of the 6** and do reasonably well.  Depending on class size, either the instructor, assistants, auto-, or peer-grading will be used. If instructors/assistants grade assignments, it will be only for enrolled students.

As is presumably obvious, people auditing the class are not required to do the homeworks. But if you are not already familiar with the content and want to learn, the assignments are highly recommended. It is very hard to learn these things "passively."

It is likely that we'll use a system such as [Github classroom](https://classroom.github.com/), but at present this is still under exploration.
