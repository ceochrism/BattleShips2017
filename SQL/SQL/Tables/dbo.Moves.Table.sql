USE [ChrisMansourianBattleships2017]
GO
/****** Object:  Table [dbo].[Moves]    Script Date: 6/27/2017 2:17:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Moves](
	[MoveID] [int] NOT NULL,
	[BoardID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[LocationX] [int] NOT NULL,
	[LocationY] [int] NOT NULL,
	[Result] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Moves] PRIMARY KEY CLUSTERED 
(
	[MoveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Moves]  WITH CHECK ADD  CONSTRAINT [FK_Moves_Boards] FOREIGN KEY([BoardID])
REFERENCES [dbo].[Boards] ([BoardID])
GO
ALTER TABLE [dbo].[Moves] CHECK CONSTRAINT [FK_Moves_Boards]
GO
