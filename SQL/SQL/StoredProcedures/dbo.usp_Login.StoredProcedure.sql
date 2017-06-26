USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 6/26/2017 3:06:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Login]
	@Username varchar(50),
	@Password varchar(64),
	@State	varchar(50)
AS
	If Exists(Select Username From Accounts Where Username = @Username AND Password = @Password)
	Begin
		UPDATE Accounts SET state = @State;
		return 1
	End
	Else
	Begin
		return 0;
	End


GO
