USE [ChrisMansourianBattleships2017]
GO
/****** Object:  Table [dbo].[Boards]    Script Date: 6/28/2017 2:59:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Boards](
	[BoardID] [int] IDENTITY(1,1) NOT NULL,
	[GameID] [int] NOT NULL,
	[CurrentTurn] [int] NOT NULL,
	[HostID] [int] NOT NULL,
	[JoinerID] [int] NOT NULL,
	[HostShipsPlaced] [int] NOT NULL,
	[JoinerShipsPlaced] [int] NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[HostHitAmount] [int] NOT NULL,
	[JoinerHitAmount] [int] NOT NULL,
	[isGameFinished] [bit] NOT NULL,
	[WinnerName] [varchar](50) NULL,
 CONSTRAINT [PK_Boards] PRIMARY KEY CLUSTERED 
(
	[BoardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Boards] ADD  CONSTRAINT [DF_Boards_HostShipsPlaced]  DEFAULT ((0)) FOR [HostShipsPlaced]
GO
ALTER TABLE [dbo].[Boards] ADD  CONSTRAINT [DF_Boards_JoinerShipsPlaced]  DEFAULT ((0)) FOR [JoinerShipsPlaced]
GO
ALTER TABLE [dbo].[Boards] ADD  CONSTRAINT [DF_Boards_Status]  DEFAULT ('placing') FOR [Status]
GO
ALTER TABLE [dbo].[Boards] ADD  CONSTRAINT [DF_Boards_HostHitAmount]  DEFAULT ((0)) FOR [HostHitAmount]
GO
ALTER TABLE [dbo].[Boards] ADD  CONSTRAINT [DF_Boards_JoinerHitAmount]  DEFAULT ((0)) FOR [JoinerHitAmount]
GO
ALTER TABLE [dbo].[Boards] ADD  CONSTRAINT [DF_Boards_isGameFinished]  DEFAULT ((0)) FOR [isGameFinished]
GO
ALTER TABLE [dbo].[Boards]  WITH CHECK ADD  CONSTRAINT [FK_Boards_Games] FOREIGN KEY([GameID])
REFERENCES [dbo].[Games] ([GameID])
GO
ALTER TABLE [dbo].[Boards] CHECK CONSTRAINT [FK_Boards_Games]
GO
