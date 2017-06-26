USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_SignUp]    Script Date: 6/26/2017 3:06:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_SignUp]
	@UserName varchar(50),
	@Password varchar(64),
	@Email    varchar(50)
AS
	IF NOT EXISTS(Select * From Accounts Where Username = @UserName)
	BEGIN
		INSERT INTO Accounts (GUID, Username, Password, Email)
		Values (NEWID(), @UserName, @Password, @Email);
		Return 1;
	END
	ELSE
	BEGIN
		Return 0;
	END


GO
