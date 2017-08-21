----------------------------------------------------------------------------------
--	SELECT * FROM SourceKinds
PRINT	'Creating reference book SourceKinds'

INSERT	INTO	SourceKinds
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
		FROM	SourceKinds	s
		WHERE	s.Name	= x.Name
	)

GO

----------------------------------------------------------------------------------
--	SELECT * FROM TextItemKinds
PRINT	'Creating reference book TextItemKinds'

INSERT	INTO	TextItemKinds
(	Name
)
SELECT	Name
FROM	(	SELECT	'unknown' AS Name
UNION ALL	SELECT	'word'
UNION ALL	SELECT	'punctuation mark'
UNION ALL	SELECT	'number'
)	x
WHERE	NOT EXISTS	
	(	SELECT	1
		FROM	TextItemKinds	s
		WHERE	s.Name	= x.Name
	)

GO

----------------------------------------------------------------------------------
--	SELECT * FROM Sources
PRINT	'Creating zero row for Sources (Id=0)'

IF	NOT EXISTS
	(	SELECT	1
		FROM	Sources
		WHERE	Id	= 0
	)
BEGIN
	SET IDENTITY_INSERT Sources ON

	INSERT	INTO	Sources
	(	Id	,
		Name	,
		Kind
	)
	VALUES
	(	0	,	
		''	,
		(	SELECT	Id
			FROM	SourceKinds
			WHERE	Name = 'unknown' 
		) 
	)

	SET IDENTITY_INSERT Sources OFF
END

GO

----------------------------------------------------------------------------------
--	SELECT * FROM TextItems
PRINT	'Creating zero row for TextItems (Id=0)'

IF	NOT EXISTS
	(	SELECT	1
		FROM	TextItems
		WHERE	Id	= 0
	)
BEGIN
	SET IDENTITY_INSERT TextItems ON

	INSERT	INTO	TextItems
	(	Id	,
		Item	,
		Kind
	)
	VALUES	
	(	0	,
		''	,
		(	SELECT	Id
			FROM	TextItemKinds
			WHERE	Name = 'unknown' 
		) 
	)

	SET IDENTITY_INSERT TextItems OFF
END

GO

----------------------------------------------------------------------------------
--	SELECT * FROM TextItems
PRINT	'Adding punctuation marks to TextItems'

DECLARE	@KindId	INT

SELECT	@KindId	= Id
FROM	TextItemKinds
WHERE	Name = 'punctuation mark'

INSERT	INTO	TextItems
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
		FROM	TextItems	s
		WHERE	s.Item	= x.Item
	)

GO

----------------------------------------------------------------------------------
--	SELECT * FROM TextData
PRINT	'Creating zero row for TextData (Id=0)'

IF	NOT EXISTS
	(	SELECT	1
		FROM	TextData
		WHERE	Id	= 0
	)
BEGIN
	SET IDENTITY_INSERT TextData ON

	INSERT	INTO	TextData
	(	Id,	PrevId,	TextItemId,	Source	)
	VALUES	
	(	0,	0,	0,		0	)

	SET IDENTITY_INSERT TextData OFF
END

GO