IF	object_id('dbo.TextItems') IS NOT NULL
	DROP	TABLE	dbo.TextItems
GO

PRINT	'Creating dbo.TextItems'
--	

CREATE TABLE   dbo.TextItems
(
Id		BIGINT		IDENTITY	CONSTRAINT ITextItemsId		PRIMARY KEY NONCLUSTERED		,
Item		VARCHAR(50)	NOT NULL										, -- (Longest English word in a major dictionary have 45 letters)
Kind		INT		NOT NULL	CONSTRAINT RTextItemsKind	REFERENCES dbo.TextItemKinds ( Id )	, -- Text kinds: words, numbers, punctuation marks, etc.
)
GO