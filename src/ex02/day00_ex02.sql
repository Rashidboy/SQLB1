-- 1st select statement (using comparison signs: <=, >=)
SELECT
    name,
    rating
FROM
    pizzeria
WHERE
    rating >= 3.5
    AND rating <= 5
ORDER BY
    rating;

-- 2nd select statement (using BETWEEN keyword)
SELECT
    name,
    rating
FROM
    pizzeria
WHERE
    rating BETWEEN 3.5 AND 5
ORDER BY
    rating;