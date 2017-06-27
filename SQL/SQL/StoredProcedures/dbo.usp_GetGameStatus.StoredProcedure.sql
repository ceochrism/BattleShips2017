USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetGameStatus]    Script Date: 6/27/2017 2:17:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_GetGameStatus]
	@GameID int
AS
	CREATE TABLE #TempTable(
		BoardID int,
		HostID int,
		JoinerID int,
		CurrentTurn int,
		HostHitAmount int,
		JoinerHitAmount int,
		isGameFinished bit,
		WinnerName varchar(50),
		HostShipsPlaced int,
		JoinerShipsPlaced int
		)
	Insert INTO #TempTable (BoardID,HostID,JoinerID,CurrentTurn, HostHitAmount, JoinerHitAmount, isGameFinished,WinnerName, HostShipsPlaced, JoinerShipsPlaced) 
	Select BoardID,HostID,JoinerID, CurrentTurn, HostHitAmount, JoinerHitAmount,isGameFinished,WinnerName, HostShipsPlaced, JoinerShipsPlaced From Boards Where GameID =@GameID;

	DECLARE @WinnerName As varchar(50);

	IF ((Select HostHitAmount From #TempTable) = 14 AND (SELECT isGameFinished From #TempTable) = 0)
	Begin
		
		SET @WinnerName = (SELECT Username From Accounts Where UserID = (SELECT HostID FROM #TempTable));
		
		UPDATE Boards SET  WinnerName = @WinnerName , isGameFinished = 1 Where BoardID = (Select BoardID From #TempTable);

		Return 'The Winner of the Game Is ' + @WinnerName + '!';
	END
	IF ((Select JoinerHitAmount From #TempTable) = 14 AND (SELECT isGameFinished From #TempTable) = 0)
	Begin
		
		SET @WinnerName = (SELECT Username From Accounts Where UserID = (SELECT JoinerID FROM #TempTable));
		
		UPDATE Boards SET  WinnerName = @WinnerName , isGameFinished = 1 Where BoardID = (Select BoardID From #TempTable);

		Return 'The Winner of the Game Is ' + @WinnerName + '!';
	END

	IF((SELECT isGameFinished From #TempTable) = 1)
	BEGIN
		Return 'This Game is Over and ' + (Select WinnerName From #TempTable);
	End

	IF((SELECT isGameFinished From #TempTable) = 0)
	BEGIN
		IF((SELECT HostShipsPlaced From #TempTable) != 4 AND (Select JoinerShipsPlaced From #TempTable) != 4)
		BEGIN
			RETURN 'Game is still in ship select phase... Please Wait...';
		END
		RETURN SELECT * FROM Moves Where BoardID = (SELECT BoardID From #TempTable);
	END


	RETURN 'Game Not Found...'

GO