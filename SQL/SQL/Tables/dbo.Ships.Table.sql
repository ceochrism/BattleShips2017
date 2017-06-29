USE [ChrisMansourianBattleships2017]
GO
/****** Object:  Table [dbo].[Ships]    Script Date: 6/29/2017 3:21:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ships](
	[BoardID] [int] NOT NULL,
	[ShipLength] [int] NOT NULL,
	[StartX] [int] NULL,
	[StartY] [int] NULL,
	[UserID] [int] NOT NULL,
	[ShipName] [varchar](50) NOT NULL,
	[ShipStatus] [varchar](50) NULL,
	[Orientation] [int] NULL,
	[ShipID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Ships_1] PRIMARY KEY CLUSTERED 
(
	[ShipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Ships]  WITH CHECK ADD  CONSTRAINT [FK_Ships_Boards] FOREIGN KEY([BoardID])
REFERENCES [dbo].[Boards] ([BoardID])
GO
ALTER TABLE [dbo].[Ships] CHECK CONSTRAINT [FK_Ships_Boards]
GO
