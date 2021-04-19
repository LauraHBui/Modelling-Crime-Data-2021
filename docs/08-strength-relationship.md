
# Testing relationships II.  

#### Learning Outcomes: {-}
-	Explore more measures of effect sizes for relationships with categorical variables
- Explore relationship between two numeric variables
- Understand statistical power




#### Today’s Learning Tools: {-}




##### *Data:*{-}
-	Seattle Neighborhoods and Crime Survey
-	Patrick Sharkey’s data




##### *Packages:*{-}
-	`DescTools`
-	`dplyr`
-	`ggplot2`
-	`GoodmanKruskal`
- `haven`
- `here`
-	`tibble`
- `pwr`




##### *Functions introduced (and packages to which they belong)*{-}
-	`add_row()` : Add rows to a data frame (`tibble`)
-	`cor()` : Produces the correlation of two variables (`base R`)
-	`cor.test()` : Obtains correlation coefficient (`base R`)
-	`CramerV()` : Conducts the Cramer’s V measure of association (`DescTools`)
-	`GoodmanKruskalGamma()` : Conducts Goodman-Kruskal gamma measure of association (`DescTools`)
-	`Phi()` : Conducts the phi measure of association (`DescTools`)
-	`rm()` : Remove object from R environment (`base R`)
-	`SomersDelta()` : Conducts the Somers’ D measure of association (`DescTools`)
- `ES.w2()`: Compute effect size w for a two-way probability table (`pwr`)
- `pwr.chisq.test()` : Compute power of test or determine parameters to obtain target power (`pwr`)




---


## Measures of Association




So far in the course, we have learned ways of measuring whether there is a relationship between variables. If there is a relationship between variables, it means that the value of IV can be used to predict the value of the DV. Although we are able to test for statistical significance, we are unable to say anything about how *strong* these associations between variables are. 

We also leaned that in crime and criminal justice research, not only are we interested in whether there is a relationship between variables, but we are also interested in the size of that relationship. Knowing the strength of the relationship is useful because it indicates the size of the difference. It addresses the question of ‘To what extent is this relationship generalisable?’ instead of merely ‘Is there a relationship or not?’ 

The strength of relationship is known more as the **effect size**, and simply quantifies the magnitude of difference between two variables. We began to explore this in last week's session and learned about rediduals, odds ratios, and more. This lesson we will consider a few more measures. 

We will also consider evaluating relationships between two numeric variables specifically we will explore measures of **correlation**. 

Finally, we keep saying that with large enough sample sizes we can relax some of our assumptions, and generally we talk about sample sizes that are "large enough" but what is large enough? We will introduce **power analysis** and how we can use that to estimate our minimum sample sizes needed for our analyses. 



We begin by :




1.	Opening our project




2.	Loading the required packages




3.	Opening the Seattle Neighborhoods and Crime Survey dataset using the function `read.dta()` and naming the data frame object as `seattle_ df`




4.	Get to know the data by using the functions `View()` and `dim()`, and to see if it has been loaded successfully




---


## Today’s 3




We will learn some more measures of effect sizes for categorical variables, then we will explroe relationship bbetween numeric variables, and how to interpret them. Finally, we will learn about power analyses for estimating sample sizes. 



---


### Effect sizes for relationships between with categorical variables 

Following last week’s lesson on the chi-square analysis, the effect size for the relationship between two categorical variables can be conducted after obtaining the *χ*2 statistic. A number of measures are available to test *how related* the two variables are to each other. We learn three of them: *phi*, *Cramer’s V*, and *Goodman and Kruskal’s lambda and tau*.




#### Activity 1:  Phi




