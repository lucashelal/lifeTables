#--------------------------------------------------------------#
# _script: dataWrangling.R
# _goal: standardize data wrangling process
# _input: "01_datasets_working/lifeTablesPanel_NOSHOCK.csv"
# _parent: 10_scripts/base/main.R
#          10_scripts/base/datasetJoin.R
# _child/output: 02_datasets_cleaned/lifeTablesPanel_NOSHOCK_{date}{version}.csv
#--------------------------------------------------------------#
# _author: Lucas Helal
# _created: 2024-OCT-23 0746AMZ-03:00
# _updated: 2024-OCT-23 0746AMZ-03:00
# _version: 1.0
# _dependencies: tidyverse, readr, stringr, janitor, lubridate, here
# _language: R/C++
# _IDE: Visual Studio Code 1.61.0
# _copilot: enabled by command
# _versioning: git through VSCODE at github.com/lucashelal/lifetables
#--------------------------------------------------------------#
# _relevantVSCodeExtensions: rainbow_csv, R, pdf_viewer, githistory,
#                            Live Share, Prettier, JSON Language Features,
#                            GitHub Pull Requests and Issues, Image preview,
#                            Path Intellisense, FiraCode Font, C/C++, .gitignore,
#                            Latex Workshop, RMarkdown, Markdown All in One,
#                            Folder Structure, Smart Commit, YAML Formatter,
#                            Pandoc, MySQL, SQLite, PostgreSQL, MongoDB,
#                            SQL Server (mssql), Docker, Draw.io Integration,
#                            MATLAB, PHP IntelliSense, Python, Jupyter Notebook and
#                            Project Manager.
#--------------------------------------------------------------#
# _contact at: lucashelal@gmail.com
# _license: MIT
# _openSource: TRUE
# _credits:
# _forProfit: FALSE
# _openAccess: TRUE
#--------------------------------------------------------------#

### INIT -----
