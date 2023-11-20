USE heros_mysql;

-- Query 1: Number of heros and villains by creators
SELECT
    COUNT(CASE WHEN alignment = "Good" THEN 1 END) AS number_heros,
    COUNT(CASE WHEN alignment = "Bad" THEN 1 END) AS number_villains,
    creator
FROM heros
GROUP BY creator
ORDER BY number_heros DESC, number_villains DESC;

-- Query 2: Show only if there are more villains than heros
SELECT
    COUNT(CASE WHEN alignment = "Good" THEN 1 END) AS number_heros,
    COUNT(CASE WHEN alignment = "Bad" THEN 1 END) AS number_villains,
    creator
FROM heros
GROUP BY creator
HAVING number_villains > number_heros
ORDER BY number_heros DESC, number_villains DESC;

-- Query 3: Show information about these villains
WITH race_table AS
    (SELECT name, real_name, creator, gender, alignment,
        CASE WHEN type_race LIKE 'Human%' THEN 'human' ELSE 'not-human' END AS race
    FROM heros)
SELECT
    name, real_name, race_table.creator, gender, race
FROM race_table
    JOIN
        (SELECT creator,
            COUNT(CASE WHEN alignment = 'Good' THEN 1 END) AS number_heros,
            COUNT(CASE WHEN alignment = 'Bad' THEN 1 END) AS number_villains
        FROM heros
        GROUP BY creator
        HAVING number_villains > number_heros
        ) AS subquery
        ON race_table.creator = subquery.creator
WHERE race_table.alignment = 'Bad';

-- Query 4: Average power_score per alignment
SELECT AVG(overall_score) AS mean_power, alignment
FROM heros
GROUP BY alignment
ORDER BY mean_power DESC;

-- Query 5: Maximum power_score per alignment:
SELECT MAX(overall_score) AS max_power, alignment
FROM heros
GROUP BY alignment;

-- Query 6: Who has this maximum score
WITH cte AS
    (SELECT MAX(overall_score) AS max_power, alignment,
        CASE WHEN type_race LIKE 'Human%' THEN 'human' ELSE 'not-human' END AS race
    FROM heros
    GROUP BY alignment, race)
SELECT DISTINCT heros.alignment, name, real_name, gender, race, overall_score AS power
FROM heros
    JOIN cte
        ON heros.overall_score = cte.max_power AND heros.alignment = cte.alignment
ORDER BY race,alignment;

-- Query 7: Avergae number of superpowers per alignment
SELECT alignment, AVG(n_superpowers) AS superpowers
FROM heros
GROUP BY alignment;

-- Query 8: Prefered powers in Good
WITH max AS
    (SELECT MAX(Good) AS max_good FROM superpowers)
SELECT superpowers.index, superpowers.Good
FROM superpowers
    JOIN max
        ON superpowers.Good = max.max_good;

-- Query 9: prefered powers in Bad
WITH max AS
    (SELECT MAX(Bad) AS max_bad FROM superpowers)
SELECT superpowers.index, superpowers.Bad
FROM superpowers
    JOIN max
        ON superpowers.Bad = max.max_bad;

-- Query 10: prefered powers in Neutral
WITH max AS
    (SELECT MAX(Neutral) AS max_neutral FROM superpowers)
SELECT superpowers.index, superpowers.Neutral
FROM superpowers
    JOIN max
        ON superpowers.Neutral = max.max_neutral;

-- Query 11: Groups of types of prefered powers by alignment
SELECT alignment,
    AVG(energy_powers), AVG(matter_powers), AVG(self_powers), AVG(reality_powers), AVG(mind_powers), AVG(resistance_powers),
    AVG(invulnerability), AVG(supersenses), AVG(stamina), AVG(capabilities), AVG(jump_flight), AVG(stealth), AVG(weapons), AVG(speed),
    AVG(strength)
FROM heros
GROUP BY alignment;


-- Query 12: Alignment by race
WITH race_table AS
    (SELECT alignment, creator,
        CASE WHEN type_race LIKE 'Human%' THEN 'human' ELSE 'not-human' END AS race
    FROM heros)
SELECT race,
    SUM(CASE WHEN alignment = 'Good' THEN 1 END)/COUNT(*) AS good_prop,
    SUM(CASE WHEN alignment = 'Neutral' THEN 1 END)/COUNT(*) AS neutral_prop,
    SUM(CASE WHEN alignment = 'Bad' THEN 1 END)/COUNT(*) AS bad_prop
FROM race_table
GROUP BY race;

-- Query 13: Alignment by sex and race
WITH race_table AS
    (SELECT alignment, creator, gender,
        CASE WHEN type_race LIKE 'Human%' THEN 'human' ELSE 'not-human' END AS race
    FROM heros)
SELECT race, gender,
    SUM(CASE WHEN alignment = 'Good' THEN 1 END)/COUNT(*) AS good_prop,
    SUM(CASE WHEN alignment = 'Neutral' THEN 1 END)/COUNT(*) AS neutral_prop,
    SUM(CASE WHEN alignment = 'Bad' THEN 1 END)/COUNT(*) AS bad_prop
FROM race_table
GROUP BY race, gender
ORDER BY gender;

-- Query 14: power per race and alignment
WITH race_table AS
    (SELECT overall_score, alignment,
        CASE WHEN type_race LIKE 'Human%' THEN 'human' ELSE 'not-human' END AS race
    FROM heros)
SELECT race, alignment, AVG(overall_score) AS mean_power
FROM race_table
GROUP BY alignment, race
ORDER BY mean_power DESC;

-- Query 15: Power per race, gender and alignment
WITH race_table AS
    (SELECT overall_score, alignment, gender,
        CASE WHEN type_race LIKE 'Human%' THEN 'human' ELSE 'not-human' END AS race
    FROM heros)
SELECT gender, race, alignment, AVG(overall_score) AS mean_power
FROM race_table
GROUP BY alignment, race, gender
ORDER BY mean_power DESC;

-- Query 16: Frequency of superpower groups per race and alignemnt
WITH race_table AS
    (SELECT *,
        CASE WHEN type_race LIKE 'Human%%' THEN 'human' ELSE 'not_human' END AS race
    FROM heros)
SELECT race, alignment,
    AVG(energy_powers), AVG(matter_powers), AVG(self_powers), AVG(reality_powers), AVG(mind_powers), AVG(resistance_powers),
    AVG(invulnerability), AVG(supersenses), AVG(stamina), AVG(capabilities), AVG(jump_flight), AVG(stealth), AVG(weapons), AVG(speed),
    AVG(strength)
FROM race_table
GROUP BY alignment, race;

-- Query 17: Frequency of superpower groups per race, gender and alignemnt
WITH race_table AS
    (SELECT *,
        CASE WHEN type_race LIKE 'Human%%' THEN 'human' ELSE 'not_human' END AS race
    FROM heros)
SELECT gender, race, alignment,
    AVG(energy_powers), AVG(matter_powers), AVG(self_powers), AVG(reality_powers), AVG(mind_powers), AVG(resistance_powers),
    AVG(invulnerability), AVG(supersenses), AVG(stamina), AVG(capabilities), AVG(jump_flight), AVG(stealth), AVG(weapons),
    AVG(speed), AVG(strength)
FROM race_table
GROUP BY alignment, race, gender;