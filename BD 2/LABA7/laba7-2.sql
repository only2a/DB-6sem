-- 1 --
create table report
(
    id      number generated always as identity,
    xml_col xmltype,
    constraint report_pk primary key (id)
);


CREATE OR REPLACE PROCEDURE Generate_XML AS
    xml_col XMLType;
BEGIN
    SELECT XMLELEMENT("report",
                      XMLELEMENT("total", (SELECT SUM(c.id) FROM comments c)),
                      XMLELEMENT("report_date", SYSDATE),
                      XMLELEMENT("posts",
                                 (SELECT XMLAGG(
                                     XMLELEMENT("post",
                                                XMLELEMENT("id", p.id),
                                                XMLELEMENT("text", p.post_text),
                                                XMLELEMENT("author", u.first_name)
                                     ))
                                 FROM Post p
                                          INNER JOIN Users u ON u.id = p.user_id)),
                      XMLELEMENT("comments",
                                 (SELECT XMLAGG(
                                     XMLELEMENT("comment",
                                                XMLELEMENT("id", c.id),
                                                XMLELEMENT("text", c.comment_text),
                                                XMLELEMENT("author", u.first_name)
                                     ))
                                 FROM Comments c
                                          INNER JOIN Users u ON u.id = c.user_id))
    )
    INTO xml_col
    FROM dual;

    INSERT INTO Report (xml_col) VALUES (xml_col);
    COMMIT;
END;
/



begin
    Generate_XML;
end;

select xml_col
from report;

SELECT xml_col AS xml_content
FROM report;

SELECT XMLSerialize(CONTENT xml_col) AS xml_content
FROM report;



-- 4 --
CREATE INDEX idx_report_xml_col ON report(xml_col) INDEXTYPE IS XDB.XMLINDEX;

DROP INDEX idx_report_xml_col;


--test the index in oracle
SELECT *
FROM report
WHERE XMLExists('//total[text() = "3"]' PASSING xml_col);

EXPLAIN PLAN FOR
SELECT *
FROM report
WHERE XMLExists('//total[text() = "3"]' PASSING xml_col);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);








-- 5 --
CREATE OR REPLACE PROCEDURE ExtractXMLElementAndAttribute (
    pElementXPath VARCHAR2,
    pAttributeXPath VARCHAR2
) AS
    vElementValue VARCHAR2(100);
    vAttributeValue VARCHAR2(100);
BEGIN
    SELECT EXTRACTVALUE(xml_col, pElementXPath),
           EXTRACT(xml_col, pAttributeXPath).getStringVal()
    INTO vElementValue, vAttributeValue
    FROM report
    WHERE XMLExists(pElementXPath PASSING xml_col);

    DBMS_OUTPUT.PUT_LINE('Element Value: ' || vElementValue);
    DBMS_OUTPUT.PUT_LINE('Date Value: ' || vAttributeValue);
END;
/

BEGIN
    ExtractXMLElementAndAttribute('/report/total', '/report/report_date');
END;
