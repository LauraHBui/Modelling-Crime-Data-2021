
# Relationships with Categorical Variables
#### *Independent and Dependent Variables, T-test, Chi-square* {-}


#### Learning Outcomes: {-}
-	Learn to arrange variables as independent and dependent variables
-	Learn to test for statistical significance in relationships with categorical variables
-	Understand how to interpret outputs from t-tests and the chi-square test

<div style="margin-bottom:35px;">
</div>

#### Today’s Learning Tools: {-}

<div style="margin-bottom:15px;">
</div>

##### *Data:* {-}
-	National Youth Survey (NYS)
-	British Crime Survey (BCS)

<div style="margin-bottom:15px;">
</div>

##### *Packages:* {-}
-	`dplyr`
-	`forcats`
-	`gmodels`
-	`haven`
-	`here`
-	`labelled`
-	`skimr`
-	`tidyverse`

<div style="margin-bottom:15px;">
</div>

##### *Functions introduced (and packages to which they belong)* {-}
-	`chisq.test()` : Produces the chi-square test (`base R`)
-	`CrossTable()` : Produces contingency tables (`gmodels`)
-	`fct_explicit_na()` : Provides missing values an explicit factor level (`forcats`)
-	`fisher.test()` : Produces Fisher’s exact test (`base R`)
- `merge()` : Merge datasets by common row or column names (`base R`)
-	`n()` : Count observations within `summarize()`, `mutate()`, `filter()` (`dplyr`)
-	`read_dta()` : Imports a .dta Stata file (`haven`)
-	`t.test()`: Performs one and two sample t-tests on vectors of data (`base R`)
-	`var.test()` : Performs an F-test to compare the variances of two samples from normal populations (`base R`)
-	`with()` : Evaluates an expression, often to specify data you want to use (`base R`)

<div style="margin-bottom:50px;">
</div>

---


## Associating with Categorical Variables

<div style="margin-bottom:50px;">
</div>

We are familiar with categorical variables, which take the forms of nominal and ordinal level characteristics. In `R`, these variables are encoded as a factor class, and for shorthand, are referred to as **factors**. 

In inferential statistics, sometimes we want to make predictions about relationships with factors. For example, we want to understand the relationship between sex and alcohol consumption. Perhaps we think males will have higher alcohol consumption than females. The variable, sex, in this example, is a binary factor with the two categories, male and female, whereas alcohol consumption is a numeric variable. 

Today, we learn how to conduct more inferential statistical analyses, but this time with categorical variables. 

Before we start, we do the following:

<div style="margin-bottom:15px;">
</div>

1.	Open up our existing `R` project

<div style="margin-bottom:15px;">
</div>

2.	Install and load the required packages listed above


<div style="margin-bottom:15px;">
</div>

3.	Open the National Youth Survey (NYS) datasets (*nys_1_ID.dta* and *nys_2_ID.dta*) using the function `read.dta ()`, specifying the working directory with `here()`

<div style="margin-bottom:15px;">
</div>


4.	Name the data frames `nys_1` and `nys_2` respectively

<div style="margin-bottom:15px;">
</div>

5.	Get to know the datasets with the codes `View(nys_1)` and `View(nys_2)`

<div style="margin-bottom:15px;">
</div>

6.	There is some code on scientific notation that we will ignore, so run `options(scipen=999)` to turn it off. 


```r
View(nys_1)
View(nys_2)

options(scipen=999)
```
<div style="margin-bottom:50px;">
</div> 

---

<div style="margin-bottom:50px;">
</div> 

## Today’s 3

We further our understanding of inferential statistics by learning more about variables and a couple of new statistical analyses that examine a relationship with factor variables. Our three topics today are: **independent and dependent variables**, the **t-test**, and the **chi-square**. 

<div style="margin-bottom:50px;">
</div> 
---

### Independent and Dependent Variables

<div style="margin-bottom:50px;">
</div> 

In learning to set hypotheses last week, we primarily wanted to know whether there was a relationship between certain variables. Inadvertently, we also were arranging our variables in a way that indicated one was the explanation and the other was the outcome. 

Using our previous example on sex and alcohol consumption, we can arrange them so that sex is the **independent variable** (*X*), which means that it is assumed to have an impact on the amount of alcohol consumption, the **dependent variable** (*Y*), which is considered to be influenced by *X*. We believe that sex (X) has an influence on level of alcohol consumption (Y), and hypothesise, based on previous research, that males will have higher levels of alcohol consumption than females. We then conduct an appropriate statistical test to find out. 

Although independent and dependent variables are not terms usually used for today’s analyses, we will use them to indicate which variable plays the role of explanation and which plays the part of outcome. In addition, it is good to get into the mindset of arranging your variables as such. This helps to clarify how your variables will relate to each other. 

