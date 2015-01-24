---
title       : Coursera Developing Data Products
subtitle    : Georgia High Schools - 2014 National Test Scores
author      : Kanti Chalasani; Jan 24th 2015
job         : All Things Data/Analytics; R Hacker
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


---

## Derivations - Averages, Percents and Rankings 

* State.Rank - Rank assigned to this school within the State of Georgia.
* Selected.Schools.Rank - Rank assigned on the fly based on your current selection of the schools.

* Ranking Criteria - Highest to the lowest. 

SAT - Rank assigned based on SAT Combined Score.  

ACT - Rank assigned based on ACT Composite Score

AP - Rank assigned based on the percent of AP Course completions.

* SAT Combined Average, AP Pass Percents were also calculated.


---

## Alanta Metro Public School Districts Definition

* Atlanta Public Schools
* Cherokee County
* Cobb County                                         
* DeKalb County
* Douglas County
* Forsyth County
* Fulton County
* Gwinnett County
* Buford City
* Decatur City
* Marietta City

---


## AP 2014 Performance of Top 10 Schools in Georgia


<div id = 'chart1a1449ce3594' class = 'rChart highcharts'></div>
<script type='text/javascript'>
    (function($){
        $(function () {
            var chart = new Highcharts.Chart({
 "dom": "chart1a1449ce3594",
"width":            800,
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
 "text": "AP_PASS_PCT" 
} 
} 
],
"series": [
 {
 "data": [
 [
 "Bremen High School",
         81.63,
98 
],
[
 "Chattahoochee High School",
         83.55,
1574 
],
[
 "Etowah High School",
         81.97,
638 
],
[
 "Gwinnett School of Mathematics Science and Technol",
         81.76,
1453 
],
[
 "McIntosh High School",
         82.22,
838 
],
[
 "Northview High School",
         82.42,
1826 
],
[
 "Roswell High School",
          81.8,
1857 
],
[
 "Walton High School",
          88.9,
3001 
],
[
 "Wheeler High School",
         86.66,
937 
],
[
 "Woodstock High School",
         87.36,
617 
] 
],
"type": "bubble",
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
"categories": [ "Bremen High School", "Chattahoochee High School", "Etowah High School", "Gwinnett School of Mathematics Science and Technol", "McIntosh High School", "Northview High School", "Roswell High School", "Walton High School", "Wheeler High School", "Woodstock High School" ] 
} 
],
"subtitle": {
 "text": null 
},
"id": "chart1a1449ce3594",
"chart": {
 "renderTo": "chart1a1449ce3594" 
} 
});
        });
    })(jQuery);
</script>

---


## SAT 2014 Performance of Top 5 Schools in Georgia


<div id = 'chart1a142c353068' class = 'rChart highcharts'></div>
<script type='text/javascript'>
    (function($){
        $(function () {
            var chart = new Highcharts.Chart({
 "dom": "chart1a142c353068",
"width":            800,
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
"id": "chart1a142c353068",
"chart": {
 "renderTo": "chart1a142c353068" 
} 
});
        });
    })(jQuery);
</script>


---

# Interactive Report 

Average Scores for Top Performing Schools by Assessment 

Note for R Fans: Page under construction - functionality can be viewed using runDeck()]

<div class="row-fluid">
  <div class="span4">
    <form class="well">
      <label class="control-label" for="ASSMT">Choose Assessment Type</label>
      <select id="ASSMT"><option value="SAT" selected>SAT</option>
<option value="ACT">ACT</option>
<option value="AP">AP</option></select>
      <script type="application/json" data-for="ASSMT" data-nonempty="">{}</script>
      <label class="control-label" for="Rnk">Choose School Rank 1 to 5</label>
      <select id="Rnk"><option value="1" selected>1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option></select>
      <script type="application/json" data-for="Rnk" data-nonempty="">{}</script>
    </form>
  </div>
  <div class="span8">
    <div id="ASSMT1" class="shiny-text-output"></div>
    <br/>
    <hr/>
    <br/>
    <div id="ASSMT" class="shiny-text-output"></div>
  </div>
</div>

----


## Thank You

Thank You for your time.

My First Shiny Application: https://kchalasa.shinyapps.io/GANationalTests_prj/



