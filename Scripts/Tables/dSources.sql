IF	object_id('dbo.Sources') IS NOT NULL
	DROP	TABLE	dbo.Sources
GO

PRINT	'Creating dbo.Sources'
--	

CREATE TABLE   dbo.Sources
(
Id		INT		IDENTITY	CONSTRAINT ISourcesId		PRIMARY KEY NONCLUSTERED	,
Kind		INT		NOT NULL	CONSTRAINT RSourcesKind		REFERENCES dbo.SourceKinds ( Id ), -- Source kinds: books, dialogues, articles, etc.
Name		VARCHAR(255)	NOT NULL									,
Author		VARCHAR(255)	NULL										,
Description	VARCHAR(255)	NULL										,
URL		VARCHAR(255)	NULL										,
)
GO