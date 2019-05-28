
# One Hot Encoding

May 27, 2019

Made by: Cristian E. Nuno

> `OneHotEncoder` transforms each categorical feature with `n_categories` possible values into `n_categories` binary features, with one of them 1, and all others 0. - [`sklearn.preprocessing` user guide](https://scikit-learn.org/stable/modules/preprocessing.html#preprocessing-categorical-features)


> The input to this transformer should be an array-like of integers or strings, denoting the values taken on by categorical (discrete) features. The features are encoded using a one-hot (aka ‘one-of-K’ or ‘dummy’) encoding scheme. This creates a binary column for each category and returns a sparse m. - [`sklearn.preprocessing` documentation](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.OneHotEncoder.html)

![transformer](../visuals/transformer.gif)

![chris albon notecard](../visuals/ohe_chris_albon.png)

## Data

Today we'll be using [Chicago Public Schools School Year 2018-2019 school profile data](https://cenuno.github.io/pointdexter/reference/cps_sy1819.html).


```python
from sklearn.preprocessing import OneHotEncoder
import pandas as pd
import numpy as np
```


```python
relevant_columns = ["school_id", "short_name", "primary_category", "classification_type"]

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
      <th>classification_type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>609760</td>
      <td>CARVER MILITARY HS</td>
      <td>HS</td>
      <td>Military academy</td>
    </tr>
    <tr>
      <th>1</th>
      <td>609780</td>
      <td>MARINE LEADERSHIP AT AMES HS</td>
      <td>HS</td>
      <td>Military academy</td>
    </tr>
    <tr>
      <th>2</th>
      <td>610304</td>
      <td>PHOENIX MILITARY HS</td>
      <td>HS</td>
      <td>Military academy</td>
    </tr>
    <tr>
      <th>3</th>
      <td>610513</td>
      <td>AIR FORCE HS</td>
      <td>HS</td>
      <td>Military academy</td>
    </tr>
    <tr>
      <th>4</th>
      <td>610390</td>
      <td>RICKOVER MILITARY HS</td>
      <td>HS</td>
      <td>Military academy</td>
    </tr>
  </tbody>
</table>
</div>




```python
cps_sy1819["primary_category"].value_counts()
```




    ES    471
    HS    180
    MS      9
    Name: primary_category, dtype: int64



Store the `primary_category` feature as either a 2-dimensional array or a pandas DataFrame.


```python
primary_category = cps_sy1819["primary_category"].values.reshape(-1, 1)
primary_category[:5]
```




    array([['HS'],
           ['HS'],
           ['HS'],
           ['HS'],
           ['HS']], dtype=object)



Create our `OneHotEncoder()` object and specify `drop="first"` to specify the methodology to use to drop one of the categories per feature. This is useful in situations where perfectly collinear features cause problems, such as when feeding the resulting data into a neural network or an unregularized regression [(source)](https://github.com/scikit-learn/scikit-learn/blob/7813f7efb/sklearn/preprocessing/_encoders.py#L179).


```python
encoder = OneHotEncoder(drop="first").fit(primary_category)
```

Just like in `value_counts()`, the categories in our `OneHotEncoder()` object are sorted in alphabetical order.


```python
encoder.categories_
```




    [array(['ES', 'HS', 'MS'], dtype=object)]



This is important to know seeing as we can expect our output to have two features: one for `HS` and one for `MS` since `ES` is the first category and we specified it to be dropped.


```python
encoder.get_feature_names(["primary_category"])
```




    array(['primary_category_HS', 'primary_category_MS'], dtype=object)



Now let's place our output in a Data Frame.


```python
ohe = pd.DataFrame(encoder.transform(primary_category).toarray(),
                   columns=encoder.get_feature_names(["primary_category"]))

ohe.head()
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
      <th>primary_category_HS</th>
      <th>primary_category_MS</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
</div>



Great! Now let's column column bind `ohe` onto `cps_sy1819` after we drop the `primary_category` column from `cps_sy1819`.


```python
pd.concat([cps_sy1819.drop("primary_category", axis=1), ohe], axis=1).head()
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
      <th>classification_type</th>
      <th>primary_category_HS</th>
      <th>primary_category_MS</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>609760</td>
      <td>CARVER MILITARY HS</td>
      <td>Military academy</td>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>609780</td>
      <td>MARINE LEADERSHIP AT AMES HS</td>
      <td>Military academy</td>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>610304</td>
      <td>PHOENIX MILITARY HS</td>
      <td>Military academy</td>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>610513</td>
      <td>AIR FORCE HS</td>
      <td>Military academy</td>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>610390</td>
      <td>RICKOVER MILITARY HS</td>
      <td>Military academy</td>
      <td>1.0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
</div>