This measure builds directly off of the chi-square statistic, but it is for the strength of association between two *binary* variables. It is used for 2×2 tables to obtain a measure of association ranging from 0 to 1, whereby higher values indicate a stronger relationship. 
What this measure does is account for the sample size under observation, as the chi-square statistic is influenced by it. We obtain the **phi** coefficient by dividing the chi-square value by the sample size and taking the square root of that result, but we can do this in `R`. For example, we would like to know whether there is a relationship between sex and reporting victimisation to the police, and what is the strength of that relationship. We obtain the relevant variables, then conduct a chi-square analysis and obtain the phi coefficient:





```r
# Create copies of the variables, rename them so it is easier to remember 
# sex is variable ‘QDEM3’
table(seattle_df$QDEM3)
```

```
## 
##    1    2 
## 1145 1075
```

```r
# Use factor () function to create factor variable ‘sex’
seattle_df$sex <- factor(seattle_df$QDEM3, levels = c(1, 2), labels = c("female" ,
                                                                        "male"))

# Reported victimisation to police is ‘Q58E’
table(seattle_df$Q58E)
```

```
## 
##   -1    0    1    8    9 
## 1582  379  255    2    2
```

```r
# Use factor () function to create factor variable ‘reported_to_police’
seattle_df$reported_to_police <- factor(seattle_df$Q58E, levels = c(0, 1), labels =
                                          c("no" , "yes"))

# Chi-square analysis 
# Place variable objects into new object ‘chi’
chi<-table(seattle_df$sex, seattle_df$reported_to_police) 
# Make sure the relationship is significant first
chisq.test(chi)
```

```
## 
## 	Pearson's Chi-squared test with Yates' continuity correction
## 
## data:  chi
## X-squared = 5.8156, df = 1, p-value = 0.01588
```

```r
# Chi-square is significant ( p= 0.01588)

# Calculate the phi coefficient 
Phi(seattle_df$sex, seattle_df$reported_to_police)
```

```
## [1] 0.09903062
```




The phi value is about 0.1, and as the range is 0 to 1, it seems that this value is closer to 0 than it is to 1. We conclude that this is a weak association between a respondent’s sex and whether they reported their victimisation to the police. 




---



#### Activity 2: Cramer’s V




For tables that are larger than 2x2, meaning these categorical variables are not binary, **Cramer’s V** is appropriate (although using Cramer’s V on a 2x2 table will produce the same value as that of the phi coefficient). Interpreting this value is similar to phi: a range from 0 to 1 with higher values indicating a stronger relationship. An advantage of Cramer’s V is that it is not swayed by sample size, so if you had suspected that the chi-square statistic was the result of a large sample size, this value can help determine that:





```r
# Cramer's V test for the same relationship detailed above to show that it is exactly like phi: 
CramerV(seattle_df$sex, seattle_df$reported_to_police)
```

```
## [1] 0.09903062
```

```r
# Now for non-binary variable, Q52, ‘How often do you worry about being attacked in your neighbourhood’

# Checking it out
table(seattle_df$Q52)
```

```
## 
##    1    2    3    4    8    9 
## 1584  354  167   98   12    5
```

```r
# Make a copy of the Q52 variable 
seattle_df$worry_attacked <- factor(seattle_df$Q52, levels = c(1, 2, 3, 4), labels =
                                      c("Less than once a month" , "once a month",
                                        "about o nce a week", "everyday"))

# Run a chi-square test to make sure there is a significant relationship 
# Save the result in the object "chi2" 
chi2 <- table(seattle_df$worry_attacked, seattle_df$sex) 
chisq.test(chi2)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  chi2
## X-squared = 38.092, df = 3, p-value = 2.702e-08
```

```r
# Conduct the Cramer's V test of association on the contingency table 
# You can use the object ‘chi2’ for convenience 
CramerV(chi2)
```

```
## [1] 0.1314953
```




Like the phi, the value shows a relatively small relationship between residents’ sex and how often they worry about being attacked in their neighbourhood.







In some common situations in crime and criminal justice research, we work with survey data that have ordered response categories. For example, a likert scale of how strongly someone feels about abolishing the death penalty. 

