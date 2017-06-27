USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_PlaceShip]    Script Date: 6/27/2017 2:17:39 PM ******/
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
	@ShipLength int,
	@state varchar(50)
As
	DECLARE @UserID as int;
	SET @UserID = (Select UserID From Accounts Where Username = @Username);

	DECLARE @BoardID as int;
	SET @BoardID = (Select BoardID From Boards Where GameID = @GameID);

	DECLARE @HostID as int;
	SET @HostID = (Select HostID From Boards Where GameID = @GameID);

	DECLARE @JoinerID as int;
	SET @HostID = (Select JoinerID From Boards Where GameID = @GameID);

	IF ((Select state From Accounts where Username = Username)= @state)
	Begin
	IF EXISTS(SELECT * FROM Ships Where @UserID = UserID AND ShipLength = @ShipLength)
	BEGIN
		IF(@HostID = @UserID AND (Select HostShipsPlaced From Boards Where BoardID = @BoardID) < 4)
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
				INSERT INTO Cells (BoardID, ContainsShip, X, Y, UserID, ShipLength) VALUES (@BoardID, 1, @StartX + @Counter, @StartY, @UserID, @ShipLength);
				
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
				INSERT INTO Cells (BoardID, ContainsShip, X, Y, UserID, ShipLength) VALUES (@BoardID, 1, @StartX - @Counter, @StartY, @UserID, @ShipLength);
				
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
				INSERT INTO Cells (BoardID, ContainsShip, Y, X, UserID, ShipLength) VALUES (@BoardID, 1, @StartY - @Counter, @StartX, @UserID, @ShipLength);
				
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
				INSERT INTO Cells (BoardID, ContainsShip, Y, X, UserID, ShipLength) VALUES (@BoardID, 1, @StartY + @Counter, @StartX, @UserID, @ShipLength);
				
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





		IF(@JoinerID = @UserID AND (Select JoinerShipsPlaced From Boards Where BoardID = @BoardID) < 4)
		BEGIN
		IF (@Orientation = 1 AND @StartY < 10 AND @StartY > 0 AND @StartX > 0 AND (@StartX + @ShipLength) < 10)
		BEGIN
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
				INSERT INTO Cells (BoardID, ContainsShip, X, Y, UserID, ShipLength) VALUES (@BoardID, 1, @StartX + @Counter, @StartY, @UserID, @ShipLength);
				
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
				INSERT INTO Cells (BoardID, ContainsShip, X, Y, UserID, ShipLength) VALUES (@BoardID, 1, @StartX - @Counter, @StartY, @UserID, @ShipLength);
				
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
				INSERT INTO Cells (BoardID, ContainsShip, Y, X, UserID, ShipLength) VALUES (@BoardID, 1, @StartY - @Counter, @StartX, @UserID, @ShipLength);
				
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
				INSERT INTO Cells (BoardID, ContainsShip, Y, X, UserID, ShipLength) VALUES (@BoardID, 1, @StartY + @Counter, @StartX, @UserID, @ShipLength);
				
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
		END
	END
	RETURN 0;



GO
