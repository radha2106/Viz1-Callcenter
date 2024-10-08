# Project Sharelove
This is a proyect about KPI Metrics in a callcenter for a customer service by differents departments; emails, chats and phone. This include the precentage of good/bad rates given by how well done is the service provided. Data info was/is created in excel (since I cant find any data related with callcenter); then all the info is imported to SQL (excel files are keep as backups), all the calculations and aggroupations are done in SQL, after that just connect to PowerBi. Background is made in Figma.

## Steps in Excel
- Bring a list of dates ranging from January to December (dont use first week and last 2 week of year and dont use weekends)
- Bring a list of agents names
- Repeat agents names by amount of dates remaining, do the same for the dates
- Add an index to rows and get the months numbers
- Give 1-3 random days off to agents by months
- Use a column to filter if the agent is absent or not
- Add random number to determine the amount of call/chat/emails will the agent receive
- Using that random number repeat the agent name by the amount received

Better details here: [Steps for excel](https://github.com/radha2106/Viz1/blob/main/Excel%20Steps.txt) and here: [Steps for call/chat/emails](https://github.com/radha2106/Viz1/blob/main/steps%20for%20call-chat-emails.txt)

## Steps for SQL
### Create tables with necessary columns
- Create a calendar table
- Create an absences table
- Create an agent table
- Create a mode table (where different type of response are)
- Create a QA table (where QA score are stored)
- Create different tabless depending on how many department are (call,chat,emails)
- Create views
- Create triggers and functions to help better checking inserting new rows/info

Better details here: [SQL Table Snap](https://github.com/radha2106/Viz1/tree/main/tables_sql_folder) and [SQL Full Code](https://github.com/radha2106/Viz1/blob/main/table_trigger_view.psql)

## Steps in PBI
- Connect PBI query to Postgres query and import the tables
- Make relationship between tables
- Create necessary meassures in an additional folder
- Use a palette color of 2-3 colors (#FFFFFF;#013A63;#CCCCCC)
- Meassure are here: [DAX Codes](https://github.com/radha2106/Viz1/blob/main/Dax%20Code) and the [Data Modeling](https://github.com/radha2106/Viz1/blob/main/DataModel%20PBI.png)

Full Dashboard is here [Viz1](https://project.novypro.com/7z40kB)
