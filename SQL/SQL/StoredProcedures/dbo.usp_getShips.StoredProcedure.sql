USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_getShips]    Script Date: 6/30/2017 3:07:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_getShips]
	@UserName varchar(50),
	@GameID	int
AS
	DECLARE @UserID as int;
	SET @UserID = (SELECT UserID From Accounts Where Username = @UserName);

	DECLARE @BoardID as int;
	SET @BoardID = (Select BoardID From Boards Where GameID = @GameID);

	SELECT X,Y From Cells Where @BoardID = BoardID AND UserID = @UserID;

GO
