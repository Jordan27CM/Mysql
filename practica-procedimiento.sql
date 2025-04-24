--los procedimientos almacenados son un conjunto de intrucciones predefinidas que se guardan y pueden ser ejecutadas rapidamente
--pueden o no devorver un dato y pueden o no recibir datos de entradas estos procedimientos puden realizar operaciones del CRUD

DELIMITER //
--se establecer la creacion de el procedimiento
CREATE PROCEDURE nombre_procedimiento(
    IN parametro_entrada int, --se establecen los datos de entrada y de salida los de salida con IN nombre tipo_de_dato
    OUT parametro_salida int) --y los de salida con OUT nombre y tipo_de_dato
BEGIN --BEGIN para encerrar la estructura de el procedimiento
    DECLARE numero int  --dentro de un procedimiento se pueden declarar variables con DECLARE nombre tipo_de_dato los datos de salida OUT
                        --se pueden manejar como variables para enviar datos hacia afuera
    SET numero = 5; --las variables se le puede asignar datos con SET
    SELECT  algo INTO numero;-- otra forma de asignar datos dentro de una consulta es con INTO 
    SELECT * from tabla WHERE id = parametro_entrada;   --se pueden hacer consultas dentro de un procedimiento con los datos que
                                                        --vienen de entrada IN para ejecutar logica 
END//--el bloque se finaliza con END 
DELIMITER ;
DECLARE @parametro_salida;
CALL nombre_procedimiento(1, @parametro_salida) --para usar los parametros de salida se capturan con un @y el nombre de la variable
                                                --y se usan como variable fuera del procedimiento
SELECT @parametro_salida;--con un SELECT se puede mostrar el valor de la variable


------------------------------------------
--este ejemplo recibe dos parameros de numero los compara y dice cual numero es mayor
CREATE PROCEDURE Condicional(
    IN num1 int, --recibe el primer numero de entrada INT  
    IN num2 int  --recibe el segundo numero de entrada INT
)
BEGIN
    IF num1>num2 THEN --con el if se compara si el numero 1 es mayor que el numero 2
        SELECT CONCAT('El numero mayor es el 1: ', num1);--imprime este mensaje si el num1 es mayor a num2
    ELSE
        SELECT CONCAT('El numero mayor es el 2: ', num2);--imprime este mensaje si el num2 es mayor a num1
    END IF;-- finaliza la estructura de el if
END //
--otra forma de hacer el ejercicio es creando una variable local y modificarla dependiendo de la condicional
CREATE PROCEDURE Condicional_con_variable(
    IN num1 int,   
    IN num2 int  
)
BEGIN
    DECLARE mayor INT
    IF num1>num2 THEN --con el if se compara si el numero 1 es mayor que el numero 2
        SET mayor = num1;
    ELSE
        SET mayor = num2;
    END IF;-- finaliza la estructura de el if
    SELECT CONCAT('El numero mayor es: ', num2);
END //