We learn two measures that deal with relationships between categorical, ordinal variables: Goodman-Kruskal's Gamma and Somers’ D. Both use concordant and discordant pairs of observations to estimate the effect size. **Concordant pairs** are observations where the rankings are consistent for both variables, and **discordant pairs** are observations whose rankings are inconsistent for both variables. If a pair of observations has the same rank on the variables of interest, they are considered a **tied pair**. 




---



#### Activity 3: Goodman-Kruskal Gamma




**Gamma** can take on values ranging from −1 to +1, where: 0 indicates no relationship at all; a negative value indicates a negative relationship; and a positive value a positive relationship. The closer the value is to either −1 or +1, the stronger the relationship is between variables. 

For this example, we test the association between two measures commonly used to gauge community informal social control. The first variable, `Q20A`, is based on a survey question asking respondents how likely it is that their neighbours would do something about a group of neighbourhood children skipping school. The second variable, `Q20B`, asks respondents how likely it is that neighbours would do something if children were spray painting graffiti on a neighbourhood building. 





```r
# First, check and recode your variables if necessary 
table(seattle_df$Q20A)
```

```
## 
##   1   2   3   4   8   9 
## 432 701 784 207  87   9
```

```r
# Recode Q20A- check the codebook on the variable's ranking
seattle_df$intv.truancy <- factor(seattle_df$Q20A, levels = c(1, 2, 3, 4), labels =
                                    c("very likely" , "likely", "unlikely", "very unlikely"))

# Review everything was coded correctly 
table(seattle_df$intv.truancy)
```

```
## 
##   very likely        likely      unlikely very unlikely 
##           432           701           784           207
```

```r
class(seattle_df$intv.truancy)
```

```
## [1] "factor"
```

```r
# Now do the same for the graffiti variable 
table(seattle_df$Q20B)
```

```
## 
##    1    2    3    4    8    9 
## 1198  761  177   43   35    6
```

```r
seattle_df$intv.graff<- factor(seattle_df$Q20B, levels = c(1, 2, 3, 4), labels =
                                 c("very likely" , "likely", "unlikely", "very unlikely")) 

table(seattle_df$intv.graff)
```

```
## 
##   very likely        likely      unlikely very unlikely 
##          1198           761           177            43
```

```r
class(seattle_df$intv.graff)
```

```
## [1] "factor"
```

```r
# Assess the relationship between these two variables 
GoodmanKruskalGamma(seattle_df$intv.truancy, seattle_df$intv.graff, conf.level = .95)
```

```
##     gamma    lwr.ci    upr.ci 
## 0.6315274 0.5898587 0.6731960
```

```r
# We can also run it using a table saved as an R object 
x <- table(seattle_df$intv.truancy, seattle_df$intv.graff) 
gamma_neighbor_intervene <- GoodmanKruskalGamma(x, conf.level = .95)
```




We specified the `conf.level` option and get a 95% confidence interval around the gamma coefficient. The value we receive is 0.63, which, in addition to the confidence interval that does not overlap with 0, indicates a fairly strong statistically significant and positive association between the two variables.




---




#### Activity 4: Somers’ D




**Somer’s D** provides a value between −1 and +1, whereby values closer to −1 and +1 indicate better prediction ability. This commonly used measure for ordinal variables indicates how much improvement in the prediction of the dependent variable is attributed to information we know from the independent variable. 

We use the `SomersDelta` function from the `DescTools` package to conduct Somers’ D. We examine the relationship between the respondents’ perception of their neighbour’s willingness to exert informal social control and how likely the respondent would miss their neighbourhood if they moved away (`Q7`):




```r
# Recode the variable Q7 
seattle_df$miss_neigh <- factor(seattle_df$Q7, levels = c(1, 2, 3, 4), labels = c("very likely" , "likely", "unlikely", "very unlikely")) 

# Check our newly coded variable 
table(seattle_df$miss_neigh)
```

```
## 
##   very likely        likely      unlikely very unlikely 
##          1094           760           244           102
```

