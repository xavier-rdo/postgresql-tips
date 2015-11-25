-- Track any change in the public.employee TABLE (INSERT, UPDATE OR DELETE)
-- tip : @see psql's \i command in order to execute this script (\? to get help in psql)

CREATE SCHEMA IF NOT EXISTS audit;

CREATE TABLE IF NOT EXISTS audit.employee(
    operation         varchar(10) NOT NULL,
    stamp             timestamp   NOT NULL,
    userid            text        NOT NULL,
    employee_id       int         NOT NULL,
    lastname          varchar(50) NOT NULL
);

-- http://www.postgresql.org/docs/current/static/plpgsql-trigger.html
-- TRIGGER HANDLER FUNCTION

CREATE OR REPLACE FUNCTION audit.process_employee_audit()
RETURNS TRIGGER AS $employee_audit$
    BEGIN
        -- Create a row in audit.employee TABLE to reflect the operation performed on
        -- the public.employee TABLE. Make use of the special variable TG_OP to work
        -- out the operation (DELETE, UPDATE OR INSERT)
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO audit.employee SELECT TG_OP, now(), user, OLD.id, OLD.lastname;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE' OR TG_OP = 'INSERT') THEN
            INSERT INTO audit.employee SELECT TG_OP, now(), user, NEW.id, NEW.lastname;
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger handler
    END;
$employee_audit$ LANGUAGE plpgsql;

-- THE TRIGGER ITSELF
-- Note: the name of a trigger cannot be schema-qualified, it inherits the schema of its table

CREATE TRIGGER audit_employee
AFTER INSERT OR UPDATE OR DELETE ON public.employee
    FOR EACH ROW EXECUTE PROCEDURE audit.process_employee_audit()
;
