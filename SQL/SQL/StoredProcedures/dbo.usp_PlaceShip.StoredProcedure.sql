USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_PlaceShip]    Script Date: 6/30/2017 3:07:19 PM ******/
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
	@state uniqueidentifier
As
	DECLARE @R as int;
	SET @R = 0;
	
	DECLARE @UserID as int;
	SET @UserID = (Select UserID From Accounts Where Username = @Username);

	DECLARE @BoardID as int;
	SET @BoardID = (Select BoardID From Boards Where GameID = @GameID);

	DECLARE @HostID as int;
	SET @HostID = (Select HostID From Boards Where GameID = @GameID);

	DECLARE @JoinerID as int;
	SET @JoinerID = (Select JoinerID From Boards Where GameID = @GameID);

	DECLARE @HostShipsPlaced AS int;
	SET @HostShipsPlaced = (Select HostShipsPlaced From Boards Where BoardID = @BoardID);

	DECLARE @JoinerShipsPlaced AS int;
	SET @JoinerShipsPlaced = (Select JoinerShipsPlaced From Boards Where BoardID = @BoardID);

	IF ((Select state From Accounts where Username = @Username)= @state)
	Begin
	IF EXISTS(SELECT * FROM Ships Where @UserID = UserID AND ShipLength = @ShipLength AND BoardID = @BoardID)
	BEGIN
	
			IF((SELECT StartX From Ships Where @UserID = UserID AND @BoardID = BoardID) IS NOT NULL)
			BEGIN 
				RETURN
			END


		IF(@HostID = @UserID AND @HostShipsPlaced < 4)
		BEGIN
		
		
		IF (@Orientation = 1 AND @StartY < 10 AND @StartY > 0 AND @StartX > 0 AND (@StartX + @ShipLength) < 10)
		BEGIN
			DECLARE @Counter As int;
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE Y = @StartY AND X = (@StartX + @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					SET @R=0;
					RETURN;
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
			SET @R = 1;
			SELECT @R;
			RETURN;
		END



		IF (@Orientation = 2 AND @StartY < 10 AND @StartY > 0 AND @StartX < 10 AND (@StartX - @ShipLength) > 0)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE Y = @StartY AND X = (@StartX - @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					SET @R=0;
					RETURN;
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
			SET @R = 1;
			SELECT @R;
			RETURN;
		END


		IF (@Orientation = 3 AND @StartX < 10 AND @StartX > 0 AND @StartY < 10 AND (@StartY - @ShipLength) > 0)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE X = @StartX AND Y = (@StartY - @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					SET @R=0;
					RETURN;
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
			SET @R = 1;
			SELECT @R;
			RETURN;
		END


		IF (@Orientation = 4 AND @StartX < 10 AND @StartX > 0 AND @StartY > 0 AND (@StartY + @ShipLength) < 10)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE X = @StartY AND Y = (@StartY + @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					SET @R=0;
					RETURN;
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
			SET @R = 1;
			SELECT @R;
			RETURN;
		END
		END





		IF(@JoinerID = @UserID AND @JoinerShipsPlaced < 4)
		BEGIN
		IF (@Orientation = 1 AND @StartY < 10 AND @StartY > 0 AND @StartX > 0 AND (@StartX + @ShipLength) < 10)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE Y = @StartY AND X = (@StartX + @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					SET @R=0;
					RETURN;
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
			SET @R = 1;
			SELECT @R;
			RETURN;
		END



		IF (@Orientation = 2 AND @StartY < 10 AND @StartY > 0 AND @StartX < 10 AND (@StartX - @ShipLength) > 0)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE Y = @StartY AND X = (@StartX - @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					SET @R=0;
					RETURN;
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
			SET @R =1;
			SELECT @R;
			RETURN;
		END


		IF (@Orientation = 3 AND @StartX < 10 AND @StartX > 0 AND @StartY < 10 AND (@StartY - @ShipLength) > 0)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE X = @StartX AND Y = (@StartY - @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					SET @R=0;
					RETURN;
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
			SET @R = 1;
			SELECT @R;
			RETURN;
		END


		IF (@Orientation = 4 AND @StartX < 10 AND @StartX > 0 AND @StartY > 0 AND (@StartY + @ShipLength) < 10)
		BEGIN
			Set @Counter = 0;
			WHILE (@Counter < @ShipLength)
			BEGIN
				IF EXISTS (SELECT CellID From Cells WHERE X = @StartY AND Y = (@StartY + @Counter) AND UserID = @UserID AND BoardID = @BoardID)
				BEGIN
					SET @R=0;
					RETURN;
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
			SET @R = 1;
			SELECT @R;
			RETURN;
		END
		END
		END
	END
	--SELECT @R;









GO
