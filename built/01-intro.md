---
sandpaper-digest: ea75c0cac7891885543286ab5fc1f869
title: Python Fundamentals
teaching: 20
exercises: 10
---



<div class='objectives' markdown='1'>

- Assign values to variables.

</div>

<div class='questions' markdown='1'>

- What basic data types can I work with in Python?
- How can I create a new variable in Python?
- Can I change the value associated with a variable after I create it?

</div>

## Variables

Any Python interpreter can be used as a calculator:

```python
3 + 5 * 4
```

```output
23
```

This is great but not very interesting.
To do anything useful with data, we need to assign its value to a *variable*.
In Python, we can [assign](reference/#assign) a value to a
[variable](reference/#variable), using the equals sign `=`.
For example, to assign value `60` to a variable `weight_kg`, we would execute:

```python
weight_kg = 60
```

From now on, whenever we use `weight_kg`, Python will substitute the value we assigned to
it. In layman's terms, **a variable is a name for a value**.

In Python, variable names:

- can include letters, digits, and underscores
- cannot start with a digit
- are [case sensitive](reference/#case-sensitive).

This means that, for example:

- `weight0` is a valid variable name, whereas `0weight` is not
- `weight` and `Weight` are different variables

## Types of data

Python knows various types of data. Three common ones are:

- integer numbers
- floating point numbers, and
- strings.

In the example above, variable `weight_kg` has an integer value of `60`.
To create a variable with a floating point value, we can execute:

```python
weight_kg = 60.0
```

And to create a string, we add single or double quotes around some text, for example:

```python
weight_kg_text = 'weight in kilograms:'
```

## Using Variables in Python

To display the value of a variable to the screen in Python, we can use the `print` function:

```python
print(weight_kg)
```

```output
60.0
```

We can display multiple things at once using only one `print` command:

```python
print(weight_kg_text, weight_kg)
```

```output
weight in kilograms: 60.0
```

Moreover, we can do arithmetic with variables right inside the `print` function:

```python
print('weight in pounds:', 2.2 * weight_kg)
```

```output
weight in pounds: 132.0
```

The above command, however, did not change the value of `weight_kg`:

```python
print(weight_kg)
```

```output
60.0
```

To change the value of the `weight_kg` variable, we have to
**assign** `weight_kg` a new value using the equals `=` sign:

```python
weight_kg = 65.0
print('weight in kilograms is now:', weight_kg)
```

```output
weight in kilograms is now: 65.0
```

<div class='callout' markdown='1'>

## Variables as Sticky Notes
A variable is analogous to a sticky note with a name written on it:
assigning a value to a variable is like putting that sticky note on a particular value.
![Value of 65.0 with weight\_kg label stuck on it](fig/python-sticky-note-variables-01.svg)

This means that assigning a value to one variable does **not** change
values of other variables.
For example, let's store the subject's weight in pounds in its own variable:

```python
# There are 2.2 pounds per kilogram
weight_lb = 2.2 * weight_kg
print(weight_kg_text, weight_kg, 'and in pounds:', weight_lb)
```

```output
weight in kilograms: 65.0 and in pounds: 143.0
```

![Value of 65.0 with weight\_kg label stuck on it, and value of 143.0 with weight\_lb label stuck on it](fig/python-sticky-note-variables-02.svg)

Let's now change `weight_kg`:

```python
weight_kg = 100.0
print('weight in kilograms is now:', weight_kg, 'and weight in pounds is still:', weight_lb)
```

```output
weight in kilograms is now: 100.0 and weight in pounds is still: 143.0
```

![Value of 100.0 with label weight\_kg stuck on it, and value of 143.0 with label weight\_lb stuck on it](fig/python-sticky-note-variables-03.svg)

Since `weight_lb` doesn't "remember" where its value comes from,
it is not updated when we change `weight_kg`.

</div>

<div class='challenge' markdown='1'>

## Check Your Understanding
What values do the variables `mass` and `age` have after each of the following statements?
Test your answer by executing the lines.
```python
mass = 47.5
age = 122
mass = mass * 2.0
age = age - 20
```

<div class='solution' markdown='1'>

## Solution
 
```output
`mass` holds a value of 47.5, `age` does not exist
`mass` still holds a value of 47.5, `age` holds a value of 122
`mass` now has a value of 95.0, `age`'s value is still 122
`mass` still has a value of 95.0, `age` now holds 102
```

</div>

</div>

<div class='challenge' markdown='1'>

## Sorting Out References
What does the following program print out?
```python
first, second = 'Grace', 'Hopper'
third, fourth = second, first
print(third, fourth)
```

<div class='solution' markdown='1'>

## Solution
 
```output
Hopper Grace
```

</div>

</div>

{% include links.md %}

<div class='keypoints' markdown='1'>

- Basic data types in Python include integers, strings, and floating-point numbers.
- Use `variable = value` to assign a value to a variable in order to record it in memory.
- Variables are created on demand whenever a value is assigned to them.
- Use `print(something)` to display the value of `something`.

</div>


