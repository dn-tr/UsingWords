PRINT	'Dropping TextData'
IF	object_id('dbo.TextData') IS NOT NULL
	DROP	TABLE	dbo.TextData
GO

PRINT	'Dropping Sources'
IF	object_id('dbo.Sources') IS NOT NULL
	DROP	TABLE	dbo.Sources
GO

PRINT	'Dropping SourceKinds'
IF	object_id('dbo.SourceKinds') IS NOT NULL
	DROP	TABLE	dbo.SourceKinds
GO

PRINT	'Dropping TextItems'
IF	object_id('dbo.TextItems') IS NOT NULL
	DROP	TABLE	dbo.TextItems
GO

PRINT	'Dropping TextItemKinds'
IF	object_id('dbo.TextItemKinds') IS NOT NULL
	DROP	TABLE	dbo.TextItemKinds
GO

