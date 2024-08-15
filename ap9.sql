-- Nombre de mi base de datos
use ap9;

-- Hacer UPDATE en la columna experience_level
UPDATE data_science_jobs_salaries
SET experience_level = CASE
    WHEN experience_level = 'EN' THEN 1
    WHEN experience_level = 'MI' THEN 2
    WHEN experience_level = 'SE' THEN 3
    WHEN experience_level = 'EX' THEN 4
    ELSE experience_level
END;

-- Hacer UPDATE en la columna job_title
UPDATE data_science_jobs_salaries
SET job_title = CASE
    WHEN job_title = 'Data Scientist' THEN 1
    WHEN job_title = 'Data Engineer' THEN 2
    WHEN job_title = 'Data Analyst' THEN 3
    WHEN job_title = 'Machine Learning Engineer' THEN 4
    ELSE 5
END;

-- Hacer UPDATE en la columna company_size
UPDATE data_science_jobs_salaries
SET company_size = CASE
    WHEN company_size = 'S' THEN 1
    WHEN company_size = 'M' THEN 2
    WHEN company_size = 'L' THEN 3
    ELSE company_size
END;

-- Agregar una columna que indique 1 si employee_residence=company_location
ALTER TABLE data_science_jobs_salaries
ADD COLUMN same_location INT DEFAULT 0;

UPDATE data_science_jobs_salaries
SET same_location = 1
WHERE employee_residence = company_location;

-- Agregar una columna que indique 1 si salary_in_usd es mayor igual a 60,000
ALTER TABLE data_science_jobs_salaries
ADD COLUMN high_salary INT DEFAULT 0;

UPDATE data_science_jobs_salaries
SET high_salary = 1
WHERE salary_in_usd >= 60000;
