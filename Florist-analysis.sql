USE Fiorella
GO

EXEC sp_executesql 
    N'CREATE OR ALTER VIEW Product AS
        SELECT S.*, 1 AS "Agency" FROM SanSalvador_i20191007 S
        UNION
        SELECT S.*, 2 FROM SantaAna_c20191007 S
        UNION
        SELECT S.*, 3 FROM SanMiguel_j20191007 S'
GO

EXEC sp_executesql 
    N'CREATE OR ALTER VIEW TotalSale AS
    (
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END AS ''Agency'',
            ''Rosas'' AS ''Product'',
            COUNT(id) AS ''Cantidad''
        FROM Product
        WHERE Rosas = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Claveles'',
            COUNT(id)
        FROM Product
        WHERE Claveles = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Macetas'',
            COUNT(id)
        FROM Product
        WHERE Macetas = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Tierra'',
            COUNT(id)
        FROM Product
        WHERE Tierra = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Girasoles'',
            COUNT(id)
        FROM Product
        WHERE Girasoles = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Hortensia'',
            COUNT(id)
        FROM Product
        WHERE Hortensia = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Globos'',
            COUNT(id)
        FROM Product
        WHERE Globos = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Tarjetas'',
            COUNT(id)
        FROM Product
        WHERE Tarjetas = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Orquideas'',
            COUNT(id)
        FROM Product
        WHERE Orquideas = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Carmesi'',
            COUNT(id)
        FROM Product
        WHERE Carmesi = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Lirios'',
            COUNT(id)
        FROM Product
        WHERE Lirios = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Aurora'',
            COUNT(id)
        FROM Product
        WHERE Aurora = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Tulipanes'',
            COUNT(id)
        FROM Product
        WHERE Tulipanes = 1
        GROUP BY Agency
        UNION
        SELECT
            CASE
                WHEN Agency = 1 THEN ''San Salvador''
                WHEN Agency = 2 THEN ''Santa Ana''
                WHEN Agency = 3 THEN ''San Miguel''
                ELSE ''''
            END,
            ''Liston'',
            COUNT(id)
        FROM Product
        WHERE Liston = 1
        GROUP BY Agency
    )'
GO

-- ================= Show seller record ====================
SELECT Product, SUM(Cantidad) AS 'Cantidad' FROM TotalSale
GROUP BY Product
ORDER BY Cantidad DESC

-- By the agency
SELECT Agency, Product, SUM(Cantidad) AS 'Cantidad' FROM TotalSale
GROUP BY Agency, Product
ORDER BY Agency, Cantidad DESC

-- ================== Best sale ========================
SELECT TOP 1 Product, SUM(Cantidad) AS 'Cantidad' FROM TotalSale
GROUP BY Product
ORDER BY Cantidad DESC

-- By the agency
SELECT t.Agency, t.Product, t.Cantidad FROM (
    SELECT Agency, Product, SUM(Cantidad) AS 'Cantidad' FROM TotalSale
    GROUP BY Agency, Product
) AS t
INNER JOIN (
    SELECT Agency, Product, MAX(t.Cantidad) OVER (PARTITION BY Agency) AS 'Cantidad'
    FROM (
        SELECT Agency, Product, SUM(Cantidad) AS 'Cantidad' FROM TotalSale
        GROUP BY Agency, Product
    ) AS t
) AS max_value ON t.Agency = max_value.Agency AND t.Product = max_value.Product AND t.Cantidad = max_value.Cantidad

-- ================ Best combinations =======================
EXEC sp_executesql
    N'CREATE OR ALTER VIEW SellCodes AS (
        SELECT
            id,
            CONCAT(
                IIF(P.Rosas = 1, ''A'', ''''),
                IIF(P.Claveles = 1, ''B'', ''''),
                IIF(P.Macetas = 1, ''C'', ''''),
                IIF(P.Tierra = 1, ''D'', ''''),
                IIF(P.Girasoles = 1, ''E'', ''''),
                IIF(P.Hortensia = 1, ''F'', ''''),
                IIF(P.Globos = 1, ''G'', ''''),
                IIF(P.Tarjetas = 1, ''H'', ''''),
                IIF(P.Orquideas = 1, ''I'', ''''),
                IIF(P.Carmesi = 1, ''J'', ''''),
                IIF(P.Lirios = 1, ''K'', ''''),
                IIF(P.Aurora = 1, ''L'', ''''),
                IIF(P.Tulipanes = 1, ''M'', ''''),
                IIF(P.liston = 1, ''N'', '''')
            ) AS ''name'',
            Agency
        FROM Product P
    )'
GO

IF (NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Combination')
)
BEGIN
    WITH Letter
    AS (
        SELECT 
            [ASCII] = ASCII('A'), 
            [value] = CHAR(ASCII('A'))
        UNION ALL
        SELECT 
            [ASCII] + 1, 
            [value] = CHAR([ASCII]+1)
        FROM  Letter
        WHERE [ASCII] < ASCII('N')
    ),
    Combination(letter, combination) AS (
        SELECT L.value, CAST(L.value AS VARCHAR(100))
        FROM Letter L
        UNION ALL
        SELECT L.[value], CAST(CONCAT(C.combination, L.[value]) AS VARCHAR(100)) FROM Combination C
        INNER JOIN Letter L ON L.[value] > C.letter
    )
    SELECT combination, 0 AS 'quantity' INTO Combination FROM Combination
    WHERE LEN(combination) > 1
END

-- Total
SELECT C.combination, COUNT(S.id) AS 'Cantidad' FROM Combination C
INNER JOIN SellCodes S ON S.name LIKE '%' + C.combination + '%'
GROUP BY C.combination
ORDER BY Cantidad DESC

-- By the agency
SELECT
    CASE
        WHEN t.Agency = 1 THEN 'San Salvador'
        WHEN t.Agency = 2 THEN 'Santa Ana'
        WHEN t.Agency = 3 THEN 'San Miguel'
        ELSE ''
    END AS 'Agency',
    t.combination,
    t.Cantidad
FROM (
    SELECT S.Agency, C.combination, COUNT(S.id) AS 'Cantidad' FROM Combination C
    INNER JOIN SellCodes S ON S.name LIKE '%' + C.combination + '%'
    GROUP BY S.Agency, C.combination
) AS t
INNER JOIN (
    SELECT Agency, combination, MAX(Cantidad) OVER (PARTITION BY agency) AS 'Cantidad' FROM (
        SELECT S.Agency, C.combination, COUNT(S.id) AS 'Cantidad' FROM Combination C
        INNER JOIN SellCodes S ON S.name LIKE '%' + C.combination + '%'
        GROUP BY S.Agency, C.combination
    ) AS t
) AS max_value ON t.Agency = max_value.Agency AND t.combination = max_value.combination AND t.Cantidad = max_value.Cantidad
