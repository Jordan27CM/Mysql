--los trigger se ejecutan automaticamente cuando ocurre un evento especifico en una tabla como INSERT, UPDATE, DELETE
--existen dos tipos de trigger BEFORE(antes), After(despues)
DELIMITER //
--se establece la creacion del trigger con su nombre
CREATE TRIGGER nombre_trigger
--se especifica si se realiza antes o despues del evento(BEFORE o AFTER) despues el tipo de evento que activara el trigger(INSERT, UPDATE, DELETE)
--y el nombre de la tabla con el cual se activara
{BEFORE | AFTER} {INSERT | UPDATE | DELETE} 
ON NombreTabla
--FOR EACH ROW significa que el trigger se ejecutará por cada fila afectada por la operación.
FOR EACH ROW
BEGIN   
    --dentro de la estructura BEGIN se encierra la logica del trigger un ejemplo practico seria insertar datos automaticamente
    --a otra tabla o validar datos antes de insertarlos en una tabla 
END;
DELIMITER;


--en este ejemplo tenemos dos tablas una de empleados y otra de auditoria este trigger registra cada cambio en el salario de un empleado
--en la tabla de auditoria automaticamente
DELIMITER //
CREATE TRIGGER insert_auditoria
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
    IF NEW.salario < 1 THEN
        SIGNAL SQLSTATE '45000' --Genera un error con un código de estado SQL (en este caso, '45000', que representa un error genérico de aplicación)
        SET MESSAGE_TEXT = 'mensaje de error personalizado'; --Devuelve un mensaje personalizado que describe el problema
    ELSE
        INSERT INTO auditoria(id_empleado, salario_antiguo, salario_nuevo, fecha)--este INSERT se ejecuta automaticamente con cada UPDATE que se haga en la tabla de empleados
        VALUES(OLD.id_empleado, OLD.salario, NEW.salario, NOW());   --para obtener un dato antes del cambio se usa OLD. y el nombre de la columna
    END IF                                                          --y para obtener el nuevo dato se usa NEW. y el nombre de la columna 
END //
DELIMITER ;

---------------------------------------------------------------

--este ejemplo se valida el stock para que no sea menos o igual a 0 
CREATE TRIGGER validar_Stock
BEFORE UPDATE ON productos --establese que antes que se ejecute un UPDATE en la tabla de productos se ejecute este trigger
FOR EACH ROW
BEGIN
    IF NEW.stock > 0 THEN --comprara el nuevo precio del producto si es correcto se hace un INSERT en la tabla de auditoria con los campos
        INSERT INTO auditoria (tipo_cambio, objeto_id, valor_anterior, valor_nuevo, usuario_responsable)
        VALUES('Cambio stock', OLD.id, OLD.stock, NEW.stock, 'yo');
    ELSE
        SIGNAL SQLSTATE '45000' --se ejecuta un error con mensaje y no se realiza el UPDATE
        SET MESSAGE_TEXT = 'Error: El nuevo stock no puede ser menor a 0.';
    
    END IF;
END //

--este ejemplo se utilizan las mismas tablas pero con diferente campos a validar ahora el precio
CREATE TRIGGER validar_precio
BEFORE UPDATE
FOR EACH ROW
BEGIN
    IF NEW.precio > 0 THEN
        INSERT INTO auditoria (tipo_cambio, objeto_id, valor_anterior, valor_nuevo, usuario_responsable)
        VALUES('Cambio Precio', OLD.id, OLD.precio, NEW.precio, 'yo');
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El nuevo precio no puede ser menor a 0.';
    
    END IF
END//

CREATE TRIGGER validar_salario
BEFORE UPDATE on empleados
FOR EACH ROW
BEGIN
    IF NEW.salario != OLD.salario AND NEW.salario > 1 THEN
        INSERT INTO auditoria (tipo_cambio, objeto_id, valor_anterior, valor_nuevo, usuario_responsable)
        VALUES('Cambio salario', OLD.id, OLD.salario, NEW.salario, 'yo')
    ELSE
        SELECT CONCAT('El nuevo salario no es valido') AS ERROR;
    END IF
END//
DELIMITER ;

