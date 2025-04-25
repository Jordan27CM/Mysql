--las funciones definidas por el usuario UDF son bloques de que realizarn una funcion y devuelven un solo valor
--y pueden ser usadas en cualquier consuta sql pero no pueden modificar tablas de ninguna manera solo SELECT
DELIMITER //
CREATE FUNCTION nombre_funcion(nombre_parametro int)--una funcion puede recibir multiples parametros de entrada solo de entrada
RETURNS int --las funciones simpre devuelven un dato solo uno y se especifica al inicio con el tipo de dato que va a devolver
BEGIN --BEGIN para encerrar la estructura de la funcion
    IF nombre_parametro == 1 THEN --una estructura IF se define con IF [condicion] THEN segido de lo que hace si se cumple
        RETURN nombre_parametro; --con la sentencia RETURN se devuelve un dato hacia afuera 
    ELSEIF nombre_parametro < 21 THEN--en caso de requerir otra condicional se usa ELSEIF [condicion] THEN segudo de lo que hace si se cumple
        RETURN nombre_parametro * 2; 
    ELSE --en el ultimo caso si no se cumple ningun if se pone ELSE seguido de lo que hace
        RETURN 0;
    END IF;--para finalizar la estructura if se usa el END IF; 
END //
DELIMITER ;
--dentro de la estructura de la funcion se puede ejecutar lojica condicional IF, WHILE, CASE 
--el ejemplo anterior solo toma un numero y devuelve el doble y una funcion se utiliza de la misma manera que las propias de sql COUNT(), AVG() etc.
SELECT nombre_funcion(salario) FROM empleados;
--este ejemplo devorveria el doble del salario de un empleado 


---------------------------------------------------------------