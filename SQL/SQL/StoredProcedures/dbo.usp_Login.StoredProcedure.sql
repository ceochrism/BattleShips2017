USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 6/28/2017 2:59:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_Login]
	@Username varchar(50),
	@Password varchar(64)
AS
	UPDATE	Accounts
	SET		state		=	NEWID()
	WHERE	Username	=	@Username
	AND		Password	=	@Password	

	SELECT	Username
	,		State
	FROM	Accounts
	WHERE	Username	=	@Username
	AND		Password	=	@Password




GO
