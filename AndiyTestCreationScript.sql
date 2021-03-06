USE [AndriyTest]
GO
/****** Object:  Table [dbo].[BlackList]    Script Date: 09/06/2013 00:25:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BlackList](
	[CompanyCode] [varchar](6) NOT NULL,
	[ExpireMessage] [varchar](256) NOT NULL,
 CONSTRAINT [PK_BlackList] PRIMARY KEY CLUSTERED 
(
	[CompanyCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Company]    Script Date: 09/06/2013 00:25:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Company](
	[CompanyIndex] [int] NOT NULL,
	[CompanyCode] [varchar](6) NOT NULL,
	[CompanyName] [varchar](64) NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Company] UNIQUE NONCLUSTERED 
(
	[CompanyCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SettUser]    Script Date: 09/06/2013 00:25:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SettUser](
	[SettIndex] [int] NOT NULL,
	[CompanyCode] [varchar](6) NULL,
	[UserName] [varchar](10) NULL,
	[IPAddress] [varchar](50) NULL,
	[LastLogonDate] [date] NULL,
 CONSTRAINT [PK_SettUser] PRIMARY KEY CLUSTERED 
(
	[SettIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CompanyDetails]    Script Date: 09/06/2013 00:25:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CompanyDetails](
	[ComanyCode] [varchar](6) NOT NULL,
	[OpenedThisYear] [int] NULL,
	[SettledThisYear] [int] NULL,
	[LastUpdated] [date] NULL,
	[CurrentVersion] [int] NULL,
 CONSTRAINT [PK_CompanyDetails] PRIMARY KEY CLUSTERED 
(
	[ComanyCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AppExpiry]    Script Date: 09/06/2013 00:25:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AppExpiry](
	[CompanyCode] [varchar](6) NOT NULL,
	[AppIndex] [int] NULL,
	[LUCheckDate] [date] NULL,
	[TerminateDate] [date] NULL,
	[ExpiryDate] [date] NULL,
	[BuildVersion] [int] NULL,
	[Message] [varchar](256) NULL,
 CONSTRAINT [PK_AppExpiry] PRIMARY KEY CLUSTERED 
(
	[CompanyCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_AppExpiry] UNIQUE NONCLUSTERED 
(
	[AppIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK_Company_BlackList]    Script Date: 09/06/2013 00:25:38 ******/
ALTER TABLE [dbo].[Company]  WITH NOCHECK ADD  CONSTRAINT [FK_Company_BlackList] FOREIGN KEY([CompanyCode])
REFERENCES [dbo].[BlackList] ([CompanyCode])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_BlackList]
GO
/****** Object:  ForeignKey [FK_AppExpiry_Company]    Script Date: 09/06/2013 00:25:38 ******/
ALTER TABLE [dbo].[AppExpiry]  WITH CHECK ADD  CONSTRAINT [FK_AppExpiry_Company] FOREIGN KEY([CompanyCode])
REFERENCES [dbo].[Company] ([CompanyCode])
GO
ALTER TABLE [dbo].[AppExpiry] CHECK CONSTRAINT [FK_AppExpiry_Company]
GO
/****** Object:  ForeignKey [FK_CompanyDetails_Company]    Script Date: 09/06/2013 00:25:38 ******/
ALTER TABLE [dbo].[CompanyDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_CompanyDetails_Company] FOREIGN KEY([ComanyCode])
REFERENCES [dbo].[Company] ([CompanyCode])
GO
ALTER TABLE [dbo].[CompanyDetails] CHECK CONSTRAINT [FK_CompanyDetails_Company]
GO
/****** Object:  ForeignKey [FK_SettUser_Company]    Script Date: 09/06/2013 00:25:38 ******/
ALTER TABLE [dbo].[SettUser]  WITH CHECK ADD  CONSTRAINT [FK_SettUser_Company] FOREIGN KEY([CompanyCode])
REFERENCES [dbo].[Company] ([CompanyCode])
GO
ALTER TABLE [dbo].[SettUser] CHECK CONSTRAINT [FK_SettUser_Company]
GO