An important point to remember is that although the independent variable (IV) is considered to impact on the dependent variable (DV), it *does not mean the IV causes the DV*. We can only arrange these variables in the direction we think is suitable and make statements about whether they are related to each other. It is in experimental research designs that we can speak of causality.

<div style="margin-bottom:50px;">
</div> 
---


### The T-Test

<div style="margin-bottom:50px;">
</div> 

#### Independent Sample T-test

<div style="margin-bottom:35px;">
</div> 

We return to that previous example of sex and alcohol consumption. We would like to know whether there is a difference between the mean alcohol consumption level of males and females. In this example, we use the **independent sample t-test** or *unpaired t-test*. This test requires that the IV be a binary factor while the DV be either a ratio or interval variable and be normally distributed -- unless **N** (the number of the sample) is large. Both variables meet the assumptions. We are interested in knowing whether there is a significant difference between males and females in the mean number of times they reported being drunk in the past year. Our null and alternative hypotheses are as follows:

<div style="margin-bottom:35px;">
</div> 

$H_0$: There is no significant difference in frequency of getting drunk between males and females in the past year. 

<div style="margin-bottom:15px;">
</div> 

$H_A$: There is a significant difference in frequency of getting drunk between males and females in the past year.

<div style="margin-bottom:35px;">
</div> 

We use the data frame, `nys_1`, to address our research question: Is there a difference in the amount of drunkenness between males and females? Before conducting our t-test, we need to check our variables of interest to see if they need any recoding. We use the function `summarize ()` to examine the sex variable ( `sex` ) and use the function `n ()` to obtain frequencies:

<div style="margin-bottom:35px;">
</div> 


```r
# Examining distribution of sex variable
nys_1 %>% group_by(sex) %>% summarize(n = n())
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 2
##          sex     n
##    <dbl+lbl> <int>
## 1 1 [Male]     918
## 2 2 [Female]   807
```

<div style="margin-bottom:50px;">
</div> 

According to the output, there are 918 males and 807 females. In addition, the codes for each value are shown: males are coded ‘1’ whereas females are coded ‘2’. We may want to recode these values to make a dummy variable (binary but codes are 0 and 1) so that females are ‘1’ and males are ‘0’:

<div style="margin-bottom:35px;">
</div> 


```r
# First, recode ‘sex’ and store it in a new variable called ‘female’
nys_1$female <- recode(nys_1$sex, '2' = 1, '1' = 0) 

# Next, label the values so that female is ‘1’ and male is ‘0’
nys_1 <- nys_1 %>% add_value_labels(female = c("Female"=1, "Male"=0)) 

# Check they were added correctly by getting frequencies 
count(nys_1, female)
```

```
## # A tibble: 2 x 2
##       female     n
##    <dbl+lbl> <int>
## 1 0 [Male]     918
## 2 1 [Female]   807
```

<div style="margin-bottom:50px;">
</div> 

Now we check out our dependent variable `drunk` using the `skim ()` function from the `skimr` package familiar from lesson 4:

<div style="margin-bottom:35px;">
</div> 


```r
# Use skim() function from skimr package to examine drunk variable 
skim(nys_1, drunk)
```


