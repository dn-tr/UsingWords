IF	object_id('dbo.Words') IS NOT NULL
	DROP	TABLE	dbo.Words
GO

--	

CREATE TABLE   dbo.Words
(
Id		INT		IDENTITY	CONSTRAINT ICtlAccId		PRIMARY KEY NONCLUSTERED	,
Word		VARCHAR		NOT NULL									,
)
GO