----------------------------------------------------------------------------------
--	SELECT * FROM dbo.SourceKinds
PRINT	'Creating reference book dbo.SourceKinds'

INSERT	INTO	dbo.SourceKinds
(	Name
)
SELECT	Name
FROM	(	SELECT	'unknown' AS Name
UNION ALL	SELECT	'book'
UNION ALL	SELECT	'dialogue'
UNION ALL	SELECT	'article'
UNION ALL	SELECT	'internet article'
)	x
WHERE	NOT EXISTS	
	(	SELECT	1
		FROM	dbo.SourceKinds	s
		WHERE	s.Name	= x.Name
	)

GO

----------------------------------------------------------------------------------
--	SELECT * FROM dbo.TextItemKinds
PRINT	'Creating reference book dbo.TextItemKinds'

INSERT	INTO	dbo.TextItemKinds
(	Name
)
SELECT	Name
FROM	(	SELECT	'unknown' AS Name
UNION ALL	SELECT	'word'
UNION ALL	SELECT	'symbol'
UNION ALL	SELECT	'number'
)	x
WHERE	NOT EXISTS	
	(	SELECT	1
		FROM	dbo.TextItemKinds	s
		WHERE	s.Name	= x.Name
	)

GO

----------------------------------------------------------------------------------
--	SELECT * FROM dbo.Sources
PRINT	'Creating zero row for dbo.Sources (Id=0)'

IF	NOT EXISTS
	(	SELECT	1
		FROM	dbo.Sources
		WHERE	Id	= 0
	)
BEGIN
	SET IDENTITY_INSERT dbo.Sources ON

	INSERT	INTO	dbo.Sources
	(	Id	,
		Name	,
		Kind
	)
	VALUES
	(	0	,	
		''	,
		(	SELECT	Id
			FROM	dbo.SourceKinds
			WHERE	Name = 'unknown' 
		) 
	)

	SET IDENTITY_INSERT dbo.Sources OFF
END

GO

----------------------------------------------------------------------------------
--	SELECT * FROM dbo.TextItems
PRINT	'Creating zero row for dbo.TextItems (Id=0)'

IF	NOT EXISTS
	(	SELECT	1
		FROM	dbo.TextItems
		WHERE	Id	= 0
	)
BEGIN
	SET IDENTITY_INSERT dbo.TextItems ON

	INSERT	INTO	dbo.TextItems
	(	Id	,
		Item	,
		Kind
	)
	VALUES	
	(	0	,
		''	,
		(	SELECT	Id
			FROM	dbo.TextItemKinds
			WHERE	Name = 'unknown' 
		) 
	)

	SET IDENTITY_INSERT dbo.TextItems OFF
END

GO

----------------------------------------------------------------------------------
--	SELECT * FROM dbo.TextItems
PRINT	'Adding symbols to dbo.TextItems'

DECLARE	@KindId	INT

SELECT	@KindId	= Id
FROM	dbo.TextItemKinds
WHERE	Name = 'symbol'

INSERT	INTO	dbo.TextItems
(	Item	,
	Kind
)
SELECT	Item	,
	@KindId
FROM	(	SELECT	'.'	AS Item
UNION	ALL	SELECT	','
UNION	ALL	SELECT	':'
UNION	ALL	SELECT	';'
UNION	ALL	SELECT	'!'
UNION	ALL	SELECT	'&'
UNION	ALL	SELECT	'-'
UNION	ALL	SELECT	'/'
UNION	ALL	SELECT	'\'
UNION	ALL	SELECT	'|'
UNION	ALL	SELECT	''''
UNION	ALL	SELECT	'"'
UNION	ALL	SELECT	'«'
UNION	ALL	SELECT	'»'
UNION	ALL	SELECT	'`'
UNION	ALL	SELECT	'’'
UNION	ALL	SELECT	'~'
UNION	ALL	SELECT	'@'
UNION	ALL	SELECT	'#'
UNION	ALL	SELECT	'¹'
UNION	ALL	SELECT	'$'
UNION	ALL	SELECT	'^'
UNION	ALL	SELECT	'*'
UNION	ALL	SELECT	'('
UNION	ALL	SELECT	')'
UNION	ALL	SELECT	'['
UNION	ALL	SELECT	']'
UNION	ALL	SELECT	'<'
UNION	ALL	SELECT	'>'
UNION	ALL	SELECT	'{'
UNION	ALL	SELECT	'}'
UNION	ALL	SELECT	'+'
UNION	ALL	SELECT	'='
)	x
WHERE	NOT EXISTS	
	(	SELECT	1
		FROM	dbo.TextItems	s
		WHERE	s.Item	= x.Item
	)

GO

----------------------------------------------------------------------------------
--	SELECT * FROM dbo.TextData
PRINT	'Creating zero row for dbo.TextData (Id=0)'

IF	NOT EXISTS
	(	SELECT	1
		FROM	dbo.TextData
		WHERE	Id	= 0
	)
BEGIN
	SET IDENTITY_INSERT dbo.TextData ON

	INSERT	INTO	dbo.TextData
	(	Id,	PrevId,	TextItemId,	SourceId	)
	VALUES	
	(	0,	0,	0,		0	)

	SET IDENTITY_INSERT dbo.TextData OFF
END

GO