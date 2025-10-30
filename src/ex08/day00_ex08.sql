SELECT
    *
FROM
    person_order
WHERE
    (id % 2) = 0 -- PostgreSQLda MOD o'rniga % ishlatish mumkin, yoki MOD() funksiyasini
ORDER BY
    id;