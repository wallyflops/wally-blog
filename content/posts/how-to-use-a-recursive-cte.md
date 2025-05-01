+++ 
draft = false
date = 2021-10-24T10:46:48+01:00
title = "How to use a recursive CTE"
description = "A tutorial and explanation of how to effectively use CTE's (Common table expressions)"
slug = ""
authors = []
tags = []
categories = []
externalLink = ""
series = []
+++
We would write a normal CTE with the ‘with’ statement like so:

```sql
;with a_normal_cte_table as (
    select  *
    from    Customers
)
select  *
from    a_normal_cte_table;
```

This will enter the results of our simple select statement, into the temporary result set named ‘a_normal_cte_table’, then we can select from this after the closing bracket.
We should begin each CTE with statement with a “;” before it begins.
To make this a bit more complicated, we can also run over this recursively, which is helpful when exploring data with a hierarchy. Imagine if you were asked to list employees, and their managers, showing the company structure.

```sql
;with recursive a_recursive_cte as (
    -- Anchor of the CTE
    select  * from table where Key = 1
        union all
    -- The query to execute recursively
    select  * from table1 t1 inner join a_recursive_cte t2 on t1.id = t2.id
)
select  *
from    a_recursive_cte ;
```


We start the query with the “Anchor” of the CTE. This is what the code will run on it’s first pass through, commonly this may be one single record.
Let’s use our employee example and change this to select our most junior employee, and expand upwards from there:

```sql
;with recursive a_recursive_cte as (
    -- Anchor of the CTE
    -- We only need our most junior employee, we do this with the where clause.
    select managed_by 
    from Employees where Emp_ID = 1
        union all
    -- The query to execute recursively
    -- This statement will run, with the results of the previous interation. Until it returns null.
    select  rec.managed_by
    from Employees emp 
    inner join a_recursive_cte rec on rec.Managed_By = emp.Emp_ID
)
select  e.Emp_ID, e.Name
from    a_recursive_cte cte
inner join Employees e on cte.managed_by = e.emp_id ;
```

If we imagine a fake dataset which looks like this:

![table with names](/images/table_with_names.png)

As the code executes, it will go through 3 iterations, I’ve tried to draw these in Excel:

![query_results](/images/query_results.png)

On the first iteration, we simply run the code above the ‘union all’
on the second iteration, we use the results we had previously ‘2’ and link it back into Emp_ID.
On the third iteration, we base results from the previous iteration, so ‘3’, and keep going through in this fashion until we hit the database limit for maximum amount of loops, or the second query returns null.
Finall we have the ouput of our CTE, this comes after the brackets.
In this we take our completed list (Of Emp_IDs) and return a more traditional query with them, for simplicity I will simply return the employees name.