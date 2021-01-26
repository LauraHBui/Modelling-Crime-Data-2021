
# Descriptive Statistics
#### *Central Tendency, Outliers, and Dispersion* {-}


---

##### **Learning Outcomes** {-}
- Revisit what descriptive statistics are and their importance in understanding your data
- Learn / review measures of the central tendency and dispersion and how to conduct them 
- Learn how to identify outliers and skewness 

<div style="margin-bottom:30px;">
</div>

##### **Today’s Learning Tools:** {-}
<div style="margin-bottom:15px;">
</div>

##### *Data:* {-}
-	Law Enforcement Management and Administrative Statistics (LEMAS)-Body-Worn Camera Supplement (BWCS) Survey
<div style="margin-bottom:10px;">
</div>
-	2004 Survey of Inmates in State and Federal Correctional Facilities (SISFCF)

<div style="margin-bottom:15px;">
</div>

##### *Packages:* {-}
-	`dplyr`
-	`ggplot2`
-	`here`
-	`modeest`
-	`moments`
-	`qualvar`
-	`skimr`

<div style="margin-bottom:15px;">
</div>

##### *Functions introduced (and packages to which they belong)* {-}
-	`attach()` : Commonly used to attach a data frame object for easier access (`base R`)
-	`diff()` : Computes differences between values in a numeric vector (`base R`)
-	`dim()` : Check the dimensions of an `R` object (`base R`)
-	`DM()` : Computes deviation from the mode (`qualvar`)
-	`group_by()` : Group observations by variable(s) for performing operations (`dplyr`)
-	`IQR()` : Compute interquartile range (`base R`)
-	`is.na()` : Returns `TRUE` when values are missing, `FALSE` if not (`base R`)
-	`mean()` : Compute arithmetic mean (`base R`)
-	`max()` : Returns the maximum value (`base R`)
-	`min()` : Returns the minimum value (`base R`)
-	`mlv()` : Compute the mode (`modeest`)
-	`quantile()` : Compute quantiles as per specified probabilities (`base R`)
-	`sd()` : Computes standard deviation of a numeric vector (`base R`)
-	`skewness()` : Calculate degree of skewness in a numeric vector (`modeest`)
-	`skim()` : Provide summary statistics specific to object class (`skimr`)
-	`str()` : Returns internal structure of an `R` object (`base R`)
-	`summarize()` : Create new summary variable(s), e.g., counts, mean (`dplyr`)
-	`summary()` : Produce summary of model results (`base R`)
-	`table()` : Generates a frequency table (`base R`)
- `var()` : Computes variance (`base R`)

<div style="margin-bottom:30px;">
</div>
---

## Revisiting Descriptive Statistics
<div style="margin-bottom:30px;">
</div>

The field of statistics is divided into two main branches: descriptive and inferential. Much of what you will cover today on descriptive statistics will be a review from last semester, but learning to conduct them in `R` will be a new learning experience. 

So, what are descriptive statistics? If general statistics is concerned with the study of how best to collect, analyse, and make conclusions about data, then this specific branch, descriptive statistics, is concerned with the sample distribution and the population distribution from which the sample is drawn. Basically, descriptive statistics are ways of describing your data. 

Similar to last week’s lesson on data visualization, describing your data is important because it helps you identify patterns and anomalies. In addition, it gives others a succinct understanding about your data, so it facilitates good communication. We revisit and learn another three substantive topics today: the **central tendency**, **outliers**, and **dispersion**. 

We start by doing the usual routine, but with new data on police body-worn cameras: 
<div style="margin-bottom:15px;">
</div>

1.	Open up your existing `R` project
<div style="margin-bottom:15px;">
</div>

2.	Install and load the required packages (listed at top of this lesson) using `install.packages ()`  
<div style="margin-bottom:15px;">
</div>

