USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_StartGame]    Script Date: 6/29/2017 3:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE Procedure [dbo].[usp_StartGame]
@UserName varchar(50),
@state	  uniqueidentifier
AS
DECLARE @R as varchar(100);
SET @R = 0;
	IF ((Select state From Accounts where Username = @Username)= @state)
	Begin
		DECLARE @TempID as int;
		SET @TEMPID = (SELECT UserID From Accounts Where Username = @Username);
		IF NOT EXISTS(Select GUID From Rooms Where JoinerID Is NULL AND @TempID != HostID)
		BEGIN
			INSERT INTO Rooms (GUID, HostID, CreationDate) Values (NEWID(), @TempID, GETDATE());
			SET @R = 1;
		END
		ELSE
		BEGIN
			DECLARE @HostID as int;
			SET @HostID = (Select Top 1 HostID From Rooms Where JoinerID IS NULL Order by HostID desc);
			DECLARE @RoomID as int;
			SET @RoomID = (Select Top 1 RoomID From Rooms Where JoinerID IS Null AND HostID = @HostID Order by RoomID desc);
			UPDATE Rooms SET JoinerID = @TempID Where @RoomID = RoomID;
			INSERT INTO Games (HostID,JoinerID,Status) Values(@HostID, @TempID, 'playing');
			Declare @GameID as int;
			Set @GameID = (SELECT Top 1 GameID From Games Where HostID = @HostID AND @TempID = JoinerID Order by GameID desc);
			Insert INTO Boards(GameID,CurrentTurn, HostID, JoinerID) Values(@GameID, @HostID, @HostID, @TempID);

			DECLARE @BoardID int
			SET @BoardID = (SELECT BoardID FROM Boards Where GameID = @GameID);

			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 2, @HostID, 'Submarine');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 2, @TempID, 'Submarine');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 3, @HostID, 'Cruiser');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 3, @TempID, 'Cruiser');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 4, @HostID, 'Battleship');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 4, @TempID, 'Battleship');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 5, @HostID, 'Aircraft');
			INSERT INTO Ships (BoardID, ShipLength, UserID, ShipName) Values(@BoardID, 5, @TempID, 'Aircraft');

			SET @R = 1;

		END
		
	End

	SELECT @R;










GO