```r
# To run Somers' D, first save the contingency table in the R object "z" 
z <- table(seattle_df$intv.graff, seattle_df$miss_neigh) 

# Now run the Somers' D measure 
# ‘direction’ tells R which variable should be considered the IV
# It defaults to row, so if you excluded this option, the function would still provide you with a value
SomersDelta(z, direction = "row", conf.level = 0.95)
```

```
##    somers    lwr.ci    upr.ci 
## 0.1867064 0.1502957 0.2231171
```




Somers’ D is positive, but close to 0, meaning that perception of neighbours’ willingness to intervene is a poor predictor of how much respondents would miss their neighbourhood if they moved. The confidence interval around the estimate does not overlap with 0 meaning that the association is statistically significant, even though the association is weak. 




---


### Relationships Between Numeric Variables




This section is about measuring the strength of relationships between two ratio/ interval variables. Load Professor Patrick Sharkey’s dataset (sharkey.csv), which is a study on the effect of nonprofit organisations on the levels of crime, using the `read_csv()` function. Alternatively, you can load the dataset from the [Dataverse website](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/46WIH0). 



Name the data frame `sharkey`, and if you dislike scientific notation, you can turn it off in `R` by using `options(scipen=999)`.

First, we examine our bivariate relationship between variables of interest through a scatterplot. The reason for this is we need to figure out if the variables have a **linear relationship**, and this determines what test we need to use. The extent to which two variables move together is called **covariation**: one variable can increase and so will the other (positive linear relationship); one variable can decrease while the other increases (negative linear relationship).

We focus on the year 2012, which is the most recent year in the dataset, and on only a few select variables. We will place them in a data frame named, `df`. To do this, we will use the `filter()` and `select()` functions from the `dplyr` package. Then, we will remove the dataset from `R` using the `rm()` function.





```r
df <- filter(sharkey, year == "2012") 
df <- select(df, place_name, state_name, black, lesshs, unemployed, fborn,
             incarceration, log_viol_r, largest50) 

# Goodbye sharkey
rm(sharkey)

# View the number of cities located in each of the 44 states
table(df$state_name)
```

```
## 
##              Alabama               Alaska              Arizona 
##                    4                    1                    9 
##             Arkansas           California             Colorado 
##                    1                   65                   10 
##          Connecticut District of Columbia              Florida 
##                    5                    1                   18 
##              Georgia                Idaho             Illinois 
##                    2                    1                    8 
##              Indiana                 Iowa               Kansas 
##                    3                    3                    5 
##            Louisiana             Maryland        Massachusetts 
##                    4                    1                    3 
##             Michigan            Minnesota          Mississippi 
##                    6                    3                    1 
##             Missouri              Montana             Nebraska 
##                    5                    1                    2 
##               Nevada        New Hampshire           New Jersey 
##                    3                    1                    4 
##           New Mexico             New York       North Carolina 
##                    1                    5                    9 
##         North Dakota                 Ohio             Oklahoma 
##                    1                    5                    4 
##               Oregon         Pennsylvania         Rhode Island 
##                    4                    4                    1 
##       South Carolina         South Dakota            Tennessee 
##                    3                    1                    6 
##                Texas                 Utah             Virginia 
##                   30                    4                    7 
##           Washington            Wisconsin 
##                    6                    3
```



The variables we now have contain information on the demographic composition of those cities (percent black population, percent without high school degree, percent unemployed, percent foreign born) and criminal justice characteristics (incarceration rate and the rate of sworn full-time police officers). In addition, we have measures of the violence rate and a binary variable that tells us if the city is one of the 50 largest in the country (value ‘1’ means one of the 50 largest).

#### Ativity 5: Scatterplot

As the first step in exploring relationships is to visualise them, we create a scatterplot between the log of the violence rate (`log_viol_r`) and unemployment (`unemployed`) using the `ggplot()` function in the `ggplot2` package:





