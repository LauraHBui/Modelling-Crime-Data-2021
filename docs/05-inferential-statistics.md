
# Inferential Statistics
#### *Samples, Standard Errors, and Confidence Intervals* {-}


#### **Learning Outcomes:** {-}
-	Understand what inferential statistics are and why they are used
-	Learn how samples can be used to draw conclusions about the population
-	Learn about and calculate standard errors and confidence intervals




#### **Today’s Learning Tools:** {-}



##### *Total number of activities*: 8 {-}



 
##### *Data:* {-}
-	Synthetic data we make ourselves




##### *Packages:* {-}
-	`dplyr`
-	`ggplot2`
-	`mosaic`




##### *Functions introduced (and packages to which they belong)* {-}
-	`bind_rows()` : Combine data frame(s) together row-wise (`dplyr`)
-	`geom_density()` : Geometry layer for density plots (`ggplot2`)
-	`geom_errorbar()` : Draw error bars by specifying maximum and minimum value (`ggplot2`)
-	`do()` : Loop for resampling (`mosaic`)
-	`geom_vline()` : Geometry layer for adding vertical lines (`ggplot2`)
-	`if_else()` : Tests conditions for true or false, taking on values for each (`dplyr`)
-	`rnorm()` : Create synthetic normally distributed data (`base R`)
-	`round()` : Rounds to nearest whole number or specified number of decimals (`base R`)
-	`sample()` : Randomly sample from a vector or data frame (`mosaic`)
-	`set.seed()` : Random number generator start point (`base R`)



---




## Generalising About the World from Data

Last week we revisited a familiar sort of statistics: descriptive. But we also learned how to conduct these measures using `R`. Today we learn the other main branch of statistics: inferential. 

Whereas descriptive statistics is concerned with summarising and describing your data, **inferential (or frequentist) statistics** is concerned with using the data to say something about the world in which we live. Using samples drawn from our population of interest, we can conduct statistical analyses to generalise to our lives and what we observe around us. 

Inferences made from inferential statistics are not bound to one dataset and sample, and that is the strength of this type of statistics. Because, however, we will be saying something that is applicable to the ‘real’ world, we must understand the theory for which makes this possible. 

Today’s learning experience is the most theoretical of this course unit. To understand later inferential statistical analyses is to first understand the base on which they stand. Our three substantive topics today are: **samples**, **standard errors**, and **confidence intervals**. 




### Activity 1: Our preparation routine

As usual, we begin by opening your existing `R` project, then installing and loading the required packages as listed above under the 'Packages' subheader. 





---




## Today’s 3




As you continue the remainder of this course unit, you will observe how important it is to collect accurate information to conduct inferential statistics. Your findings are only as good as its basis, and if that basis is a shoddy collection of data, what you have to say will reflect that. An important way to collect accurate information is to ensure that what we have is representative of that real world. This is where samples arrive to play. 




---

### Samples




Say we are curious about how widespread robbery in the UK has been in the past 12 months. We could obtain police-recorded data to tell us this information. We also, however, know from previous criminology classes that many people do not report crimes to the police, so this data is limited, unable to tap into what is known as ‘the dark figure of crime’. 

