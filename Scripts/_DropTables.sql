PRINT	'Dropping dbo.TextData'
IF	object_id('dbo.TextData') IS NOT NULL
	DROP	TABLE	dbo.TextData
GO

PRINT	'Dropping dbo.Sources'
IF	object_id('dbo.Sources') IS NOT NULL
	DROP	TABLE	dbo.Sources
GO

PRINT	'Dropping dbo.SourceKinds'
IF	object_id('dbo.SourceKinds') IS NOT NULL
	DROP	TABLE	dbo.SourceKinds
GO

PRINT	'Dropping dbo.TextItems'
IF	object_id('dbo.TextItems') IS NOT NULL
	DROP	TABLE	dbo.TextItems
GO

PRINT	'Dropping dbo.TextItemKinds'
IF	object_id('dbo.TextItemKinds') IS NOT NULL
	DROP	TABLE	dbo.TextItemKinds
GO

