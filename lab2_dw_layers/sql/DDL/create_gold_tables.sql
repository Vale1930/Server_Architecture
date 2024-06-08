--Quiero saber la produccion de grillos en cada mes
--Cada caja de tipo 'E' va a producir 2.5 kg harina
--Cada caja de tipo 'R' va a producir 1.5 kg harina

WITH PRE AS(
SELECT 
    count(*) as number_of_boxes,  
    EXTRACT(MONTH FROM fecha_sacrificio_esperada) as month, 
    tipo as type
FROM silver.aggr_data
GROUP BY 2, 3
ORDER BY 2, 3
),
PROD AS(
    SELECT 
        month,
        type,
        number_of_boxes,
        CASE 
            WHEN type = 'E' THEN number_of_boxes * 2.5
            WHEN type = 'R' THEN number_of_boxes * 1.5
        END as flour_produced_kg
    FROM PRE
),
FINAL AS(
SELECT
    month as mes_numero, 
    sum(number_of_boxes) as numero_de_cajas,
    sum(flour_produced_kg) as total_kg_harina
FROM PROD
GROUP BY 1
)
SELECT
numero_de_cajas,
total_kg_harina,
       CASE
           WHEN mes_numero = 1 THEN 'January'
           WHEN mes_numero = 2 THEN 'February'
           WHEN mes_numero = 3 THEN 'March'
           WHEN mes_numero = 4 THEN 'April'
           WHEN mes_numero = 5 THEN 'May'
           WHEN mes_numero = 6 THEN 'June'
           WHEN mes_numero = 7 THEN 'July'
           WHEN mes_numero = 8 THEN 'August'
           WHEN mes_numero = 9 THEN 'September'
           WHEN mes_numero = 10 THEN 'October'
           WHEN mes_numero = 11 THEN 'November'
           WHEN mes_numero = 12 THEN 'December'
       END AS mes_nombre
FROM FINAL;
--RETO
--cambiar columna de mes por el nombre del mes
