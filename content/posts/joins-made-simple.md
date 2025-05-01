+++ 
draft = false
date = 2021-10-24T10:46:48+01:00
title = "SQL Joins made simple"
description = "Tutorial and explainer on how SQL joins work"
slug = ""
authors = []
tags = []
categories = []
externalLink = ""
series = []
+++
Let’s start with some example data

![example_data](/images/joins_1.png)

Example data text
## Inner join
Probably the most common example is the ‘inner join’, which can just be written as ‘join’.

```sql
select  *
from    People p
inner join City c on p.id = c.id
```

The inner join will return all matching rows, in this case we are joining on “id” column.

The results from this query will look like this

![inner join query](/images/joins_2.png)

The results of the earlier query
Notably, this is not returning rows which have no match, id 5 & 6 Sophie and Patrick have no relevant matches in the City table.

## Left join
Left join is probably the second-most common join type, it can also be called by it’s full name a Left Outer Join.

the left join will return ALL rows from our original table, and then only bring back results from our joined table where they match.


![left join query](/images/joins_3.png)

The results of a left join query
So this example brings back our full list of the People table, but then just leaves NULLS where id 5 & 6 have no matching data in the City table.

## Right join
This is pretty much the same as the left join as the name implies, but the results are kept in your joining table. Often this wouldn’t be used in practice as you could just write your query the other way around (Swapping the position of the tables).

Here’s the same query as before, but we replace Left with Right.

```sql
select  *
from    People p
right join City c on p.id = c.id
```

So we will notice now a reverse of the left join, with the query returning ALL the Cities, but only the matching results from the Person table

Query results from a right join

![right join query](/images/joins_4.png)

## Cross Join
This is a weird one and is used less so than the ones above, but does have some niche uses. This is a cartesian product or more simply put “everything by everything.” This can produce a scary amount of records and you should be very careful running this.

I also see this written in two different ways, but I always prefer the most explicit version.

### Explicit

```sql
select  *
from    People 
cross join City
```

I prefer this method, as it’s clearer
### Implicit

```sql
select  *
from    People, City
```

I see this method a lot, but I find it much less clear to read at a glance
I’ve had to cut this one off in the image, but it will carry on for every single record in the People table, and place every single record in the City table beside it


![implicit join query](/images/joins_5.png)

The results of a cross join query
## Full Outer Join
This is a mix of left and right joins. It will return all records in the People and City tables, and if there is no match it will show a NULL

```sql
select  *
from    People p 
full outer join City c on p.id = c.id
```

The results of this one are pretty self explanatory if you’ve been following

The results of a full outer join
This again has some more niche uses, I see it a lot in BI tools like Qlik Sense