```r
ggplot(df, aes(x = unemployed, y = log_viol_r)) + 
# Jitter adds a little random noise 
# This makes points less likely to overlap one another in the plot 
  geom_point(alpha=.2, position="jitter")
```

![](08-strength-relationship_files/figure-epub3/unnamed-chunk-9-1.png)<!-- -->




Is there a linear relationship between violence and unemployment? Does it look as if cities that have a high score on the x-axis (unemployment) also have a high score on the y-axis (violent crime)? It is hard to see but there is a trend: cities with more unemployment seem to have more violence. Notice, for example, how at high levels of unemployment, there are places with high levels of violence.

As there is a linear relationship, we conduct a **Pearson’s correlation** test. This test tells you whether the two variables are significantly related to one another – whether they covary. A p-value is provided to determine this. Also provided is a Pearson’s r value, which indicates the strength of the relationship between the two variables. The value ranges from −1 (a negative linear relationship) to 1 (a positive linear relationship). Values that are closer to 1 or −1 suggest a stronger relationship. 

The test calculates this value, the Pearson's r, by, first, examining the extent to which each case deviates from the mean of each of the two variables, and then multiplies these deviations:

$$covariation~ of ~scores =	\sum_{i=1}^{n} (x_{1i} - \bar{x_1})(x_{2i} - \bar{x_2})$$

Second, it standardises the covariation by taking the square root of the value obtained from the sums of squared deviations from the mean of both variables. This is because, sometimes, the variables may use different units of measurement from each other. For example, one variable measures in inches and the other variable measures in decades. Thus, Pearson's r is the ratio between the covariation of scores and this standardisation of covariation:

$$ Pearson's~ r = \frac{\sum_{i=1}^{n} (x_{1i} - \bar{x_1})(x_{2i} - \bar{x_2})}{\sqrt{[\sum_{i=1}^{n} (x_{1i}- \bar{x_1})^2][\sum_{i=1}^{n} (x_{2i}- \bar{x_2})^2]}} $$




Our null and alternative hypotheses are as follows:




$H_0$: There is no correlation between the violence rate and unemployment. 




$H_A$: There is a correlation between the violence rate and unemployment.


#### Activity 6: Pearson's correlation in R

We use the `cor()` function and `cor.test` from `base R` to conduct a Pearson’s correlation:






```r
cor(df$log_viol_r, df$unemployed)
```

```
## [1] 0.5368416
```

```r
cor.test(~ log_viol_r + unemployed, data=df, method = "pearson", conf.level = 0.95)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  log_viol_r and unemployed
## t = 10.3, df = 262, p-value < 0.00000000000000022
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.4449525 0.6175447
## sample estimates:
##       cor 
## 0.5368416
```





The `cor()` function gives the correlation but `cor.test()` gives more detail. Both give a positive correlation of 0.54. The coefficient is also an indication of the strength of the relationship. Jacob Cohen (1988) suggests that within the social sciences, a correlation of 0.10 may be defined as a small relationship; a correlation of 0.30, a moderate relationship; and a correlation of 0.50, a large relationship.

As our relationship was linear and our results are statistically significant, we reject the null hypothesis. We conclude that there is a statistically significant relationship between the violence rate and unemployment.


#### Activity 7: Nonparametric correlation tests


Now what about bivariate relationships where linearity is not met? This would call for either **Kendall’s tau** and **Spearman’s correlation**, nonparametric versions of Pearson’s correlation. Kendall’s tau is more accurate when you have a small sample size compared to Spearman’s rho. 

We again use the function `cor.test()` to conduct these:





```r
# We purposely add an outlier so that the relationship is no longer linear
# This will produce a fictitious city with a very high level of unemployment and the lowest level of violence
# For convenience, we will first further reduce the number of variables 
df_1 <- select(df, unemployed, log_viol_r) 

# To add cases to data frame, use the add_row() function from the tibble package
df_1 <- add_row(df_1, unemployed = 20, log_viol_r = 1)

# Conducting a Kendall
cor.test(~ log_viol_r + unemployed, data=df_1, method = "kendall", conf.level = 0.95)
```

