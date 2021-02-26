
# Descriptive Statistics
#### *Central Tendency, Outliers, and Dispersion* {-}


##### **Learning Outcomes** {-}
- Revisit what descriptive statistics are and their importance in understanding your data
- Learn / review measures of the central tendency and dispersion and how to conduct them 
- Learn how to identify outliers and skewness 


##### **Today’s Learning Tools:** {-}


##### *Total number of activities*: 11 {-}


##### *Data:* {-}

-	Law Enforcement Management and Administrative Statistics (LEMAS)-Body-Worn Camera Supplement (BWCS) Survey
-	2004 Survey of Inmates in State and Federal Correctional Facilities (SISFCF)

##### *Packages:* {-}
-	`dplyr`
-	`ggplot2`
-	`here`
-	`modeest`
-	`moments`
-	`qualvar`
-	`skimr`



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


---

## Revisiting Descriptive Statistics

The field of statistics is divided into two main branches: descriptive and inferential. Much of what you will cover today on descriptive statistics will be a review from last semester, but learning to conduct them in `R` will be a new learning experience. 

So, what are descriptive statistics? If general statistics is concerned with the study of how best to collect, analyse, and make conclusions about data, then this specific branch, descriptive statistics, is concerned with the sample distribution and the population distribution from which the sample is drawn. Basically, descriptive statistics are ways of describing your data. 

Similar to last week’s lesson on data visualization, describing your data is important because it helps you identify patterns and anomalies. In addition, it gives others a succinct understanding of your data, so it facilitates good communication. We revisit and learn another three substantive topics today: the **central tendency**, **outliers**, and **dispersion**. 


### Activity 1: Our preparation routine

We start by doing the usual routine, but with new data on police body-worn cameras: 


1.	Open up your existing `R` project


2.	Install and load the required packages (listed at the top of this lesson) using the function `install.packages()`  


