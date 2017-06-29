USE [ChrisMansourianBattleships2017]
GO
/****** Object:  Table [dbo].[Cells]    Script Date: 6/29/2017 3:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cells](
	[CellID] [int] IDENTITY(1,1) NOT NULL,
	[BoardID] [int] NOT NULL,
	[ContainsShip] [bit] NOT NULL,
	[X] [int] NOT NULL,
	[Y] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ShipLength] [int] NOT NULL,
	[AlreadyHit] [bit] NOT NULL,
 CONSTRAINT [PK_Cells] PRIMARY KEY CLUSTERED 
(
	[CellID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Cells] ADD  CONSTRAINT [DF_Cells_AlreadyHit]  DEFAULT ((0)) FOR [AlreadyHit]
GO
ALTER TABLE [dbo].[Cells]  WITH CHECK ADD  CONSTRAINT [FK_Cells_Boards] FOREIGN KEY([BoardID])
REFERENCES [dbo].[Boards] ([BoardID])
GO
ALTER TABLE [dbo].[Cells] CHECK CONSTRAINT [FK_Cells_Boards]
GO
