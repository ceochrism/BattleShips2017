USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_StartGame]    Script Date: 6/26/2017 3:06:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[usp_StartGame]
@UserName varchar(50),
@state	  varchar(50)
AS
	IF ((Select state From Accounts where Username = Username)= @state)
	Begin
		DECLARE @TempID as int;
		SET @TEMPID = (SELECT UserID From Accounts Where Username = Username);
		IF NOT EXISTS(Select GUID From Rooms Where JoinerID = NULL)
		BEGIN
			INSERT INTO Rooms (GUID, HostID, CreationDate) Values (NEWID(), @TempID, GETDATE());
			RETURN 1;
		END
		ELSE
		BEGIN
			DECLARE @HostID as int;
			SET @HostID = (Select HostID From Rooms Where JoinerID = NULL);
			UPDATE Rooms SET JoinerID = @TempID Where JoinerID = NULL AND @HostID = HostID;
			INSERT INTO Games (HostID,JoinerID,Status) Values(@HostID, @TempID, 'playing');
			Declare @GameID as int;
			Set @GameID = IDENT_CURRENT('Games');
			Insert INTO Boards(GameID,CurrentTurn, HostID, JoinerID) Values(@GameID, @HostID, @HostID, @TempID);

			DECLARE @BoardID int
			SET @BoardID = (SELECT TOP 1 HostID FROM Boards Where GameID = @GameID);

			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 2, @HostID, 'Submarine');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 2, @TempID, 'Submarine');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 3, @HostID, 'Cruiser');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 3, @TempID, 'Cruiser');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 4, @HostID, 'Battleship');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 4, @TempID, 'Battleship');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 5, @HostID, 'Aircraft');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 5, @HostID, 'Aircraft');

			Return 1;

		END
		
	End

	Return 0;


GO
