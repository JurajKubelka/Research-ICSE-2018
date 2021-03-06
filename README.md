<!-- -*- coding: utf-8-unix ; mode: markdown ; font-lock-multiline: t ; eval: (auto-fill-mode -1) ; eval: (flyspell-mode 1) ; eval: (visual-line-mode 1) -*- -->

# Research Articles

Repository includes dataset of two research studies published in the following venues:

- Title: *The Road to Live Programming: Insights From the Practice*
- Authors: Juraj Kubelka, Romain Robbes, Alexandre Bergel
- [ICSE 2018](https://www.icse2018.org/event/icse-2018-technical-papers-the-road-to-live-programming-insights-from-the-practice)

Title: *Live Programming and Software Evolution: Questions during a Programming Change Task*
- Authors: Juraj Kubelka, Romain Robbes, Alexandre Bergel
- [ICPC 2019](https://conf.researchr.org/home/icpc-2019)

# ICSE'18: The Road to Live Programming: Insights From the Practice

The ICSE 2018 study includes analysis of:
- an exploratory study analysis based on analysis of 17 recorded programming sessions of practitioners using [Pharo](http://pharo.org),
- a complementary on-line survey, and
- a subsequent analysis of 16 on-line programming sessions in additional languages

## Exploratory Study

Transcripts of the 17 sessions are available in an [Org-mode](http://orgmode.org) structured file: [transcripts.org.txt](./01-exploratory-study/transcripts.org.txt). The interaction data, extracted from DFlow, are available at [windows.csv](./01-exploratory-study/windows.csv). The original DFlow data are available at [dflow.zip](./01-exploratory-study/dflow.zip).

Assignments for sessions on unfamiliar source code are available at [assignments.pdf](./01-exploratory-study/assignments.pdf).

If you want an access to the session videos, visit http://doi.org/10.5281/zenodo.1170460.

The transcript was written in [GNU/Emacs](https://en.wikipedia.org/wiki/Emacs), in particular [Aquamacs](http://aquamacs.org), using the  [Org-mode](http://orgmode.org). We used a set of Emacs scripts that is available at [04-scripts](./04-scripts) directory.

## On-line Survey

The survey data is available at [02-survey](./02-survey) directory. It includes questions and responses.

## On-line Coding Session Videos

Subsequent video classification and links to video sources are available at [03-subsequent-videos](03-subsequent-videos) directory. It includes a CSV file.

# ICPC'19: Live Programming and Software Evolution: Questions during a Programming Change Task

The ICPC 2019 study includes analysis of:
- list of questions practitioners asked during programing change tasks, and
- an analysis of question occurrences, question complexities, and tool support answering questions.

The list of questions is extracted from [transcripts.org.txt](./01-exploratory-study/transcripts.org.txt) and is available at [questions.csv](./01-exploratory-study/questions.csv), including used question properties.
