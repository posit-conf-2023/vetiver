Deploy and maintain models with vetiver
================

### posit::conf 2023

by Julia Silge and Isabel Zimmerman

-----

:spiral_calendar: September 18, 2023  
:alarm_clock:     09:00 - 17:00  
:hotel:           ROOM TBD  
:writing_hand:    [pos.it/conf](http://pos.it/conf)  
:speaking_head:   [GitHub Discussions](https://github.com/posit-conf-2023/vetiver/discussions)

-----

## Overview

These are the materials for a one-day workshop on [MLOps with vetiver](https://vetiver.rstudio.com/) on Monday, 18 Sept at [posit::conf 2023](http://pos.it/conf)!

Many data scientists understand what goes into training a machine learning or statistical model, but creating a strategy to deploy and maintain that model can be daunting. In this workshop, learn what MLOps (machine learning operations) is, what principles can be used to create a practical MLOps strategy, and what kinds of tasks and components are involved. We’ll use vetiver, a framework for MLOps tasks in Python and R, to version, deploy, and monitor the models you have trained and want to deploy and maintain in production reliably and efficiently.

## Is this workshop for me? 

We expect participants to have exposure to basic modeling and machine learning practice, but NOT expert familiarity with advanced ML or MLOps topics. This workshop is for you if you:

- have intermediate R or Python knowledge (this will be a "choose your own adventure" workshop where you can work through the exercises in either R or Python)
- can read data from CSV and other flat files, transform and reshape data, and make a wide variety of graphs
- can fit a model to data with your modeling framework of choice

## Prework

We will provide an environment with [Posit Workbench](https://posit.co/products/enterprise/workbench/) and [Posit Connect](https://posit.co/products/enterprise/connect/) available, but you also have the option to work locally on your laptop rather than on Posit Workbench. If this is your preference, please come to the workshop with your laptop already set up.

- Clone the [repo](https://github.com/posit-conf-2023/vetiver) so you have the files and data locally
- To use R: Install recent versions of [R](https://cran.r-project.org/) and [RStudio](https://www.rstudio.com/download), along with the packages outlined in our [`DESCRIPTION`](https://github.com/posit-conf-2023/vetiver/blob/main/DESCRIPTION) file
- To use Python: Install recent versions of Python (3.7 or greater) and your preferred IDE, along with the packages outlined in our [`requirements.txt`](https://github.com/posit-conf-2023/vetiver/blob/main/requirements.txt). 
- Optionally, install [Docker Desktop](https://docs.docker.com/desktop/)

Join us on [GitHub Discussions](https://github.com/posit-conf-2023/vetiver/discussions) to ask questions and share ideas.

## Schedule

Quarto files for working along [are available on GitHub](https://github.com/posit-conf-2023/vetiver/tree/main/class-work).

| Time          | Activity         |
| :------------ | :--------------- |
| 09:00 - 10:30 | [Introduction](https://posit-conf-2023.github.io/vetiver/slides/01-introduction.html)       |
| 10:30 - 11:00 | *Coffee break*   |
| 11:00 - 12:30 | [Deploy your model](https://posit-conf-2023.github.io/vetiver/slides/02-deploy.html)        |
| 12:30 - 13:30 | *Lunch break*    |
| 13:30 - 15:00 | [Deeper into deployment](https://posit-conf-2023.github.io/vetiver/slides/03-deploy.html)   |
| 15:00 - 15:30 | *Coffee break*   |
| 15:30 - 17:00 | [Monitor your model](https://posit-conf-2023.github.io/vetiver/slides/04-monitor.html)      |

## Instructors

Julia Silge is a software engineer at Posit PBC focusing on open source MLOps tools, as well as an author and international keynote speaker. Julia loves making beautiful charts, Jane Austen, and her two cats.

Isabel Zimmerman is also a software engineer on the open source team at Posit PBC, where she works on building MLOps frameworks. When she's not geeking out over new data science techniques, she can be found hanging out with her dog or watching Marvel movies.

-----

![](https://i.creativecommons.org/l/by/4.0/88x31.png) This work is
licensed under a [Creative Commons Attribution 4.0 International
License](https://creativecommons.org/licenses/by/4.0/).
