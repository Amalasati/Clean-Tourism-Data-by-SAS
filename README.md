# Clean-Tourism-Data-by-SAS

# About Data
Two main tables: the tourism table and the country_info table. The tourism table contains information on arrivals of non-resident visitors, departures, and tourism expenditure for both the country and other countries. The data was sourced from the UN data website and comprises 23 columns and over 2,400 rows.

The country_info table, on the other hand, consists of two columns and 250 rows. It contains country names and their corresponding continent IDs. This information allows us to categorize countries into their respective continents.

The tourism table has two primary categories: inbound tourism and outbound tourism. Inbound tourism refers to visitors coming to a particular country, and the data includes information on arrivals and expenditure in US dollars. Outbound tourism, on the other hand, involves individuals from a country traveling to other countries. The data contains details about departures and tourism expenditure in US dollars.

For proper conversion of the data in the tourism table, the country column plays a crucial role. It contains various information, such as country names, tourism type (inbound/outbound), and tourism categories (number of arrivals or departures, or expenditure) in US dollars. The series column provides data collection method details, but it won't be extensively used in the case study.

Additionally, the scaled numeric data in columns _1995 through _2014 is stored as text. The country column provides the necessary information to convert this data into numeric values. The expenditure data is in millions of US dollars, while the arrivals and departures are represented in thousands (with a scaling factor of 1,000).

# Divide the work into three tasks:

Task 1: Create the cleaned_tourism table by restructuring the original tourism table to meet specific data requirements. The original table contains diverse types of information in the country column, which needs to be restructured for meaningful analysis.

Task 2: Merge the newly restructured tourism table with the country_info table to create the final tourism table that contains only matching rows. This will help align tourism data with the corresponding country information.

Task 3: Generate the nocountryfound table, which will contain a distinct list of countries that did not have matching rows in the country_info table.