```
## 
## 	Kendall's rank correlation tau
## 
## data:  log_viol_r and unemployed
## z = 8.3925, p-value < 0.00000000000000022
## alternative hypothesis: true tau is not equal to 0
## sample estimates:
##      tau 
## 0.345979
```

```r
# Conducting a Spearman
cor.test(~ log_viol_r + unemployed, data=df_1, method = "spearman", conf.level = 0.95)
```

```
## Warning in cor.test.default(x = c(7.2830276, 6.79316, 6.478019, 5.949461, :
## Cannot compute exact p-value with ties
```

```
## 
## 	Spearman's rank correlation rho
## 
## data:  log_viol_r and unemployed
## S = 1574389, p-value < 0.00000000000000022
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho 
## 0.4923882
```




The correlation coefficient is represented by tau for Kendall’s rank (ranges from 0 to 1) and by Spearman’s r (or rho) value (ranges −1 to 1) for Spearman’s rank. 





---

### Power analysis

In this section we introduce the `pwr` package for power analysis. In the video lectures you had to watch as preparation for today we introduced the notion of power analysis. In order for a statistical test to be able to be effective, to be able to detect an effect, you need to have sufficient power.


Power is related to the magnitude of the effect (it will be easier to detect stronger rather than weaker effects) and sample size (it will be easier to detect effects with large samples than with small samples). A problem with many scientific studies is that they are *underpowered*, the fail to reject the null hypothesis simply because they do not have sufficient power (often because the sample size is not large enough). Power analysis is generally done during the planning of an analysis so that you know what kind of sample you are going to need if you want to be able to run meaningful hypothesis tests. That is you do your power analysis before you collect your data. 


But we can also check how much power we have after the fact, just to ensure we are not failing to reject the null hypothesis as a consequence of insufficient power. For this purposes we can use the `pwr` package. For computing the power when comparing two sample means we use the function which is most appropriate for the kind of test we want to carry out. For example, if we were comparins means between two groups (remember t-test!) we would use the `pwr.t2n.test()` function. For calculating power for a chi-square test you would use the `pwr.chisq.test()` function. Here is a list for functions for more tests: 


- `pwr.p.test()`: one-sample proportion test
- `pwr.2p.test()`: two-sample proportion test
- `pwr.2p2n.test()`: two-sample proportion test (unequal sample sizes)
- `pwr.t.test()`: two-sample, one-sample and paired t-tests
- `pwr.t2n.test()`: two-sample t-tests (unequal sample sizes)
- `pwr.anova.test()`: one-way balanced ANOVA
- `pwr.r.test()`: correlation test
- `pwr.chisq.test()`: chi-squared test (goodness of fit and association)
- `pwr.f2.test()`: test for the general linear model


Once you knwo what test you are calculating your power for, this function expects we provide the sample size of each group (if we are doing the power calculation after we have collated our data) and the effect size we may want to be able to detect. 

#### Activity 8: post-hoc power analysis


Checking for our statistical power in this after-the-fact manner is referred to as post-hoc power analysis. Post-hoc power is the retrospective power of an observed effect based on the sample size and parameter estimates derived from a given data set. Post-hoc power can be considered as a follow-up analysis. 

Going back go our Seattle data set, we can have a look at our test of relationship between gender and reporting th the police .First let's see how many men and women we have in our data: 



```r
seattle_df %>% 
  group_by(sex) %>% 
  count()
```

```
## # A tibble: 2 x 2
## # Groups:   sex [2]
##   sex        n
##   <fct>  <int>
## 1 female  1145
## 2 male    1075
```

Ok, so that is 1145 women  and 1075 men. Good to know. Now if we were pre-data collection, and could influence the number of people we include in our sample, we would want to specify two things. We would want to specify our alpha level (usually our $\alpha = 0.05$), and also the minimum effect size we want to detect. 