One way to address this is self-report victimisation surveyrs, such as the [Crime Survey for England and Wales](https://www.crimesurvey.co.uk/en/index.html). While it might be ideal to survey everyone in the UK about whether they have been a victim of robbery in the past year and how many times they have been robbed, you might imagine, this is quite impractical. Surveying the entire **population** is not very practical because of time and financial constraints.

Sure, eventually mass collection of data from the population may be possible in the future as we have seen with social media corporations, but even then, access and availability remain issues. Because of these limitations of collecting information from the population, we use a sample. 

A **sample** of the population is a small selection of that population of interest. You may recall from last semester and from your first year research methods courses about different approaches to sampling - that is different ways to select the people who you want to ask the questions to. In the case of such surveys, the aim is to choose the best sampling method to promote **external validity**.

If our sample has high **external validity**, then those included in it are a good representation of the population. To establish external validity depends on the way you collect your sample (e.g., random sampling versus convenience samples). This will make conclusions from a sample generalisable to the population. That is what the *Crime Survey of England and Wales* does: sample from the population to get an estimate of how widespread crime and victimisation are in the whole of the population. 

<!-- The big concern now is: how do we know that a sample is generalisable to the wider population? Is there a way to prove that? -->


So how good is a sample at representing the characteristics of an entire population? In the real world, most of the time it is impossible to get whole population data. So to illustrate and show you how we can trust our statistics from our samples to represent the parameters in the populations from which they are derived, we will create a fake population, from which we can draw samples. 


We create **synthetic data** to represent a fake population to demonstrate how it is possible for a sample to be used to estimate what goes on in the whole population. 
<!-- Why the data are based on a fake population is because rarely do we have information on the whole population, of course.  -->






Last week we learned about distributions. Specifically, we focused on the **normal distribution**. This is also called a bell curve, because when we squint a little, the shape looks like a bell. Remember that normal distrbutions are symmetrical, (there is no skew!) and the mean is the same as the median. You can also look at measures of distribution, for example standard deviation, to realise how dispersed your data are. You can also know that about 68% of your data fall within +/- 1 standard deviation of your mean, and 95% of your data within +/- 2 standard deviations of your mean, and 99% of your data within +/- 3 standard deviations of your mean, when your variable is normally distributed. Neat!

![](05-inferential-statistics_files/figure-epub3/unnamed-chunk-1-1.png)<!-- -->

Much of the work we will be carrying out in the coming weeks in terms of drawing inferences about the population based on a sample will make the assumption that our data are normally distributed. This is something that you will keep having to check, and come back to. In our case study today, we will be creating a fake population, who's IQ scores follow a normal distribution. Let's get to this now!


#### Activity 2: Making normally distributed synthetic data



The synthetic data will consist og randomly generated numbers to represent the intelligence quotient (IQ) scores of every probationer in the US, which is a population of about 3.6 million. For this example, we assume the mean IQ scores to be 100 and the standard deviation to be 15. We create this population distribution by using the function `nrnorm()` and assigning this to a vector object called `prob_iq`. Within the `nrnorm()` function, we specify the parameters `n = `, `mean =`, and `sd = `. That is the **n**umber of observations we want (3.6 million, one for each of the probationers in the US, remember this is the **population**), the **mean** IQ score we want the population to have (that is 100, specified above), and the dispersion around this mean, given by the standard deviation in the `sd =` parameter (specified above as 15 IQ points). 





```r
prob_iq <- rnorm(n = 3600000, mean = 100, sd = 15)
```



Great, we now have a vector of numbers, all randomly created. Let's get some descriptives: 


```r
mean(prob_iq) 
```

```
## [1] 100.0008
```

```r
median(prob_iq) 
```

```
## [1] 100.004
```

```r
sd(prob_iq) 
```

```
## [1] 14.99332
```


You may notice a few things: 

- 1: the mean is not **exactly** 100 and the sd not **exactly** 15. But they are very very close.
- 2: your answers may be slightly different to the lab notes. This is because r is *randomly* generating these numbers for you, every time you ask it to. So if you re-run the code above to re-create your `` object, you will get yet another set of numbers!


So what can we do? Well, we can set a specific seed from which the random numbers should grow. If we choose the same seed, then we will get the same set of random numbers. If we do this, we will all get the same results!

So, if want our results to be the same, so we set a seed using the function `set.seed()`, which ensures it generates the exact same distribution for this session. Then we re-create the `prob_iq` object: 




```r
set.seed(1612) # Use this number! 

prob_iq <- rnorm(n = 3600000, mean = 100, sd = 15)
```



Now again take the mean, the median, and the sd, and see that you are getting the same results as we are!


```r
mean(prob_iq) 
```

```
## [1] 100.0032
```

```r
median(prob_iq) 
```

```
## [1] 100.0035
```

```r
sd(prob_iq) 
```

```
## [1] 14.99679
```



Great! Now we have these random IQ scores, let's build a data frame using the function `data.frame()` in which we will create 2 columns. One for a unique identifier for each probationer. Let's call this column `probationer_id` and another for IQ let's call this one `IQ`. Name the whole dataframe `prob_off`: 


```r
prob_off <- data.frame(probationer_id = 1:3600000,      # create a column and fill with all the numbers from 1 to 3.6 million
                       IQ = prob_iq )     # create a column and fill with our random IQ scores
```



Now we are nearly there with our fake population data, but for one last step. The values for IQ score must be whole numbers (integers). To achieve this, we will use the `round()` function. In the `round()` function you specify two things, first the object you wish to round (the numbers in the IQ column of our prob_off dataframe so `prob_off$IQ`) and the number of decimals you would like displayed (since we want whole numbers, we want 0 decimals!). 



```r
prob_off$IQ <- round(prob_off$IQ, 0)
```


Now we finally have our complete fake population of 3.6 million US probationers and their IQ scores. You can have a look at this data with the `View()` function. Let's also visualise this distribution will help us identify its shape. We use `ggplot2`:



```r
# Have you loaded the 'ggplot2' library?


ggplot(prob_off) + 
  geom_histogram(mapping = aes(x = IQ), bins = 60) + 
  geom_vline(xintercept = mean(prob_off$IQ), col = "red", linetype = "dashed") # We add a red line in the code to show the mean of the population IQ
```

![](05-inferential-statistics_files/figure-epub3/unnamed-chunk-8-1.png)<!-- -->




Visualising the distribution of IQ scores, we observe that the scores are normally distributed, which is bell-shaped, and there is no skewness on other side. The majority of probationers have an IQ around the mean of 100. 







---






#### Activity 3: Taking a sample from (our synthetic) population



So above we created a dataset of all probationers in the US, all 3.6 million of them. This is our **population**. When we look at the mean, median, and standard deviation of this population, these numbers are the *true* estimates of IQ scores in the population of American probationers. 


Now if we take a sample from this population, how accurate would our sample estimates be compared to the population estimates?

First, we make a sample that is taken from our population. We draw a random sample of 100 probationers using the function `sample()` from the `mosaic` package:





```r
library(mosaic)
```


In the `sample()` function, we specify two parameters. `x = ` specifies what data set to sample from, and `size =` specifies the size of the sample to take. So in this case, to randomly select 100 probationers from the `prob_off` dataframe we use: 


```r
# We take a sample of 100 from our data frame, ‘prob_off’, and put it into an object called ‘sample1’
sample1 <- sample(x = prob_off, size = 100)
```


Now that we have our sample `sample1`, we can take some descriptive statistics of ‘sample1’



```r
mean(sample1$IQ) # 101.59 
```

```
## [1] 101.59
```

```r
median(sample1$IQ) # 101.5 
```

```
## [1] 101.5
```

```r
sd(sample1$IQ) # 16.27485
```

```
## [1] 16.27485
```



The results seem very close to the ‘true’ estimates from our population of probationers. Let's try another sample with another seed: 


```r
set.seed(90201)
sample2 <- sample(x = prob_off, size = 100)
```


Now that we have our second, sample `sample2`, we can take some descriptive statistics once more: 



```r
mean(sample2$IQ) # 100.81 
```

```
## [1] 100.81
```

```r
median(sample2$IQ) # 102.5 
```

```
## [1] 102.5
```

```r
sd(sample2$IQ) # 15.08206
```

```
## [1] 15.08206
```

You can see we have slightly different numbers. This is because we took a different sample! The results are still close to our population measures, but they are different to sample 1. Alright, let's do this one more time!


```r
set.seed(42)
sample3 <- sample(x = prob_off, size = 100)
```

Now the descriptives: 


```r
mean(sample3$IQ) # 99.41 
```

```
## [1] 99.41
```

```r
median(sample3$IQ) # 101 
```

```
## [1] 101
```

```r
sd(sample3$IQ) # 15.53497
```

```
## [1] 15.53497
```


Again, we are getting slightly different numbers, as we have sampled a separate 100 probationers from our population of 3.6 million. Depending on which sample we chose, our conclusions would be different. This variation in estimates is known as **sampling variability**, an unavoidable consequence of randomly sampling observations from the population. 


For example, above, we took 3 different samples. Let's look at the mean of each sample again:


```r
mean(sample1$IQ) 
```

```
## [1] 101.59
```

```r
mean(sample2$IQ) 
```

```
## [1] 100.81
```

```r
mean(sample3$IQ) 
```

```
## [1] 99.41
```

Each time we get a slightly different value for the mean, depending on the sample which we look at. 

---

**Sampling variability** 


Getting different estimates each time we randomly sample from the population is a real problem facing researchers: each time you take a sample from your population of interest, we need to be confident that its estimates are similar to the true but unknown estimates of that population. 

Sampling variability makes up what is known as the **sampling distribution**. Sampling distribution of a sample statistic (for example the mean) refers to the distribution of that value if we were to take many many many many many many many samples, and each time, record the value. Then if we took all of these values, they will follow a normal distribution, the mean of which will be the true population value! This is really cool, and we will explore it in the next activity. 





<!-- This distribution comprises the means of the many samples we draw from the same population. These two concepts are crucial to demonstrating how samples can be used to make inferences about the population. Here’s why: -->

<!-- When we resample – take repeated samples from the same population of interest – we create many sample means. The interesting bit is that when you take the overall mean of a large number of sample means, it is very close to that true population mean of 100. -->





#### Activity 4: The sampling distribution 


Let's demonstrate this with taking 1,000 samples of 100 people each, from the 3.6 million probationers. Imagine we got funding to run 1,000 surveys, each time we take a random sample of 100 probationers, and we take the mean IQ for the sample. 


Remember the function to get one sample of 100 people above? It was `sample(x = prob_off, size = 100)`. Now to repeat this 1,000 times we can use the `do()` function, which tells R to do something multiple times. So to take 1,000 samples of 100 probationers we want to *do* `sample(x = prob_off, size = 100)` 1,000 times, like so: 



```r
sample1000 <- do(1000) * sample(x = prob_off, size = 100)
```


This might take a while (you are sampling 1,000 times after all!) so give R time to process. When done, you will see the sample1000 object appear in your environment. Have a look at it with `View()`.

You can see we have the prisoner ID, and we have the IQ score, but we also have these new variables, `.row` and `.index`. `.row` refers to the probationer's position in their particular sample, while `.index` refers to the sample into which they belong. So if the `.index` says 1, they were in the 1st sample, 2, the 2nd sample, and so on up to 1000. To select a particular sample for example the 2nd one, you could use the `filter()` function in order to select all cases where `.index == 2`. But we want to keep all 1,000 samples. Instead, what we want is the **average IQ for each sample**.


You may recall how to get the mean for each value of a categorical variable from last week! Specifically, we used `group_by()` and `summarise()`. Let's use these again, to create a new object, `sample_means1000`, which has the mean IQ for each sample (all 1,000 of them!): 


```r
sample_means1000 <- sample1000 %>% 
  group_by(.index) %>% # Group by .index  (the sample id)
  summarize(meanIQ = mean(IQ)) # Creating new variable of mean IQ
```

The resulting dataframe (`sample_means1000`) has 2 columns, one for sample id and one for the mean score of IQ for that specific sample. It has 1,000 observations - one for each sample!


So what does our variability look like? We can visualise this sampling distribution to compare to the previous population distribution



```r
ggplot(data = sample_means1000) + 
  geom_histogram(mapping = aes(x = meanIQ)) + 
  geom_vline(mapping = aes(xintercept = mean(meanIQ)), col = "red", linetype = "dashed")
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](05-inferential-statistics_files/figure-epub3/unnamed-chunk-19-1.png)<!-- -->



The histogram of our sampling distribution shows this very important concept in inferential statistics: in the case of an **unbiased estimator** what we see is that whenever we draw a sample, sometimes we *over estimate* the parameter, and sometimes we *under estimate* the parameter. In this case, this means that sometimes our sample mean is *larger* than our population mean, and other times our sample mean is *smaller* than the population mean. Usually the mean of the randomly selected sample will fall close to the populatin mean, but occasionally, it will fall far. Now - what is really exciting, is that if you randomly draw repeated samples from the same population and calculate the mean of each sample, then plot the frequency of those means, you will get the *normal distribution* -- that bell-shaped curve! It doesn't even matter if your underlying data are normally distributed! Your sample statistics will be!


This indicates that most samples drawn from the population will have a mean close to the true population mean, and in general over/under estimate it in about equal amounts!

So according to our sampling distribution of probationer IQ scores, drawing a sample with a mean IQ score that is radically different from that of the population would be unlikely. See above, how 68% of observations in a normal distribution fall within +/- 1 standard deviation of the mean? And 95% within +/- 2 standard deviations. This should be reassuring!

**However** in real life, you are not ever going to conduct 1,000 surveys on 100 probationers each. Instead, you will have one survey, and you will have to make sure that your one sample is a good one. Random sampling is one approach, we see here, but another thing to think about is that of the **sample size**. The next activity explores this. 


---





#### Activity 5: Sample sizes

We came out pretty well in the above example, with our samples of 100 probationers. But is 100 a good number? What if we had repeated samples of 30 instead of 100. What about 1,000? 


Well let's create 3 sets of 1,000 samples this time, to see how the sample size might affect our sampling distribution of our mean!


Let's make the 3 samples new dataframe objects, and call them `sample30`, `sample100`, and `sample1000`:


```r
# 30 probationers in each sample 
sample30 <- do(1000) * sample(x = prob_off, size = 30) 

# 100 probationers in each sample 
sample100 <- do(1000) * sample(x = prob_off, size = 100) 


# 1000 probationers in each sample 
sample1000 <- do(1000) * sample(x = prob_off, size = 1000) 
```



Now we have 3 dataframes, all with 1,000 samples of varying sample sizes. The first with 1,000 30-person samples, the second with 1,000 100-person samples, and the 3rd with 1,000 1000-person samples. Which one of these would you trust to best represent the population? Why? Do you come across anything like this in your own lives? Discuss in your groups if you're in the chatty rooms!


In the meantime, let's also create a new dataframe for each set of 1,000 samples where we calculate the mean IQ for each one of them. 


```r
# Calculate the means IQ scores for each sample 

sample_means30 <- sample30 %>% 
  group_by(.index) %>% 
  summarize(meanIQ = mean(IQ))

sample_means100 <- sample100 %>% 
  group_by(.index) %>% 
  summarize(meanIQ = mean(IQ)) 

sample_means1000 <- sample1000 %>% 
  group_by(.index) %>% 
  summarize(meanIQ = mean(IQ)) 
```


We now have 3 dataframes, each with 1,000 samples, but one with 30 people per sample, one with 100 peope per sample, and one with 1,000 people per sample. Let's bind these together, but first, for each one, create a new column called "sample_size" which tell us which one has how many people in each sample. 



```r
sample_means30 <- sample_means30 %>% mutate(sample_size = "30")

sample_means100 <- sample_means100 %>% mutate(sample_size = "100")

sample_means1000 <- sample_means1000 %>% mutate(sample_size = "1000")
```




We use the function `bind_rows()` to *bind* these different data frames of different sample sizes into one complete dataframe, to answer our question:





```r
sample.means.total <- bind_rows(sample_means30, sample_means100, sample_means1000)
```


Now if you look at this dataframe, it has 3,000 samples in it, 1,000 with 30 people in each, 1,000 with 100 people in each, and 1,000 with 1,000 people in each. Let's look at the distribution of the mean IQ for each of these three sets. We can use `geom_density` to create a density plot. Let's fill by sample_size, and let's set the opacity (`alpha = ` to 0.5 so we can see through each one for they will overlap)





```r
# Density plot for comparison 
ggplot(data = sample.means.total) + 
  geom_density(mapping = aes(x = meanIQ, fill = sample_size), alpha = 0.5) 
```

![](05-inferential-statistics_files/figure-epub3/unnamed-chunk-24-1.png)<!-- -->



From the density plot, all three sample distributions are normally distributed and have similar means to that of the population. (remember that the mean of the sampling distribution will be the true population parameter!)



Notice, however, that the *larger the sample size, the more likely that the sample means are closer to those of the population*. The distribution of sample sizes of 1,000, for example, is tight and pointy, indicating that the IQ scores cluster very closely to the mean of the sampling distribution (and therefore the true population mean). 

Whereas if we look at the distribution of the sample sizes of 30, it is flatter and wider - its scores are more spread away from the true population mean. The implication is that if we draw small sized samples, we have a higher chance of having a sample that does not reflect the true population at all. With small sample, we run the risk of getting a sample statistic that is further away from the population parameter than we do with larger samples. So generally, larger the sample the better. Otherwise, our findings and generalisations will be inaccurate. 


So how do we know what sample size is big enough? For this, we carry out something known as a **power analysis** but we will get to that next week. For now, think "bigger is better" when it comes to sample size!


So great, we can say all these things in our hypothetical world of the many many many samples from the same population. But like we said earlier, we don't really get a chance to do that in the real world. So how can we trust our samples? To do this, we can quantify our sample variabilty using **standard errors**. 


---




### Standard Errors




#### Activity 6: The central limit theorem

We can summarise the variability of the sampling distribution in an estimate called **standard error** (SE). It is essentially the standard deviation of the sampling distribution. We demonstrate how sample size affects the SE, in that the larger the sample size, the smaller the SE and vice versa:




```r
sd(sample_means30$meanIQ)
```

```
## [1] 2.802161
```

```r
sd(sample_means100$meanIQ)
```

```
## [1] 1.468766
```

```r
sd(sample_means1000$meanIQ)
```

```
## [1] 0.474146
```


You can see that as the sample sizes get larger, we see a smaller result for the standard deviation of our sampling distribution - or the standard error of our sample. 

What we have learned is succinctly referred to as the **Central Limit Theorem**. This theorem states that as sample sizes get larger, the means of the sampling distribution approaches normal distribution; it is able to reflect the true population estimate. 

With the synthetic data, we have demonstrated how samples can estimate the population, which is usually unknown to us. The SE is helpful for when we want to know the extent to which the mean of the sample we have, drawn from a population whose estimates are unknown to us, is an accurate estimation of the true mean in that population. 


But I promised a way to quantify our sample variability without having to do 1000 repeat samples. Well, excitingly, we can calculate the standard error from just one sample! Let's do this by using a sample of 1,000 people. Let's make a new one of these: 


```r
set.seed(1234)
new_1000_sample <- sample(prob_off, 1000)
```

Now we can get the standard error by dividing the standard deviation of the IQ variable in this sample by the square root of our sample size (in this case 1000):

$SE = \sigma/\sqrt(n)$


In `R`: 


```r
sd(new_1000_sample$IQ)/sqrt(1000)
```

```
## [1] 0.4887421
```



The SE is 0.4887421. What does this mean? Well remember that the standard error is the standard deviation of the sampling distribution of our sample statistic (here the mean). And remember what percentage of observations, within a normal distribution, fall within some standard deviations away from the mean?

- 68% between +/- 1 standard deviation from the mean
- 95% between +/- 2 standard deviations away from the mean
- 99% between +/- 3 standard deviations away from the mean


So, with our standard error above, we can say that almost all of the samples (95%) will produce a statistic (in this case a mean) which are within +/- 2* 0.4887421, so within +/- 0.9774842 or about 1 IQ point away from the true mean IQ for the whole population of 3.6 million probationers!



This is how we can use the theory of the sampling distribution of the mean to then look into our one sample, and be able to estimate how representative are the estimates we derive from them about the whole population. How cool is that?! It is the power of statistics all in our hands!





---


### Confidence Intervals


The last thing we will learn about is a  better way of communicating the extent of inaccuracy in sample estimates. Communicating uncertainty when talking about statistics is an incredibly important topic! In statistics, we are making generalisations, we are making inferences about a population based on some data we collected from a sample. This means that we will always have some element of error and uncertainty in our conclusions. 

One way to clearly quantify and communicate our uncertainty is to use **confidence intervals** (CIs). These appear as an interval that tells you the margin of error – far away is your sample statistic from the population parameter. We calculate them by, first, returning to our normal distribution, and its **68-95-99 rule**, or known as an empirical rule, which states that 68% of cases in the distribution will fall within one standard deviation above and below the mean; 95% within two SD; and 99% within three SD. 




#### Activity 7: The 68-95-97 rule in action

Two observations to note: first, last week we learned about standard deviations and that there was mention of 68% of verbal assaults falling within one SD; it was a reference to this rule. Second, there is a contradiction with the numbers. If 95% of values fall within 1.96 SD, then why does the empirical rule state that 95% of values will fall within 2 SD, and why have you been saying this so far? Well, I'm simply rounding up. The former (1.96) is the precise number and the latter (2) is an approximation, meant to help you memorise this rule easier than if the value was a non-integer like 1.96. 

If 95% of values of the normal distribution fall within 1.96 SD of the mean, we are able to calculate the upper and lower boundaries of this particular confidence interval using this 1.96 value (also known as z-value) from our sample using the following formula: 


$\bar{x} \pm 1.96*{sd}/{\sqrt{n}}$


Let's look back at our `sample1` object. Then take the mean of IQ in this sample: 



```r
mean(sample1$IQ, na.rm = TRUE)
```

```
## [1] 101.59
```


Now to create the lower bound for the confidence interval around this sample statistic, we take this mean minus 1.96 times the standard deviation:


```r
mean(sample1$IQ, na.rm = TRUE) - 1.96*sd(sample1$IQ)/sqrt(100)
```

```
## [1] 98.40013
```


And to get the upper bound, you add the same value (1.96*the standard deviation) to the mean: 


```r
mean(sample1$IQ, na.rm = TRUE) + 1.96*sd(sample1$IQ)/sqrt(100)
```

```
## [1] 104.7799
```



<!-- We can visualise these add these using a density plot for the distribution of IQ scores in our sample, and the the `geom_vline` function to show the mean (red line) and the +/- standard deviation (blue line), and the upper and lower CIs (green line): -->



<!-- ```{r} -->

<!-- ggplot(data = sample1) +  -->
<!--   geom_density(mapping = aes(x = IQ)) +  -->
<!--   geom_vline(mapping = aes(xintercept = mean(IQ)), col = "red", linetype = "dashed") + -->
<!--   geom_vline(mapping = aes(xintercept = mean(IQ) +  -->
<!--                              1.96*sd(IQ)), col = "blue", linetype = "dashed") + -->
<!--   geom_vline(mapping = aes(xintercept = mean(IQ) - 1.96*sd(IQ)), col = "blue", linetype = "dashed") +  -->
<!--   geom_vline(mapping = aes(xintercept = mean(IQ) +  -->
<!--                              1.96*sd(IQ)/sqrt(100)), col = "green", linetype = "dashed") + -->
<!--   geom_vline(mapping = aes(xintercept = mean(IQ) - 1.96*sd(IQ)/sqrt(100)), col = "green", linetype = "dashed") -->

<!-- ``` -->



Seeing the dashes that represent the confidence interval shows us that IQ scores will vary away from the mean of our sample, but 95% of them will fall within this interval. Similar to what we learned about repeated samples, if we took 100 resamples of our population of probationers and obtained the sample means, the true population mean will fall within the confidence interval 95% of the time. Thus, only 5% of the time will our resamples fail to obtain the true population mean.  


So here, we can conclude from our sample that the mean IQ for all probationers will be somewhere between 98.4001302 and 101.908987. 


What if we took a different sample though? You can repeat the steps above for sample 2 and sample 3, and you will see the following conclusions: 

- **Sample 2**: we conclude that the mean IQ for all probationers will be somewhere between 97.8539159 and 103.7660841. 
- **Sample 3**: we conclude that the mean IQ for all probationers will be somewhere between 96.3651461 and 102.4548539. 


With each different sample we get a slightly different upper and lower bound. So how can we trust this? Well since we know that we have 95% of observations within +/- 1.96 standard deviations from the mean of the sampling distribution, we can conclude that on the whole, the confidence intervals derived from 95% of our samples will contain the true population parameter!

Don't believe me? Let's plot this!

First let's take our population parameter, the true mean IQ for all probationers in the US: 


```r
# Create a vector containing the true population mean from prob_off
true.mean <- mean(prob_off$IQ)
```


Then, let's take another 100 samples of 100 probationers in each sample: 


```r
set.seed(1897)
new_sample_100 <- do(1000) * sample(prob_off, size = 100)
```

Now for each sample, calculate the mean and the lower and upper CIs (remember above the formula to get these CIs!)


```r
# Select the sample of 1,000 samples, each with 100 probationers and place in object, ‘new.sample.ci100’
new.sample.ci100 <- new_sample_100 %>% 
  group_by(.index) %>% 
  summarise(sample_mean = mean(IQ), 
         sample_sd = sd(IQ),
         lower_ci = sample_mean-1.96*sample_sd/sqrt(100), 
         upper_ci = sample_mean+1.96*sample_sd/sqrt(100)) 
```


If you have a look at this new dataframe `new.sample.ci100` you can see that for each one of our 100 samples, we have the sample mean, as well as the sd and the calculated upper and lower CI. Let's revisit what we learned from recoding, and use the `if_else()` function to create an additional variable, which tells us whether or not each one of the CIs contains the true population mean (`true.mean` above). 


```r
new.sample.ci100 <- new.sample.ci100 %>% 
  mutate(capture.mean = if_else(condition = lower_ci > true.mean | upper_ci < true.mean, true = "no", false = "yes")) # Specify code below to be: If lower > true mean or upper < true mean then capture.mean will #be "yes" 
# If not, capture.mean will be "no"
```

We can now use this to produce a table to show new variable and how many Cis captured the true population mean: 


```r
table(new.sample.ci100$capture.mean)
```

```
## 
##  no yes 
##  42 958
```

Looks like our samples fared better than we would hope, in this example 958% contained our true population mean, and  42% did not, but it's still close to what we expected. What if we were to do this with 1000 samples of 100? What do you think the yes vs nos would look like then? What about 10,000 samples? Discuss in your groups. 


---




#### Activity 8: Visualising confidence intervals

Finally, to illustrate, we can visualise this to better understand what we have just found:




```r
ggplot(data = new.sample.ci100) + 
  geom_vline(mapping = aes(xintercept = true.mean), linetype = "dashed") +
  geom_errorbarh(mapping = aes(xmin = lower_ci, xmax = upper_ci, y = .index, colour = capture.mean)) + # Creating error bars to represent CIs and colouring in which ones captured population mean #and did not by ‘capture.mean’
  geom_point(mapping = aes(y = .index, x = sample_mean, colour = capture.mean))
```

![](05-inferential-statistics_files/figure-epub3/unnamed-chunk-36-1.png)<!-- -->



The visual shows the result obtained in the table, but here, you can see all 100 of the scores, their CIs, and how 95% of the time, they capture the true population mean. In reality, we have no way of knowing whether we have captured the true population estimates in our sample, but the use of the confidence interval gives us *confidence* that we are on the right track, so reporting CIs in your results is good practice for presenting your findings. 





---




## SUMMARY




Today was a theoretical demonstration of why **samples** can be used to estimate what is happening in the **population**. Samples with high **external validity** can do so. This is the foundation of inferential statistics, the use of samples to draw conclusions about the population. We used **synthetic data** to show why. Despite **sampling variability**, the means of the **sampling distribution** demonstrate that it is able to approximate the normal distribution and, therefore, the true population estimates. This is further demonstrated by the **central limit theorem**, which clarifies that sample size matters in producing more accurate estimates of the population. We learned about the standard error and then onto **confidence intervals**, which is useful in establishing how accurate our estimates are, because in reality, rarely are the population estimates known. 





Homework time!






