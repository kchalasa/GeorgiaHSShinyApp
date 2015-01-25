---
title       : Coursera Developing Data Products
subtitle    : Georgia High Schools - 2014 National Test Scores
author      : Kanti Chalasani; Jan 24th 2015
job         : Senior BI/Data Architect ; R Hacker
framework   : io2012        # {io2012, html5slides, shower, dzslides, revealjs,...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [bootstrap, quiz, shiny, interactive]   # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft, selfcontained}
ext_widgets : {rCharts: ["libraries/highcharts", "libraries/nvd3", "libraries/morris"]}
knit        : slidify::knit2slides

---

## Project Introduction

As a parent I am always interested in the statistical facts about the schools in our school district as compared to  other schools within the State of Georgia. This assignment motivated me to choose the 2014 data for National Tests and AP Course completions  for public schools within the State of Georgia, United States.

Data Source : [Georgia Deparment of Education (GaDOE)](http://www.gadoe.org)

Pre processed [SAT, AP](http://www.gadoe.org/Curriculum-Instruction-and-Assessment/Curriculum-and-Instruction/Documents/COLLEGE%20READINESS/2014-SAT-GA-School-Level.xlsx), [ACT](http://www.gadoe.org/Curriculum-Instruction-and-Assessment/Curriculum-and-Instruction/Documents/COLLEGE%20READINESS/2014-ACT-GA-School-Level.xls) and [Georgia high schools](http://www.gadoe.org/CCRPI/Documents/2014/2014%20CCRPI%20Indicator%20Score.xls) data to prepare final data sets needed for this project. Several data cleansing techniques were applied. Some data were derived, like SAT AVG Combined Score, State Ranks, dynamic ranks etc. 

Note : Some schools had sparse data and were dropped from the data set in order to meet the tight timelines for this project. 

---

## The Data Elements



**SAT Data**


```
##  [1] "District_Code" "District"      "School_Code"   "School"       
##  [5] "Avg_Combined"  "State.Rank"    "Test_Takers"   "Avg_Reading"  
##  [9] "Avg_Math"      "Avg_Writing"   "School_Year"   "AICode"
```

**ACT Data**


```
##  [1] "District_Code" "District"      "SCHOOL.ID"     "School"       
##  [5] "Avg_Composite" "State.Rank"    "Test_Takers"   "Avg_Eng"      
##  [9] "Avg_Math"      "Avg_Reading"   "Avg_Science"   "AICODE"       
## [13] "School_Year"
```

**AP Data**


```
##  [1] "District_Code"                    
##  [2] "District"                         
##  [3] "School_Code"                      
##  [4] "School"                           
##  [5] "AP_PASS_PCT"                      
##  [6] "State.Rank"                       
##  [7] "Test_Takers"                      
##  [8] "Total.Exams.Taken"                
##  [9] "Num.of.Exams.with.Scores.3.4.or.5"
## [10] "AICode"
```

---

## How is this website organized?

This website is organized into left and right panels.

* Left Panel - Data selection

  This panel allows you to choose the data level - State or District (in GA) or Atlanta Metro School Districts. This selection only applies to the first three tabs on the right panel.
  
* Right panel - Data Display

  This is organized into four tabs. First there tabs are one for each of the standardized assessments - SAT, AP and ACT respectively. 

  Fourth "School Comparison" tab  allows you to select the assessment type and any two high schools within the State of Georgia for comparison.
  
Shiny Application Link: http://kchalasa.shinyapps.io/GANationalTests_prj/


---

## Derivations - Averages, Percents and Rankings 

* State.Rank - Rank assigned to this school within the State of Georgia.
* Selected.Schools.Rank - Rank assigned on the fly based on your current selection of the schools.

* Ranking Criteria - Highest to the lowest  

SAT - Rank assigned based on SAT Combined Score.  

ACT - Rank assigned based on ACT Composite Score

AP - Rank assigned based on the percent of AP Course completions.

* SAT Combined Average=SAT_AVG_Reading + SAT_AVG_Math + SAT_AVG_Writing
* AP Pass Percents = (Total Exams with a Score of 3,4 or 5)/ (Total AP Exams Taken) *100


---


SAT 2014 Performance of Top 5 Schools in Georgia


<div id = 'chart50c699d41f6' class = 'rChart highcharts'></div>
<script type='text/javascript'>
    (function($){
        $(function () {
            var chart = new Highcharts.Chart({
 "dom": "chart50c699d41f6",
"width":            400,
"height":            400,
"credits": {
 "href": null,
"text": null 
},
"exporting": {
 "enabled": false 
},
"title": {
 "text": null 
},
"yAxis": [
 {
 "title": {
 "text": "Avg_Combined" 
} 
} 
],
"series": [
 {
 "data": [
 [
 "Alpharetta High School",
1704 
],
[
 "Columbus High School",
1702 
],
[
 "Gwinnett School of Mathematics, Science and Technology",
1912 
],
[
 "Northview High School",
1779 
],
[
 "Walton High School",
1724 
] 
],
"type": "bar",
"marker": {
 "radius":              3 
} 
} 
],
"legend": {
 "enabled": false 
},
"xAxis": [
 {
 "title": {
 "text": "School" 
},
"categories": [ "Alpharetta High School", "Columbus High School", "Gwinnett School of Mathematics, Science and Technology", "Northview High School", "Walton High School" ] 
} 
],
"subtitle": {
 "text": null 
},
"id": "chart50c699d41f6",
"chart": {
 "renderTo": "chart50c699d41f6" 
} 
});
        });
    })(jQuery);
</script>


