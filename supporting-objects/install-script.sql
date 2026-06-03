set define off
set sqlblanklines on

prompt Installing Task Center supporting objects

@schema-install.sql
@data-install.sql
@email-automation-migration.sql

prompt Task Center supporting objects installed
