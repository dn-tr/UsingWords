IF	object_id('dbo.SourceKinds') IS NOT NULL
	DROP	TABLE	dbo.SourceKinds
GO

PRINT	'Creating dbo.SourceKinds'
--	Source kinds: books, dialogues, articles, etc.

CREATE TABLE   dbo.SourceKinds
(
Id		INT		IDENTITY	CONSTRAINT ISourceKindsId		PRIMARY KEY NONCLUSTERED	,
Name		VARCHAR(30)	NOT NULL										,
)
GO