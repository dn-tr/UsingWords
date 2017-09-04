IF	object_id('dbo.TextItemKinds') IS NOT NULL
	DROP	TABLE	dbo.TextItemKinds
GO

PRINT	'Creating dbo.TextItemKinds'
--	Text kinds: words, numbers, punctuation marks, etc.

CREATE TABLE   dbo.TextItemKinds
(
Id		INT		IDENTITY	CONSTRAINT ITextItemKindsId		PRIMARY KEY NONCLUSTERED	,
Name		VARCHAR(30)	NOT NULL										,
)
GO