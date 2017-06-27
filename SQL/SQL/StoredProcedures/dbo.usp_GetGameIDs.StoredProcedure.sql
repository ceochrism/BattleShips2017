USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetGameIDs]    Script Date: 6/27/2017 2:17:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetGameIDs]
	@Username varchar(50)
AS
	DECLARE @UserID as int;
	SET @UserID = (Select UserID From Accounts Where @Username = Username);

	RETURN SELECT GameID From Boards Where (@UserID = HostID AND isGameFinished = 0) OR (@UserID = JoinerID AND isGameFinished = 0);
GO
