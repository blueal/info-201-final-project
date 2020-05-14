# Final Project
## Domain of Interest
### **Reasons for Interest**
- As students attending school in Seattle, crime in this area concerns our personal safety (i.e. types of crimes, frequency).
- Crime analysis allows us to determine suspicious locations in the Seattle area for personal precaution.
- Analysis potentially unveils the effectiveness of Seattle area police.

### **Projects Examples**
- King County Sheriff's Office crime incident [visualization](https://data.kingcounty.gov/d/rzfs-wyvy/visualization)
- [Incident map](https://data.kingcounty.gov/dataset/King-County-Sheriff-s-Office-Incidents-Map/5jaq-rrc4) of crime throughout King County
- Interactive [density map](https://www.seattle.gov/police/information-and-data/crime-dashboard) of Seattle crime by chosen district
- SPD [map](http://seattlecitygis.maps.arcgis.com/apps/MapSeries/index.html?appid=94c31b66facc438b95d95a6cb6a0ff2e) detailing recent incidents of 911 calls

### **Questions to Answer**
- In what areas have the highest density of crime?
- Types of crime? and in what areas?
- Time of year? day? for offense, length of offense, report date?
- What is the realtionship between call-ins and arrests (i.e. resolution of call-ins)?

### *Data to Answer Questions*:

By utilizing offense start time, latitude & longitude, offense type, call-in resolution, etc. (information/columns available in the 3 datasets), our group can determine common times for crime incidence, crime type, location, etc.

## Finding Data
### **Datasets of Interest**
1. [SPD Crime Data: 2008-Present](https://data.seattle.gov/Public-Safety/SPD-Crime-Data-2008-Present/tazs-3rd5)
2. [King County Sheriff's Office - Incident Dataset](https://data.kingcounty.gov/Law-Enforcement-Safety/King-County-Sheriff-s-Office-Incident-Dataset/rzfs-wyvy)
3. [911 Seattle Call Data](https://data.seattle.gov/Public-Safety/Call-Data/33kz-ixgy)

### SPD Crime Data: 2008-Present

* **Data Collection:**
    * The Seattle Police department relies on the National incident-based reporting system was used to standardized crime classifications. The data is updated every twenty four hours.

* **Rows:** 
    * 827K

* **Columns:** 
    * 17

* **Questions:** 
    * This data set will answer what time crimes are most likely to happen and how many / what crimes happen in different places. 

### King County Sheriff's Office - Incident Dataset
* **Data Collection:**
    * Instances of crime reported by King Country Sherrif office (even if recorded by another policing agency, e.g. SPD).

* **Rows:**
    * 20.4K

* **Columns:**
    * 13

* **Questions:** 
    * This data will unveil crime density for the greater Seattle area as well as type of crime & common incident dates.

### 911 Seattle Call Data
* **Data Collection:**
    * 911 call data comes from Data Analytics Platform (DAP) and is logged with the Seattle Police Department (SPD) Communications Center. Police officers log calls and observations of the field from within the community.
    1) Data queried from the Data Analytics Platform (DAP), and updated incrementally on a daily basis. A full refresh will occur twice a year and is intended to reconcile minor changes. 
    2) This data set only contains records of police response. If a call is queued in the system but cleared before an officer can respond, it will not be included.
    3) These data contain administrative call types. Use the "Initial" and "Final" call type to identify the calls you wish to include in your analysis.

* **Rows:** 
    * 4.34 Million

* **Columns:**
    * 11

* **Questions:**
    * This dataset will answer questions about the types of calls, how severe/important the call was (priority), what location the calls/observation originated from, and the clearance description of the call.