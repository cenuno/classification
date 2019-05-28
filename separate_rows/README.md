
# Separate a collapsed column into multiple rows

Sometimes a variable has multiple elements stored in one row, where they are each separated by a delimeter (i.e. `,`, `\t`, `\`, etc.). Often it more useful to separate those elements into their own records so our [data becomes tidy](http://vita.had.co.nz/papers/tidy-data.pdf).

## Goal

If a variable contains observations with multiple delimited values, this notebook will show you how to separate the values and place each one in its own row as a pandas DataFrame.

### Stack Overflow

This would not be possible without [this answer from Stack Overflow](https://stackoverflow.com/a/28182629/7954106) regarding the separation of elements in a column into multiple rows.

### Load necessary modules


```python
import pandas as pd
```

### Load necessary data

Today we'll be using [Chicago Public Schools (CPS) School Year 2018-2019 school profile data](https://cenuno.github.io/pointdexter/reference/cps_sy1819.html).


```python
relevant_columns = ["school_id", "short_name", 
                    "primary_category", "grades_offered_all"]

cps_sy1819 = pd.read_csv("../raw_data/cps_sy1819_profiles.csv")[relevant_columns]
cps_sy1819.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>school_id</th>
      <th>short_name</th>
      <th>primary_category</th>
      <th>grades_offered_all</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>609760</td>
      <td>CARVER MILITARY HS</td>
      <td>HS</td>
      <td>9,10,11,12</td>
    </tr>
    <tr>
      <th>1</th>
      <td>609780</td>
      <td>MARINE LEADERSHIP AT AMES HS</td>
      <td>HS</td>
      <td>7,8,9,10,11,12</td>
    </tr>
    <tr>
      <th>2</th>
      <td>610304</td>
      <td>PHOENIX MILITARY HS</td>
      <td>HS</td>
      <td>9,10,11,12</td>
    </tr>
    <tr>
      <th>3</th>
      <td>610513</td>
      <td>AIR FORCE HS</td>
      <td>HS</td>
      <td>9,10,11,12</td>
    </tr>
    <tr>
      <th>4</th>
      <td>610390</td>
      <td>RICKOVER MILITARY HS</td>
      <td>HS</td>
      <td>9,10,11,12</td>
    </tr>
  </tbody>
</table>
</div>



### [Cast each element in the `Series` as a string](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.str.html) and [split each string by the delimiter](https://docs.python.org/3.7/library/stdtypes.html#str.split). 

Afterwards, store the `Series` object as a `list` of lists.


```python
cps_sy1819["grades_offered_all"].str.split(",")[0:5]
```




    0          [9, 10, 11, 12]
    1    [7, 8, 9, 10, 11, 12]
    2          [9, 10, 11, 12]
    3          [9, 10, 11, 12]
    4          [9, 10, 11, 12]
    Name: grades_offered_all, dtype: object



### Store results in a [`DataFrame`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.html#pandas.DataFrame)

After coverting the `list` to a `DataFrame`, you'll notice a lot of `None` values. Behind the hood, `pandas` is ensuring each record has 13 columns. Since not all schools serve 13 grades, they'll get `None` values.



```python
pd.DataFrame(cps_sy1819["grades_offered_all"].str.split(",").tolist(),
             index=cps_sy1819.index).head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th>10</th>
      <th>11</th>
      <th>12</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>9</td>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
    </tr>
    <tr>
      <th>1</th>
      <td>7</td>
      <td>8</td>
      <td>9</td>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
    </tr>
    <tr>
      <th>2</th>
      <td>9</td>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
    </tr>
    <tr>
      <th>3</th>
      <td>9</td>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
    </tr>
    <tr>
      <th>4</th>
      <td>9</td>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
    </tr>
  </tbody>
</table>
</div>



### Covert the `DataFrame` to a `Series` with a multi-level index via [`stack()`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.stack.html)

> The function is named by analogy with a collection of books being re-organised from being side by side on a horizontal position (the columns of the dataframe) to being stacked vertically on top of of each other (in the index of the dataframe).

![Stripes book](../visuals/stripes_book.gif)


```python
pd.DataFrame(cps_sy1819["grades_offered_all"].str.split(",").tolist(),
             index=cps_sy1819.index).head().stack()[0:10]
```




    0  0     9
       1    10
       2    11
       3    12
    1  0     7
       1     8
       2     9
       3    10
       4    11
       5    12
    dtype: object



### Putting it all together

[Reset the index](http://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.reset_index.html) to add the old index is added as a column

We will no longer need the lower level index for each grade in each school so it can be dropped. Instead, the higher level index for each school is what we will use moving forward.

*Note: I renamed the columns to make them easier to understand.*


```python
grades_df = pd.DataFrame(cps_sy1819["grades_offered_all"].str.split(",").tolist(),
             index=cps_sy1819.index).stack()

grades_df = grades_df.reset_index()

grades_df = grades_df.drop("level_1", axis=1)

grades_df.columns = ["school_index", "grade_offered"]

grades_df.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>school_index</th>
      <th>grade_offered</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>9</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0</td>
      <td>10</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0</td>
      <td>11</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0</td>
      <td>12</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1</td>
      <td>7</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1</td>
      <td>8</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1</td>
      <td>9</td>
    </tr>
    <tr>
      <th>7</th>
      <td>1</td>
      <td>10</td>
    </tr>
    <tr>
      <th>8</th>
      <td>1</td>
      <td>11</td>
    </tr>
    <tr>
      <th>9</th>
      <td>1</td>
      <td>12</td>
    </tr>
  </tbody>
</table>
</div>



### Merge `grades_df` onto `cps_sy1819` via a left join

We'll use the indices from `cps_sy1819` on the left-hand side, along with the `school_index` values from `grades_df`, to perfom the join.

After the join, we'll drop the `school_index` feature since it's redundant information in that `school_id` already indicates that each record is related to one particular CPS school.


```python
cps_sy1819 = pd.merge(cps_sy1819,
                      grades_df,
                      left_index=True,
                      right_on="school_index",
                      how="left").drop("school_index", axis=1)

cps_sy1819.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>school_id</th>
      <th>short_name</th>
      <th>primary_category</th>
      <th>grades_offered_all</th>
      <th>grade_offered</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>609760</td>
      <td>CARVER MILITARY HS</td>
      <td>HS</td>
      <td>9,10,11,12</td>
      <td>9</td>
    </tr>
    <tr>
      <th>1</th>
      <td>609760</td>
      <td>CARVER MILITARY HS</td>
      <td>HS</td>
      <td>9,10,11,12</td>
      <td>10</td>
    </tr>
    <tr>
      <th>2</th>
      <td>609760</td>
      <td>CARVER MILITARY HS</td>
      <td>HS</td>
      <td>9,10,11,12</td>
      <td>11</td>
    </tr>
    <tr>
      <th>3</th>
      <td>609760</td>
      <td>CARVER MILITARY HS</td>
      <td>HS</td>
      <td>9,10,11,12</td>
      <td>12</td>
    </tr>
    <tr>
      <th>4</th>
      <td>609780</td>
      <td>MARINE LEADERSHIP AT AMES HS</td>
      <td>HS</td>
      <td>7,8,9,10,11,12</td>
      <td>7</td>
    </tr>
    <tr>
      <th>5</th>
      <td>609780</td>
      <td>MARINE LEADERSHIP AT AMES HS</td>
      <td>HS</td>
      <td>7,8,9,10,11,12</td>
      <td>8</td>
    </tr>
    <tr>
      <th>6</th>
      <td>609780</td>
      <td>MARINE LEADERSHIP AT AMES HS</td>
      <td>HS</td>
      <td>7,8,9,10,11,12</td>
      <td>9</td>
    </tr>
    <tr>
      <th>7</th>
      <td>609780</td>
      <td>MARINE LEADERSHIP AT AMES HS</td>
      <td>HS</td>
      <td>7,8,9,10,11,12</td>
      <td>10</td>
    </tr>
    <tr>
      <th>8</th>
      <td>609780</td>
      <td>MARINE LEADERSHIP AT AMES HS</td>
      <td>HS</td>
      <td>7,8,9,10,11,12</td>
      <td>11</td>
    </tr>
    <tr>
      <th>9</th>
      <td>609780</td>
      <td>MARINE LEADERSHIP AT AMES HS</td>
      <td>HS</td>
      <td>7,8,9,10,11,12</td>
      <td>12</td>
    </tr>
  </tbody>
</table>
</div>


