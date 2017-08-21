IF	object_id('dbo.TextData') IS NOT NULL
	DROP	TABLE	dbo.TextData
GO

PRINT	'Creating TextData'
--	Using words in sources (textes)

CREATE TABLE   dbo.TextData
(
Id		BIGINT		IDENTITY	CONSTRAINT ITextDataId		PRIMARY KEY NONCLUSTERED	,
PrevId		BIGINT		NOT NULL	CONSTRAINT ITextDataPrevId	DEFAULT ( 0 )
						CONSTRAINT RTextDataPrevId	REFERENCES TextData ( Id )	, -- Reference to previose word in text
TextItemId	BIGINT		NOT NULL	CONSTRAINT ITextDataTextItemId	DEFAULT ( 0 )
						CONSTRAINT RTextDataTextItemId	REFERENCES TextItems ( Id )	,
Source		INT		NOT NULL	CONSTRAINT ITextDataSource	DEFAULT ( 0 )
						CONSTRAINT RTextDataSource	REFERENCES Sources ( Id )	,
)
GO