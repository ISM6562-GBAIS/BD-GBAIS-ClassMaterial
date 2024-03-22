# Week01 Overview

## Introduction

This week we will cover three important concepts in understanding big data: the nature of big data, scaling database systems, and data storage architectures.

In the first lecture, we will explore the four Vs that characterize big data: volume, variety, velocity and veracity. We will also discuss the paradigm shift that big data enables in how organizations utilize data.

The second lecture dives deeper into a key challenge that the volume and variety of big data presents - scaling databases effectively. We will contrast vertical and horizontal scaling approaches and discuss technologies like Hadoop and NoSQL that are designed with horizontal scalability in mind.

In the final lecture, we define two pivotal data storage architectures - data lakes and data warehouses. We will compare their distinct purposes, architectures, use cases, and the process of moving data from lakes to warehouses.

## Learning Outcomes

By the end of this week, students will be able to:

1. Explain the four Vs of big data and the paradigm shift that big data is driving
2. Contrast vertical and horizontal scaling approaches for databases
Discuss the technical considerations and tradeoffs of vertically or horizontally scaling systems
3. Articulate the difference between a data lake and a data warehouse
4.  Outline the key steps involved in moving data from a lake to a warehouse

The goal is to equip students with a well-rounded conceptual foundation regarding some of the fundamental architectural shifts occurring due to the advent of big data systems and technologies.

## Lecture Material

- **[Big Data Introduction](1.big-data-intro.md):** In this document, we introduce Big Data by understanding the four V's of big data. We then discuss that Big Data is more than a technical shift in the tools we use but also a paradigm shift that involves looking at data in new ways.
  - [The four V's](1.big-data-intro.md#the-four-vs)
    - [1. Volume: The Monumental Scale of Data](1.big-data-intro.md#1-volume-the-monumental-scale-of-data)
    - [2. Variety: The Diverse Universe of Data](1.big-data-intro.md#2-variety-the-diverse-universe-of-data)
    - [3. Velocity: The Rapid Pace of Data Flow](1.big-data-intro.md#3-velocity-the-rapid-pace-of-data-flow)
    - [4. Veracity: The Credibility Challenge](1.big-data-intro.md#4-veracity-the-credibility-challenge)
  - [The Paradigm Shift in Data: A New Era of Information Utilization](1.big-data-intro.md#the-paradigm-shift-in-data-a-new-era-of-information-utilization)
    - [Conceptualizing the Shift](1.big-data-intro.md#conceptualizing-the-shift)
    - [Key Aspects of the Paradigm Shift](1.big-data-intro.md#key-aspects-of-the-paradigm-shift)
    - [Implications for the Future](1.big-data-intro.md#implications-for-the-future)

- **[Vertical and Horizontal Scaling](2.vertical-vs-horizontal-scaling.md):** Big Data is partially defined by the issue that large datasets pose on more traditional database systems, such as relational databases. In this introduction, we will explore these two important concepts concerning traditional RDBMS and Big Data systems along the dimensions of vertical and horizontal scaling.
    - [Vertical Scaling](#vertical-scaling)
      - [Technical Insights](#technical-insights)
      - [Advantages](#advantages)
      - [Limitations](#limitations)
  - [Horizontal Scaling](#horizontal-scaling)
    - [Technical Insights](#technical-insights-1)
    - [Advantages](#advantages-1)
    - [Limitations](#limitations-1)
  - [Big Data Technologies and Horizontal Scalability](#big-data-technologies-and-horizontal-scalability)

- **[Data Lake vs Data Warehouse](3.data-lake-vs-data-warehouse.md):** Terms that you will often hear used in Big Data are _Data Lake_ and _Data Warehouse_. In this document, we define and contrast these two concepts.
  - [Data Lake](#data-lake)
  - [Data Warehouse](#data-warehouse)
  - [Moving Data from Lakes to Warehouses](#moving-data-from-lakes-to-warehouses)
