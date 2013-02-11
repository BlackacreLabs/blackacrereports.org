Blackacre Reports
=================

[blackacrereports.org](http://blackacrereports.org), a project of
[Blackacre Labs](http://www.blackacrelabs.org)

Read, annotate, and discuss the judicial opinions of the United States
Supreme Court.

## Data

Data files containing Supreme Court opinion texts and case metadata
are developed as a sister project, the United States Reporter, also on
GitHub:

[BlackacreLabs/unitedstatesreporter](https://github.com/BlackacreLabs/unitedstatesreporter)

## Hacking

Please see the contribution guide for tips and guidelines:

[CONTRIBUTING.md](https://github.com/BlackacreLabs/blackacrereports.org/blob/master/CONTRIBUTING.md)

### Stack

You will need to reproduce or emulate the following services:

- Rack server to run the application
- MongoDB for data storage
- Git on `$PATH` for data updates
- Amazon Web Services S3 for case PDFs and other files

You can use a `.env` file to manage credentials on your development
machine. See `.env.example` to get started.
