IF	object_id('dbo.TextItems') IS NOT NULL
	DROP	TABLE	dbo.TextItems
GO

PRINT	'Creating TextItems'
--	

CREATE TABLE   dbo.TextItems
(
Id		BIGINT		IDENTITY	CONSTRAINT ITextItemsId		PRIMARY KEY NONCLUSTERED	,
Item		VARCHAR		NOT NULL									,
Kind		INT		NOT NULL	CONSTRAINT RTextItemsKind	REFERENCES TextItemKinds ( Id )	, -- Text kinds: words, numbers, punctuation marks, etc.
)
GO