ALTER TABLE employees ADD COLUMN department VARCHAR(100);

COMMENT ON COLUMN employees.department IS 'Department where the employee works';

