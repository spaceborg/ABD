use abd_sup_mer;
use ais_escuela;
use supermercado_ahumada;

show tables;
show full tables WHERE table_type = 'VIEW';
show procedure status WHERE db = 'abd_sup_mer';
show function status WHERE db = 'abd_sup_mer';

drop schema ais_escuela;
drop schema abd_sup_mer;
drop schema supermercado_ahumada;

CREATE SCHEMA supermercado_ahumada DEFAULT CHARACTER SET utf8MB4 ;