For example, to calculate power for our chisquare table, we need first the effect size. We can get this with the `ES.w2()` function, which requires a proportions table. We can first create a cross tab with the table function, and then use the `prop.table()` function to turn this into a proportions table: 


```r
cross_tab <- table(seattle_df$sex, seattle_df$reported_to_police)
prop_tab <- prop.table(cross_tab)

prop_tab
```

```
##         
##                 no       yes
##   female 0.2287066 0.1940063
##   male   0.3690852 0.2082019
```

You can see now the proportions of our observations of each cell - which represents all the combinations -  females who repored and did not report, and males who reported and did not report. All the proportions together should add up to 1. 


So to calculate power for our chi-square test, we will need the effect size, which we can acquire with the `ES.w2()` function. This function computes effect size $w$ for a two-way probability table corresponding to the alternative hypothesis in the chi-squared test of association in two-way contingency tables.


```r
library(pwr)

ES.w2(prop_tab)
```

```
## [1] 0.09903062
```

In this case, effect size $w$ is the square root of the standardized chi-square statistic.


We also need the total number of observations. We can get this with the `dim()` function, or by counting the number of rows with the `nrow()` function: 


```r
dim(seattle_df)
```

```
## [1] 2220  234
```

```r
nrow(seattle_df)
```

```
## [1] 2220
```

We can see there are 2220 observations. 

We also need degrees of freedom, which is the product of the number of values in each column minus 1. $df = (n-1)(n-1)$ in this case df = (2-1)*(2-1), which is 1.

Finally, we specify our significance level (the default is 0.05, so we don't *have* to do this, but it's good to be explicit...)



```r
pwr.chisq.test(w = ES.w2(prop_tab), N = 2220, df = 1, sig.level =  0.05)
```

```
## 
##      Chi squared power calculation 
## 
##               w = 0.09903062
##               N = 2220
##              df = 1
##       sig.level = 0.05
##           power = 0.9965956
## 
## NOTE: N is the number of observations
```

The function is telling us that we have a power of 0.9965956. The statistical power ranges from 0 to 1, and as statistical power increases, the probability of making a type II error (wrongly failing to reject the null) decreases. So with a power so close to 1 we are very unlikely indeed to failing to reject the null hypothesis when we should.

With sample sizes this large, you are unlikely to run into problems with power. But these things do matter in particular applications. Think for example of cases when you are trying to evaluate if a particular criminal justice intervention works. If you work with small samples you may wrongly conclude that your intervention didn't make a difference (you fail to reject the null hypothesis) because you did not have sufficient statistical power. This was a common problem in older studies (see [here](https://www.sciencedirect.com/science/article/pii/0047235289900044) for a review) and it is a problem that still persist to some extent (read [this](https://www.tandfonline.com/doi/abs/10.1080/07418825.2018.1495252) more recent review).


So how would you use power analysis to tell you what sample side you need to achieve? Well, for this you would use a pre-hoc power analysis - you want to carry out your power analysis before you collect your data. 


#### Activity 9: Power analysis for sample sizes

So what do you do if you don't have your data yet, but you want to calculate your ideal sample size, so that you can find the effect size which you think you're after in your experiment or reserach study? Well we can, instead of taking the effect size from our sample, we can give our *desired* effect size - what size of effect we'd like to detect? And instead of giving our sample size, we can specify the level of statistical power we want to have in our results. 


