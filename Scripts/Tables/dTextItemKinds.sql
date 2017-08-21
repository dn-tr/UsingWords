IF	object_id('dbo.TextItemKinds') IS NOT NULL
	DROP	TABLE	dbo.TextItemKinds
GO

PRINT	'Creating TextItemKinds'
--	Text kinds: words, numbers, punctuation marks, etc.

CREATE TABLE   dbo.TextItemKinds
(
Id		INT		IDENTITY	CONSTRAINT ITextItemKindsId		PRIMARY KEY NONCLUSTERED	,
Name		CHAR(30)	NOT NULL										,
)
GO