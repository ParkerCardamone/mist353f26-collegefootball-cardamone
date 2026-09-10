/*create table test_table (
    
);*/
CREATE LOGIN NandaSurendra
WITH PASSWORD = 'MIST353Instructor';

create user NandaSurendra
for login NandaSurendra;

alter role db_owner add member NandaSurendra;