Table: (\#tab:unnamed-chunk-6)Data summary

                                 
-------------------------  ------
Name                       nys_1 
Number of rows             1725  
Number of columns          26    
_______________________          
Column type frequency:           
numeric                    1     
________________________         
Group variables            None  
-------------------------  ------


**Variable type: numeric**

skim_variable    n_missing   complete_rate   mean      sd   p0   p25   p50   p75   p100  hist  
--------------  ----------  --------------  -----  ------  ---  ----  ----  ----  -----  ------
drunk                    6               1   1.24   10.48    0     0     0     0    250  ▇▁▁▁▁ 

```r
# Checking out DV by variable ‘female’
nys_1 %>% group_by(female) %>% skim(drunk)
```


Table: (\#tab:unnamed-chunk-6)Data summary

                                      
-------------------------  -----------
Name                       Piped data 
Number of rows             1725       
Number of columns          26         
_______________________               
Column type frequency:                
numeric                    1          
________________________              
Group variables            female     
-------------------------  -----------


**Variable type: numeric**

skim_variable    female   n_missing   complete_rate   mean      sd   p0   p25   p50   p75   p100  hist  
--------------  -------  ----------  --------------  -----  ------  ---  ----  ----  ----  -----  ------
drunk                 0           3               1   1.61   11.75    0     0     0     0    250  ▇▁▁▁▁ 
drunk                 1           3               1   0.82    8.82    0     0     0     0    240  ▇▁▁▁▁ 

<div style="margin-bottom:50px;">
</div> 

From the output, it seems that most youth did not report getting drunk in the past year; this is evidenced by the mean. The mean, however, shows that males have a slightly higher level of being drunk than females (1.61 as opposed to 0.82). Is this a statistically significant difference?

Our observation of a difference between means prompts us to test whether this difference is an actual difference, or if it is attributed to chance. 

Before we conduct the test to tell us this, we conduct the **test for equality of variance**. This is an F-test that evaluates the null hypothesis that the variances of the two groups are equal. When we want to compare variances, we conduct this test as the variances may affect how we specify our t-test.

<div style="margin-bottom:35px;">
</div> 


```r
# DV comes first in code, then the IV
var.test(nys_1$drunk~nys_1$female)
```

```
## 
## 	F test to compare two variances
## 
## data:  nys_1$drunk by nys_1$female
## F = 1.7729, num df = 914, denom df = 803, p-value < 2.2e-16
## alternative hypothesis: true ratio of variances is not equal to 1
## 95 percent confidence interval:
##  1.549899 2.026885
## sample estimates:
## ratio of variances 
##           1.772941
```

<div style="margin-bottom:50px;">
</div> 

The information to focus on in the output are the alternative hypothesis, the F-statistic, and associated p-value. The alternative hypothesis states that the variances are not equal to 1, meaning they are not equal to each other. The p-value is very small, so we reject the null hypothesis that the variances are equal to each other. Conducting the F-test is an important step before the t-test because now we must set `var.equal` to `FALSE` in the following independent sample t-test. 

<div style="margin-bottom:35px;">
</div> 


```r
# Run the t-test with var.equal option set to false 
t.test(nys_1$drunk~nys_1$female, var.equal = FALSE)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  nys_1$drunk by nys_1$female
## t = 1.5994, df = 1677.3, p-value = 0.1099
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.1800974  1.7716968
## sample estimates:
## mean in group 0 mean in group 1 
##        1.614208        0.818408
```

```r
# You can save your results in an object, too, to refer back to later:
t_test_results <- t.test(nys_1$drunk~nys_1$female, var.equal = FALSE)

# Print independent t-test results 
t_test_results
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  nys_1$drunk by nys_1$female
## t = 1.5994, df = 1677.3, p-value = 0.1099
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.1800974  1.7716968
## sample estimates:
## mean in group 0 mean in group 1 
##        1.614208        0.818408
```

<div style="margin-bottom:50px;">
</div> 

From the output, focus on the means, alternative hypothesis, the t-statistics, the p-value, and the 95% confidence interval (CI). 

First, the means show that males got drunk an average of 1.6 times the year before, whereas females got drunk an average of 0.8 times, similar to the output of our descriptive statistics. Second, the alternative hypothesis (a true difference in means) is not equal to 0, which is what we expect. Third, the t-statistic reports 1.5994 with an associated p-value of 0.1099, which is greater than α = 0.05, so we fail to reject the null hypothesis. Fourth, the 95% CI tells us that, 95% of the time, the true t-value in the population will fall between -0.1801 and 1.772. We conclude that the true difference in means is not significantly different from 0 – there is *no significant difference in frequency of getting drunk between males and females in the past year*.

<div style="margin-bottom:50px;">
</div> 

---

#### Dependent Sample T-test

<div style="margin-bottom:35px;">
</div> 

When you are interested in comparing means of two groups that are related to each other, the **dependent sample t-test** or *paired sample t-test* is appropriate. What this means is that the responses are paired together because there is a prior connection between them. For example, I have two groups where the first group comprises test scores before an intervention and the second group comprises test scores after that intervention of the same people from the first group – a dependent sample t-test is called for. Another example: the first group are of brothers and the second group comprises sisters to those in the first group.  This, too, would call for a dependent sample t-test. 

We return to our NYS sample, which is drawn from a longitudinal study whereby the same people are surveyed over multiple time periods. In this example, we compare the behaviours of youth from Wave 1 to Wave 2 to address the research question: *‘Do youth report a significantly different number of instances where they steal something over $50 in Wave 2 than in Wave 1?’* Our non-directional null and alternative hypotheses are as follows:

<div style="margin-bottom:35px;">
</div> 

$H_0$: There is no significant difference in the number of times a youth reported stealing something worth more than $50 between Wave 1 and Wave 2. 

<div style="margin-bottom:15px;">
</div> 

$H_A$: There is a significant difference in the number of times a youth reported stealing something worth more than $50 between Wave 1 and Wave 2.

<div style="margin-bottom:35px;">
</div> 

As responses from both Waves 1 and 2 are required, cases without this pair of responses will be dropped automatically when our analysis is conducted. This t-test also requires the DV to be stored in two separate variables and the level of measurement to be ratio or interval. Let us get to know our data:

<div style="margin-bottom:35px;">
</div> 


```r
# View NYS wave 2 data 
View(nys_2)
```

<div style="margin-bottom:50px;">
</div> 

The variable `CASEID` is the case identification numbers and these are found across all waves. We want to examine Waves 1 and 2, so will need to merge the waves together using the variable `CASEID`:

<div style="margin-bottom:35px;">
</div> 


```r
# Merging waves 1 and 2 of data together by CASEID
# Putting this merged data into the data frame object called ‘nys_merged’
nys_merged <-merge(nys_1, nys_2, by="CASEID")
```
<div style="margin-bottom:50px;">
</div> 

Now, for the dependent sample t-test whereby we use the variables `thftg50` and `thftg50_w2`:

<div style="margin-bottom:35px;">
</div> 


```r
# Let us run the dependent samples t-test 
# Specify TRUE for the paired option 
t.test(nys_merged$thftg50_w2, nys_merged$thftg50, paired= TRUE)
```

```
## 
## 	Paired t-test
## 
## data:  nys_merged$thftg50_w2 and nys_merged$thftg50
## t = 1.7707, df = 1648, p-value = 0.07679
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.004178788  0.081801589
## sample estimates:
## mean of the differences 
##               0.0388114
```

<div style="margin-bottom:50px;">
</div> 

The results indicate that we fail to reject the null hypothesis as the p-value is above α = 0.05. We conclude that there is no significant difference in thefts of items totaling more than $50 between the paired Waves 1 and 2 responses.

<div style="margin-bottom:50px;">
</div> 

---


### Chi-square

<div style="margin-bottom:50px;">
</div> 

We now open the 2007–2008 wave of the British Crime Survey dataset using the `read.dta ()` function. We name the data frame `BCS0708`. Use the `View()` and `dim()` functions to get to know your data.



The **chi-square statistic** is a test of statistical significance for two categorical variables. It tells us how much the observed distribution differs from the one expected under the null hypothesis. To begin to even understand this definition, we start with cross tabulations or **contingency tables**. These appear as a table that shows the crossed frequency distributions of more than one variable simultaneously and are particularly helpful in exploring relationships between categorical variables that do not have too many categories. Specifically, cross-tabulations have the same meaning except they are applied only to relationships between two categorical variables. 

We produce a cross tabulation of victimisation ( `bcsvictim` ) and whether rubbish is a problem in the area where the respondent lives (`rubbcomm`). According to *Broken Windows Theory*, proposed by James Q. Wilson and George Kelling, we should see a relationship between these two variables. 

First, we check out our variables:

<div style="margin-bottom:35px;">
</div> 


```r
# Seeing what class these variables are
class(BCS0708$bcsvictim)
```

```
## [1] "haven_labelled" "vctrs_vctr"     "double"
```

```r
class(BCS0708$rubbcomm)
```

```
## [1] "haven_labelled" "vctrs_vctr"     "double"
```

```r
# 0-Not victim of crime; 1-Victim of crime
attributes(BCS0708$bcsvictim) 
```

```
## $label
## [1] "experience of any crime in the previous 12 months"
## 
## $format.stata
## [1] "%8.0g"
## 
## $class
## [1] "haven_labelled" "vctrs_vctr"     "double"        
## 
## $labels
## not a victim of crime       victim of crime 
##                     0                     1
```

```r
# 5-point Likert-scale ranging from 1 (very common) to 4 (not common) 
attributes(BCS0708$rubbcomm)
```

```
## $label
## [1] "in the immediate area how common is litter\\rubbish"
## 
## $format.stata
## [1] "%8.0g"
## 
## $class
## [1] "haven_labelled" "vctrs_vctr"     "double"        
## 
## $labels
##       very common     fairly common   not very common not at all common 
##                 1                 2                 3                 4 
##         not coded 
##                 5
```

```r
table(BCS0708$bcsvictim)
```

```
## 
##    0    1 
## 9318 2358
```

```r
# If you want the frequency distribution with labels, use ‘as_factor ()’
table(as_factor(BCS0708$bcsvictim))
```

```
## 
## not a victim of crime       victim of crime 
##                  9318                  2358
```

```r
table(as_factor(BCS0708$rubbcomm))
```

```
## 
##       very common     fairly common   not very common not at all common 
##               204              1244              4154              5463 
##         not coded 
##                 0
```

```r
# Checking for any missing values using ‘sum ()’ to count number of NA data
sum(is.na(BCS0708$bcsvictim))
```

```
## [1] 0
```

```r
# Value of 5 indicates missing
sum(is.na(BCS0708$rubbcomm))
```

```
## [1] 611
```

<div style="margin-bottom:50px;">
</div> 

For the DV, we are missing 611 cases. For this course unit, keep in mind that all the statistical tests you will learn rely on **full cases analysis** whereby the tests exclude cases that have missing values. There are appropriate ways in dealing with missing data but this is beyond the scope of this class. 

There are a couple of ways of producing cross tabulations in `R`:

<div style="margin-bottom:35px;">
</div> 


```r
# Basic R
table(as_factor(BCS0708$bcsvictim), 
      as_factor(BCS0708$rubbcomm))
```

```
##                        
##                         very common fairly common not very common
##   not a victim of crime         141           876            3173
##   victim of crime                63           368             981
##                        
##                         not at all common not coded
##   not a victim of crime              4614         0
##   victim of crime                     849         0
```

```r
# dplyr
results <- BCS0708 %>% # ‘fct_explicit_na()’ function from the forcats package to get an explicit factor level from our # missing values
  group_by(fct_explicit_na(as_factor(rubbcomm))) %>% 
  # We use the function ‘mean()’ as the variable is binary and because it is coded as 0 and 1.
  summarize( count = n(), outcome_1 = mean(bcsvictim))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
# Auto-print the results stored in the newly created object 
results
```

```
## # A tibble: 5 x 3
##   `fct_explicit_na(as_factor(rubbcomm))` count outcome_1
##   <fct>                                  <int>     <dbl>
## 1 very common                              204     0.309
## 2 fairly common                           1244     0.296
## 3 not very common                         4154     0.236
## 4 not at all common                       5463     0.155
## 5 (Missing)                                611     0.159
```

<div style="margin-bottom:50px;">
</div> 

The `dplyr` coding seems more complicated than that of `basic R` but its output is clearer to read than the one produced by `R`, and it is more detailed. The proportion of victimised individuals are within each of the levels of the categorical, ordered measure of rubbish in the area. Victimisation appears higher (31%) in the areas where rubbish in the streets is a very common problem. 

To further explore contingency tables, the best package for this is `gmodels`. It allows you to produce cross tabulations in a format similar to the one used by commercial statistical packages SPSS and SAS. We use the function `CrossTable ()` , then the `with ()` function to identify the data frame at the outset instead of having to include it with each variable. 

<div style="margin-bottom:35px;">
</div> 


```r
# Define the rows in your table (rubbcomm) and then the variable that will define the columns # (bcsvictim)
with(BCS0708, CrossTable(as_factor(rubbcomm), 
                         as_factor(bcsvictim), 
prop.chisq = FALSE, 
format = c("SPSS")))
```

```
## 
##    Cell Contents
## |-------------------------|
## |                   Count |
## |             Row Percent |
## |          Column Percent |
## |           Total Percent |
## |-------------------------|
## 
## Total Observations in Table:  11065 
## 
##                     | as_factor(bcsvictim) 
## as_factor(rubbcomm) | not a victim of crime  |       victim of crime  |             Row Total | 
## --------------------|-----------------------|-----------------------|-----------------------|
##         very common |                  141  |                   63  |                  204  | 
##                     |               69.118% |               30.882% |                1.844% | 
##                     |                1.602% |                2.786% |                       | 
##                     |                1.274% |                0.569% |                       | 
## --------------------|-----------------------|-----------------------|-----------------------|
##       fairly common |                  876  |                  368  |                 1244  | 
##                     |               70.418% |               29.582% |               11.243% | 
##                     |                9.950% |               16.276% |                       | 
##                     |                7.917% |                3.326% |                       | 
## --------------------|-----------------------|-----------------------|-----------------------|
##     not very common |                 3173  |                  981  |                 4154  | 
##                     |               76.384% |               23.616% |               37.542% | 
##                     |               36.040% |               43.388% |                       | 
##                     |               28.676% |                8.866% |                       | 
## --------------------|-----------------------|-----------------------|-----------------------|
##   not at all common |                 4614  |                  849  |                 5463  | 
##                     |               84.459% |               15.541% |               49.372% | 
##                     |               52.408% |               37.550% |                       | 
##                     |               41.699% |                7.673% |                       | 
## --------------------|-----------------------|-----------------------|-----------------------|
##        Column Total |                 8804  |                 2261  |                11065  | 
##                     |               79.566% |               20.434% |                       | 
## --------------------|-----------------------|-----------------------|-----------------------|
## 
## 
```

<div style="margin-bottom:50px;">
</div> 

Cells for the central two columns are the total number of cases in each category, comprising the *row percentages*, the *column percentages*, and the *total percentages*. 

The contingency table shows that 63 people in the category ‘rubbish is very common’ were victims of a crime; this represents 30.88% of all the people in the ‘rubbish is very common’ category (your row percent), 2.79% of all the people in the 'victim of a crime' category (your column percent), and 0.57% of all the people in the sample. 

There is quite a lot of proportions that the contingency table will churn out, but you are only interested in the proportions or percentages that allow you to make meaningful comparisons. Again, this is where talk about independent and dependent variables come in. Although talking about variables like this is not common in these analyses as they would be, say, in regression, an analysis we learn later, it is good to get into the mindset of arranging our variables in this way. 

If you believe in broken windows theory, you will think of victimisation as the outcome we want to explain (Y) and rubbish in the area as a possible explanation for the variation in victimisation (X). If so, you will need to request percentages that allow you to make comparisons across `rubbcomm` for the outcome, `bcsvictim`. 

This is a very **important** point: often, cross tabulations are interpreted the wrong way because percentages were specified incorrectly. Two rules to help ensure you interpret cross-tabs (short for cross tabulations) correctly:

<div style="margin-bottom:35px;">
</div> 

1.	If your dependent variable is defining the rows, then you ask for the *column percentages*

<div style="margin-bottom:15px;">
</div> 

2.	If your dependent variable is defining the columns, then you ask for the *row percentages*

<div style="margin-bottom:35px;">
</div> 

Also, *you make the comparisons across the right percentages in the direction where they do not add up to a hundred percent*. For example, 30.88% of people who live in areas where rubbish is very common have been victimised, whereas only 15.54% of people who live in areas where rubbish is not at all common have been victimised in the previous year. To make it easier, we can ask `R` to only give us the percentages in which we are interested:

<div style="margin-bottom:35px;">
</div> 

```r
# prop.c is column and prop.t is total
with(BCS0708, CrossTable(as_factor(rubbcomm), 
                         as_factor(bcsvictim), 
                         prop.chisq = FALSE, prop.c = FALSE, prop.t = FALSE, format =
                           c("SPSS")))
```

```
## 
##    Cell Contents
## |-------------------------|
## |                   Count |
## |             Row Percent |
## |-------------------------|
## 
## Total Observations in Table:  11065 
## 
##                     | as_factor(bcsvictim) 
## as_factor(rubbcomm) | not a victim of crime  |       victim of crime  |             Row Total | 
## --------------------|-----------------------|-----------------------|-----------------------|
##         very common |                  141  |                   63  |                  204  | 
##                     |               69.118% |               30.882% |                1.844% | 
## --------------------|-----------------------|-----------------------|-----------------------|
##       fairly common |                  876  |                  368  |                 1244  | 
##                     |               70.418% |               29.582% |               11.243% | 
## --------------------|-----------------------|-----------------------|-----------------------|
##     not very common |                 3173  |                  981  |                 4154  | 
##                     |               76.384% |               23.616% |               37.542% | 
## --------------------|-----------------------|-----------------------|-----------------------|
##   not at all common |                 4614  |                  849  |                 5463  | 
##                     |               84.459% |               15.541% |               49.372% | 
## --------------------|-----------------------|-----------------------|-----------------------|
##        Column Total |                 8804  |                 2261  |                11065  | 
## --------------------|-----------------------|-----------------------|-----------------------|
## 
## 
```

<div style="margin-bottom:50px;">
</div> 

Now with this output, we only see the row percentages. **Marginal frequencies** appear as the right column and bottom row. *Row marginals* show the total number of cases in each row. For example, 204 people perceive rubbish as very common in the area where they are living and 1,244 perceive rubbish as fairly common in their area. *Column marginals* show the total number of cases in each column: 8,804 non-victims and 2,261 victims.

In the central cells, these are the total number for each combination of categories. For example, for row percentages, 63 people who perceive rubbish as very common in their area and who are a victim of a crime represent 30.88% of all people who have reported that rubbish is common (63 out of 204). For column percentages (shown previously), 63 people who live in areas where rubbish is very common and are victims represent 2.79% of all people who were victims of crime (63 out of 2,261). 

We now have an understanding of cross-tabs so that we can interpret the **chi-square statistic**. Our null and alternative hypotheses are as follows:

<div style="margin-bottom:35px;">
</div> 

$H_0$: Victimisation and how common rubbish is in the area are not related to each other. (They are considered independent of each other.)

<div style="margin-bottom:15px;">
</div> 

$H_A$: Victimisation and how common rubbish is in the area are significantly related to each other. (They are considered dependent on each other.)

<div style="margin-bottom:35px;">
</div> 

The test does the following: 
(1) compares these expected frequencies with the ones we actually observe in each of the cells, (2) then averages the differences across the cells, and (3) produces a standardised value, *χ*$^2$ (the chi-square statistic).

We then look at a chi-square distribution to see how probable or improbable this value is. But, in practice, the p-value helps us ascertain this more quickly. 

**Expected frequencies** are the number of cases you would expect to see in each cell within a contingency table if there was no relationship between the two variables. **Observed frequencies** are the cases that we actually see in our sample. We use the `CrossTable ()` function again: 

<div style="margin-bottom:35px;">
</div> 


```r
with(BCS0708, CrossTable(as_factor(rubbcomm), 
                         as_factor(bcsvictim), 
                         expected = TRUE, prop.c = FALSE, prop.t = FALSE, format =
                           c("SPSS") ))
```

```
## 
##    Cell Contents
## |-------------------------|
## |                   Count |
## |         Expected Values |
## | Chi-square contribution |
## |             Row Percent |
## |-------------------------|
## 
## Total Observations in Table:  11065 
## 
##                     | as_factor(bcsvictim) 
## as_factor(rubbcomm) | not a victim of crime  |       victim of crime  |             Row Total | 
## --------------------|-----------------------|-----------------------|-----------------------|
##         very common |                  141  |                   63  |                  204  | 
##                     |              162.315  |               41.685  |                       | 
##                     |                2.799  |               10.899  |                       | 
##                     |               69.118% |               30.882% |                1.844% | 
## --------------------|-----------------------|-----------------------|-----------------------|
##       fairly common |                  876  |                  368  |                 1244  | 
##                     |              989.804  |              254.196  |                       | 
##                     |               13.085  |               50.950  |                       | 
##                     |               70.418% |               29.582% |               11.243% | 
## --------------------|-----------------------|-----------------------|-----------------------|
##     not very common |                 3173  |                  981  |                 4154  | 
##                     |             3305.180  |              848.820  |                       | 
##                     |                5.286  |               20.583  |                       | 
##                     |               76.384% |               23.616% |               37.542% | 
## --------------------|-----------------------|-----------------------|-----------------------|
##   not at all common |                 4614  |                  849  |                 5463  | 
##                     |             4346.701  |             1116.299  |                       | 
##                     |               16.437  |               64.005  |                       | 
##                     |               84.459% |               15.541% |               49.372% | 
## --------------------|-----------------------|-----------------------|-----------------------|
##        Column Total |                 8804  |                 2261  |                11065  | 
## --------------------|-----------------------|-----------------------|-----------------------|
## 
##  
## Statistics for All Table Factors
## 
## 
## Pearson's Chi-squared test 
## ------------------------------------------------------------
## Chi^2 =  184.0443     d.f. =  3     p =  1.180409e-39 
## 
## 
##  
##        Minimum expected frequency: 41.68495
```
<div style="margin-bottom:50px;">
</div> 

The output shows that, for example, 63 people lived in areas where rubbish was very common and experienced victimisation in the past year. Under the null hypothesis of no relationship, however, we should expect this value to be 41.69. Thus, more people are in this cell than we would expect under the null hypothesis. 

The chi-square value is 184.04, with 3 degrees of freedom (df). The df is obtained by the number of rows minus one, then multiplied by the number of columns minus one: (4 − 1)*(2 − 1). The probability associated with this particular value is nearly zero (1.180e-39). This value is considerably lower than the standard alpha level of 0.05. We conclude that there is a significant relationship between victimisation and the presence of rubbish. We reject the null hypothesis.

If you do not want to use `CrossTable ()`, you can use `chisq.test ()`  to give you the chi-square value:

<div style="margin-bottom:35px;">
</div> 


```r
chisq.test(BCS0708$rubbcomm, BCS0708$bcsvictim)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  BCS0708$rubbcomm and BCS0708$bcsvictim
## X-squared = 184.04, df = 3, p-value < 2.2e-16
```

<div style="margin-bottom:50px;">
</div> 

The chi-square statistic only tells us whether there is a relationship or not between two variables; it says nothing about strength of relationship or exactly what differences between observed and expected frequencies are driving the results. 

For the chi-square to work though, it needs to have a sufficient number of cases in each cell. Notice that `R` was telling us that the minimum expected frequency is 41.68. One rule of thumb is that all expected cell counts should be above 5. If we have a small number in the cells, one alternative is to use **Fisher’s exact test**:

<div style="margin-bottom:35px;">
</div> 



```r
with(BCS0708, fisher.test(rubbcomm, bcsvictim))
```

```r
# If you get an error message about increasing the size of your workspace, do so with this code:
fisher.test(BCS0708$rubbcomm, BCS0708$bcsvictim, workspace = 2e+07, hybrid = TRUE)
```

```
## 
## 	Fisher's Exact Test for Count Data hybrid using asym.chisq. iff
## 	(exp=5, perc=80, Emin=1)
## 
## data:  BCS0708$rubbcomm and BCS0708$bcsvictim
## p-value < 2.2e-16
## alternative hypothesis: two.sided
```

<div style="margin-bottom:50px;">
</div> 

We did not need this test for our example, but we use it to illustrate how to use Fisher’s Exact Test when counts in cells are low. The p-value from Fisher’s exact test is still smaller than α = 0.05, so we reach the same conclusion that the relationship observed can be generalised to the population. 

Last, we had observed that there were differences between the observed and expected frequencies. This is called a **residual**. Some differences seem larger than others. For example, there were about 21 more people that lived in areas where rubbish was very common and they experienced victimisation than what were expected under the null hypothesis. When you see large differences, it is unsurprising to also expect that the cell in question may be playing a particularly strong role in driving the relationship between rubbish and victimisation. 

We are not sure, however, of what is considered a large residual. A statistic that helps address this is the **adjusted standardised residuals**, which behaves like a z-score. Residuals indicate the difference between the expected and the observed counts on a standardised scale. When the null hypothesis is true, there is only about a 5% chance that any particular standardised residual exceeds 2 in absolute value. 

Whenever you see differences that are greater than 2, the difference between expected and observed frequencies in that particular cell is significant and is driving the results of your chi-square test. Values above +3 or below −3 are considered convincing evidence of a true effect in that cell:

<div style="margin-bottom:35px;">
</div> 


```r
# Include argument ‘asresid= TRUE’ to include adjusted standardised residuals
with(BCS0708, CrossTable(as_factor(rubbcomm), as_factor(bcsvictim), expected = TRUE,
                         prop.chisq = FALSE, prop.c = FALSE, prop.t = FALSE, asresid =
                           TRUE, format = c("SPSS") ))
```

```
## 
##    Cell Contents
## |-------------------------|
## |                   Count |
## |         Expected Values |
## |             Row Percent |
## |           Adj Std Resid |
## |-------------------------|
## 
## Total Observations in Table:  11065 
## 
##                     | as_factor(bcsvictim) 
## as_factor(rubbcomm) | not a victim of crime  |       victim of crime  |             Row Total | 
## --------------------|-----------------------|-----------------------|-----------------------|
##         very common |                  141  |                   63  |                  204  | 
##                     |              162.315  |               41.685  |                       | 
##                     |               69.118% |               30.882% |                1.844% | 
##                     |               -3.736  |                3.736  |                       | 
## --------------------|-----------------------|-----------------------|-----------------------|
##       fairly common |                  876  |                  368  |                 1244  | 
##                     |              989.804  |              254.196  |                       | 
##                     |               70.418% |               29.582% |               11.243% | 
##                     |               -8.494  |                8.494  |                       | 
## --------------------|-----------------------|-----------------------|-----------------------|
##     not very common |                 3173  |                  981  |                 4154  | 
##                     |             3305.180  |              848.820  |                       | 
##                     |               76.384% |               23.616% |               37.542% | 
##                     |               -6.436  |                6.436  |                       | 
## --------------------|-----------------------|-----------------------|-----------------------|
##   not at all common |                 4614  |                  849  |                 5463  | 
##                     |             4346.701  |             1116.299  |                       | 
##                     |               84.459% |               15.541% |               49.372% | 
##                     |               12.605  |              -12.605  |                       | 
## --------------------|-----------------------|-----------------------|-----------------------|
##        Column Total |                 8804  |                 2261  |                11065  | 
## --------------------|-----------------------|-----------------------|-----------------------|
## 
##  
## Statistics for All Table Factors
## 
## 
## Pearson's Chi-squared test 
## ------------------------------------------------------------
## Chi^2 =  184.0443     d.f. =  3     p =  1.180409e-39 
## 
## 
##  
##        Minimum expected frequency: 41.68495
```

<div style="margin-bottom:50px;">
</div> 

The column representing the outcome of interest (victimisation present), shows the adjusted standardised residual is lower than −12 for the ‘not at all common’ category. That is the largest residual for the DV. The expected count under the null hypothesis in this cell is much higher than the observed count.

<div style="margin-bottom:50px;">
</div> 
---

<div style="margin-bottom:50px;">
</div> 


## SUMMARY

<div style="margin-bottom:50px;">
</div> 

We learned a few inferential statistical analyses to examine relationships with categorical variables, known as **factors** in `R`. These variables, in today’s analyses, were arranged as **independent variables** or **dependent variables**. When analysing a relationship between a categorical and a numeric variable, the t-test was used. We learned to conduct **independent sample** and **dependent sample** t-tests. 

Before we performed the former t-test, we conducted the **test for equality of variance**. In the latter section, we learned to conduct a chi-square test, a test of statistical significance between two categorical variables. This involved **contingency tables**, whereby we examined specifically **cross tabulations**. 

The chi-square statistic contrasts **expected** and **observed** frequencies in the cross-tab. When counts in any one cell is lower than five, **Fisher’s Exact Test** is used instead. We also check the **adjusted standardised residuals** to identify which contrast of frequencies are driving the observed results. 

<div style="margin-bottom:100px;">
</div> 

Homework time!

<div style="margin-bottom:300px;">
</div> 
