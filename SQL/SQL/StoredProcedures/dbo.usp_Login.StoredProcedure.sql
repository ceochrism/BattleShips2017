USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 6/27/2017 2:17:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_Login]
	@Username varchar(50),
	@Password varchar(64)
AS
	If Exists(Select Username From Accounts Where Username = @Username AND Password = @Password)
	Begin
		UPDATE Accounts SET state = NewID();
		return (Select state From Accounts Where Username = @Username AND Password = @Password);
	End
	Else
	Begin
		return 0;
	End



GO
