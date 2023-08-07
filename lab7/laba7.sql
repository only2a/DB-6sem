CREATE TABLE XMLReport
(
    id INT PRIMARY KEY IDENTITY(1, 1),
    xml_col XML
);

DROP TABLE IF EXISTS XMLReport;

-- 2-3 --
CREATE OR ALTER PROCEDURE generate_xml
AS
BEGIN
    DECLARE @xml XML;
    SET @xml = (
        SELECT 
            COUNT(l.id) AS [likes],
            GETDATE() AS [report_date],
            (
                SELECT 
                    u.first_name,
                    p.id AS [p/@id],
                    p.post_text,
                    (
                        SELECT c.comment_text
                        FROM Comment c
                        WHERE c.post_id = p.id
                        FOR XML PATH('c'), TYPE
                    )
                FROM
                    Users u
                    INNER JOIN Post p ON p.user_id = u.id
                WHERE EXISTS (
                    SELECT 1
                    FROM Likes l
                    WHERE l.post_id = p.id
                )
                FOR XML PATH('p'), TYPE, ROOT('u')
            )
        FROM
            Users u
            INNER JOIN Post p ON p.user_id = u.id
            INNER JOIN Likes l ON l.post_id = p.id
        GROUP BY
            u.first_name,
            p.id,
            p.post_text
        FOR XML RAW('u'), ROOT('root')
    );

    INSERT INTO XMLReport (xml_col)
    VALUES (@xml);
END;
GO



exec generate_xml;

select *
from XMLReport;

-- 4 --
create primary xml index xml_col_index
    on XMLReport (xml_col);

--test the index
SET SHOWPLAN_XML ON;

SELECT xml_col
FROM XMLReport
WHERE xml_col.exist('/root/u[@likes="2"]') = 1;


create xml index second_xml_col_index
    on XMLReport (xml_col) using xml index xml_col_index for path;

-- 5 --
CREATE OR ALTER PROCEDURE ExtractXMLValues
    @searchValue VARCHAR(100)
AS
BEGIN
    SELECT
        x.value('local-name(.)', 'VARCHAR(100)') AS ElementOrAttributeName,
        x.value('.', 'VARCHAR(MAX)') AS ElementOrAttributeValue
    FROM
        XMLReport
    CROSS APPLY
        xml_col.nodes('//*') AS T(x)
    WHERE
        x.exist('.[@* = sql:variable("@searchValue")]') = 1
       OR x.exist('.[text()[contains(., sql:variable("@searchValue"))]]') = 1;
END;

EXEC ExtractXMLValues 'John';

EXEC ExtractXMLValues 'post';

EXEC ExtractXMLValues 'liked';




