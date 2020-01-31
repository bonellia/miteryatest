USE [MiteryaTestDB]
GO
/****** Object:  Table [dbo].[MenuActions]    Script Date: 14.01.2020 18:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuActions](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[Name_TR] [nvarchar](150) NOT NULL,
	[Name_EN] [nvarchar](150) NOT NULL,
	[Name_SA] [nvarchar](max),
	[ParentId] [uniqueidentifier] NOT NULL,
	[Rank] [int] NOT NULL,
	[Link] [nvarchar](max) NULL,
	[Icon] [nvarchar](max) NULL,
	[IsAction] [bit] NOT NULL,
	[Hierarchy] [nvarchar](max) NULL,
 CONSTRAINT [PK_MenuActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelOrganizationMenuActions]    Script Date: 14.01.2020 18:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelOrganizationMenuActions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationId] [uniqueidentifier] NOT NULL,
	[MenuActionId] [uniqueidentifier] NOT NULL,
	[IsPassive] [bit] NULL,
 CONSTRAINT [PK_RelOrganizationMenuActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMenuActions]    Script Date: 14.01.2020 18:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMenuActions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[MenuActionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RoleMenuActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserExtraMenuActions]    Script Date: 14.01.2020 18:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserExtraMenuActions](
	[DateCreated] [datetime2](7) NOT NULL,
	[UserCreated] [uniqueidentifier] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[UserModified] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[MenuActionId] [uniqueidentifier] NOT NULL,
	[UserOrganizationRoleId] [uniqueidentifier] NOT NULL,
	[IsAccess] [bit] NOT NULL,
 CONSTRAINT [PK_UserExtraMenuActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MenuActions]  WITH CHECK ADD  CONSTRAINT [FK_MenuActions_MenuActions_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[MenuActions] ([Id])
GO
ALTER TABLE [dbo].[MenuActions] CHECK CONSTRAINT [FK_MenuActions_MenuActions_ParentId]
GO
ALTER TABLE [dbo].[RelOrganizationMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_RelOrganizationMenuActions_MenuActions_MenuActionId] FOREIGN KEY([MenuActionId])
REFERENCES [dbo].[MenuActions] ([Id])
GO
ALTER TABLE [dbo].[RelOrganizationMenuActions] CHECK CONSTRAINT [FK_RelOrganizationMenuActions_MenuActions_MenuActionId]
GO
ALTER TABLE [dbo].[RelOrganizationMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_RelOrganizationMenuActions_Organizations_OrganizationId] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([Id])
GO
ALTER TABLE [dbo].[RelOrganizationMenuActions] CHECK CONSTRAINT [FK_RelOrganizationMenuActions_Organizations_OrganizationId]
GO
ALTER TABLE [dbo].[RoleMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_RoleMenuActions_MenuActions_MenuActionId] FOREIGN KEY([MenuActionId])
REFERENCES [dbo].[MenuActions] ([Id])
GO
ALTER TABLE [dbo].[RoleMenuActions] CHECK CONSTRAINT [FK_RoleMenuActions_MenuActions_MenuActionId]
GO
ALTER TABLE [dbo].[RoleMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_RoleMenuActions_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[RoleMenuActions] CHECK CONSTRAINT [FK_RoleMenuActions_Roles_RoleId]
GO
ALTER TABLE [dbo].[UserExtraMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_UserExtraMenuActions_MenuActions_MenuActionId] FOREIGN KEY([MenuActionId])
REFERENCES [dbo].[MenuActions] ([Id])
GO
ALTER TABLE [dbo].[UserExtraMenuActions] CHECK CONSTRAINT [FK_UserExtraMenuActions_MenuActions_MenuActionId]
GO
ALTER TABLE [dbo].[UserExtraMenuActions]  WITH CHECK ADD  CONSTRAINT [FK_UserExtraMenuActions_UserOrganizationRoles_UserOrganizationRoleId] FOREIGN KEY([UserOrganizationRoleId])
REFERENCES [dbo].[UserOrganizationRoles] ([Id])
GO
ALTER TABLE [dbo].[UserExtraMenuActions] CHECK CONSTRAINT [FK_UserExtraMenuActions_UserOrganizationRoles_UserOrganizationRoleId]
GO
