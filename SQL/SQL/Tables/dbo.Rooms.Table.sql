USE [ChrisMansourianBattleships2017]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 6/28/2017 2:59:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[HostID] [int] NOT NULL,
	[JoinerID] [int] NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Rooms] ADD  CONSTRAINT [DF_Rooms_JoinerID]  DEFAULT (NULL) FOR [JoinerID]
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
