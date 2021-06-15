USE Diego
GO

CREATE OR ALTER VIEW Client AS
    SELECT S.*, 1 AS Agency FROM SpaCentro_m20191007 S
    UNION
    SELECT S.*, 2 FROM SpaEscalon_i20191007 S
    UNION
    SELECT S.*, 3 FROM SpaSantaTecla_m20191007 S

-- ================== Segregate by agency ======================
-- Quantity
SELECT
    CASE
        WHEN Agency = 1 THEN 'Centro'
        WHEN Agency = 2 THEN 'Escalon'
        WHEN Agency = 3 THEN 'Santa Tecla'
        ELSE ''
    END AS 'Agencia',
    COUNT(id) AS 'Cantidad'
FROM Client
GROUP BY Agency

-- Average visit
SELECT
    CASE
        WHEN Agency = 1 THEN 'Centro'
        WHEN Agency = 2 THEN 'Escalon'
        WHEN Agency = 3 THEN 'Santa Tecla'
        ELSE ''
    END AS 'Agencia',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Agency

-- Sauna service
SELECT
    IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
    COUNT(id) AS 'Cantidad'
FROM Client
GROUP BY Sauna

SELECT
    IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Sauna

-- Massage service
SELECT
    IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
    COUNT(id) AS 'Cantidad'
FROM Client
GROUP BY Masaje

SELECT
    IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Masaje

-- Hydromassage service
SELECT
    IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
    COUNT(id) AS 'Cantidad'
FROM Client
GROUP BY Hidro

SELECT
    IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Hidro

-- Yoga service
SELECT
    IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
    COUNT(id) AS 'Cantidad'
FROM Client
GROUP BY Yoga

SELECT
    IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Yoga

-- Service merge
SELECT
    IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
    IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
    IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
    IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
    COUNT(id) AS 'Cantidad'
FROM Client
GROUP BY Sauna, Masaje, Hidro, Yoga

SELECT
    IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
    IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
    IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
    IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Sauna, Masaje, Hidro, Yoga


-- ================== Segregate by sex =========================
-- Total
SELECT
    CASE WHEN Sexo = 0 THEN 'Masculino' ELSE 'Femenino' END AS Sexo,
    COUNT(id) AS 'Cantidad',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Sexo

-- Service by sex
SELECT
    CASE WHEN Sexo = 0 THEN 'Masculino' ELSE 'Femenino' END AS Sexo,
    IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
    IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
    IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
    IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
    COUNT(id) AS 'Cantidad',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Sexo, Sauna, Masaje, Hidro, Yoga

-- By the agency
SELECT
    CASE
        WHEN Agency = 1 THEN 'Centro'
        WHEN Agency = 2 THEN 'Escalon'
        WHEN Agency = 3 THEN 'Santa Tecla'
        ELSE ''
    END AS 'Agencia',
    CASE WHEN Sexo = 0 THEN 'Masculino' ELSE 'Femenino' END AS Sexo,
    COUNT(id) AS 'Cantidad',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Agency, Sexo
ORDER BY Agency

-- Service by sex
SELECT
    CASE
        WHEN Agency = 1 THEN 'Centro'
        WHEN Agency = 2 THEN 'Escalon'
        WHEN Agency = 3 THEN 'Santa Tecla'
        ELSE ''
    END AS 'Agencia',
    CASE WHEN Sexo = 0 THEN 'Masculino' ELSE 'Femenino' END AS Sexo,
    IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
    IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
    IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
    IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
    COUNT(id) AS 'Cantidad',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Agency, Sexo, Sauna, Masaje, Hidro, Yoga
ORDER BY Agency

-- ================= Segregate by age ============================
-- Total
SELECT
    CASE
        WHEN Edad < 18 THEN '0 - 18'
        WHEN Edad BETWEEN 18 AND 30 THEN '18 - 30'
        WHEN Edad BETWEEN 31 AND 50 THEN '31 - 50'
        ELSE '51+'
    END AS 'Edad',
    COUNT(*) AS 'Cantidad',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY
    CASE
        WHEN Edad < 18 THEN '0 - 18'
        WHEN Edad BETWEEN 18 AND 30 THEN '18 - 30'
        WHEN Edad BETWEEN 31 AND 50 THEN '31 - 50'
        ELSE '51+'
    END

