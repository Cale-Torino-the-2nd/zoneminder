alter table Events modify Id int(10) unsigned;
alter table Events DROP Primary key;
alter table Events Add Primary key(Id);
alter table Events modify Id int(10) unsigned auto_incremement;

SET @s = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = DATABASE()
      AND table_name = 'Storage'
      AND column_name = 'Scheme'
    ) > 0,
    "SELECT 'Column Scheme already exists in Storage'",
    "ALTER TABLE Storage ADD `Scheme   enum('Deep','Medium','Shallow') NOT NULL default 'Medium' AFTER `DiskSpace`"
    ));

PREPARE stmt FROM @s;
EXECUTE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = DATABASE()
      AND table_name = 'Events'
      AND column_name = 'StorageScheme'
    ) > 0,
    "SELECT 'Column StorageScheme already exists in Events'",
    "ALTER TABLE Events ADD `StorageScheme   enum('Deep','Medium','Shallow') NOT NULL default 'Deep' AFTER `DiskSpace`"
    ));

PREPARE stmt FROM @s;
EXECUTE stmt;
