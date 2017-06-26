USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_PlaceShip]    Script Date: 6/26/2017 3:06:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[usp_PlaceShip]
	@GameID int,
	@Username varchar(50),
	@StartX int,
	@StartY int,
	@Orientation int,
	@ShipLength int
As
	DECLARE @UserID as int;
	SET @UserID = (Select UserID From Accounts Where Username = @Username);

	DECLARE @BoardID as int;
	SET @BoardID = (Select BoardID From Boards Where GameID = @GameID);

	IF EXISTS(SELECT * FROM Ships Where @UserID = UserID AND ShipLength = @ShipLength)
	BEGIN
		IF (@Orientation = 1 AND @StartY < 10 AND @StartY > 0 AND @StartX > 0 AND (@StartX + @ShipLength) < 10)
		BEGIN
			DECLARE @Counter As int;
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE Y = @StartY AND X = (@StartX + @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					Return 0;
				END
				SET @Counter = @Counter + 1;
			End

			Set @Counter = 0;
			While(@Counter<@ShipLength)
			BEGIN
				INSERT INTO Cells (BoardID, ContainsShip, X, Y, UserID) VALUES (@BoardID, 1, @StartX + @Counter, @StartY, @UserID);
				
				SET @Counter = @Counter + 1;
			END
			UPDATE Ships 
			SET StartX = @StartX  ,
			StartY = @StartY , 
			Orientation = @Orientation 
			Where ShipLength = @ShipLength AND BoardID = @BoardID AND UserID = @UserID;

			IF(@UserID = (SELECT HostID From Boards Where BoardID = @BoardID))
			Begin
				UPDATE Boards SET HostShipsPlaced = HostShipsPlaced + 1 Where BoardID = @BoardID;
			END
			Else
			BEGIN
				UPDATE Boards SET JoinerShipsPlaced = JoinerShipsPlaced + 1 Where BoardID = @BoardID;
			END
			RETURN 1;
		END



		IF (@Orientation = 2 AND @StartY < 10 AND @StartY > 0 AND @StartX < 10 AND (@StartX - @ShipLength) > 0)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE Y = @StartY AND X = (@StartX - @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					Return 0;
				END
				SET @Counter = @Counter + 1;
			End

			Set @Counter = 0;
			While(@Counter<@ShipLength)
			BEGIN
				INSERT INTO Cells (BoardID, ContainsShip, X, Y, UserID) VALUES (@BoardID, 1, @StartX - @Counter, @StartY, @UserID);
				
				SET @Counter = @Counter + 1;
			END
			UPDATE Ships 
			SET StartX = @StartX  ,
			StartY = @StartY , 
			Orientation = @Orientation 
			Where ShipLength = @ShipLength AND BoardID = @BoardID AND UserID = @UserID;

			IF(@UserID = (SELECT HostID From Boards Where BoardID = @BoardID))
			Begin
				UPDATE Boards SET HostShipsPlaced = HostShipsPlaced + 1 Where BoardID = @BoardID;
			END
			Else
			BEGIN
				UPDATE Boards SET JoinerShipsPlaced = JoinerShipsPlaced + 1 Where BoardID = @BoardID;
			END
			RETURN 1;
		END


		IF (@Orientation = 3 AND @StartX < 10 AND @StartX > 0 AND @StartY < 10 AND (@StartY - @ShipLength) > 0)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE X = @StartX AND Y = (@StartY - @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					Return 0;
				END
				SET @Counter = @Counter + 1;
			End

			Set @Counter = 0;
			While(@Counter<@ShipLength)
			BEGIN
				INSERT INTO Cells (BoardID, ContainsShip, Y, X, UserID) VALUES (@BoardID, 1, @StartY - @Counter, @StartX, @UserID);
				
				SET @Counter = @Counter + 1;
			END
			UPDATE Ships 
			SET StartX = @StartX  ,
			StartY = @StartY , 
			Orientation = @Orientation 
			Where ShipLength = @ShipLength AND BoardID = @BoardID AND UserID = @UserID;

			IF(@UserID = (SELECT HostID From Boards Where BoardID = @BoardID))
			Begin
				UPDATE Boards SET HostShipsPlaced = HostShipsPlaced + 1 Where BoardID = @BoardID;
			END
			Else
			BEGIN
				UPDATE Boards SET JoinerShipsPlaced = JoinerShipsPlaced + 1 Where BoardID = @BoardID;
			END
			RETURN 1;
		END


		IF (@Orientation = 4 AND @StartX < 10 AND @StartX > 0 AND @StartY > 0 AND (@StartY + @ShipLength) < 10)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE X = @StartY AND Y = (@StartY + @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					Return 0;
				END
				SET @Counter = @Counter + 1;
			End

			Set @Counter = 0;
			While(@Counter<@ShipLength)
			BEGIN
				INSERT INTO Cells (BoardID, ContainsShip, Y, X, UserID) VALUES (@BoardID, 1, @StartY + @Counter, @StartX, @UserID);
				
				SET @Counter = @Counter + 1;
			END
			UPDATE Ships 
			SET StartX = @StartX  ,
			StartY = @StartY , 
			Orientation = @Orientation 
			Where ShipLength = @ShipLength AND BoardID = @BoardID AND UserID = @UserID;

			IF(@UserID = (SELECT HostID From Boards Where BoardID = @BoardID))
			Begin
				UPDATE Boards SET HostShipsPlaced = HostShipsPlaced + 1 Where BoardID = @BoardID;
			END
			Else
			BEGIN
				UPDATE Boards SET JoinerShipsPlaced = JoinerShipsPlaced + 1 Where BoardID = @BoardID;
			END
			RETURN 1;
		END
	END
	RETURN 0;
GO