-- Service by age
SELECT
    CASE
        WHEN Edad < 18 THEN '0 - 18'
        WHEN Edad BETWEEN 18 AND 30 THEN '18 - 30'
        WHEN Edad BETWEEN 31 AND 50 THEN '31 - 50'
        ELSE '51+'
    END AS 'Edad',
    IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
    IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
    IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
    IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
    COUNT(*) AS 'Cantidad',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Sauna, Masaje, Hidro, Yoga,
    CASE
        WHEN Edad < 18 THEN '0 - 18'
        WHEN Edad BETWEEN 18 AND 30 THEN '18 - 30'
        WHEN Edad BETWEEN 31 AND 50 THEN '31 - 50'
        ELSE '51+'
    END
ORDER BY Edad

-- By the agency
SELECT
    CASE
        WHEN Agency = 1 THEN 'Centro'
        WHEN Agency = 2 THEN 'Escalon'
        WHEN Agency = 3 THEN 'Santa Tecla'
        ELSE ''
    END AS 'Agencia',
    CASE
        WHEN Edad < 18 THEN '0 - 18'
        WHEN Edad BETWEEN 18 AND 30 THEN '18 - 30'
        WHEN Edad BETWEEN 31 AND 50 THEN '31 - 50'
        ELSE '51+'
    END AS 'Edad',
    COUNT(*) AS 'Cantidad',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Agency,
    CASE
        WHEN Edad < 18 THEN '0 - 18'
        WHEN Edad BETWEEN 18 AND 30 THEN '18 - 30'
        WHEN Edad BETWEEN 31 AND 50 THEN '31 - 50'
        ELSE '51+'
    END
ORDER BY Agency

-- Service by age
SELECT
    CASE
        WHEN Agency = 1 THEN 'Centro'
        WHEN Agency = 2 THEN 'Escalon'
        WHEN Agency = 3 THEN 'Santa Tecla'
        ELSE ''
    END AS 'Agencia',
    CASE
        WHEN Edad < 18 THEN '0 - 18'
        WHEN Edad BETWEEN 18 AND 30 THEN '18 - 30'
        WHEN Edad BETWEEN 31 AND 50 THEN '31 - 50'
        ELSE '51+'
    END AS 'Edad',
    IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
    IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
    IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
    IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
    COUNT(*) AS 'Cantidad',
    AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
FROM Client
GROUP BY Agency, Sauna, Masaje, Hidro, Yoga,
    CASE
        WHEN Edad < 18 THEN '0 - 18'
        WHEN Edad BETWEEN 18 AND 30 THEN '18 - 30'
        WHEN Edad BETWEEN 31 AND 50 THEN '31 - 50'
        ELSE '51+'
    END
ORDER BY Agency, Edad

-- =================== Segregate by income =======================
-- Total
SELECT * FROM (
    SELECT
        CASE
            WHEN CAST(ingresos AS DECIMAL(10, 2)) < 350.0 THEN '$0 - $350'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 350.0 AND 600.0 THEN '$350 - $600'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 600.0 AND 1000.0 THEN '$600 - $1000'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 1000.0 AND 2000.0 THEN '$1000 - $2000'
            ELSE '$2000+'
        END AS 'Ingresos',
        COUNT(id) AS 'Cantidad',
        AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
    FROM Client
    GROUP BY
        CASE
            WHEN CAST(ingresos AS DECIMAL(10, 2)) < 350.0 THEN '$0 - $350'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 350.0 AND 600.0 THEN '$350 - $600'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 600.0 AND 1000.0 THEN '$600 - $1000'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 1000.0 AND 2000.0 THEN '$1000 - $2000'
            ELSE '$2000+'
        END
) AS t
ORDER BY CAST(
    SUBSTRING(
        REPLACE(t.Ingresos, '+', ''),
        2,
        IIF(CHARINDEX(' ', t.Ingresos) > 0, CHARINDEX(' ', t.Ingresos) - 1, len(Ingresos) - 1)
    ) AS INT
)

