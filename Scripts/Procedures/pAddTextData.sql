IF	object_id('dbo.pAddTextData') IS NOT NULL
	DROP	PROCEDURE	dbo.pAddTextData
GO

/*
	DECLARE	@Id	BIGINT
	EXEC	dbo.pAddTextData	@Word = 'new', @PrevId = 0, @SourceId = 0, @Id = @Id OUT
	SELECT	@Id
	EXEC	dbo.pAddTextData	@Word = 'word', @PrevId = @Id, @SourceId = 0, @Id = @Id OUT
	SELECT	@Id
	SELECT TOP 10 * FROM dbo.TextData ORDER BY Id DESC
	SELECT TOP 10 * FROM dbo.TextItems ORDER BY Id DESC
*/	

CREATE PROCEDURE   dbo.pAddTextData

	@Word		VARCHAR(50)	,
	@PrevId		BIGINT		,
	@SourceId	INT		,
	@Id		BIGINT	= NULL	OUT

AS

SET	NOCOUNT		ON
SET	ROWCOUNT	0

DECLARE	@TextItemId	BIGINT

SELECT	@TextItemId	= x.Id
FROM	dbo.TextItems	x
WHERE	x.Item	= @Word

IF	@TextItemId	IS NULL
BEGIN
	INSERT	INTO	dbo.TextItems
	(	Item	,
		Kind
	)
	VALUES	
	(	@Word	,
		(	SELECT	Id
			FROM	dbo.TextItemKinds
			WHERE	Name = 'word' 
		) 
	)

	IF	@@ERROR	<> 0
		GOTO	ERR_TRAN

	SELECT	@TextItemId	= @@IDENTITY
END

INSERT	INTO	dbo.TextData
(	PrevId		,
	TextItemId	,
	SourceId	
)
VALUES
(	@PrevId		,
	@TextItemId	,
	@SourceId
)

IF	@@ERROR	<> 0
	GOTO	ERR_TRAN

SELECT	@Id	= @@IDENTITY


EXIT_STAT:
	RETURN	1
ERR_TRAN:
	RETURN	0

GO