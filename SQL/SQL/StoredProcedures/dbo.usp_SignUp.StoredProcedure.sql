USE [ChrisMansourianBattleships2017]
GO
/****** Object:  StoredProcedure [dbo].[usp_SignUp]    Script Date: 6/29/2017 3:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_SignUp]
	@UserName varchar(50),
	@Password varchar(64),
	@Email    varchar(50)
AS
DECLARE @R as varchar(100);
SET @R = 0;
	IF NOT EXISTS(Select * From Accounts Where Username = @UserName)
	BEGIN
		INSERT INTO Accounts (GUID, Username, Password, Email)
		Values (NEWID(), @UserName, @Password, @Email);
		SET @R = 1;
	END
	ELSE
	BEGIN
		SET @R = 0;
	END

	SELECT @R;

GO
