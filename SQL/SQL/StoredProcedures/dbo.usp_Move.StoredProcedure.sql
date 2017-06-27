USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_Move]    Script Date: 6/27/2017 2:17:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_Move]
	@Username varchar(50),
	@X int,
	@Y int, 
	@GameID int,
	@state varchar(50)
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

	DECLARE @HostShipsPlaced as int;
	SET @HostShipsPlaced = (Select HostShipsPlaced From Boards where @BoardID = BoardID);

	DECLARE @JoinerShipsPlaced as int;
	SET @JoinerShipsPlaced = (Select HostShipsPlaced From Boards where @BoardID = BoardID);


	IF ((Select state From Accounts where Username = Username)= @state)
	Begin
	IF((SELECT isGameFinished From Boards Where BoardID = @BoardID) = 0 AND @JoinerShipsPlaced = 4 AND @HostShipsPlaced = 4)
	BEGIN
		IF(@HostID = @UserID AND @UserID = @CurrentTurn)
		BEGIN
			If EXISTS(SELECT * FROM CELLS WHERE BoardID = @BoardID AND @X = X AND @Y = Y AND UserID = @JoinerID AND AlreadyHit = 0)
			BEGIN
				INSERT INTO Moves (BoardID, UserID, LocationX, LocationY, Result) VALUES (@BoardID, @UserID, @X, @Y, 'Hit');
				UPDATE Boards SET HostHitAmount = (HostHitAmount + 1) , CurrentTurn = @JoinerID Where BoardID = @BoardID;
				Update Cells SET AlreadyHit = 1 Where @BoardID = BoardID AND @X = X AND @Y = Y AND UserID = @JoinerID;
				RETURN 'You have hit the ' + (Select ShipLength From Cells Where @BoardID = BoardID AND UserID = @JoinerID) + ' length ship!'
			END
			ELSE 
			BEGIN
				If EXISTS (SELECT * From Moves Where @BoardID = BoardID AND UserID = @UserID AND @X = LocationX AND @Y = LocationY)
				Begin
					Return '0'
				End
				INSERT INTO Moves (BoardID, UserID, LocationX, LocationY, Result) VALUES (@BoardID, @UserID, @X, @Y, 'Miss');
				UPDATE Boards SET CurrentTurn = @JoinerID Where BoardID = @BoardID;
				 RETURN 'Miss'; 
			END
		END

		IF(@JoinerID = @UserID AND @JoinerID = @CurrentTurn)
		BEGIN
			If EXISTS(SELECT * FROM CELLS WHERE BoardID = @BoardID AND @X = X AND @Y = Y AND UserID = @HostID AND AlreadyHit = 0)
			BEGIN
				INSERT INTO Moves (BoardID, UserID, LocationX, LocationY, Result) VALUES (@BoardID, @UserID, @X, @Y, 'Hit');
				UPDATE Boards SET JoinerHitAmount = (JoinerHitAmount + 1) , CurrentTurn = @HostID Where BoardID = @BoardID;				
				Update Cells SET AlreadyHit = 1 Where @BoardID = BoardID AND @X = X AND @Y = Y AND UserID = @HostID;
				RETURN 'You have hit the ' + (Select ShipLength From Cells Where @BoardID = BoardID AND UserID = @HostID) + ' length ship!'
			END
			ELSE 
			BEGIN
				If EXISTS (SELECT * From Moves Where @BoardID = BoardID AND UserID = @UserID AND @X = LocationX AND @Y = LocationY)
				Begin
					Return '0'
				End
				INSERT INTO Moves (BoardID, UserID, LocationX, LocationY, Result) VALUES (@BoardID, @UserID, @X, @Y, 'Miss');
				UPDATE Boards SET CurrentTurn = @HostID Where BoardID = @BoardID;
				 RETURN 'Miss'; 
			END
		END
		RETURN '0';
	END
	END





GO
