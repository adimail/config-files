-- Table: public.tasks

-- DROP TABLE IF EXISTS public.tasks;

CREATE TABLE IF NOT EXISTS public.tasks
(
    id integer NOT NULL DEFAULT nextval('tasks_id_seq'::regclass),
    "Task" text COLLATE pg_catalog."default",
    "Created" date,
    "Time elapsed" bigint
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tasks
    OWNER to postgres;

-- Trigger: update_time_elapsed_trigger

-- DROP TRIGGER IF EXISTS update_time_elapsed_trigger ON public.tasks;

CREATE OR REPLACE TRIGGER update_time_elapsed_trigger
    BEFORE INSERT OR UPDATE 
    ON public.tasks
    FOR EACH ROW
    EXECUTE FUNCTION public.update_time_elapsed();