3.	Open only the 2016 LEMAS-BWCS dataset (37302-0001-Data.rda). These data are from the [Inter-university Consortium for Political and Social Research (ICPSR) website](https://www.icpsr.umich.edu/web/pages/) and you can find them by using the dataset name, which refers to the ICPSR study number. The data are stored in an `R` data file format (.rda). 
<div style="margin-bottom:15px;">
</div>

4.	We will need to use the `load ()` function to import the data frame into our environment, specifying the working directory using `here()` like we have in Lesson 2.1.


<div style="margin-bottom:15px;">
</div>

5.	Name the data frame `bwcs` by using the `<-` assignment operator.


<div style="margin-bottom:15px;">
</div>

6.	Use the function `View(bwcs)` to ensure the file is loaded and to get to know your data. You can also use the function `dim(bwcs)` to see the number of observations and variables.

<div style="margin-bottom:30px;">
</div>

---

## Today’s 3

Two primary ways of describing your data are having to do with the central tendency and their dispersion. We also learn about outliers. 

<div style="margin-bottom:35px;">
</div>
---

### Central Tendency
<div style="margin-bottom:15px;">
</div>

Central tendency refers to a descriptive summary of the centre of the data’s distribution; it takes the form of a single number that is meant to represent the middle or average of the data. The **mean**, **median**, and **mode** are common statistics of the central tendency. 

The *mean* is the average and it is useful when we want to summarise a variable quickly. Its disadvantage is that it is sensitive to extreme values, so the mean can be distorted easily. 

To address this sensitivity, the *median* is a better measure because it is a robust estimate, so is not easily swayed by extreme values. It is the middle of the distribution. 

The *mode* helps give an idea of what is the most typical value in the distribution, which is the most frequently occurring case in the data. 

From today’s data, we are interested in exploring the adoption of body-worn cameras (BWCs) and their usage in this sample of agencies. The variables that will help us explore this is `Q_10A` because it measures whether the agency has adopted BWCs and `Q_12` because it measures the number of cameras that agencies reported using. 

First, however, we want to know the class of this variable – it is about getting to know our data before diving into anything more. Then we produce our measures of central tendency:

<div style="margin-bottom:35px;">
</div>


```r
# Check the class of the variable 
class(bwcs$Q_10A)  # we see this is a factor variable
```

```
## [1] "factor"
```

```r
# Which response was the most frequent
# Save the mode of Q10_A into the object ‘mode_adopted’
# Ensure the package 'modeest' is loaded
mode_adopted <- mlv(bwcs$Q_10A) 
mode_adopted
```

```
## [1] (2) Agency has not acquired
## 2 Levels: (1) Agency has acquired in any form (including testing) ...
```
<div style="margin-bottom:50px;">
</div>

The `mlv ()` function (acronym for most likely values) from the `modeest` package is used to obtain the mode. The modal response of all agencies was ‘No’, meaning that they had not adopted BWCs as of the 2016 survey. 

Our exploration into the adoption of BWCs has so far yielded the knowledge that the majority of agencies had not adopted BWCs as of 2016. But how about those that have done so? To what extent do they use BWCs? This is where variable `Q_12` comes in handy:


<div style="margin-bottom:35px;">
</div>

```r
# Check the class of variable Q_12
class(bwcs$Q_12) # we see this is a numeric variable
```

```
## [1] "numeric"
```

```r
# Check out this variable using some base R functions
# Reports the minimum value
 min(bwcs$Q_12, na.rm=TRUE)
```

```
## [1] 0
```

```r
# Reports the maximum value 
max(bwcs$Q_12, na.rm=TRUE)
```

```
## [1] 1200
```

```r
# table() provides a count for each unique value of a variable. 
# Since we see all values with the table() function, 
# We do not need the na.rm=TRUE code 
table(bwcs$Q_12)
```

```
## 
##    0    1    2    3    4    5    6    7    8    9   10   11   12   13   14   15 
##   97  191  137  112  127  107  102   46   89   49   72   19   62   27   21   62 
##   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31 
##   16   22   26    7   48    8   18    6   12   20    9    6    9    4   18    3 
##   32   33   34   35   36   37   38   39   40   42   43   44   45   46   47   48 
##    8    1    1    9    8    5    2    3   14    4    4    1    3    1    3    7 
##   49   50   52   53   54   55   56   57   58   59   60   61   65   66   68   70 
##    2   25    4    2    4    3    3    3    4    1   15    1    7    2    1    5 
##   71   72   75   76   78   80   82   85   86   87   88   89   90   91   92   93 
##    1    2    3    1    1   11    1    7    2    1    2    2    8    1    1    1 
##   95   99  100  101  105  106  107  110  111  112  114  115  116  117  119  120 
##    1    1   19    1    1    1    1    4    1    2    2    3    1    1    1    4 
##  122  123  125  127  130  133  134  135  137  140  145  150  160  163  165  168 
##    1    1    2    1    3    1    1    2    1    3    1    7    3    1    1    1 
##  175  188  190  200  210  220  224  225  230  236  239  240  245  250  260  270 
##    3    1    2    6    1    2    1    2    2    1    1    1    1    4    1    2 
##  274  292  298  300  312  325  330  347  350  351  355  360  400  402  429  430 
##    1    1    1    5    1    1    1    1    1    1    1    2    2    1    1    1 
##  450  500  544  600  630  661  815  825  900 1079 1100 1200 
##    2    2    1    1    1    1    1    2    1    1    1    3
```
<div style="margin-bottom:50px;">
</div>

What the heck is `na.rm`? When calculating measures of central tendency, you need to tell `R` that you have missing (NA) cases. Using `na.rm = TRUE` will exclude cases that have already been defined as missing. If we do not specify this code, it will return `NaN` for agencies that have acquired BWCs because `Q_12` has missing data. If you have `NaN`, however, for the row defining agencies that have not acquired BWCs, this is all right because there would be no cases for them. 

Now let us find the average number of BWCs used by agencies that have responded ‘Yes’ in `Q10_A`. We will use two ways to determine the mean: the `dplyr` way and the `base R` way.

<div style="margin-bottom:35px;">
</div>


```r
# We only want to include agencies who reponded 'Yes' to Q_10A 
# dplyr method 
bwcs %>% 
  group_by(Q_10A) %>% 
  summarize(mean_deployed = mean(Q_12, na.rm = TRUE))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 2
##   Q_10A                                                   mean_deployed
##   <fct>                                                           <dbl>
## 1 (1) Agency has acquired in any form (including testing)          31.8
## 2 (2) Agency has not acquired                                     NaN
```

```r
# Base R method 
mean(bwcs$Q_12, na.rm = TRUE)
```

```
## [1] 31.82024
```
<div style="margin-bottom:50px;">
</div>

The answers are the same: 31.8 . We use both methods because there may be situations where one is more appropriate than the other (e.g., maybe you want to see means for the individual categories when they are not `NaN`), so two ways are provided for future reference. Next, we check out the median, as, remember, the mean is susceptible to outliers: 

<div style="margin-bottom:35px;">
</div>

```r
# Use the same format as above, this time using the median() function 
# dplyr method 
bwcs %>% group_by(Q_10A) %>% summarize(med_deployed = median(Q_12, na.rm = TRUE))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 2
##   Q_10A                                                   med_deployed
##   <fct>                                                          <dbl>
## 1 (1) Agency has acquired in any form (including testing)            8
## 2 (2) Agency has not acquired                                       NA
```

```r
# Base R method 
median(bwcs$Q_12, na.rm = TRUE)
```

```
## [1] 8
```
<div style="margin-bottom:50px;">
</div>

Again, both methods to obtain the median are the same, but the median differs a lot from the mean: it is 8. Now that we have calculated these measures individually, we can now combine them together to form one code. This is where the `dplyr` method is most handy:

<div style="margin-bottom:35px;">
</div>

```r
# Table containing the mean, median, mode, and total number of BWCs deployed 
bwcs %>% 
group_by(Q_10A) %>% 
summarize(mean_deployed = mean(Q_12, na.rm = TRUE), med_deployed = median(Q_12, na.rm = TRUE), mode_deployed = mlv(Q_12, method='mfv', na.rm = TRUE), total = sum(Q_12, na.rm = TRUE))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 2 x 5
##   Q_10A                           mean_deployed med_deployed mode_deployed total
##   <fct>                                   <dbl>        <dbl>         <dbl> <dbl>
## 1 (1) Agency has acquired in any…          31.8            8             1 60363
## 2 (2) Agency has not acquired             NaN             NA           NaN     0
```
<div style="margin-bottom:50px;">
</div>

Another handy package for descriptive statistics is `skimr`. The function `skim ()` produces measures of central tendency and measures of dispersion (we will learn more on these in the later section), and number of missing values. A great feature of this is that it also includes a histogram of the numeric variables specified. If you do not want to specify any variables, `skim ()` will summarise your entire data frame, and this may be good, but depends on the size of your dataset:

<div style="margin-bottom:35px;">
</div>


```r
# Produce a summary of your Q_12 variable, grouped by Q_10 using skim() 
bwcs %>% 
  group_by(Q_10A) %>% 
  skim(Q_12)
```


Table: (\#tab:unnamed-chunk-11)Data summary

                                      
-------------------------  -----------
Name                       Piped data 
Number of rows             3928       
Number of columns          260        
_______________________               
Column type frequency:                
numeric                    1          
________________________              
Group variables            Q_10A      
-------------------------  -----------


**Variable type: numeric**

skim_variable   Q_10A                                                      n_missing   complete_rate    mean      sd   p0   p25   p50   p75   p100  hist  
--------------  --------------------------------------------------------  ----------  --------------  ------  ------  ---  ----  ----  ----  -----  ------
Q_12            (1) Agency has acquired in any form (including testing)           18            0.99   31.82   92.27    0     3     8    20   1200  ▇▁▁▁▁ 
Q_12            (2) Agency has not acquired                                     2013            0.00     NaN      NA   NA    NA    NA    NA     NA        

<div style="margin-bottom:50px;">
</div>

---

### Outliers
<div style="margin-bottom:30px;">
</div>

Recall the main disadvantage of the mean; it is not robust to extreme values, otherwise known as **outliers**. 

What exactly constitutes an *outlier*? This is where we will need to define what is meant by outlier. 

One way of determining whether a case is an outlier is if it is above or below 1.5 multiplied by the **interquartile range** (IQR), or for extreme outliers, above or below 3 multiplied by IQR. 

The IQR is another robust estimate and is the 75th percentile observation (the third quartile) minus the 25th percentile observation (the first quartile) in your distribution. The first and third quartiles are known as **Tukey fences**. 

Now we use the IQR to find and save the outliers for the `Q_12` variable:

<div style="margin-bottom:35px;">
</div>

```r
# First, let us get the IQR of the Q_12 variable using the IQR function 
bwc_deployed_iqr <- IQR(bwcs$Q_12, na.rm = TRUE) 

# It is now saved as an object
bwc_deployed_iqr
```

```
## [1] 17
```

```r
# Then, get the 1st and 3rd quartiles of the Q_12 variable using quantile() 
bwc_deployed_1st <- quantile(bwcs$Q_12, 0.25, na.rm = TRUE) 
bwc_deployed_3rd <- quantile(bwcs$Q_12, 0.75, na.rm = TRUE)


# They are now saved as objects
bwc_deployed_1st
```

```
## 25% 
##   3
```

```r
bwc_deployed_3rd
```

```
## 75% 
##  20
```

```r
# Next, calculate the fences 
# Lower Fence 
lower_inner_fence <- bwc_deployed_1st - 1.5 * bwc_deployed_iqr 
lower_inner_fence
```

```
##   25% 
## -22.5
```

```r
# Upper Fence 
upper_inner_fence <- bwc_deployed_3rd + 1.5 * bwc_deployed_iqr 
upper_inner_fence
```

```
##  75% 
## 45.5
```

```r
# You can also calculate the "outer fences" 
lower_outer_fence <- bwc_deployed_1st - 3 * bwc_deployed_iqr 
lower_outer_fence
```

```
## 25% 
## -48
```

```r
upper_outer_fence <- bwc_deployed_3rd + 3 * bwc_deployed_iqr 
upper_outer_fence
```

```
## 75% 
##  71
```

```r
# And save them in separate objects, ‘outliers’ and ‘outliers_extreme’ 
outliers <- bwcs %>% 
  filter(Q_12 > upper_inner_fence| Q_12 < lower_inner_fence) 

summary(outliers$Q_12)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    46.0    60.0   100.0   162.1   167.2  1200.0
```

```r
outliers_extreme <- bwcs %>% 
  filter(Q_12 > upper_outer_fence| Q_12 < lower_outer_fence)

summary(outliers_extreme$Q_12)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    72.0   100.0   130.0   215.4   241.2  1200.0
```
<div style="margin-bottom:50px;">
</div>

From last lesson on data visualization, you can also visualize outliers using the `boxplot` function from `ggplot`. 

<div style="margin-bottom:30px;">
</div>

#### **On Skewness**
<div style="margin-bottom:30px;">
</div>

Related to outliers is **skewness**. This has to do with the shape of the distribution. When your distribution is skewed, the majority of cases veer more to the left or right of the distribution, with a tail of outliers. An initial way of checking for skewness is to use a histogram, like from last week:

<div style="margin-bottom:35px;">
</div>


```r
# Histogram of number of BWCs deployed 
ggplot(data = bwcs, mapping = aes(x = Q_12)) + 
  geom_histogram(bins = 15, fill = "red") + 
  labs(x = "Number of BWCs Deployed", y = "Number of Agencies") + 
  ggtitle("Histogram of Number of BWCs Deployed") + 
  theme(plot.title = element_text(hjust = 0.5))
```

```
## Warning: Removed 2031 rows containing non-finite values (stat_bin).
```

<img src="04-descriptive-statistics_files/figure-html/unnamed-chunk-14-1.png" width="672" />
<div style="margin-bottom:50px;">
</div>

From our histogram, we see that most agencies deployed fewer than 250 BWCs and only a small proportion deployed more than 800. This asymmetric distribution is known as a **positively skewed distribution** -- one tail of the distribution is longer than the others because of outliers on the right side. 

Another way of checking for skewness is through the `skewness ()` function from the `moments` package. Skewness is determined by the following:

<div style="margin-bottom:30px;">
</div>

- 0 = no skewness as it is a symmetrical distribution
- positive value = means distribution is positively skewed or skewed right
- negative value = means distribution is negatively skewed or skewed left 

<div style="margin-bottom:30px;">
</div>

From the histogram above, do you think the skewness coefficient will indicate negative, positive, or no skewness? 

<div style="margin-bottom:35px;">
</div>

```r
bwc_skew <- skewness(bwcs$Q_12, na.rm = TRUE) 
```

```
## Warning: encountered a tie, and the difference between minimal and 
##                    maximal value is > length('x') * 'tie.limit'
## the distribution could be multimodal
```

```r
bwc_skew
```

```
## [1] 7.634726
```

```r
# A positive skew!
```

<div style="margin-bottom:50px;">
</div>

---

### Measures of Dispersion
<div style="margin-bottom:30px;">
</div>

What is meant by dispersion is the spread of values from the one value chosen to represent them all. That one value is usually the mean, or in the case of categorical variables, the mode. 

We learn about measures of dispersion using another dataset from the ICPSR website. The SISFCF survey has been conducted periodically since 1976, and the current survey (2004) data (04572-0001-Data.rda) can, too, be accessed at the ICPSR website and downloaded as an .rda file. Follow the same steps with loading the data as with the previous data on BWCs. Now, for this dataset, we do the following as well:

<div style="margin-bottom:35px;">
</div>


1.	Change the name of the data frame from da04572.0001 to `inmatesurvey04` by using the `<-` assignment operator. This will create an identical object but with a new name.

<div style="margin-bottom:15px;">
</div>


2.	We only deal with one dataset from this, so use the function `attach(inmatesurvey04)`. Remember to use `detach("inmatesurvey04")` once you are done with today’s lesson.


<div style="margin-bottom:30px;">
</div>

---

#### **Dispersion in Nominal and Ordinal Variables**
<div style="margin-bottom:30px;">
</div>

We learn how to conduct two measures of dispersion in `R` for categorical variables: the variation ratio and the index of qualitative variation:

The **variation ratio** (VR) tells us the proportion of cases that are not in the modal category – basically cases not in the most frequent or ‘popular’ category. The formula for the variation ratio (VR) is:

$$VR = 1 – ({\frac {N~modalcat~} {N~total~}})$$

<div style="margin-bottom:30px;">
</div>

$N~modalcat$ refers to the frequency of cases in the modal category, and $N~total~$ refers to the total number of cases. This formula states that VR is equal to 1 minus the proportion of cases that are in the modal category, which is the same as saying the proportion of cases that are not in the modal category. 

Now, for example, we are interested in knowing whether the modal category describes the overall work histories prior to arrest of federal inmates pretty accurately, or if there is a lot of variation in responses from inmates. To do so, we use the variable `V1748`:

<div style="margin-bottom:35px;">
</div>

```r
# Let us first take a look at our variable of interest, V1748 
table(V1748)  
```

```
## V1748
##  (1) Full-time  (2) Part-time (3) Occasional (7) Don't know    (8) Refused 
##           2180            284             65              0              1
```

```r
# Or use skim() 
skim(inmatesurvey04$V1748)
```


Table: (\#tab:unnamed-chunk-19)Data summary

                                                
-------------------------  ---------------------
Name                       inmatesurvey04$V1748 
Number of rows             3686                 
Number of columns          1                    
_______________________                         
Column type frequency:                          
factor                     1                    
________________________                        
Group variables            None                 
-------------------------  ---------------------


**Variable type: factor**

skim_variable    n_missing   complete_rate  ordered    n_unique  top_counts                           
--------------  ----------  --------------  --------  ---------  -------------------------------------
data                  1156            0.69  FALSE             4  (1): 2180, (2): 284, (3): 65, (8): 1 

```r
# Then, check if we have cases defined as missing using ‘is.na’ to get summary of missing cases
table(is.na(inmatesurvey04$V1748))
```

```
## 
## FALSE  TRUE 
##  2530  1156
```

```r
# While we can tell from the tables above that "Full-time" is the mode 
# We can also get R to provide the mode and save it in an object 
mode_employment <- mlv(V1748, na.rm = TRUE) 
mode_employment
```

```
## [1] (1) Full-time
## 5 Levels: (1) Full-time (2) Part-time (3) Occasional ... (8) Refused
```
<div style="margin-bottom:50px;">
</div>

Most federal inmates reported working full-time prior to arrest. Before we can calculate the variation ratio, we will have to recode the responses of *Don’t Know* and *Refused* as missing because `R` will think they are valid cases otherwise. We will create a new variable so not to overwrite the original one; then tell `R` that the latter two categories should be missing (NA):

<div style="margin-bottom:35px;">
</div>

```r
# Store the value ‘full-time’ in the object n_mode 
n_mode <- inmatesurvey04 %>% 
  filter(V1748 == "(1) Full-time" ) %>% 
  summarize(n = n()) 

# Get the number of cases who reported being employed prior to arrest 
# Store this value in the object n_employed 
n_employed <- inmatesurvey04 %>% 
  filter(!is.na(V1748)) %>% 
  summarize(n = n())

# Calculate the proportion 
# Store this value in the object proportion_mode 
proportion_mode <- n_mode/n_employed 

# Get the VR 
# Subtract proportion of cases in the modal category from 1 
vratio <- 1 - proportion_mode
vratio
```

```
##           n
## 1 0.1383399
```
<div style="margin-bottom:50px;">
</div>

The VR is 0.1383, meaning that the work history among federal inmates prior to arrest is relatively concentrated in the modal category of full-time employment. This is because the smaller the VR, the larger the number of cases there are in the model category. 

<div style="margin-bottom:30px;">
</div>

---

#### Onto the **Index of Qualitative Variation** (IQV):
<div style="margin-bottom:30px;">
</div>

The IQV is different from the VR because it considers dispersion across all categories, whereas the VR only views dispersion in terms of modal versus non-modal. 

The IQV lies between 0 and 1 and tells you the variability of the distribution. The smaller the value of the IQV, the smaller the amount of variability of the distribution. We use the `DM ()` function from the `qualvar` package, which stores frequencies of a categorical variable in a vector:

<div style="margin-bottom:35px;">
</div>


```r
# Get the index of qualitative variation for the same variable: V1748 
IQV<-as.vector(table(inmatesurvey04$V1748)) 

DM(IQV, na.rm = TRUE)
```

```
## [1] 0.1729249
```

<div style="margin-bottom:50px;">
</div>

The value is 0.1729, meaning that there is not much dispersion across the categories. This supports the result from the VR. 

<div style="margin-bottom:30px;">
</div>


#### **Dispersion in Interval and Ratio Variables**

<div style="margin-bottom:35px;">
</div>

These measures of dispersion are the most familiar because they are defined as the spread of values around a *mean*. We revisit three of these: the range, variance, and standard deviation. 

The **range** is the difference between the maximum and minimum value in a given distribution. We use the ratio-level variable `V2254`, a measure of the age at which inmates stated they first started smoking cigarettes regularly, as an example:

<div style="margin-bottom:35px;">
</div>

```r
# Examine the variable 
str(V2254)
```

```
##  num [1:3686] NA NA 19 NA 16 15 18 NA NA NA ...
##  - attr(*, "value.labels")= Named num [1:3] 98 97 0
##   ..- attr(*, "names")= chr [1:3] "Refused" "Don't know" "Never smoked regularly"
```

```r
attributes(V2254)
```

```
## $value.labels
##                Refused             Don't know Never smoked regularly 
##                     98                     97                      0
```

```r
# This variable has codes that do not indicate the number of times smoked. 
# These are 0 - never smoked; 97 - Don't know; and 98 – Refused
table(V2254)
```

```
## V2254
##   0   1   2   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21 
##  17   1   1   1   7  18  19  35  55  69 177 203 184 246 250 143 182 102  77  60 
##  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  42 
##  53  31  26  41  22  19  18   6  13   5  13   8   5  11   6   3   5   2   6   1 
##  44  45  47  50  53  55  57  97  98 
##   1   1   1   1   2   1   1  21   4
```

<div style="margin-bottom:50px;">
</div>

We notice that some categories are not about smoking, such as ‘Don’t know’ and ‘Refused’, and including these will give us an incorrect result. To resolve this, we must convert irrelevant categories into missing data:

<div style="margin-bottom:35px;">
</div>

```r
# Create a new variable so we do not write over the old one 
AgeSmokerRange<-V2254 

# Code 0, 97, and 98 values as missing 
AgeSmokerRange[AgeSmokerRange==0]<-NA 
AgeSmokerRange[AgeSmokerRange==97]<-NA 
AgeSmokerRange[AgeSmokerRange==98]<-NA

# Now for the range
# range () function prints the minimum and maximum values 
# Does not provide the actual range :-( 
range(AgeSmokerRange, na.rm = TRUE)
```

```
## [1]  1 57
```

```r
# Compute the range by assigning the min and max values to an object 
SmokerRange<-range(AgeSmokerRange, na.rm = TRUE) 

# Then, calculate the difference of that object 
diff(SmokerRange)
```

```
## [1] 56
```
<div style="margin-bottom:50px;">
</div>

The range of the age when federal inmates started smoking is 56. But you can see something strange while figuring out the range: the minimum is one year old! This may be something we want to exclude in analyses as it might not be valid -- maybe a mistake in coding -- so conducting descriptive statistics can help with tidying your data.

Now, the **variance** is about spread, specifically the sum of the squared deviations from the mean, then divided by the total number of cases. We use the function `var()` from the `stats`  package that comes already preinstalled. 

We use the variable `V2529`, which records the number of times inmates reported being written up for verbally assaulting a prison staff member, as an example: 

<div style="margin-bottom:35px;">
</div>

```r
# First, let us take a look at the variable 
summary(V2529)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    1.00    1.00    1.00   31.45    3.00  998.00    3545
```

```r
attributes(V2529)
```

```
## $value.labels
##    Refused Don't know 
##        998        997
```

```r
# Create a new variable so we do not write over the old one 
# Then code 997 and 998 values as missing 
VerbAssaultVar<-V2529 
VerbAssaultVar[VerbAssaultVar>=997]<-NA 

# Now let us calculate the variance 
var1 <- var(VerbAssaultVar, na.rm = TRUE) 
var1
```

```
## [1] 82.64384
```
<div style="margin-bottom:50px;">
</div>

The variance is 82.6, which is fairly dispersed, but if you got to know this variable, you will notice that one inmate self-reported 99 verbal assaults, so this will have had an influence on the variance. 

Last, we learn about the **standard deviation** (SD), which is the square root of the variance. The smaller it is, the more concentrated cases are around the mean, while larger values reflect a wider distance from the mean. In other words, the SD tells us how well the mean represents our data. Too large, then the mean is a poor representation, because there is too much variability. We use the variable `VerbAssaultVar` as an example:

<div style="margin-bottom:35px;">
</div>

```r
# Calculate SD of the VerbAssaultVar variable and save it to an object 
sd <- sd(VerbAssaultVar, na.rm = TRUE)
sd
```

```
## [1] 9.090866
```

```r
# Now to double check, we will see if the SD, squared, matches the variance
# We will call this var2. 
var2 <- sd^2
var2 # Yes, it does match!
```

```
## [1] 82.64384
```
<div style="margin-bottom:50px;">
</div>

The SD is 9.09087 meaning that this number of verbal assaults is one standard deviation above and below the mean, so the majority of reported verbal assaults, about 68% of them (more on the 68-95-97 rule next week), should fall within 9.09 above and below the mean. 

<div style="margin-bottom:30px;">
</div>

---

<div style="margin-bottom:50px;">
</div>

## SUMMARY

<div style="margin-bottom:30px;">
</div>

Descriptive statistics was the name of the game today. These are measures we use to describe our data. First, we learned about measures of central tendency: the **mean**, **median**, and **mode**. Second, pesky **outliers** were examined along with their cousin **skewness**.  A way of addressing outliers was through the robust estimate, the **interquartile range**. With skewness, visualizations were used to ascertain whether the distribution could be **positively skewed**. Third, we learned all about measures of dispersions: two for nominal and ordinal variables – the **variation ratio** and the **index of qualitative variation** -- and three for interval and ratio variables – the **range**, **variance**, and **standard deviation**. In some situations we found ourselves, missing values appeared. This is actually very common in data, so we addressed these with the R argument **na.rm**.  

<div style="margin-bottom:100px;">
</div>

Homework time!


<div style="margin-bottom:150px;">
</div>