-- Service by income
SELECT * FROM (
    SELECT
        CASE
            WHEN CAST(ingresos AS DECIMAL(10, 2)) < 350.0 THEN '$0 - $350'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 350.0 AND 600.0 THEN '$350 - $600'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 600.0 AND 1000.0 THEN '$600 - $1000'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 1000.0 AND 2000.0 THEN '$1000 - $2000'
            ELSE '$2000+'
        END AS 'Ingresos',
        IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
        IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
        IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
        IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
        COUNT(id) AS 'Cantidad',
        AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
    FROM Client
    GROUP BY Sauna, Masaje, Hidro, Yoga,
        CASE
            WHEN CAST(ingresos AS DECIMAL(10, 2)) < 350.0 THEN '$0 - $350'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 350.0 AND 600.0 THEN '$350 - $600'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 600.0 AND 1000.0 THEN '$600 - $1000'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 1000.0 AND 2000.0 THEN '$1000 - $2000'
            ELSE '$2000+'
        END
) AS t
ORDER BY CAST(
    SUBSTRING(
        REPLACE(t.Ingresos, '+', ''),
        2,
        IIF(CHARINDEX(' ', t.Ingresos) > 0, CHARINDEX(' ', t.Ingresos) - 1, len(Ingresos) - 1)
    ) AS INT
)

-- By the agency
SELECT * FROM (
    SELECT
        CASE
            WHEN Agency = 1 THEN 'Centro'
            WHEN Agency = 2 THEN 'Escalon'
            WHEN Agency = 3 THEN 'Santa Tecla'
            ELSE ''
        END AS 'Agencia',
        CASE
            WHEN CAST(ingresos AS DECIMAL(10, 2)) < 350.0 THEN '$0 - $350'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 350.0 AND 600.0 THEN '$350 - $600'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 600.0 AND 1000.0 THEN '$600 - $1000'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 1000.0 AND 2000.0 THEN '$1000 - $2000'
            ELSE '$2000+'
        END AS 'Ingresos',
        COUNT(id) AS 'Cantidad',
        AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
    FROM Client
    GROUP BY Agency,
        CASE
            WHEN CAST(ingresos AS DECIMAL(10, 2)) < 350.0 THEN '$0 - $350'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 350.0 AND 600.0 THEN '$350 - $600'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 600.0 AND 1000.0 THEN '$600 - $1000'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 1000.0 AND 2000.0 THEN '$1000 - $2000'
            ELSE '$2000+'
        END
) AS t
ORDER BY t.Agencia, CAST(
    SUBSTRING(
        REPLACE(t.Ingresos, '+', ''),
        2,
        IIF(CHARINDEX(' ', t.Ingresos) > 0, CHARINDEX(' ', t.Ingresos) - 1, len(Ingresos) - 1)
    ) AS INT
)

-- Service by income
SELECT *
FROM (
    SELECT
        CASE
            WHEN Agency = 1 THEN 'Centro'
            WHEN Agency = 2 THEN 'Escalon'
            WHEN Agency = 3 THEN 'Santa Tecla'
            ELSE ''
        END AS 'Agencia',
        CASE
            WHEN CAST(ingresos AS DECIMAL(10, 2)) < 350.0 THEN '$0 - $350'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 350.0 AND 600.0 THEN '$350 - $600'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 600.0 AND 1000.0 THEN '$600 - $1000'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 1000.0 AND 2000.0 THEN '$1000 - $2000'
            ELSE '$2000+'
        END AS 'Ingresos',
        IIF(Sauna = 0, 'No solicitado', 'Solicitado') AS 'Servicio de sauna',
        IIF(Masaje = 0, 'No solicitado', 'Solicitado') AS 'Servicio de masaje',
        IIF(Hidro = 0, 'No solicitado', 'Solicitado') AS 'Servicio de hidromasaje',
        IIF(Yoga = 0, 'No solicitado', 'Solicitado') AS 'Servicio de yoga',
        COUNT(id) AS 'Cantidad',
        AVG(CAST(PromVisit AS DECIMAL(10, 2))) AS 'Promedio de visitas'
    FROM Client
    GROUP BY Agency, Sauna, Masaje, Hidro, Yoga,
        CASE
            WHEN CAST(ingresos AS DECIMAL(10, 2)) < 350.0 THEN '$0 - $350'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 350.0 AND 600.0 THEN '$350 - $600'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 600.0 AND 1000.0 THEN '$600 - $1000'
            WHEN CAST(ingresos AS DECIMAL(10, 2)) BETWEEN 1000.0 AND 2000.0 THEN '$1000 - $2000'
            ELSE '$2000+'
        END
) AS t
ORDER BY t.Agencia, CAST(
    SUBSTRING(
        REPLACE(t.Ingresos, '+', ''),
        2,
        IIF(CHARINDEX(' ', t.Ingresos) > 0, CHARINDEX(' ', t.Ingresos) - 1, len(Ingresos) - 1)
    ) AS INT
)
