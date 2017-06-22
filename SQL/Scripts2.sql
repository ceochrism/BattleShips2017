USE [master]
GO
/****** Object:  Database [ChrisMansourianBattleships2017]    Script Date: 6/22/2017 2:14:53 PM ******/
CREATE DATABASE [ChrisMansourianBattleships2017]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ChrisMansourianBattleships2017', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ChrisMansourianBattleships2017.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ChrisMansourianBattleships2017_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ChrisMansourianBattleships2017_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ChrisMansourianBattleships2017].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET ARITHABORT OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET  MULTI_USER 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ChrisMansourianBattleships2017]
GO
/****** Object:  User [ChrisMansourian]    Script Date: 6/22/2017 2:14:53 PM ******/
CREATE USER [ChrisMansourian] FOR LOGIN [ChrisMansourian] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [AaronOpell]    Script Date: 6/22/2017 2:14:53 PM ******/
CREATE USER [AaronOpell] FOR LOGIN [AaronOpell] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ChrisMansourian]
GO
ALTER ROLE [db_datareader] ADD MEMBER [AaronOpell]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 6/22/2017 2:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[UserID] [int] NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[state] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Games]    Script Date: 6/22/2017 2:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Games](
	[GameID] [int] NOT NULL,
	[HostID] [int] NOT NULL,
	[JoinerID] [int] NOT NULL,
 CONSTRAINT [PK_Game] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 6/22/2017 2:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[RoomID] [int] NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[HostID] [int] NOT NULL,
	[JoinerID] [int] NOT NULL,
	[State] [varchar](50) NOT NULL,
	[HostReady] [bit] NOT NULL,
	[JoinReady] [bit] NOT NULL,
	[CreationDate] [nchar](10) NULL,
 CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Accounts]    Script Date: 6/22/2017 2:14:53 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Accounts] ON [dbo].[Accounts]
(
	[UserID] ASC,
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Rooms]  WITH CHECK ADD  CONSTRAINT [FK_Rooms_Accounts] FOREIGN KEY([JoinerID])
REFERENCES [dbo].[Accounts] ([UserID])
GO
ALTER TABLE [dbo].[Rooms] CHECK CONSTRAINT [FK_Rooms_Accounts]
GO
ALTER TABLE [dbo].[Rooms]  WITH CHECK ADD  CONSTRAINT [FK_Rooms_Accounts1] FOREIGN KEY([HostID])
REFERENCES [dbo].[Accounts] ([UserID])
GO
ALTER TABLE [dbo].[Rooms] CHECK CONSTRAINT [FK_Rooms_Accounts1]
GO
USE [master]
GO
ALTER DATABASE [ChrisMansourianBattleships2017] SET  READ_WRITE 
GO