How do we arrive at these numbers? Well it can be helpful to refer to common practice. For example, [this article from UCLA on effect size in power analysis](https://stats.idre.ucla.edu/other/mult-pkg/faq/general/effect-size-power/faqhow-is-effect-size-used-in-power-analysis/) have compiled together from [Cohen, 1988](http://www.utstat.toronto.edu/~brunner/oldclass/378f16/readings/CohenPower.pdf) a table of reference numbers:


```r
knitr::kable(data.frame(analysis = c("t-test for means", "t-test for correlation", "F-test for regression", "chi-square"), 
                        "effect" = c("d", "r", "f^2", "w"), 
                        "small" = c(.20, .10, .02, .10), 
                        "medium" = c(.50, .30, .15, .30), 
                        "large" = c(.80, .50, .35, .50)))
```



|analysis               |effect | small| medium| large|
|:----------------------|:------|-----:|------:|-----:|
|t-test for means       |d      |  0.20|   0.50|  0.80|
|t-test for correlation |r      |  0.10|   0.30|  0.50|
|F-test for regression  |f^2    |  0.02|   0.15|  0.35|
|chi-square             |w      |  0.10|   0.30|  0.50|

So for example, a medium effect size for our chi-square results would be .30 You can see above, in our actual sample, we saw an effect size of 0.099. This just about counts as a small effect size there. Now remember, just because we *can* detect a bigger effect doesn't mean there is one!!! It may be there just is not that big of an effect size in the difference in reporting to police between men and women!


So anyway, back to estimating our ideal sample sizes. Let's say we want to detect a medium sample size, and we wish to achieve 90% power with our study. In that case, these are the parameters we would specify in our `pwr.chisq.test()` function: 



```r
pwr.chisq.test(w = 0.30, power = 0.90, df = 1, sig.level = 0.05)
```

```
## 
##      Chi squared power calculation 
## 
##               w = 0.3
##               N = 116.7491
##              df = 1
##       sig.level = 0.05
##           power = 0.9
## 
## NOTE: N is the number of observations
```
So in order to detect a medium effect size, with 90% power, we need 117 respondents. Not too bad. What about to detect a large effect size? 

**Do you think this will need more people, or fewer people? Why??**


Let's try: 


```r
pwr.chisq.test(w = 0.50, power = 0.90, df = 1, sig.level = 0.05)
```

```
## 
##      Chi squared power calculation 
## 
##               w = 0.5
##               N = 42.02968
##              df = 1
##       sig.level = 0.05
##           power = 0.9
## 
## NOTE: N is the number of observations
```
You can see we need much fewer people to detect a larger effect size? Why? Think about it - the bigger the difference between the two groups, the easier this is to detect - right? So if there are large differences between men and women in reporting to the police in the population, we will see these emerge even in smaller samples. However, if the differences are smaller, then in small samples we may not observe this. 


Let's see what sample sizes we'd need to find small effect sizes: 



```r
pwr.chisq.test(w = 0.10, power = 0.90, df = 1, sig.level = 0.05)
```

```
## 
##      Chi squared power calculation 
## 
##               w = 0.1
##               N = 1050.742
##              df = 1
##       sig.level = 0.05
##           power = 0.9
## 
## NOTE: N is the number of observations
```
1050 people! That escalated quickly! However, we do have this sample size in our Seattle data, and accordingly, we did detect this small but statistically significant (i.e. gerenalisable) difference! 


The power calculation processes are similar for other types of test. You can always explore the help functions (type `?` in front of the function, like `? pwr.t.test()` for example) to find out the little variations, but the ideas are the same. And now you can confidently answer questions like how many people will you need to survey in order to detect different effect sizes. 

---



## SUMMARY




Today was all about **effect sizes** where we learned how to produce them. For relationships between nominal variables, we have the following options: **phi** and **Cramer’s V**. Then, for relationships between ordinal variables, we used **concordant and discordant pairs** to find effect sizes through **Gamma** and **Somers’ D**. We then learned to produce effect sizes for relationships between numeric relationships, and an important assumption had to do with **covariation**: **Pearson’s correlation** when the relationship is **linear** and nonparametric tests, **Kendall’s tau** and **Spearman’s correlation**, when the relationship is not. We then also learned about **power analysis** which helps determine the size of the effect which we can expect to find (or not find) in our research. Remember: *power analyses save effect sizes*!!!





Homework time!








