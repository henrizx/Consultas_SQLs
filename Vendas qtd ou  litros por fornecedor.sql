SELECT
    TO_CHAR(P.DATA, 'YYYY-MM') AS MES,
    E.CODUSUR,
    U.NOME,
    ROUND(SUM(B.PESOLIQ * P.QT / B.QTUNIT) / (CASE 
                                                 WHEN U.CODUSUR = --rca THEN --N HABITANTES
                                                 WHEN U.CODUSUR = --rca THEN --N HABITANTES
                                                 WHEN U.CODUSUR = --rca THEN --N HABITANTES
                                                 WHEN U.CODUSUR = --rca THEN --N HABITANTES
                                                 WHEN U.CODUSUR = --rca THEN --N HABITANTES
                                                 WHEN U.CODUSUR = --rca THEN --N HABITANTES
                                                 -- Adicione mais condições conforme necessário
                                                 ELSE 1 -- Valor padrão
                                             END / 12), 2) AS LITROS_PER_CAPITA,
    SUM(P.QT * P.PVENDA) AS VLTOTAL,
    SUM(B.PESOLIQ * P.QT / B.QTUNIT) AS LITROS
    
FROM
    PCPEDI P
JOIN PCPEDC E ON P.NUMPED = E.NUMPED AND P.CODCLI = E.CODCLI
JOIN PCPRODUT D ON P.CODPROD = D.CODPROD
JOIN PCFORNEC F ON D.CODFORNEC = F.CODFORNEC
JOIN PCUSUARI U ON E.CODUSUR = U.CODUSUR
JOIN PCEMBALAGEM B ON P.CODPROD = B.CODPROD AND P.CODAUXILIAR = B.CODAUXILIAR
WHERE
    P.DATA BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY') AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
    --P.DATA BETWEEN :DATAINI AND :DATAFIN
    AND E.CONDVENDA IN (1, 14)
    AND P.POSICAO = 'F'
    AND P.POSICAO NOT LIKE 'C'
    AND F.CODFORNEC = -- CODFORNECEDOR DO FILTRO
    AND U.CODUSUR IN (rcas) -- Adicionar os códigos específicos que deseja filtrar
    --AND E.CODUSUR = :CODUSUR
    AND E.DTCANCEL IS NULL
   
GROUP BY
    TO_CHAR(P.DATA, 'YYYY-MM'),
    U.CODUSUR,
    E.CODUSUR,
    U.NOME
ORDER BY
    E.CODUSUR
    --ROUND(RATIO_TO_REPORT(SUM(P.QT * P.PVENDA)) OVER() * 100, 2) DESC;

