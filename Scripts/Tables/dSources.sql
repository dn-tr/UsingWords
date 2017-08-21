IF	object_id('dbo.Sources') IS NOT NULL
	DROP	TABLE	dbo.Sources
GO

PRINT	'Creating Sources'
--	

CREATE TABLE   dbo.Sources
(
Id		INT		IDENTITY	CONSTRAINT ISourcesId		PRIMARY KEY NONCLUSTERED	,
Kind		INT		NOT NULL	CONSTRAINT RSourcesKind		REFERENCES SourceKinds ( Id )	, -- Source kinds: books, dialogues, articles, etc.
Name		VARCHAR(255)	NOT NULL									,
Author		VARCHAR		NULL										,
Description	VARCHAR		NULL										,
URL		VARCHAR		NULL										,
)
GO