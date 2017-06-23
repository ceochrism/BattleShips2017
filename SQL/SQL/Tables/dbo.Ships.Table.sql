USE [ChrisMansourianBattleships2017]
GO
/****** Object:  Table [dbo].[Ships]    Script Date: 6/23/2017 1:35:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ships](
	[BoardID] [int] NOT NULL,
	[ShipLength] [int] NOT NULL,
	[ShipStatus] [varchar](20) NOT NULL,
	[LocationX] [varchar](50) NOT NULL,
	[LocationY] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Ships] PRIMARY KEY CLUSTERED 
(
	[BoardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Ships]  WITH CHECK ADD  CONSTRAINT [FK_Ships_Boards] FOREIGN KEY([BoardID])
REFERENCES [dbo].[Boards] ([BoardID])
GO
ALTER TABLE [dbo].[Ships] CHECK CONSTRAINT [FK_Ships_Boards]
GO
