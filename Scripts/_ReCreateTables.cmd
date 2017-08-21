echo off

set serverName=DESKTOP-3HVPMDN\SQLEXPRESS
set dbName=for-any-tests

echo:
sqlcmd -E -S %serverName% -d %dbName% -i _DropTables.sql

echo:
sqlcmd -E -S %serverName% -d %dbName% -i Tables\dTextItemKinds.sql
sqlcmd -E -S %serverName% -d %dbName% -i Tables\dTextItems.sql
sqlcmd -E -S %serverName% -d %dbName% -i Tables\dSourceKinds.sql
sqlcmd -E -S %serverName% -d %dbName% -i Tables\dSources.sql
sqlcmd -E -S %serverName% -d %dbName% -i Tables\dTextData.sql

echo:
sqlcmd -E -S %serverName% -d %dbName% -i _Init.sql

set /p delExit=Press the ENTER key to exit...