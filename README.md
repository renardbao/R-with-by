# with & by in R
Renard Bao  
2018年2月27日  

with() & by() ,本篇記錄`with()`和`by()`的用法  

###   <font color=#FFAA33 face = "Palatino Linotype">With</font>

> The with( ) function applys an expression to a dataset. It is similar to DATA= in SAS.

這是來自Quick-R一篇[Using with( ) and by( )](https://www.statmethods.net/stats/withby.html)中對with()
用法的解釋,其功能和SAS中的`DATA=`相似.  
可以透過在建立指定資料集內,運行R的函數(表達式).我覺得這樣挺方便的,因為當需要指派中繼變數來達到某種目的時,我可以透過`with()`創建資料集並且同時運行函數,而不用再多花記憶體為了創建資料集而指派中繼變數.

####  **<font color=#77DDFF >參數</font>** 
`with(data,expr,...)`

####  **<font color=#77DDFF >例子:</font>**
這邊用iris的資料集來作範例


```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
with(iris, table(Species))
```

```
## Species
##     setosa versicolor  virginica 
##         50         50         50
```

####  **<font color=#77DDFF >例子2:</font>**

```r
set.seed(1234)
with(data.frame(u = rnorm(10),
                a = rnorm(10),
                b = rnorm(10)
                ),
    list(summary(lm(u ~ a)),
         summary(lm(u ~ b))
         )
    )
```

```
## [[1]]
## 
## Call:
## lm(formula = u ~ a)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1.9327 -0.2974 -0.1742  0.7970  1.3600 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)  -0.4025     0.3311  -1.216    0.259
## a            -0.1635     0.3247  -0.504    0.628
## 
## Residual standard error: 1.04 on 8 degrees of freedom
## Multiple R-squared:  0.03072,	Adjusted R-squared:  -0.09044 
## F-statistic: 0.2536 on 1 and 8 DF,  p-value: 0.6281
## 
## 
## [[2]]
## 
## Call:
## lm(formula = u ~ b)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.26193 -0.61483  0.06982  0.57162  1.42412 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)  
## (Intercept)  -0.7039     0.3266  -2.155   0.0633 .
## b            -0.8266     0.4405  -1.877   0.0974 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.8801 on 8 degrees of freedom
## Multiple R-squared:  0.3057,	Adjusted R-squared:  0.2189 
## F-statistic: 3.522 on 1 and 8 DF,  p-value: 0.0974
```

###   <font color=#FFAA33 face = "Palatino Linotype">By</font>

> The by( ) function applys a function to each level of a factor or factors. It is similar to BY processing in SAS.

這也是Quick-R裡面所提到的,將資料透過factor的因子來運行所指定的函數,很像apply系列的函數.

####  **<font color=#77DDFF >參數</font>** 
`by(data,factorlist,function)`

####  **<font color=#77DDFF >例子:</font>**
這邊一樣用iris的資料集來作範例


```r
by(iris[, 1:2], iris["Species"], sum)
```

```
## Species: setosa
## [1] 421.7
## -------------------------------------------------------- 
## Species: versicolor
## [1] 435.3
## -------------------------------------------------------- 
## Species: virginica
## [1] 478.1
```
####  **<font color=#77DDFF >例子2:</font>**


```r
by(iris, iris["Species"],
   function(x) lm(Sepal.Length ~ Sepal.Width, data = x))
```

```
## Species: setosa
## 
## Call:
## lm(formula = Sepal.Length ~ Sepal.Width, data = x)
## 
## Coefficients:
## (Intercept)  Sepal.Width  
##      2.6390       0.6905  
## 
## -------------------------------------------------------- 
## Species: versicolor
## 
## Call:
## lm(formula = Sepal.Length ~ Sepal.Width, data = x)
## 
## Coefficients:
## (Intercept)  Sepal.Width  
##      3.5397       0.8651  
## 
## -------------------------------------------------------- 
## Species: virginica
## 
## Call:
## lm(formula = Sepal.Length ~ Sepal.Width, data = x)
## 
## Coefficients:
## (Intercept)  Sepal.Width  
##      3.9068       0.9015
```
