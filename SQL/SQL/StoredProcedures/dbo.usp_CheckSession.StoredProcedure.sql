USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckSession]    Script Date: 6/30/2017 3:07:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CheckSession]
	@Username varchar(100),
	@status uniqueidentifier
AS
	SELECT	GUID 
	From	Accounts 
	Where	@Username = Username 
	AND		@status = state
GO