3.	For now, open only the 2016 LEMAS-BWCS dataset (37302-0001-Data.rda). These data are from the [Inter-university Consortium for Political and Social Research (ICPSR) website](https://www.icpsr.umich.edu/web/pages/) and you can find them by using the dataset name, which refers to the ICPSR study number. The data are stored in an `R` data file format (.rda). 


4.	We will need to use the `load()` function to import the data frame into our environment, specifying the working directory using `here()` like we have in Lesson 2.1.


```r
library(here)
```

```
## here() starts at /Users/reka/Dropbox (The University of Manchester)/modelling2021/Modelling-Crime-Data-2021
```

```r
load(here("Datasets", "37302-0001-Data.rda"))
```


5.	Name the data frame `bwcs` by using the `<-` assignment operator. Another way of looking at it is you are putting the dataset into a 'box' that you will call 'bwcs'.


```r
bwcs <- da37302.0001
```



6.	Use the function `View(bwcs)` to ensure the file is loaded and to get to know your data. You can also use the function `dim(bwcs)` to see the number of observations and variables.



---



## Today’s 3

Two primary ways of describing your data have to do with the central tendency and their dispersion. We also learn about outliers. 


---

### Central Tendency


Central tendency refers to a descriptive summary of the centre of the data’s distribution; it takes the form of a single number that is meant to represent the middle or average of the data. The **mean**, **median**, and **mode** are common statistics of the central tendency. 

The *mean* is the average and it is useful when we want to summarise a variable quickly. Its disadvantage is that it is sensitive to extreme values, so the mean can be distorted easily. 

To address this sensitivity, the *median* is a better measure because it is a robust estimate, so is not easily swayed by extreme values. It is the middle of the distribution. 

The *mode* helps give an idea of what is the most typical value in the distribution, which is the most frequently occurring case in the data. While mean and median apply to numeric variables, the mode is most useful when we are talking about categorical variables. You might want to know the most frequently appearing category. This is what the mode tells you!


#### Activity 2: Recap of how to obtain the mean, median, and mode

In Lesson 1, you were introduced to the functions `mean` and `median`. There is no direct function in `base R` to calculate the mode, but you will one way to do so after this activity. Please find only the mean and median for the following six numbers: 


```r
# 345, 100, 250, 100, 101, 300 
```

Type your answers in the group google doc.


---


From today’s data, we are interested in exploring the adoption of body-worn cameras (BWCs) and their usage in a sample of agencies. The variables that will help us explore this is `Q_10A` because it measures whether the agency adopted BWCs and `Q_12` because it measures the number of cameras that agencies reported using. 


So let's say we want to learn about these variables. The first step to choosing the appropriate analysis for our variable is establishing: *what is it's level of measurement*? I did say, we shall keep coming back to these building blocks. So take a moment and reflect: what is the level of measurement you expect for `Q_10A` - whether or not the agency has adopted body worn cameras? What about for `Q_12` - the number of cameras the agency uses? 


Have a think and write your answers in the google doc!

![](https://media.giphy.com/media/cpyA1xceZkBLq/giphy.gif)<!-- -->


So now we know what we think the level of measurement should be, but what sort of object does R think that this variable is? Well, remember we can use the `class()` function for R to tell us this. 


Let's start with `Q_10A` - whether or not the agency has adopted body worn cameras. Hopefully you thought this to be a categorical variable. Let's see what R says: 


```r
class(bwcs$Q_10A) 
```

```
## [1] "factor"
```

We see this is a factor variable. So we can think to also use our trusty `attributes()` function, to see what levels it has : 



```r
attributes(bwcs$Q_10A)
```

```
## $levels
## [1] "(1) Agency has acquired in any form (including testing)"
## [2] "(2) Agency has not acquired"                            
## 
## $class
## [1] "factor"
```

We can see it has 2 levels, "(1) Agency has acquired in any form (including testing)" and "(2) Agency has not acquired" . Which one appears the most frequently in our data set? Well to answer this, we can get the **mode** using the mlv function from the modeest package. Load the package: 



```r
library(modeest)
```

And now use the mlv() function to get the answer: 


```r
mlv(bwcs$Q_10A)
```

```
## [1] (2) Agency has not acquired
## 2 Levels: (1) Agency has acquired in any form (including testing) ...
```


You can see this tells us the answer is "(2) Agency has not acquired". It also, handily prints out all the levels, so we can see what other values there were. 


If you want to double check whether the mlv() function is telling you the truth, create another frequency table, using the `table()` function. 



```r
table(bwcs$Q_10A)
```

```
## 
## (1) Agency has acquired in any form (including testing) 
##                                                    1915 
##                             (2) Agency has not acquired 
##                                                    2013
```

Indeed there are 2013 cases where the agency had not had any body worn cameras ("(2) Agency has not acquired ") which is more than the 1915 cases where the agency had body worn cameras in any format ("(1) Agency has acquired in any form (including testing)"). 


We could also run the `mlv()` function and save the output to an object, rather than print into the console. Here we save to the object called `mode_adopted`: 


```r
mode_adopted <- mlv(bwcs$Q_10A) 
mode_adopted
```

```
## [1] (2) Agency has not acquired
## 2 Levels: (1) Agency has acquired in any form (including testing) ...
```


The `mlv()` function (acronym for **m**ost **l**ikely **v**alues) from the `modeest` package is used to obtain the mode. The modal response of all agencies was ‘No’, meaning that they had not adopted BWCs as of the 2016 survey. 

Our exploration into the adoption of BWCs has so far yielded the knowledge that the majority of agencies had not adopted BWCs as of 2016. But how about those that have done so? To what extent do they use BWCs? This is where variable `Q_12` comes in handy:



#### Activity 3: The extent of body worn camera use

Use code to obtain the class of the variable `Q_12`. Type the code you used and what class the variable is in your group google doc. (hint look back at how we did this for `Q_10`)


After you do so, we do some more investigation of Q_12. First let us get the minimum value: 

```r
 min(bwcs$Q_12, na.rm=TRUE)
```

```
## [1] 0
```

What about the maximum: 


```r
max(bwcs$Q_12, na.rm=TRUE)
```

```
## [1] 1200
```


You can see above we use the functions `min()` and `max()`, and inside we put the object we want the minimum and maximum of (`bwcs$Q_12`), but we also add another parameter after a comma where we say `na.rm=TRUE`. 


What the heck is `na.rm`? When calculating measures of central tendency, you need to tell `R` that you have missing (NA) cases. Using `na.rm = TRUE` will exclude cases that have already been defined as missing. If we do not specify this code, it will return `NA` for agencies that have acquired BWCs because `Q_12` has missing data. If you have `NA`, however, for the row defining agencies that have not acquired BWCs, this is all right because there would be no cases for them. 


---




Now let us find the average number of BWCs used by agencies that have responded ‘Yes’ in `Q10_A`. We will use two ways to determine the mean: the `dplyr` way and the usual `base R` way.


First let's start with dplyr. Load the package


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```



Now we will do two things. First we will use the `group_by()` function in order to group our observations by the values of the `Q_10A` variable. What are these values? Look above, and you will see, they are "(1) Agency has acquired in any form (including testing)" and "(2) Agency has not acquired". Then, we use the `summarise()` function, to tell us some summary statistics (in this case the mean, using the `mean()` function) **for each group**. 


We did a similar thing last semester - remember we got the mean and median and min and max etc for *each* value of a particular variable, when we were looking at the relationship between age and the reason someone got arrested. Now we are looking for the values of how many body worn video cameras are in use (`Q_12`) between whether they are in use or not (`Q_10A`): 



```r
bwcs %>% 
  group_by(Q_10A) %>% 
  summarize(mean_deployed = mean(Q_12, na.rm = TRUE))
```

```
## # A tibble: 2 x 2
##   Q_10A                                                   mean_deployed
## * <fct>                                                           <dbl>
## 1 (1) Agency has acquired in any form (including testing)          31.8
## 2 (2) Agency has not acquired                                     NaN
```
So we see that in those agencies where there is any cameras used, the average number of cameras is about 32.
But in agencies where there is no bodyworn camera at all, the average is NaN! What is this?!?

![](Images/nan.png)


Well NaN in R stands for **N**ot **a** **N**umber. This is because, *all* the values for those who have no cameras for how many cameras they have is `NA`. Hopefully this makes sense, but if not, ask now!


I did say there are many ways to answer a question in R. We used `dplyr` above, this is the `tidyverse` way. But you could also use the `base R` way. Here we use the `mean()` function, but get the average for all the groups together: 


```r
mean(bwcs$Q_12, na.rm = TRUE)
```

```
## [1] 31.82024
```


The answers are the same: 31.8 . This is because we know what one group (those who haven't adopdet bwcs yet) don't contribute to the average. We use both methods because there may be situations where one is more appropriate than the other (e.g., maybe you want to see means for the individual categories when they are not `NaN`). 


Next, we check out the median, as, remember, the mean is susceptible to outliers. To get the median for each group, we use `summarise()` again but this time we include the `median()` rather than the `mean()` function: 



```r
# Use the same format as above, this time using the median() function 
# dplyr way 
bwcs %>% group_by(Q_10A) %>% summarise(med_deployed = median(Q_12, na.rm = TRUE))
```

```
## # A tibble: 2 x 2
##   Q_10A                                                   med_deployed
## * <fct>                                                          <dbl>
## 1 (1) Agency has acquired in any form (including testing)            8
## 2 (2) Agency has not acquired                                       NA
```

What about the base R way?


```r
# Base R way 
median(bwcs$Q_12, na.rm = TRUE)
```

```
## [1] 8
```


Again, both methods to obtain the median are the same, but the median differs a lot from the mean: it is 8. 

What does this mean? Well there must be a few agencies which have a *lot* of body worn cameras, which may be skewing our mean upwards. When the median and the mean are far away, we have *skew*. 


Sometimes, we want to calculate these at once.  This is where the `dplyr` way is most handy, where we can specify more than one way to summarise our data in the `summarise()` function, separated by commas. So we create 4 columns in our table: 

- *mean_deployed*, using the `mean()` function, 
- *median_deployed*, using the `median()` function,
- *mode_deployed*, using the `mlv()` function,
- and *total*, using the `sum()` function. 



```r
# Table containing the mean, median, mode, and total number of BWCs deployed 
bwcs %>%
  group_by(Q_10A) %>% 
  summarise(mean_deployed = mean(Q_12, na.rm = TRUE),
            median_deployed = median(Q_12, na.rm = TRUE), 
            mode_deployed = mlv(Q_12, method='mfv', na.rm = TRUE), 
            total = sum(Q_12, na.rm = TRUE))
```

```
## # A tibble: 2 x 5
##   Q_10A                        mean_deployed median_deployed mode_deployed total
## * <fct>                                <dbl>           <dbl>         <dbl> <dbl>
## 1 (1) Agency has acquired in …          31.8               8             1 60363
## 2 (2) Agency has not acquired          NaN                NA           NaN     0
```


Another handy package for descriptive statistics is `skimr`. The function `skim ()` produces measures of central tendency and measures of dispersion (we will learn more on these in the later section), and number of missing values. 

A great feature of this is that it also includes a histogram of the numeric variables specified. If you do not want to specify any variables, `skim()` will summarise your entire data frame, and this may be good, but it depends on the size of your dataset:



```r
library(skimr)
```


Produce a summary of your Q_12 variable, grouped by Q_10 using skim() 



|skim_type |skim_variable |Q_10A                                                   | n_missing| complete_rate| numeric.mean| numeric.sd| numeric.p0| numeric.p25| numeric.p50| numeric.p75| numeric.p100|numeric.hist |
|:---------|:-------------|:-------------------------------------------------------|---------:|-------------:|------------:|----------:|----------:|-----------:|-----------:|-----------:|------------:|:------------|
|numeric   |Q_12          |(1) Agency has acquired in any form (including testing) |        18|     0.9906005|     31.82024|   92.26974|          0|           3|           8|          20|         1200|▇▁▁▁▁        |
|numeric   |Q_12          |(2) Agency has not acquired                             |      2013|     0.0000000|          NaN|         NA|         NA|          NA|          NA|          NA|           NA|             |


```r
bwcs %>% 
  group_by(Q_10A) %>% 
  skim(Q_12)
```



### Outliers

Recall the main disadvantage of the mean: it is not robust to extreme values, otherwise known as **outliers**. 

What exactly constitutes an *outlier*? In a general sense, an outlier is any observation that shows an extreme value on one of our variables. There are different approaches to define what is an outlier, here we will rely on using the interquartile range to do so. 

One way of determining whether a case is an outlier is if it is 1.5 multiplied by the **interquartile range** (IQR) above the 3rd quartile (very large measurement eg very many BWCs) or below the 1st quartile (very small measurement eg very few BWCs), or for extreme outliers, above or below by 3 multiplied by IQR. The IQR is another robust estimate and is the 75th percentile observation (the third quartile [Q3]) minus the 25th percentile observation (the first quartile [Q1]) in your distribution:


$$ IQR= Q3 - Q1 $$


In the case of our body worn camera data, we can calculate these measures using the quantile() function. If we ask for the quantiles of the variable we get: 



```r
quantile(bwcs$Q_12, na.rm = TRUE)
```

```
##   0%  25%  50%  75% 100% 
##    0    3    8   20 1200
```


This is our 5 number summary - you may remember this is the **1** - minimum, **2** - first quartile, **3** - second quartile (also known as the *median*), **4** - third quartile, and **5** - maximum value. To get any one of these, we can request it with its appropriate number in square brackets, after the function. For example


`quantile(bwcs$Q_12, na.rm = TRUE)[1]` will give the minimum, `quantile(bwcs$Q_12, na.rm = TRUE)[5]` will give the maximum, and so on!


So, so get our inter quartile range, we would subtract our first quartile from our third quartile (remember $ IQR= Q3 - Q1 $) so this would be: 


```r
quantile(bwcs$Q_12, na.rm = TRUE)[4] - quantile(bwcs$Q_12, na.rm = TRUE)[2]
```

```
## 75% 
##  17
```

The `75%` label is an artefact, and doesn't tell us much here, we can remove by wrapping the whole thing in the function `as.numeric()`:


```r
as.numeric(quantile(bwcs$Q_12, na.rm = TRUE)[4] - quantile(bwcs$Q_12, na.rm = TRUE)[2])
```

```
## [1] 17
```


Woo we have our IQR! Now that you've gone through all that, I can tell you, there is also a function that will tell us the IQR. It is.... drumroll please..... `IQR()`


```r
IQR(bwcs$Q_12, na.rm = TRUE)
```

```
## [1] 17
```


We see we get the same number, 17, so we can trust this is a correct answer, now that we've gotten it 3 different ways... 


So, what would be an outlier then? Remember back to the outlier definition we gave above: 

>  a case is an outlier is if it is 1.5 multiplied by the **interquartile range** (IQR) above the 3rd quartile (very large measurement eg very many BWCs) or below the 1st quartile (very small measurement eg very few BWCs)

So any agency is an outlier if it has either fewer than 1st quartile minus 1.5 times the IQR ($Q1 - 1.5*IQR$) body worn cameras, or more than 3rd quartile plus 1.5 times the IQR ($Q3 + 1.5*IQR$) body worn cameras.  Let's get some numbers plugged into the equation: 

$Q1 - 1.5*IQR$ is


```r
as.numeric(quantile(bwcs$Q_12, na.rm = TRUE)[2] - 1.5*IQR(bwcs$Q_12, na.rm = TRUE))
```

```
## [1] -22.5
```


So... any agency that has *minus* 23 body worn cameras would be a negative outlier... I imagine this is not a likely scenario... 


What about high outliers? 

$Q3 + 1.5*IQR$ is


```r
as.numeric(quantile(bwcs$Q_12, na.rm = TRUE)[4] + 1.5*IQR(bwcs$Q_12, na.rm = TRUE))
```

```
## [1] 45.5
```


This one is more realistic, any agency that has 46 or more body worn cameras is an outlier. What about extreme outliers in this direction? Remember that is anything more than 3 times the IQR above the 3rd quartile. In an equation: 

$Q3 + 3*IQR$


```r
as.numeric(quantile(bwcs$Q_12, na.rm = TRUE)[4] + 3*IQR(bwcs$Q_12, na.rm = TRUE))
```

```
## [1] 71
```

Any agencies with more than 71 body worn cameras are extreme outliers!


A nice way to visualise this is with a boxplot. Remember, a boxplot visually represents yout 5-number-summary, like this: 


```
## Warning: Transformation introduced infinite values in continuous x-axis
```

```
## Warning: Removed 97 rows containing non-finite values (stat_boxplot).
```

![](04-descriptive-statistics_files/figure-epub3/unnamed-chunk-29-1.png)<!-- -->



Now you can also see where the outliers, and extreme outliers are. Outliers are anything above the orange line, extreme outliers are anything above the purple line: 


![](04-descriptive-statistics_files/figure-epub3/unnamed-chunk-30-1.png)<!-- -->


We could also show this in a histogram, where everything to the right of the orange line is an outlier, and everything to the right of the purple is an extreme outlier: 

![](04-descriptive-statistics_files/figure-epub3/unnamed-chunk-31-1.png)<!-- -->




A popular method for determining outliers is known as **Tukey fences**. According to this method, outliers are seen as falling within a lower or upper fence. They are calculated from the following:



$$ Lower~ fence = Q1 - 1.5(IQR)$$ 

$$ Upper~ fence = Q3 - 1.5(IQR) $$


#### Activity 4: Determining outliers using Tukey fences

Now we use the IQR to construct Tukey fences so to find and save the outliers for the `Q_12` variable:


First, let us get the IQR of the Q_12 variable using the IQR function, and save this into an object called 'bwc_deployed_iqr'.


```r
bwc_deployed_iqr <- IQR(bwcs$Q_12, na.rm = TRUE) 
```

It is now saved as an object. You can see it holds the value for the IQR: 


```r
bwc_deployed_iqr
```

```
## [1] 17
```

Now let's do the same. Then, get the 1st and 3rd quartiles of the Q_12 variable using `quantile()` function and place them in objects: 


```r
bwc_deployed_1st <- quantile(bwcs$Q_12, 0.25, na.rm = TRUE) 
bwc_deployed_3rd <- quantile(bwcs$Q_12, 0.75, na.rm = TRUE)
```


Now we calculate the Tukey fences. 

First the lower Fence: 


```r
lower_inner_fence <- bwc_deployed_1st - 1.5 * bwc_deployed_iqr 
lower_inner_fence
```

```
##   25% 
## -22.5
```

Then the Upper Fence:


```r
upper_inner_fence <- bwc_deployed_3rd + 1.5 * bwc_deployed_iqr 
upper_inner_fence
```

```
##  75% 
## 45.5
```


You can also calculate the 'outer fences' which are considered extreme outliers


```r
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


Are these numbers familiar? You can see, the Tukey fences are just the names given to what we calculated above!


Now let's see how many agencies actually fall into outliers and extreme outliers categories. We will be oing back to the `filter()` functions for this. Remember we filter to keep all rows that meet a specific condition. In this case, we want all cases where the value for the variable Q_12 (how many BWCs an agency has) is an outlier (greater than inner fence, but smaller than outer fence) and an extreme outlier (greater than outer fence). save them in separate objects called ‘outliers’ and ‘outliers_extreme’ 


```r
outliers <- bwcs %>% 
  filter(Q_12 > upper_inner_fence| Q_12 < lower_inner_fence) 
```

and


```r
outliers_extreme <- bwcs %>% 
  filter(Q_12 > upper_outer_fence| Q_12 < lower_outer_fence)
```

Now we can look at these objects in our environment, and see that outliers has 282 rows (so 282 agencies that are outliers) while extreme_outliers has 188 rows (so 282 agencies that are extreme outliers)!  


We can look at their characteristics on the number of BWCs with the `summary()` function: 


```r
summary(outliers$Q_12)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    46.0    60.0   100.0   162.1   167.2  1200.0
```
and 


```r
summary(outliers_extreme$Q_12)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    72.0   100.0   130.0   215.4   241.2  1200.0
```


In your group google doc, type your answers to the following: (1) lower and upper inner fences, (2) lower and upper outer fences, (3) minimum of `outliers` and `outliers_extreme`.


---



#### **On Skewness**

Related to outliers is **skewness**. This has to do with the shape of the distribution. You might remember from last semester we discussed something called the bell curve, or normal distribution. This is how you expect your data to look if the mean and the median are the same exact value, and your data are distributed equally on the two sides. 

Here is a normal distribution: 

![](04-descriptive-statistics_files/figure-epub3/unnamed-chunk-43-1.png)<!-- -->

Now a skewed distribution would pull to the left or to the right, where you have a long tail on either side. This would also cause your mean and median to get further apart. 


Here is a right skewed distribution: 

![](04-descriptive-statistics_files/figure-epub3/unnamed-chunk-44-1.png)<!-- -->



And here is a left: 


![](04-descriptive-statistics_files/figure-epub3/unnamed-chunk-45-1.png)<!-- -->



So how can we tell if our data are skewed? Well exactly like above, what we want is to visualise it! We will do this in the next activity. 




#### Activity 5: Visualizing skewness using a histogram

When your distribution is skewed, the majority of cases veer more to the left or right of the distribution, with a tail of outliers. An initial way of checking for skewness is to use a histogram, like from last week:


Remember to bring up the package ggplot2 if you have not done so

```r
library(ggplot2)
```


To create a histogram of number of BWCs deployed, we will use the `ggplot()` function and the geometry for histogram which is `geom_histogram()`. 



```r
ggplot(data = bwcs, mapping = aes(x = Q_12)) + 
  geom_histogram(bins = 15, fill = "red") + 
  labs(x = "Number of BWCs Deployed", y = "Number of Agencies") + 
  ggtitle("Histogram of Number of BWCs Deployed") + 
  theme(plot.title = element_text(hjust = 0.5))
```

```
## Warning: Removed 2031 rows containing non-finite values (stat_bin).
```

![](04-descriptive-statistics_files/figure-epub3/unnamed-chunk-47-1.png)<!-- -->


What do you observe from the histogram? Discuss in your groups, or reflect if you are in the quiet room. What do you think the number of BWCs may depend on? Size of the agency? Willingness to adopt BWCs? Are you surprised by this data? 

![](Images/bwcs.jpg)

From our histogram, we see that most agencies deployed fewer than 250 BWCs and only a small proportion deployed more than 800. 

Another way of checking for skewness is through the `skewness()` function from the `moments` package. Skewness is determined by the following:

- 0 = no skewness as it is a symmetrical distribution
- positive value = means distribution is positively skewed or skewed right
- negative value = means distribution is negatively skewed or skewed left 


 
We calculate skewness for our variable `Q_12`. Calculate skewness of Q_12 and put it into an object called bwc_skew: 


```r
bwc_skew <- skewness(bwcs$Q_12, na.rm = TRUE) 
```

```
## Warning: encountered a tie, and the difference between minimal and 
##                    maximal value is > length('x') * 'tie.limit'
## the distribution could be multimodal
```

Now print the result.  Will the skewness coefficient indicate negative, positive, or no skewness?


```r
bwc_skew
```

```
## [1] 7.634726
```

We see a positive skew!


From the two ways of checking for skewness, `Q_12` is an asymmetric distribution known as a **positively skewed distribution** -- one tail of the distribution is longer than the others because of outliers on the right side. 


---


### Measures of Dispersion


What is meant by dispersion is the spread of values from the one value chosen to represent them all. That one value is usually the mean, or in the case of categorical variables, the mode. This is important because the single number to summarise our data might often mask variation. If last year you read "The Tiger That Isn't", you might remember the section about the "white rainbow". We know the vibrancy of the colours of the rainbow and we know what we would lack if we combined them to form a bland white band in the sky - the average of all the colours is white. If we just represented the rainbow by the average, we would miss quite a lot!

![](Images/rainbow.jpg)
Let's explore how we measure dispersion, and how we can interpret this to draw conclusions about the data. 

#### Activity 6: Loading the other dataset

We learn about measures of dispersion using another dataset from the ICPSR website. The SISFCF survey has been conducted periodically since 1976, and the current survey (2004) data (04572-0001-Data.rda) can, too, be accessed at the ICPSR website and downloaded as an .rda file. Follow the same steps with loading the data as with the previous data on BWCs. Now, for this dataset, we do the following as well:



```r
load(here("Datasets", "04572-0001-Data.rda"))
```

1.	Change the name of the data frame from da04572.0001 to `inmatesurvey04` by using the `<-` assignment operator. This will create an identical object but with a new name.



```r
inmatesurvey04 <- da04572.0001
```

<!-- 2.	We only deal with one dataset from this, so use the function `attach(inmatesurvey04)`. Remember to use `detach("inmatesurvey04")` once you are done with today’s lesson. -->

<!-- ```{r, echo=FALSE, message=FALSE, warning=FALSE} -->
<!-- attach(inmatesurvey04) -->
<!-- ``` -->


Once finished with this activity, you will find your new data frame, `inmatesurvey04`, in the *Environment* pane.


---


#### **Dispersion in Nominal and Ordinal Variables**


We learn how to conduct two measures of dispersion in `R` for categorical variables: the variation ratio and the index of qualitative variation:

The **variation ratio** (VR) tells us the proportion of cases that are not in the modal category – basically cases not in the most frequent or ‘popular’ category. The formula for the variation ratio (VR) is:


$$VR = 1 – ({\frac {N~modalcat~} {N~total~}})$$


$N~modalcat$ refers to the frequency of cases in the modal category, and $N~total~$ refers to the total number of cases. This formula states that VR is equal to 1 minus the proportion of cases that are in the modal category, which is the same as saying the proportion of cases that are not in the modal category. 



#### Activity 7: Calculating the variation ratio

Now, for example, we are interested in knowing whether the modal category describes the overall work histories prior to arrest of federal inmates pretty accurately, or if there is a lot of variation in responses from inmates. To do so, we use the variable `V1748` which tells us about their work history prior to arrest. 

We can look at a frequency table:



```r
table(inmatesurvey04$V1748)  
```

```
## 
##  (1) Full-time  (2) Part-time (3) Occasional (7) Don't know    (8) Refused 
##           2180            284             65              0              1
```

Or we can use skim



|skim_type |skim_variable | n_missing| complete_rate|factor.ordered | factor.n_unique|factor.top_counts                    |
|:---------|:-------------|---------:|-------------:|:--------------|---------------:|:------------------------------------|
|factor    |data          |      1156|     0.6863809|FALSE          |               4|(1): 2180, (2): 284, (3): 65, (8): 1 |

```r
skim(inmatesurvey04$V1748)
```

Then, check if we have cases defined as missing using ‘is.na’ to get a summary of missing cases


```r
table(is.na(inmatesurvey04$V1748))
```

```
## 
## FALSE  TRUE 
##  2530  1156
```

This tells us that there are 2530 complete cases and 1156 NA values. 

So we could tell from the tables above that 'Full-time' is the mode, but we can also get R to provide the mode and save it in an object 


```r
mode_employment <- mlv(inmatesurvey04$V1748, na.rm = TRUE) 
mode_employment
```

```
## [1] (1) Full-time
## 5 Levels: (1) Full-time (2) Part-time (3) Occasional ... (8) Refused
```



<!-- We can see that federal inmates reported working full-time prior to arrest more than any other single category. But we see that there were these options:   *Don’t Know* and *Refused*. It may be that we are interested in these answers, but it is possible also we only care about those who actually have one of the categories as an answer.   -->

<!-- To do this, we will have to recode the responses of *Don’t Know* and *Refused* as missing, so `R` will not treat these as valid cases. We will create a new variable so not to overwrite the original one; then tell `R` that the latter two categories should be missing (NA). We can use the `recode()` funtion from `dplyr` which we learned about earlier to do this.  -->


So we have the modal category. But what about the variation ratio? To get this, we create two dataframes, and count the number of people who reported any employment (answers of (1) Full-time  (2) Part-time and (3) Occasional) in one, and the numbers who reported the modal category (1) Full-time. 


Store the value ‘full-time’ in the object n_mode 


```r
n_mode <- inmatesurvey04 %>% 
  filter(V1748 == "(1) Full-time" ) %>% 
  summarize(n = n()) 
```

Now get the number of cases who reported being employed prior to arrest. Store this value in the object n_employed 


```r
n_employed <- inmatesurvey04 %>% 
  filter(!is.na(V1748)) %>% 
  summarize(n = n())
```

And finally, we can calculate the proportion. Store this value in the object proportion_mode 


```r
proportion_mode <- n_mode/n_employed 
```

We can use this to get the variation ratio. To do this, subtract proportion of cases in the modal category from 1 .


```r
vratio <- 1 - proportion_mode
vratio
```

```
##           n
## 1 0.1383399
```


The VR is 0.1383, meaning that the work history among federal inmates prior to arrest is relatively concentrated in the modal category of full-time employment. This is because the smaller the VR, the larger the proportion of cases there are concentrated in the model category. 



---



#### Activity 8: Onto the Index of Qualitative Variation (IQV)

The IQV is different from the VR because it considers dispersion across all categories, whereas the VR only views dispersion in terms of modal versus non-modal. 

The IQV lies between 0 and 1 and tells you the variability of the distribution. The smaller the value of the IQV, the smaller the amount of variability of the distribution. We use the `DM()` function from the `qualvar` package, which stores frequencies of a categorical variable in a vector:



```r
library(qualvar)
```


Get the index of qualitative variation for the same variable: V1748 

```r
#
IQV<-as.vector(table(inmatesurvey04$V1748)) 

DM(IQV, na.rm = TRUE)
```

```
## [1] 0.1729249
```



What is value that you get in the output? Type the value in your google doc and what you think this value means.


---



#### **Dispersion in Interval and Ratio Variables**



These measures of dispersion are the most familiar because they are defined as the spread of values around a *mean*. We revisit three of these: the range, variance, and standard deviation. 



#### Activity 9: The range

The **range** is the difference between the maximum and minimum value in a given distribution. We use the ratio-level variable `V2254`, a measure of the age at which inmates stated they first started smoking cigarettes regularly, as an example:

Examine the variable 


```r
attributes(inmatesurvey04$V2254)
```

```
## $value.labels
##                Refused             Don't know Never smoked regularly 
##                     98                     97                      0
```


Note that this variable has codes that do not indicate the number of times smoked.  These are 0 - never smoked; 97 - Don't know; and 98 – Refused. We notice that some categories are not about smoking, such as ‘Don’t know’ and ‘Refused’, and including these will give us an incorrect result. To resolve this, we must convert irrelevant categories into missing data:

First create a new variable so we do not write over the old one, calling it `age_smoker_range` using the `mutate()` function, first assigning it the values of the `V2254` variable, and then recoding each value (0, 97, 98) as a `NA` using the `na_if()` function from the dplyr package. 



```r
inmatesurvey04 <- inmatesurvey04 %>% 
  mutate(age_smoker_range = V2254,
           age_smoker_range = na_if(age_smoker_range, 0),
          age_smoker_range = na_if(age_smoker_range, 97),
          age_smoker_range = na_if(age_smoker_range, 98),
         )
```


Now for the range. `range ()` function prints the minimum and maximum values. 


```r
smoker_range <- range(inmatesurvey04$age_smoker_range, na.rm = TRUE)

smoker_range 
```

```
## [1]  1 57
```

We can then use these to calculate the range by subtracting the minimum value from the maximum. 


```r
smoker_range[2] - smoker_range[1]
```

```
## [1] 56
```


Or we could also calculate the difference of that object using the `diff()`function. 


```r
diff(smoker_range)
```

```
## [1] 56
```


What is the range? Input the answer in your google doc. 

BUT you can see something strange while figuring out the range: the minimum is one year old! This may be something we want to exclude in analyses as it might not be valid -- maybe a mistake in coding -- so conducting descriptive statistics can help with tidying your data.


---



#### Activity 10: Variance

Now, the **variance** ( $s^2$ ) is about spread, specifically the sum of the squared deviations from the mean, then divided by the total number of cases. The equation looks like this:

$$ s^2 = \frac{\sum(x - \mu)^2}{N}$$ 



We use the function `var()` from the `stats` package that comes already preinstalled with base R. 

We use the variable `V2529`, which records the number of times inmates reported being written up for verbally assaulting a prison staff member, as an example: 

First, let us take a look at the variable 

```r
summary(inmatesurvey04$V2529)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    1.00    1.00    1.00   31.45    3.00  998.00    3545
```

```r
attributes(inmatesurvey04$V2529)
```

```
## $value.labels
##    Refused Don't know 
##        998        997
```



Now let's create a new variable so we do not write over the old one. We do this so we can code 997 and 998 values as missing - you can see these stand for Refused and Don't know . 


```r
inmatesurvey04 <- inmatesurvey04 %>% 
  mutate(verb_assault_var = V2529,
          verb_assault_var = na_if(verb_assault_var, 997),
          verb_assault_var = na_if(verb_assault_var, 998),
         )
```

Now let us calculate the variance 


```r
var1 <- var(inmatesurvey04$verb_assault_var, na.rm = TRUE) 
var1
```

```
## [1] 82.64384
```

The variance is 82.6, which is fairly dispersed, but if you got to know the data and this variable, you will notice that one inmate self-reported 99 verbal assaults, so this will have had an influence on the variance. 

---



#### Activity 11: Standard deviation

Last, we learn about the **standard deviation** (SD), which is the square root of the variance. The smaller it is, the more concentrated cases are around the mean, while larger values reflect a wider distance from the mean. In other words, the SD tells us how well the mean represents our data. Too large, then the mean is a poor representation, because there is too much variability. We use the variable `verb_assault_var` as an example:

Calculate th standard deviation of the verb_assault_var variable and save it to an object 



```r
sd <- sd(inmatesurvey04$verb_assault_var, na.rm = TRUE)
sd
```

```
## [1] 9.090866
```

Now, we told you that the standard deviation is the square root of the variance. You can double check, we will see if the SD, squared, matches the variance. Create a new object, var2, by taking the square of the standard deviation. We will call this var2. 



```r
var2 <- sd^2
var2 
```

```
## [1] 82.64384
```


Yes, it does match!


The SD is 9.09087 meaning that this number of verbal assaults is one standard deviation above and below the mean, so the majority of reported verbal assaults, about 68% of them (more on the 68-95-97 rule next week), should fall within 9.09 above and below the mean. 



---


## SUMMARY



Descriptive statistics was the name of the game today. These are measures we use to describe our data. First, we learned about measures of central tendency: the **mean**, **median**, and **mode**. Second, pesky **outliers** were examined along with their cousin **skewness**.  A way of addressing outliers was through the robust estimate, the **interquartile range**. With skewness, visualizations were used to ascertain whether the distribution could be **positively skewed**. Third, we learned all about measures of dispersions: two for nominal and ordinal variables – the **variation ratio** and the **index of qualitative variation** -- and three for interval and ratio variables – the **range**, **variance**, and **standard deviation**. In some situations we found ourselves, missing values appeared. This is actually very common in data, so we addressed these with the R argument **na.rm**.  



Homework time!


