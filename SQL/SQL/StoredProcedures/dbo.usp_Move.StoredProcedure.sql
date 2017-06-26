USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_Move]    Script Date: 6/26/2017 3:06:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Move]
	@Username varchar(50),
	@X int,
	@Y int, 
	@GameID int
AS
	DECLARE @UserID as int;
	SET @UserID = (Select UserID From Accounts Where Username = @Username);

	DECLARE @BoardID as int;
	SET @BoardID = (Select BoardID From Boards Where GameID = @GameID);

	DECLARE @HostID as int;
	SET @HostID =  (SELECT HostID From Boards Where @BoardID = BoardID);

	DECLARE @JoinerID as int;
	SET @JoinerID =  (SELECT JoinerID From Boards Where @BoardID = BoardID);

	DECLARE @CurrentTurn as int;
	SET @CurrentTurn = (SELECT CurrentTurn From Boards where @BoardID = BoardID);

	IF(@HostID = @UserID AND @UserID = @CurrentTurn)
	BEGIN
		If EXISTS(SELECT * FROM CELLS WHERE BoardID = @BoardID AND @X = X AND @Y = Y AND UserID = @JoinerID)
		BEGIN
			 INSERT INTO Moves (BoardID, UserID, LocationX, LocationY, Result) VALUES (@BoardID, @UserID, @X, @Y, 'Hit');
			 RETURN 1;
		END
		ELSE 
		BEGIN
			INSERT INTO Moves (BoardID, UserID, LocationX, LocationY, Result) VALUES (@BoardID, @UserID, @X, @Y, 'Miss');
			 RETURN 1; 
		END
	END

GO
