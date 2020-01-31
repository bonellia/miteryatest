-- DO NOT USE THIS SCRIPT ON PRODUCTION DATABASE!

-- Make sure to use correct DB.
USE [MiteryaTestDB]
GO

-- First, clear all data.
DELETE FROM [dbo].[Settings]
GO
DELETE FROM [dbo].[RelOrganizationMenuActions]
GO
DELETE FROM [dbo].[UserOrganizationRoles]
GO
DELETE FROM [dbo].[Organizations]
GO
DELETE FROM [dbo].[OrganTypes]
GO
DELETE FROM [dbo].[RoleMenuActions]
GO
DELETE FROM [dbo].[Roles]
GO
DELETE FROM [dbo].[MenuActions]
GO

-- Insert organ types.
INSERT [dbo].[OrganTypes] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [TypeName], [TypeName_US]) VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'242821d5-58ab-47c9-991e-1e96a6fc3074', N'School', N'School')
GO
INSERT [dbo].[OrganTypes] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [TypeName], [TypeName_US]) VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'32222218-716a-47b0-bddf-6d9ae4837c2e', N'Organizasyon', N'Organization')
GO
INSERT [dbo].[OrganTypes] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [TypeName], [TypeName_US]) VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'a1e78419-9ea6-4b61-b4e6-c7f2c6be68ef', N'Şubesiz Sınıf', N'ClassroomWithoutBranch')
GO
INSERT [dbo].[OrganTypes] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [TypeName], [TypeName_US]) VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'fafe25e5-2e61-4502-b076-f04217acb18b', N'Kampüs\Kolej', N'Campus\College')
GO
INSERT [dbo].[OrganTypes] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [TypeName], [TypeName_US]) VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'e0a53bfc-7837-4b05-a351-fcae56a371d7', N'Sınıf', N'Classroom')
GO

-- Insert roles.
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'2667d80a-f83e-4b18-93e4-4ec48ea734ec', N'Operatör', N'Operator', 7)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'Personel', N'Personnel', 9)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'Öğretmen', N'Teacher', 2)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'8b743fdc-ccfa-475d-9bb2-a6776fdb77b8', N'Aday', N'Candidate', 11)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'deb470c7-9827-4375-b20a-bea56511ea49', N'Öğrenci', N'Student', 1)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'574d2187-d602-4188-a63c-c2b9dc5133df', N'Rehber Öğretmen', N'Leader Teacher', 4)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'a308971f-8f17-41c5-b898-c8f3adc33535', N'Müdür', N'Manager', 5)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'Veli', N'Parent', 3)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'57447a54-040e-44ea-b312-d5389c040467', N'Müdür Yardımcısı', N'ManagerAssistant', 8)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'c5067cd0-bebf-4e27-809f-f24eca55b1fb', N'Organizasyon Yöneticisi', N'Organization Manager', 10)
GO
INSERT [dbo].[Roles] ([Id], [RoleName], [RoleName_US], [Code]) VALUES (N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'Süper Admin', N'Super Administrator', 6)
GO

-- Insert menu actions.
ALTER TABLE [dbo].[MenuActions]
	NOCHECK CONSTRAINT [FK_MenuActions_MenuActions_ParentId];   
GO  
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'f1d10c94-e815-4682-840c-010e456380b6', N'Pozisyona Dayalı Liyakat', N'Position-based merit', N'', N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8', 3, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,f1d10c94-e815-4682-840c-010e456380b6')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'73b5e68d-c09c-4aa1-b8ef-018b8b3af054', N'Lider yetkinlik analizi', N'Leading competency analysis', N'', N'741ea582-a64b-471e-91a8-d2b3731e1e4e', 2, N'/HrLeadership/LeadershipAnalysis/Index', N'', 0, N'741ea582-a64b-471e-91a8-d2b3731e1e4e,73b5e68d-c09c-4aa1-b8ef-018b8b3af054')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'2f55368e-b8f9-4b26-81fe-02a170d5af17', N'Okul kültür uyumu', N'School culture harmony', N'', N'2b9611ca-2046-4879-a8b0-7993cc25f57b', 1, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,2b9611ca-2046-4879-a8b0-7993cc25f57b,2f55368e-b8f9-4b26-81fe-02a170d5af17')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'96455b8c-b17b-45ab-92b4-044f9c7885a2', N'Mesleki Kariyer', N'Professional Career', N'', N'96455b8c-b17b-45ab-92b4-044f9c7885a2', 9, N'', N'fa fa-bars', 0, N'96455b8c-b17b-45ab-92b4-044f9c7885a2')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'1391a4e1-3330-4cff-8dce-079e4b2743ff', N'Değer Gelişim Takibi', N'Value Development Tracking', N'', N'ff5c7018-2096-43ea-8d4f-0b5a940f620b', 3, N'/HrMerit/DevelopmentTracking', N'', 1, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,ff5c7018-2096-43ea-8d4f-0b5a940f620b,1391A4E1-3330-4CFF-8DCE-079E4B2743FF')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'c9cf9e81-ceb8-444f-a224-0818232bfac5', N'Zihinsel Yetenek', N'Mental Ability', N'', N'adb07640-d3ec-4ba9-9944-a377f8761769', 1, N'/TalentIntelligence/index', N'', 0, N'adb07640-d3ec-4ba9-9944-a377f8761769,c9cf9e81-ceb8-444f-a224-0818232bfac5')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'ff5c7018-2096-43ea-8d4f-0b5a940f620b', N'Liyakat Performans Gelişim Takibi', N'Merit Performance Development Tracking', N'', N'c1dd98bf-cc4d-4688-88d9-8f2ab5bab520', 4, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,ff5c7018-2096-43ea-8d4f-0b5a940f620b')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'9994a0a6-5507-4add-999b-0b76eb8630fd', N'Genel Liyakat Gelişim Takibi', N'General Merit Development Tracking', N'', N'ff5c7018-2096-43ea-8d4f-0b5a940f620b', 1, N'/HrGeneralMeritDevelopmentTracking/DevelopmentTracking', N'', 1, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,ff5c7018-2096-43ea-8d4f-0b5a940f620b,9994A0A6-5507-4ADD-999B-0B76EB8630FD')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'd3ee7993-7ab7-4283-a237-0fa64d833a41', N'Rehberlik Danışmanlık ', N'Guidance Counseling ', N'', N'd3ee7993-7ab7-4283-a237-0fa64d833a41', 8, N'', N'fa fa-bars', 0, N'd3ee7993-7ab7-4283-a237-0fa64d833a41')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'e2207879-7a81-4e91-88bc-10650fa2b061', N'Yönetici uyumu', N'Executive compliance', N'', N'2b9611ca-2046-4879-a8b0-7993cc25f57b', 3, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,2b9611ca-2046-4879-a8b0-7993cc25f57be2207879-7a81-4e91-88bc-10650fa2b061')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'15c79218-0ced-4dd9-91e4-173ffade25fc', N'Kişisel Gelişim ', N'Personal Development Module', N'', N'15c79218-0ced-4dd9-91e4-173ffade25fc', 6, N'', N'fa fa-bars', 0, N'15c79218-0ced-4dd9-91e4-173ffade25fc')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'901d6329-3099-411c-90ff-18079ee7fa61', N'Zihinsel Gelişim', N'Mental development', N'', N'15c79218-0ced-4dd9-91e4-173ffade25fc', 1, N'/PersonalGuidance/MentalDevelopmentIndex', N'', 0, N'15c79218-0ced-4dd9-91e4-173ffade25fc,901d6329-3099-411c-90ff-18079ee7fa61')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'620e091c-3562-4528-8fbb-19163e1f4638', N'Grup Etkinlik Planlama', N'Group Event Planning', N'', N'10dc87d8-525c-49ec-bd72-ba2a7db76187', 2, N'', N'', 0, N'10dc87d8-525c-49ec-bd72-ba2a7db76187,620e091c-3562-4528-8fbb-19163e1f4638')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'5ffb1216-3810-4ad1-bb73-1d66c7c462ec', N'Dav.Olgunluk Değer', N'Val.Maturation Value', N'', N'c1dd98bf-cc4d-4688-88d9-8f2ab5bab520', 3, N'/HrMerit/index', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,5ffb1216-3810-4ad1-bb73-1d66c7c462ec')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'96d7d6ae-afd6-4e10-968a-248efe5a674f', N'Öğretmen Portfolyö', N'Teacher Portfolio', N'', N'3de0c8c1-0812-49e1-b1e0-786e7e53e951', 2, N'', N'', 0, N'3de0c8c1-0812-49e1-b1e0-786e7e53e951,96d7d6ae-afd6-4e10-968a-248efe5a674f')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'e2e945c0-6479-439b-81b6-26434497e68d', N'Risk Analizi', N'Risk analysis', N'', N'2d816bc2-5248-44af-b226-2839daeda5f8', 1, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,e2e945c0-6479-439b-81b6-26434497e68d')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'2d816bc2-5248-44af-b226-2839daeda5f8', N'Uyum ve Risk', N'Compliance and Risk', N'', N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8', 5, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'114ee2e9-fa59-491b-90d8-28dae80ed53d', N'Mizaç Profil Değerlendirme', N'Temperament Profile Evaluation', N'', N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8', 1, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,114ee2e9-fa59-491b-90d8-28dae80ed53d')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'98d7a3e1-45cf-44fe-a1cb-29864aca5a9e', N'Aday Sosyal Yeterlilik Analizi', N'Candidate Social Competence Analysis', N'', N'ffdcdc8c-b009-4a49-bdee-9d7bd491c078', 5, N'/Recruitment/CandidateSocialAnalysis', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,ffdcdc8c-b009-4a49-bdee-9d7bd491c078,628631ff-fa4d-43f7-bfd1-372acddbce64')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'5c208285-3ae6-45d1-a762-2b6701bd0cdd', N'İlgi Alanları Analiz', N'Areas of Interest Analysis', N'', N'96455b8c-b17b-45ab-92b4-044f9c7885a2', 1, N'', N'', 0, N'96455b8c-b17b-45ab-92b4-044f9c7885a2,5c208285-3ae6-45d1-a762-2b6701bd0cdd')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'd29f7bf7-9e6f-4e48-be6e-2e549a35b26a', N'Genel İK Risk', N'General HR Risk', N'', N'e2e945c0-6479-439b-81b6-26434497e68d', 1, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,e2e945c0-6479-439b-81b6-26434497e68d,d29f7bf7-9e6f-4e48-be6e-2e549a35b26a')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'168f748d-904f-4cda-ab93-30f564f81c58', N'Aday Davranışsal Değer Analizi', N'Candidate Behavioral Value Analysis', N'', N'ffdcdc8c-b009-4a49-bdee-9d7bd491c078', 6, N'/Recruitment/CandidateMeritAnalysis', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,ffdcdc8c-b009-4a49-bdee-9d7bd491c078,628631ff-fa4d-43f7-bfd1-372acddbce64')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'12136eb8-809d-4652-866a-32d60b8bcd18', N'Sosyal Beceri', N'Social Skills', N'', N'7a544814-4aee-4f77-aa57-f524e1a073a0', 3, N'/HrSocialQualification/Index', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,7a544814-4aee-4f77-aa57-f524e1a073a0,12136eb8-809d-4652-866a-32d60b8bcd18')
GO

INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'57f0dcf6-f956-42f9-84f9-346a3da174e7', N'Genel Liyakat Profil Kartı', N'General Merit Profile Card', N'', N'c1dd98bf-cc4d-4688-88d9-8f2ab5bab520', 5, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,57f0dcf6-f956-42f9-84f9-346a3da174e7')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'cc6dffc4-4e38-4a89-bd8e-35d1b84b4249', N'Pozisyona Dayalı Profil Kartı', N'Positioning Profile Card', N'', N'f1d10c94-e815-4682-840c-010e456380b6', 2, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,f1d10c94-e815-4682-840c-010e456380b6,cc6dffc4-4e38-4a89-bd8e-35d1b84b4249')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'628631ff-fa4d-43f7-bfd1-372acddbce64', N'Aday Profil Kartı', N'Candidate Profile Card', N'', N'ffdcdc8c-b009-4a49-bdee-9d7bd491c078', 3, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,ffdcdc8c-b009-4a49-bdee-9d7bd491c078,628631ff-fa4d-43f7-bfd1-372acddbce64')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'6f0c8c72-057d-4d05-b5b8-3e3afccdbd01', N'Öğrenci Portfolyö', N'Student Portfolio', N'', N'3de0c8c1-0812-49e1-b1e0-786e7e53e951', 1, N'/StudentPortfolio', N'', 0, N'3de0c8c1-0812-49e1-b1e0-786e7e53e951,6f0c8c72-057d-4d05-b5b8-3e3afccdbd01')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'aa6df866-7e91-4140-98a0-42f89c3e99cf', N'Uyum ve Risk Profil Kartı', N'Compliance and Risk Profile Card', N'', N'2d816bc2-5248-44af-b226-2839daeda5f8', 3, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,aa6df866-7e91-4140-98a0-42f89c3e99cf')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'2c76d195-9e02-461c-bf7e-43d763e64b9d', N'Aday Mizaç Profil Analizi', N'Candidate Temperament Profile Analysis', N'', N'ffdcdc8c-b009-4a49-bdee-9d7bd491c078', 1, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,ffdcdc8c-b009-4a49-bdee-9d7bd491c078,2c76d195-9e02-461c-bf7e-43d763e64b9d')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'8be80f90-abe0-47a6-8e11-44cd5e55158d', N'Rapor ve Değerlendirme Metni Yönetimi', N'Report and Evaluation Text Management', N'', N'8964d431-5901-4fea-8a36-d8f4972a802a', 4, N'/ReportParagraphManagement', N'', 0, N'8964d431-5901-4fea-8a36-d8f4972a802a,8be80f90-abe0-47a6-8e11-44cd5e55158d')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'ad9d7ff2-1a08-4439-aa46-468eef0d5a50', N'Öğrenci Danışmanlık Listem', N'Student Consultancy List', N'', N'd3ee7993-7ab7-4283-a237-0fa64d833a41', 4, N'/Consultancy/MyConsultancyStudentList', N'', 0, N'd3ee7993-7ab7-4283-a237-0fa64d833a41,ad9d7ff2-1a08-4439-aa46-468eef0d5a50')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'ad9d7ff2-1a08-4439-aa46-468eef0d5f45', N'Veli Görüşmeleri', N'Parent Interview', N'', N'd3ee7993-7ab7-4283-a237-0fa64d833a41', 5, N'/Consultancy/MyConsultancyParentList', N'', 0, N'd3ee7993-7ab7-4283-a237-0fa64d833a41,ad9d7ff2-1a08-4439-aa46-468eef0d5f45')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'13ba253f-80c8-4e34-a55f-47fa4f63c1de', N'Departman Yönetimi', N'Department Management', N'', N'8964d431-5901-4fea-8a36-d8f4972a802a', 5, N'/Department', N'', 0, N'8964d431-5901-4fea-8a36-d8f4972a802a,13ba253f-80c8-4e34-a55f-47fa4f63c1de')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'6c4b11cb-a1b5-4fcb-858b-4ee7a8e71d65', N'Mizaca Özgü Anketler', N'Temperament Specific Surveys', N'', N'd3ee7993-7ab7-4283-a237-0fa64d833a41', 2, N'/GuidanceSurvey/Index', N'', 0, N'd3ee7993-7ab7-4283-a237-0fa64d833a41,6c4b11cb-a1b5-4fcb-858b-4ee7a8e71d65')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'428ac73e-e029-4dd9-b944-5205473bd0a8', N'Ekip uyumu', N'Team compliance', N'', N'2b9611ca-2046-4879-a8b0-7993cc25f57b', 2, N'/HrRisk/TeamHarmony/Index', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,2b9611ca-2046-4879-a8b0-7993cc25f57b,428ac73e-e029-4dd9-b944-5205473bd0a8')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'bc652726-b975-4ab7-82b2-5447fe919de6', N'Öğrenci Danışmanlık Havuzu', N'Student Consultancy Pool', N'', N'd3ee7993-7ab7-4283-a237-0fa64d833a41', 4, N'/Consultancy/Index', N'', 0, N'd3ee7993-7ab7-4283-a237-0fa64d833a41,bc652726-b975-4ab7-82b2-5447fe919de6')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'95f37472-c6c3-4455-8a5f-5516c4adaaf7', N'Eylem-Duygu-Biliş Analizi', N'Action-Emotion-Cognition Analysis', N'', N'114ee2e9-fa59-491b-90d8-28dae80ed53d', 2, N'/HrTemperamentAnalysis/ActionEmotionCognitionAnalysis', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,114ee2e9-fa59-491b-90d8-28dae80ed53d,95f37472-c6c3-4455-8a5f-5516c4adaaf7')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'680382f7-1e25-4342-94ee-587f8c0303e2', N'Sınıf Mevcudu Belirleme', N'Determining Class Availability', N'', N'3ed8b345-6337-42f3-a57a-8e877dfdcab0', 1, N'/ClassDistribution', N'', 0, N'3ed8b345-6337-42f3-a57a-8e877dfdcab0,680382f7-1e25-4342-94ee-587f8c0303e2')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'e098c6d0-28c3-4fe9-b43f-5b945d902512', N'İs Doyumu', N'job satisfaction', N'', N'e2e945c0-6479-439b-81b6-26434497e68d', 1, N'/HrRisk/JobSatisfaction/Index', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,e2e945c0-6479-439b-81b6-26434497e68d,E098C6D0-28C3-4FE9-B43F-5B945D902512')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'1fc8faea-5cca-4457-bb81-5cd4b5bf0bbe', N'Lider Profil Kartı', N'Leading Profile Card', N'', N'741ea582-a64b-471e-91a8-d2b3731e1e4e', 3, N'/HrLeadership/LeadershipProfileCard/Index', N'', 0, N'741ea582-a64b-471e-91a8-d2b3731e1e4e,1fc8faea-5cca-4457-bb81-5cd4b5bf0bbe')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'c32dbf83-8e04-4a84-b99c-62e6cdf7d58a', N'Kurumsal Bağlılık', N'Corporate Loyalty', N'', N'e2e945c0-6479-439b-81b6-26434497e68d', 1, N'/HrRisk/CorporateLoyality/Index', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,e2e945c0-6479-439b-81b6-26434497e68d,C32DBF83-8E04-4A84-B99C-62E6CDF7D58A')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'5d84d650-ff90-4247-8cbf-630711aa7b56', N'Organizasyon Yönetimi', N'Organization Management', N'', N'8964d431-5901-4fea-8a36-d8f4972a802a', 1, N'/OrganizationManagement', N'', 0, N'8964d431-5901-4fea-8a36-d8f4972a802a,5d84d650-ff90-4247-8cbf-630711aa7b56')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'3f78e781-11b5-473f-bf05-6379b58d475a', N'Mesleki Yönlendirme', N'Vocational Guidance', N'', N'96455b8c-b17b-45ab-92b4-044f9c7885a2', 2, N'', N'', 0, N'96455b8c-b17b-45ab-92b4-044f9c7885a2,3f78e781-11b5-473f-bf05-6379b58d475a')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'b31eaab6-4230-4b7c-b14c-6584989b4c24', N'Pozisyon Yönetimi', N'Position Management', N'', N'8964d431-5901-4fea-8a36-d8f4972a802a', 6, N'/Position', N'', 0, N'8964d431-5901-4fea-8a36-d8f4972a802a,b31eaab6-4230-4b7c-b14c-6584989b4c24')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'f399136e-d3b9-42f3-b977-674803dbc7f4', N'Mizaç Testim', N'My Temperament Test', N'', N'598af2e2-c286-4805-89bd-c577085bb621', 1, N'/MizacTest', N'', 0, N'598af2e2-c286-4805-89bd-c577085bb621,f399136e-d3b9-42f3-b977-674803dbc7f4')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'09710c22-d9d2-4ba0-8c86-69e32e94e8d0', N'Aday Yetkinlik Analizi', N'Candidate Perfection Analysis', N'', N'ffdcdc8c-b009-4a49-bdee-9d7bd491c078', 1, N'/Recruitment/CandidatePerfectionAnalysis', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,ffdcdc8c-b009-4a49-bdee-9d7bd491c078,09710c22-d9d2-4ba0-8c86-69e32e94e8d0')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'5d29c0ee-3b71-4f50-b257-6a4d73a4ef31', N'Anketlerim', N'My Polls', N'', N'd3ee7993-7ab7-4283-a237-0fa64d833a41', 2, N'/GuidanceSurvey/getGuidanceAssignedSurvey', N'', 0, N'd3ee7993-7ab7-4283-a237-0fa64d833a41,5d29c0ee-3b71-4f50-b257-6a4d73a4ef31')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'7db22b4b-0fa7-4fb9-9ec3-6af6447f9071', N'Pozisyon Liyakat Analizi', N'', N'Position Merit Analysis', N'f1d10c94-e815-4682-840c-010e456380b6', 1, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,f1d10c94-e815-4682-840c-010e456380b6,7db22b4b-0fa7-4fb9-9ec3-6af6447f9071')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6', N'Ana Sayfa', N'Home Page', N'', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6', 0, N'/Home', N'fa fa-home', 0, N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'3de0c8c1-0812-49e1-b1e0-786e7e53e951', N'Portfolyö Yönetimi', N'', N'Portfolio Management', N'3de0c8c1-0812-49e1-b1e0-786e7e53e951', 12, N'', N'fa fa-bars', 0, N'3de0c8c1-0812-49e1-b1e0-786e7e53e951')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'2b9611ca-2046-4879-a8b0-7993cc25f57b', N'Uyum Analizi', N'Compliance Analysis', N'', N'2d816bc2-5248-44af-b226-2839daeda5f8', 2, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,2b9611ca-2046-4879-a8b0-7993cc25f57b')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'7a9962d0-830b-4b0b-be07-7bd8eddd3529', N'Parazit Analizi', N'Parasite Analysis', N'', N'e2e945c0-6479-439b-81b6-26434497e68d', 1, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,e2e945c0-6479-439b-81b6-26434497e68d,7a9962d0-830b-4b0b-be07-7bd8eddd3529')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'c517e688-bfa9-4161-816d-7ca833783b91', N'Menü ve Sayfa Yönetimi', N'Menu and Page Management', N'', N'8964d431-5901-4fea-8a36-d8f4972a802a', 3, N'/MenuActionManagement', N'', 0, N'8964d431-5901-4fea-8a36-d8f4972a802a,c517e688-bfa9-4161-816d-7ca833783b91')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'fa9f6eb6-42e7-4379-93e7-80fec8ec7565', N'Yetişkin Mizaç Profili Analizi', N'Adults Temperament Profile Analysis', N'', N'598af2e2-c286-4805-89bd-c577085bb621', 4, N'/TemperamentProfile/TemperamentProfileAnalysis', N'', 0, N'598af2e2-c286-4805-89bd-c577085bb621,fa9f6eb6-42e7-4379-93e7-80fec8ec7565')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'66c536e0-9db9-4c6b-837f-882a37391712', N'Kişilik Gelişimi', N'Personality Development', N'', N'15c79218-0ced-4dd9-91e4-173ffade25fc', 2, N'/PersonalGuidance/PersonalityDevelopmentIndex', N'', 0, N'15c79218-0ced-4dd9-91e4-173ffade25fc,66c536e0-9db9-4c6b-837f-882a37391712')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'edd78954-d102-42d1-bb32-8a13d59a201a', N'Sosyal Yeterlilik Gelişim Takibi', N'Social Qualification Development Tracking', N'', N'ff5c7018-2096-43ea-8d4f-0b5a940f620b', 2, N'/HrSocialQualification/DevelopmentTracking', N'', 1, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,ff5c7018-2096-43ea-8d4f-0b5a940f620b,EDD78954-D102-42D1-BB32-8A13D59A201A')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'3ed8b345-6337-42f3-a57a-8e877dfdcab0', N'Sınıf Yönetimi ', N'Class Management ', N'', N'3ed8b345-6337-42f3-a57a-8e877dfdcab0', 11, N'', N'fa fa-bars', 0, N'3ed8b345-6337-42f3-a57a-8e877dfdcab0')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'c1dd98bf-cc4d-4688-88d9-8f2ab5bab520', N'Genel Liyakat', N'General Merit', N'', N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8', 2, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'affda8e6-dafc-42a5-8850-91207689fc04', N'Mizac Temelli Öğrenme', N'Temperament Based Learning', N'', N'affda8e6-dafc-42a5-8850-91207689fc04', 5, N'', N'fa fa-bars', 0, N'affda8e6-dafc-42a5-8850-91207689fc04')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'a70b98ff-3c30-4399-a084-925af7f2c774', N'Yetkinlik', N'perfection', N'', N'c1dd98bf-cc4d-4688-88d9-8f2ab5bab520', 2, N'/HrPerfection/Index', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,a70b98ff-3c30-4399-a084-925af7f2c774')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'36764e26-dc35-4f3d-8d7f-945fdd87db85', N'Anketlerim', N'My Surveys', N'', N'36764e26-dc35-4f3d-8d7f-945fdd87db85', 2, N'/HrSurvey/GetMySurveys/Index', N'fa fa-bars', 0, N'36764E26-DC35-4F3D-8D7F-945FDD87DB85')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'0022d087-3aa1-4a46-805e-9a58c617625d', N'Veli Portfolyö', N'Parent Portfolyö', N'', N'3de0c8c1-0812-49e1-b1e0-786e7e53e951', 4, N'', N'', 0, N'3de0c8c1-0812-49e1-b1e0-786e7e53e951,0022d087-3aa1-4a46-805e-9a58c617625d')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'ffdcdc8c-b009-4a49-bdee-9d7bd491c078', N'İşe Alım', N'Recruitment', N'', N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8', 4, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,ffdcdc8c-b009-4a49-bdee-9d7bd491c078')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'2dcac56d-b39d-45cf-a345-a238341c0ca8', N'Küresel Yaşam Becerileri', N'Global Life Skills', N'', N'15c79218-0ced-4dd9-91e4-173ffade25fc', 4, N'/GlobalLifeSkills/GlobalLifeSkillIndex', N'', 0, N'15c79218-0ced-4dd9-91e4-173ffade25fc,2dcac56d-b39d-45cf-a345-a238341c0ca8')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'adb07640-d3ec-4ba9-9944-a377f8761769', N'Zihinsel Yetenek', N'Mental Ability', N'', N'adb07640-d3ec-4ba9-9944-a377f8761769', 4, N'', N'fa fa-bars', 0, N'adb07640-d3ec-4ba9-9944-a377f8761769')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'13999894-0b6e-4052-afc1-a90ff4a7bb33', N'Aday Karşılaştırma', N'Candidate Comparison', N'', N'ffdcdc8c-b009-4a49-bdee-9d7bd491c078', 2, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,ffdcdc8c-b009-4a49-bdee-9d7bd491c078,13999894-0b6e-4052-afc1-a90ff4a7bb33')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'0885d2de-c845-4b14-81ae-adcbc0ad84fd', N'Kullanıcı Yönetimi', N'User Management', N'', N'8964d431-5901-4fea-8a36-d8f4972a802a', 2, N'/UserManagement', N'', 0, N'8964d431-5901-4fea-8a36-d8f4972a802a,0885d2de-c845-4b14-81ae-adcbc0ad84fd')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'f7563540-2d50-4df6-ab9b-b20a0c637b1d', N'Oturma Düzeni Belirleme', N'Seating Layout Determination', N'', N'3ed8b345-6337-42f3-a57a-8e877dfdcab0', 2, N'/ClassroomSittingPlan', N'', 0, N'3ed8b345-6337-42f3-a57a-8e877dfdcab0,f7563540-2d50-4df6-ab9b-b20a0c637b1d')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'4ce34450-7c82-44db-b9df-b5bf9547204f', N'Tükenmişlik', N'Fatigue', N'', N'e2e945c0-6479-439b-81b6-26434497e68d', 1, N'/HrRisk/Fatigue/Index', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,e2e945c0-6479-439b-81b6-26434497e68d,4CE34450-7C82-44DB-B9DF-B5BF9547204F')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'10dc87d8-525c-49ec-bd72-ba2a7db76187', N'Etkinlik Takip ', N'Activity Tracking ', N'', N'10dc87d8-525c-49ec-bd72-ba2a7db76187', 10, N'', N'fa fa-bars', 0, N'10dc87d8-525c-49ec-bd72-ba2a7db76187')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 0, 1, N'002c9642-f789-4b6e-99fe-bd3e59d32d66', N'Genel Anketler', N'General Surveys', N'', N'd3ee7993-7ab7-4283-a237-0fa64d833a41', 3, N'', N'', 0, N'd3ee7993-7ab7-4283-a237-0fa64d833a41,002c9642-f789-4b6e-99fe-bd3e59d32d66')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'202a61f7-2327-4f17-8840-be8813e5e76d', N'Parazit Analizi', N'Parasite Analysis', N'', N'114ee2e9-fa59-491b-90d8-28dae80ed53d', 3, N'/HrTemperamentAnalysis/ParasiteAnalysis', N'', 1, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,114ee2e9-fa59-491b-90d8-28dae80ed53d,202a61f7-2327-4f17-8840-be8813e5e76d')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'909f112e-400c-4721-921e-bf19d495c8b0', N'Davranışsal Değer Gelişim Takibi', N'Behavioral Value Development Follow-up', N'', N'4ad466c0-a850-4032-83c1-cb6316b84e5c', 1, N'/MeritDevelopment/index', N'fa fa-bars', 0, N'4ad466c0-a850-4032-83c1-cb6316b84e5c,909f112e-400c-4721-921e-bf19d495c8b0')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'598af2e2-c286-4805-89bd-c577085bb621', N'Mizaç Profil Analiz ', N'Temperament Profile Analysis ', N'', N'598af2e2-c286-4805-89bd-c577085bb621', 3, N'', N'fa fa-bars', 0, N'598af2e2-c286-4805-89bd-c577085bb621')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'4ad466c0-a850-4032-83c1-cb6316b84e5c', N'Değer Farkındalık Gelişim ', N'Value Awareness Development Module', N'', N'4ad466c0-a850-4032-83c1-cb6316b84e5c', 7, N'', N'fa fa-bars', 0, N'4ad466c0-a850-4032-83c1-cb6316b84e5c')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'788bf403-66fa-4d83-8b00-cbb4f3dcd891', N'Bireysel Etkinlik Planlama', N'Individual Event Planning', N'', N'10dc87d8-525c-49ec-bd72-ba2a7db76187', 1, N'', N'', 0, N'10dc87d8-525c-49ec-bd72-ba2a7db76187,788bf403-66fa-4d83-8b00-cbb4f3dcd891')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'e5698e34-5f71-493c-a5de-cf98fdf9ad5c', N'Öğrenme Stilleri', N'Learning Styles', N'', N'affda8e6-dafc-42a5-8850-91207689fc04', 1, N'', N'', 0, N'affda8e6-dafc-42a5-8850-91207689fc04,e5698e34-5f71-493c-a5de-cf98fdf9ad5c')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'adae9c7e-6b57-4535-9a85-d0bef85ab583', N'Öğrenci Mizaç Profili Analizi', N'Students Temperament Profile Analysis', N'', N'598af2e2-c286-4805-89bd-c577085bb621', 2, N'/TemperamentProfile/MyStudentsTemperamentTests', N'', 0, N'598af2e2-c286-4805-89bd-c577085bb621,adae9c7e-6b57-4535-9a85-d0bef85ab583')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8', N'Miterya İK ', N'School HR ', N'', N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8', 13, N'', N'fa fa-bars', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'741ea582-a64b-471e-91a8-d2b3731e1e4e', N'Eğitim Liderliği', N'Education Leadership', N'', N'741ea582-a64b-471e-91a8-d2b3731e1e4e', 14, N'', N'fa fa-bars', 0, N'741ea582-a64b-471e-91a8-d2b3731e1e4e')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'2857f5ac-afa9-4a51-9d26-d5f4a5639fe6', N'Lider mizaç profil analizi', N'Lead temperament profile analysis', N'', N'741ea582-a64b-471e-91a8-d2b3731e1e4e', 1, N'/HrLeadership/LeadershipTemperamentProfileAnalysis/Index', N'', 0, N'741ea582-a64b-471e-91a8-d2b3731e1e4e,2857f5ac-afa9-4a51-9d26-d5f4a5639fe6')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'1b1df837-2d9d-463b-b1b8-d640052ad10e', N'İşten Ayrılma', N'quitting', N'', N'e2e945c0-6479-439b-81b6-26434497e68d', 1, N'/HrRisk/Quitting/Index', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,2d816bc2-5248-44af-b226-2839daeda5f8,e2e945c0-6479-439b-81b6-26434497e68d,1B1DF837-2D9D-463B-B1B8-D640052AD10E')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'8964d431-5901-4fea-8a36-d8f4972a802a', N'Sistem Yönetimi ', N'System Management ', N'', N'8964d431-5901-4fea-8a36-d8f4972a802a', 1, N'', N'fa fa-bars', 0, N'8964d431-5901-4fea-8a36-d8f4972a802a')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'83b477f4-cfd0-48aa-940e-daa30e42fa3d', N'Mizaç Profil Analizi', N'Temperament Profile Analysis', N'', N'114ee2e9-fa59-491b-90d8-28dae80ed53d', 1, N'Temperament Profile Analysis', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,114ee2e9-fa59-491b-90d8-28dae80ed53d,83b477f4-cfd0-48aa-940e-daa30e42fa3d')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'2e9f2400-596a-4c12-8d40-de252420e519', N'Yaşam ve Kariyer Önerileri', N'Life and Career Advice', N'', N'114ee2e9-fa59-491b-90d8-28dae80ed53d', 4, N'/HrTemperamentAnalysis/LifeAndCareerAnalysis', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,114ee2e9-fa59-491b-90d8-28dae80ed53d,2e9f2400-596a-4c12-8d40-de252420e519')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'21318e97-d106-4696-bfc9-e27e7a5f1eb4', N'Sosyal Beceri Gelişimi', N'Social Skills Development', N'', N'15c79218-0ced-4dd9-91e4-173ffade25fc', 3, N'/PersonalGuidance/SocialSkillIndex', N'', 0, N'15c79218-0ced-4dd9-91e4-173ffade25fc,21318e97-d106-4696-bfc9-e27e7a5f1eb4')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'ed6ceba5-d1a8-4009-8134-e45d38fe32a8', N'Anket Yönetimi', N'Survey Management', N'', N'8964d431-5901-4fea-8a36-d8f4972a802a', 1, N'/HrSurvey/index', N'fa fa-home', 0, N'8964D431-5901-4FEA-8A36-D8F4972A802A')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'b187b8f4-c814-4d5e-a9d8-e59d48e5947f', N'Çocuğumun Mizaç Testi', N'My Childs Temperament Test', N'', N'598af2e2-c286-4805-89bd-c577085bb621', 3, N'/TemperamentProfile/MyChildTemperamentTest', N'', 0, N'598af2e2-c286-4805-89bd-c577085bb621,b187b8f4-c814-4d5e-a9d8-e59d48e5947f')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'de0f3b80-d872-4ae3-bad7-e810683daf4a', N'Çalışma alışkanlıkları analiz', N'Temperament Based Study Habits', N'', N'affda8e6-dafc-42a5-8850-91207689fc04', 2, N'', N'', 0, N'affda8e6-dafc-42a5-8850-91207689fc04,de0f3b80-d872-4ae3-bad7-e810683daf4a')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'b708bd78-80f7-4ceb-9394-f1d99b6ba5ee', N'Zihinsel Yetenek', N'Mental Ability', N'', N'7a544814-4aee-4f77-aa57-f524e1a073a0', 2, N'/HrSkill/index', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,7a544814-4aee-4f77-aa57-f524e1a073a0,b708bd78-80f7-4ceb-9394-f1d99b6ba5ee')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'7a544814-4aee-4f77-aa57-f524e1a073a0', N'Yeterlilik', N'Qualifications', N'', N'c1dd98bf-cc4d-4688-88d9-8f2ab5bab520', 1, N'', N'', 0, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,7a544814-4aee-4f77-aa57-f524e1a073a0')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'1b970988-6650-4dd5-9a91-f5f35249f644', N'Evrensel Yaşam Becerileri', N'Universal Life Skills', N'', N'15c79218-0ced-4dd9-91e4-173ffade25fc', 5, N'/UniversalLifeSkills/UniversalLifeSkillIndex', N'', 0, N'15c79218-0ced-4dd9-91e4-173ffade25fc,1b970988-6650-4dd5-9a91-f5f35249f644')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'316d3daa-988e-46a6-8671-f6433df9b6d3', N'Yönetici Portfolyö', N'Executive Portfolio', N'', N'3de0c8c1-0812-49e1-b1e0-786e7e53e951', 3, N'', N'', 0, N'3de0c8c1-0812-49e1-b1e0-786e7e53e951,316d3daa-988e-46a6-8671-f6433df9b6d3')
GO
INSERT [dbo].[MenuActions] ([DateCreated], [UserCreated], [DateModified], [UserModified], [IsActive], [IsDeleted], [Id], [Name_TR], [Name_EN], [Name_SA], [ParentId], [Rank], [Link], [Icon], [IsAction], [Hierarchy]) 
VALUES (CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', CAST(N'2019-02-12T16:19:02.1165240' AS DateTime2), N'e291d1e3-6936-4e0b-b1c0-667d71c4abea', 1, 0, N'a3196480-539b-447a-b273-fc1090f846d0', N'Yetkinlik Gelişim Takibi', N'Competency Development Tracking', N'', N'ff5c7018-2096-43ea-8d4f-0b5a940f620b', 4, N'/HrPerfection/DevelopmentTracking', N'', 1, N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8,c1dd98bf-cc4d-4688-88d9-8f2ab5bab520,ff5c7018-2096-43ea-8d4f-0b5a940f620b,A3196480-539B-447A-B273-FC1090F846D0')
GO
ALTER TABLE [dbo].[MenuActions]
	NOCHECK CONSTRAINT [FK_MenuActions_MenuActions_ParentId];   
GO

-- Insert proper menus for given roles.
SET IDENTITY_INSERT [dbo].[RoleMenuActions] ON 
GO
-- Super Admin role menus.
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (1, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (2, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'8964d431-5901-4fea-8a36-d8f4972a802a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (3, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'5d84d650-ff90-4247-8cbf-630711aa7b56')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (4, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'0885d2de-c845-4b14-81ae-adcbc0ad84fd')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (5, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'c517e688-bfa9-4161-816d-7ca833783b91')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (6, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'8be80f90-abe0-47a6-8e11-44cd5e55158d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (7, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'13ba253f-80c8-4e34-a55f-47fa4f63c1de')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (8, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'b31eaab6-4230-4b7c-b14c-6584989b4c24')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (9, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'3de0c8c1-0812-49e1-b1e0-786e7e53e951')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (10, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'6f0c8c72-057d-4d05-b5b8-3e3afccdbd01')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (11, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'96d7d6ae-afd6-4e10-968a-248efe5a674f')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (12, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'316d3daa-988e-46a6-8671-f6433df9b6d3')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (13, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'0022d087-3aa1-4a46-805e-9a58c617625d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (14, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'9994a0a6-5507-4add-999b-0b76eb8630fd')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (15, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'edd78954-d102-42d1-bb32-8a13d59a201a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (16, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'1391a4e1-3330-4cff-8dce-079e4b2743ff')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (17, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'a3196480-539b-447a-b273-fc1090f846d0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (22, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'598af2e2-c286-4805-89bd-c577085bb621')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (23, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'f399136e-d3b9-42f3-b977-674803dbc7f4')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (24, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'adae9c7e-6b57-4535-9a85-d0bef85ab583')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (25, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'b187b8f4-c814-4d5e-a9d8-e59d48e5947f')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (26, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'fa9f6eb6-42e7-4379-93e7-80fec8ec7565')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (27, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'15c79218-0ced-4dd9-91e4-173ffade25fc')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (28, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'901d6329-3099-411c-90ff-18079ee7fa61')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (29, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'66c536e0-9db9-4c6b-837f-882a37391712')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (30, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'21318e97-d106-4696-bfc9-e27e7a5f1eb4')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (31, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'1b970988-6650-4dd5-9a91-f5f35249f644')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (32, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'4ad466c0-a850-4032-83c1-cb6316b84e5c')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (33, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'909f112e-400c-4721-921e-bf19d495c8b0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (34, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'adb07640-d3ec-4ba9-9944-a377f8761769')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (35, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'c9cf9e81-ceb8-444f-a224-0818232bfac5')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (36, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'5c208285-3ae6-45d1-a762-2b6701bd0cdd')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (37, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'affda8e6-dafc-42a5-8850-91207689fc04')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (38, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'de0f3b80-d872-4ae3-bad7-e810683daf4a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (39, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'96455b8c-b17b-45ab-92b4-044f9c7885a2')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (40, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'10dc87d8-525c-49ec-bd72-ba2a7db76187')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (41, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'788bf403-66fa-4d83-8b00-cbb4f3dcd891')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (42, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'620e091c-3562-4528-8fbb-19163e1f4638')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (43, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'd3ee7993-7ab7-4283-a237-0fa64d833a41')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (45, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'6c4b11cb-a1b5-4fcb-858b-4ee7a8e71d65')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (46, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'002c9642-f789-4b6e-99fe-bd3e59d32d66')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (47, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'bc652726-b975-4ab7-82b2-5447fe919de6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (48, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'ad9d7ff2-1a08-4439-aa46-468eef0d5a50')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (49, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'ad9d7ff2-1a08-4439-aa46-468eef0d5f45')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (50, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'3ed8b345-6337-42f3-a57a-8e877dfdcab0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (51, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'680382f7-1e25-4342-94ee-587f8c0303e2')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (52, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'f7563540-2d50-4df6-ab9b-b20a0c637b1d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (53, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (54, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'114ee2e9-fa59-491b-90d8-28dae80ed53d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (55, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'83b477f4-cfd0-48aa-940e-daa30e42fa3d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (56, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'95f37472-c6c3-4455-8a5f-5516c4adaaf7')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (57, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'202a61f7-2327-4f17-8840-be8813e5e76d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (58, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'2e9f2400-596a-4c12-8d40-de252420e519')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (59, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'c1dd98bf-cc4d-4688-88d9-8f2ab5bab520')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (60, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'7a544814-4aee-4f77-aa57-f524e1a073a0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (61, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'b708bd78-80f7-4ceb-9394-f1d99b6ba5ee')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (62, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'12136eb8-809d-4652-866a-32d60b8bcd18')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (63, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'a70b98ff-3c30-4399-a084-925af7f2c774')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (64, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'5ffb1216-3810-4ad1-bb73-1d66c7c462ec')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (65, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'ff5c7018-2096-43ea-8d4f-0b5a940f620b')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (66, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'57f0dcf6-f956-42f9-84f9-346a3da174e7')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (67, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'f1d10c94-e815-4682-840c-010e456380b6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (68, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'7db22b4b-0fa7-4fb9-9ec3-6af6447f9071')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (69, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'cc6dffc4-4e38-4a89-bd8e-35d1b84b4249')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (70, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'ffdcdc8c-b009-4a49-bdee-9d7bd491c078')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (71, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'09710c22-d9d2-4ba0-8c86-69e32e94e8d0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (72, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'13999894-0b6e-4052-afc1-a90ff4a7bb33')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (73, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'628631ff-fa4d-43f7-bfd1-372acddbce64')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (74, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'2d816bc2-5248-44af-b226-2839daeda5f8')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (75, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'e2e945c0-6479-439b-81b6-26434497e68d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (76, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'd29f7bf7-9e6f-4e48-be6e-2e549a35b26a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (77, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'7a9962d0-830b-4b0b-be07-7bd8eddd3529')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (78, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'2b9611ca-2046-4879-a8b0-7993cc25f57b')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (79, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'2f55368e-b8f9-4b26-81fe-02a170d5af17')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (80, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'428ac73e-e029-4dd9-b944-5205473bd0a8')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (81, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'e2207879-7a81-4e91-88bc-10650fa2b061')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (82, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'aa6df866-7e91-4140-98a0-42f89c3e99cf')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (83, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'741ea582-a64b-471e-91a8-d2b3731e1e4e')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (84, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'2857f5ac-afa9-4a51-9d26-d5f4a5639fe6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (85, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'73b5e68d-c09c-4aa1-b8ef-018b8b3af054')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (86, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'1fc8faea-5cca-4457-bb81-5cd4b5bf0bbe')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (87, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'2dcac56d-b39d-45cf-a345-a238341c0ca8')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (88, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'e5698e34-5f71-493c-a5de-cf98fdf9ad5c')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (89, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'3f78e781-11b5-473f-bf05-6379b58d475a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (90, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'5d29c0ee-3b71-4f50-b257-6a4d73a4ef31')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (283, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'ed6ceba5-d1a8-4009-8134-e45d38fe32a8')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (307, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'c32dbf83-8e04-4a84-b99c-62e6cdf7d58a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (291, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'36764e26-dc35-4f3d-8d7f-945fdd87db85')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (299, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'e098c6d0-28c3-4fe9-b43f-5b945d902512')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (315, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'4ce34450-7c82-44db-b9df-b5bf9547204f')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (323, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'1b1df837-2d9d-463b-b1b8-d640052ad10e')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (419, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'2c76d195-9e02-461c-bf7e-43d763e64b9d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (421, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'98d7a3e1-45cf-44fe-a1cb-29864aca5a9e')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (422, N'a7612e1d-fcdd-437b-8e0e-fafe13da7a61', N'168f748d-904f-4cda-ab93-30f564f81c58')
GO
-- Operator role menus.
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (91, N'2667d80a-f83e-4b18-93e4-4ec48ea734ec', N'8964d431-5901-4fea-8a36-d8f4972a802a') -- Sistem Yönetimi for Operator
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (92, N'2667d80a-f83e-4b18-93e4-4ec48ea734ec', N'0885d2de-c845-4b14-81ae-adcbc0ad84fd') -- Kullanıcı Yönetimi for Operator
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (93, N'2667d80a-f83e-4b18-93e4-4ec48ea734ec', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6') -- Ana Sayfa for Operator
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (281, N'2667d80a-f83e-4b18-93e4-4ec48ea734ec', N'ed6ceba5-d1a8-4009-8134-e45d38fe32a8') -- Anket Yönetimi for Operator
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (284, N'2667d80a-f83e-4b18-93e4-4ec48ea734ec', N'36764e26-dc35-4f3d-8d7f-945fdd87db85') -- Anketlerim for Operator
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (410, N'2667d80a-f83e-4b18-93e4-4ec48ea734ec', N'f399136e-d3b9-42f3-b977-674803dbc7f4') -- Mizaç Testim for Operator
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (412, N'2667d80a-f83e-4b18-93e4-4ec48ea734ec', N'598af2e2-c286-4805-89bd-c577085bb621') -- Mizaç Profil Analiz for Operator
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (413, N'2667d80a-f83e-4b18-93e4-4ec48ea734ec', N'5d84d650-ff90-4247-8cbf-630711aa7b56') -- Organizasyon Yönetimi for Operator
GO
-- Manager role menus.
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (94, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6') -- Valid. Inserts a "Ana Sayfa" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (100, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'598af2e2-c286-4805-89bd-c577085bb621') -- Valid. Inserts a "Mizac Profil Analiz" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (101, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'f399136e-d3b9-42f3-b977-674803dbc7f4') -- Valid. Inserts a "Mizac Testim" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (102, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'adae9c7e-6b57-4535-9a85-d0bef85ab583') -- Valid. Inserts a "Ogrenci Mizac Profili Analizi" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (103, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'fa9f6eb6-42e7-4379-93e7-80fec8ec7565') -- Valid. Inserts a "Yetiskin Mizac Profili Analizi" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (104, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'15c79218-0ced-4dd9-91e4-173ffade25fc') -- Valid. Inserts a "Kisisel Gelisim" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (105, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'901d6329-3099-411c-90ff-18079ee7fa61') -- Valid. Inserts a "Zihinsel Gelisim" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (106, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'66c536e0-9db9-4c6b-837f-882a37391712') -- Valid. Inserts a "Kisilik Gelişimi" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (107, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'21318e97-d106-4696-bfc9-e27e7a5f1eb4') -- Valid. Inserts a "Sosyal Beceri Gelişimi" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (108, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'1b970988-6650-4dd5-9a91-f5f35249f644') -- Valid. Inserts a "Evrensel Yasam Becerileri" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (109, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'4ad466c0-a850-4032-83c1-cb6316b84e5c') -- Valid. Inserts a "Deger Farkindalik Gelisim " record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (110, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'909f112e-400c-4721-921e-bf19d495c8b0') -- Valid. Inserts a "Davranissal Deger Gelisim Takibi" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (120, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'd3ee7993-7ab7-4283-a237-0fa64d833a41') -- Valid. Inserts a "Rehberlik Danismanlik " record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (124, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'bc652726-b975-4ab7-82b2-5447fe919de6') -- Valid. Inserts a "Ogrenci Danismanlik Havuzu" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (125, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'ad9d7ff2-1a08-4439-aa46-468eef0d5a50') -- Valid. Inserts a "Ogrenci Danismanlik Listem" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (127, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'3ed8b345-6337-42f3-a57a-8e877dfdcab0') -- Valid. Inserts a "Sinif Yonetimi" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (166, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'5d29c0ee-3b71-4f50-b257-6a4d73a4ef31') -- Valid. Inserts a "Anketlerim" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (167, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'2dcac56d-b39d-45cf-a345-a238341c0ca8') -- Valid. Inserts a "Kuresel Yasam Becerileri" record for Manager Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (425, N'a308971f-8f17-41c5-b898-c8f3adc33535', N'680382f7-1e25-4342-94ee-587f8c0303e2')
GO
-- Teacher role menus.
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (168, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (212, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'598af2e2-c286-4805-89bd-c577085bb621')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (213, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'adae9c7e-6b57-4535-9a85-d0bef85ab583')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (214, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'fa9f6eb6-42e7-4379-93e7-80fec8ec7565')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (215, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'15c79218-0ced-4dd9-91e4-173ffade25fc')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (216, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'901d6329-3099-411c-90ff-18079ee7fa61')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (217, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'66c536e0-9db9-4c6b-837f-882a37391712')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (218, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'21318e97-d106-4696-bfc9-e27e7a5f1eb4')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (219, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'1b970988-6650-4dd5-9a91-f5f35249f644')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (220, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'4ad466c0-a850-4032-83c1-cb6316b84e5c')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (221, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'909f112e-400c-4721-921e-bf19d495c8b0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (231, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'3ed8b345-6337-42f3-a57a-8e877dfdcab0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (232, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'f7563540-2d50-4df6-ab9b-b20a0c637b1d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (233, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'f399136e-d3b9-42f3-b977-674803dbc7f4')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (234, N'46a1c2f2-aa44-41ef-a746-59ac5ec09dce', N'2dcac56d-b39d-45cf-a345-a238341c0ca8')
GO
-- Student role menus
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (238, N'deb470c7-9827-4375-b20a-bea56511ea49', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (241, N'deb470c7-9827-4375-b20a-bea56511ea49', N'598af2e2-c286-4805-89bd-c577085bb621')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (243, N'deb470c7-9827-4375-b20a-bea56511ea49', N'15c79218-0ced-4dd9-91e4-173ffade25fc')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (244, N'deb470c7-9827-4375-b20a-bea56511ea49', N'1b970988-6650-4dd5-9a91-f5f35249f644')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (245, N'deb470c7-9827-4375-b20a-bea56511ea49', N'4ad466c0-a850-4032-83c1-cb6316b84e5c')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (246, N'deb470c7-9827-4375-b20a-bea56511ea49', N'909f112e-400c-4721-921e-bf19d495c8b0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (251, N'deb470c7-9827-4375-b20a-bea56511ea49', N'788bf403-66fa-4d83-8b00-cbb4f3dcd891')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (252, N'deb470c7-9827-4375-b20a-bea56511ea49', N'f399136e-d3b9-42f3-b977-674803dbc7f4')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (253, N'deb470c7-9827-4375-b20a-bea56511ea49', N'2dcac56d-b39d-45cf-a345-a238341c0ca8')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (254, N'deb470c7-9827-4375-b20a-bea56511ea49', N'5d29c0ee-3b71-4f50-b257-6a4d73a4ef31')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (414, N'deb470c7-9827-4375-b20a-bea56511ea49', N'66c536e0-9db9-4c6b-837f-882a37391712')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (415, N'deb470c7-9827-4375-b20a-bea56511ea49', N'21318e97-d106-4696-bfc9-e27e7a5f1eb4')
GO
-- Parent Role Menus
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (255, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6') -- Valid. Inserts a "Ana Sayfa" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (258, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'598af2e2-c286-4805-89bd-c577085bb621') -- Valid. Inserts a "Mizaç Profil Analiz " record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (259, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'b187b8f4-c814-4d5e-a9d8-e59d48e5947f') -- Valid. Inserts a "Çocuğumun Mizaç Testi" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (260, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'fa9f6eb6-42e7-4379-93e7-80fec8ec7565') -- Valid. Inserts a "Yetişkin Mizaç Profili Analizi" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (261, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'15c79218-0ced-4dd9-91e4-173ffade25fc') -- Valid. Inserts a "Kişisel Gelişim " record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (262, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'901d6329-3099-411c-90ff-18079ee7fa61') -- Valid. Inserts a "Zihinsel Gelişim" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (263, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'66c536e0-9db9-4c6b-837f-882a37391712') -- Valid. Inserts a "Kişilik Gelişimi" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (264, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'21318e97-d106-4696-bfc9-e27e7a5f1eb4') -- Valid. Inserts a "Sosyal Beceri Gelişimi" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (265, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'1b970988-6650-4dd5-9a91-f5f35249f644') -- Valid. Inserts a "Evrensel Yaşam Becerileri" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (266, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'4ad466c0-a850-4032-83c1-cb6316b84e5c') -- Valid. Inserts a "Değer Farkındalık Gelişim " record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (267, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'909f112e-400c-4721-921e-bf19d495c8b0') -- Valid. Inserts a "Davranışsal Değer Gelişim Takibi" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (277, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'f399136e-d3b9-42f3-b977-674803dbc7f4') -- Valid. Inserts a "Mizaç Testim" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (278, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'2dcac56d-b39d-45cf-a345-a238341c0ca8') -- Valid. Inserts a "Küresel Yaşam Becerileri" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (279, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'D3EE7993-7AB7-4283-A237-0FA64D833A41') -- Valid. Inserts a "Rehberlik Danismanlik" record for Parent Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (280, N'13676a48-fc7a-4694-82b2-cf0ee8f06313', N'5d29c0ee-3b71-4f50-b257-6a4d73a4ef31') -- Valid. Inserts a "Anketlerim" record for Leader Teacher Role.
GO

-- Personnel role menus.
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (285, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'36764e26-dc35-4f3d-8d7f-945fdd87db85')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (293, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'e098c6d0-28c3-4fe9-b43f-5b945d902512')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (301, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'c32dbf83-8e04-4a84-b99c-62e6cdf7d58a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (309, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'4ce34450-7c82-44db-b9df-b5bf9547204f')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (317, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'1b1df837-2d9d-463b-b1b8-d640052ad10e')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (426, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (427, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'598af2e2-c286-4805-89bd-c577085bb621')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (428, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'fa9f6eb6-42e7-4379-93e7-80fec8ec7565')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (429, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'5d29c0ee-3b71-4f50-b257-6a4d73a4ef31')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (430, N'5e184c9f-69a7-4a53-bb12-58c885eca3f9', N'f399136e-d3b9-42f3-b977-674803dbc7f4')
GO
-- Organization Manager role menus.
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (290, N'c5067cd0-bebf-4e27-809f-f24eca55b1fb', N'36764e26-dc35-4f3d-8d7f-945fdd87db85')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (298, N'c5067cd0-bebf-4e27-809f-f24eca55b1fb', N'e098c6d0-28c3-4fe9-b43f-5b945d902512')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (306, N'c5067cd0-bebf-4e27-809f-f24eca55b1fb', N'c32dbf83-8e04-4a84-b99c-62e6cdf7d58a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (314, N'c5067cd0-bebf-4e27-809f-f24eca55b1fb', N'4ce34450-7c82-44db-b9df-b5bf9547204f')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (322, N'c5067cd0-bebf-4e27-809f-f24eca55b1fb', N'1b1df837-2d9d-463b-b1b8-d640052ad10e')
GO
-- Candidate role menus.
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (416, N'8b743fdc-ccfa-475d-9bb2-a6776fdb77b8', N'36764e26-dc35-4f3d-8d7f-945fdd87db85')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (417, N'8b743fdc-ccfa-475d-9bb2-a6776fdb77b8', N'f399136e-d3b9-42f3-b977-674803dbc7f4')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (418, N'8b743fdc-ccfa-475d-9bb2-a6776fdb77b8', N'598af2e2-c286-4805-89bd-c577085bb621')
GO

-- Manager Assistant role menus.
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (431, N'57447a54-040e-44ea-b312-d5389c040467', N'9994a0a6-5507-4add-999b-0b76eb8630fd')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (432, N'57447a54-040e-44ea-b312-d5389c040467', N'edd78954-d102-42d1-bb32-8a13d59a201a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (433, N'57447a54-040e-44ea-b312-d5389c040467', N'1391a4e1-3330-4cff-8dce-079e4b2743ff')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (434, N'57447a54-040e-44ea-b312-d5389c040467', N'a3196480-539b-447a-b273-fc1090f846d0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (435, N'57447a54-040e-44ea-b312-d5389c040467', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (436, N'57447a54-040e-44ea-b312-d5389c040467', N'3de0c8c1-0812-49e1-b1e0-786e7e53e951')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (437, N'57447a54-040e-44ea-b312-d5389c040467', N'6f0c8c72-057d-4d05-b5b8-3e3afccdbd01')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (438, N'57447a54-040e-44ea-b312-d5389c040467', N'96d7d6ae-afd6-4e10-968a-248efe5a674f')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (439, N'57447a54-040e-44ea-b312-d5389c040467', N'316d3daa-988e-46a6-8671-f6433df9b6d3')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (440, N'57447a54-040e-44ea-b312-d5389c040467', N'0022d087-3aa1-4a46-805e-9a58c617625d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (441, N'57447a54-040e-44ea-b312-d5389c040467', N'598af2e2-c286-4805-89bd-c577085bb621')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (442, N'57447a54-040e-44ea-b312-d5389c040467', N'f399136e-d3b9-42f3-b977-674803dbc7f4')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (443, N'57447a54-040e-44ea-b312-d5389c040467', N'adae9c7e-6b57-4535-9a85-d0bef85ab583')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (444, N'57447a54-040e-44ea-b312-d5389c040467', N'fa9f6eb6-42e7-4379-93e7-80fec8ec7565')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (445, N'57447a54-040e-44ea-b312-d5389c040467', N'15c79218-0ced-4dd9-91e4-173ffade25fc')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (446, N'57447a54-040e-44ea-b312-d5389c040467', N'901d6329-3099-411c-90ff-18079ee7fa61')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (447, N'57447a54-040e-44ea-b312-d5389c040467', N'66c536e0-9db9-4c6b-837f-882a37391712')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (448, N'57447a54-040e-44ea-b312-d5389c040467', N'21318e97-d106-4696-bfc9-e27e7a5f1eb4')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (449, N'57447a54-040e-44ea-b312-d5389c040467', N'1b970988-6650-4dd5-9a91-f5f35249f644')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (450, N'57447a54-040e-44ea-b312-d5389c040467', N'4ad466c0-a850-4032-83c1-cb6316b84e5c')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (451, N'57447a54-040e-44ea-b312-d5389c040467', N'909f112e-400c-4721-921e-bf19d495c8b0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (452, N'57447a54-040e-44ea-b312-d5389c040467', N'adb07640-d3ec-4ba9-9944-a377f8761769')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (453, N'57447a54-040e-44ea-b312-d5389c040467', N'c9cf9e81-ceb8-444f-a224-0818232bfac5')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (454, N'57447a54-040e-44ea-b312-d5389c040467', N'5c208285-3ae6-45d1-a762-2b6701bd0cdd')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (455, N'57447a54-040e-44ea-b312-d5389c040467', N'affda8e6-dafc-42a5-8850-91207689fc04')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (456, N'57447a54-040e-44ea-b312-d5389c040467', N'de0f3b80-d872-4ae3-bad7-e810683daf4a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (457, N'57447a54-040e-44ea-b312-d5389c040467', N'96455b8c-b17b-45ab-92b4-044f9c7885a2')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (458, N'57447a54-040e-44ea-b312-d5389c040467', N'10dc87d8-525c-49ec-bd72-ba2a7db76187')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (459, N'57447a54-040e-44ea-b312-d5389c040467', N'788bf403-66fa-4d83-8b00-cbb4f3dcd891')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (460, N'57447a54-040e-44ea-b312-d5389c040467', N'620e091c-3562-4528-8fbb-19163e1f4638')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (461, N'57447a54-040e-44ea-b312-d5389c040467', N'd3ee7993-7ab7-4283-a237-0fa64d833a41')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (462, N'57447a54-040e-44ea-b312-d5389c040467', N'002c9642-f789-4b6e-99fe-bd3e59d32d66')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (463, N'57447a54-040e-44ea-b312-d5389c040467', N'bc652726-b975-4ab7-82b2-5447fe919de6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (464, N'57447a54-040e-44ea-b312-d5389c040467', N'ad9d7ff2-1a08-4439-aa46-468eef0d5a50')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (465, N'57447a54-040e-44ea-b312-d5389c040467', N'3ed8b345-6337-42f3-a57a-8e877dfdcab0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (466, N'57447a54-040e-44ea-b312-d5389c040467', N'b6d140ae-1e6f-4eb0-8bc8-d1c9858faec8')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (467, N'57447a54-040e-44ea-b312-d5389c040467', N'114ee2e9-fa59-491b-90d8-28dae80ed53d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (468, N'57447a54-040e-44ea-b312-d5389c040467', N'83b477f4-cfd0-48aa-940e-daa30e42fa3d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (469, N'57447a54-040e-44ea-b312-d5389c040467', N'95f37472-c6c3-4455-8a5f-5516c4adaaf7')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (470, N'57447a54-040e-44ea-b312-d5389c040467', N'202a61f7-2327-4f17-8840-be8813e5e76d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (471, N'57447a54-040e-44ea-b312-d5389c040467', N'2e9f2400-596a-4c12-8d40-de252420e519')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (472, N'57447a54-040e-44ea-b312-d5389c040467', N'c1dd98bf-cc4d-4688-88d9-8f2ab5bab520')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (473, N'57447a54-040e-44ea-b312-d5389c040467', N'7a544814-4aee-4f77-aa57-f524e1a073a0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (474, N'57447a54-040e-44ea-b312-d5389c040467', N'b708bd78-80f7-4ceb-9394-f1d99b6ba5ee')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (475, N'57447a54-040e-44ea-b312-d5389c040467', N'12136eb8-809d-4652-866a-32d60b8bcd18')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (476, N'57447a54-040e-44ea-b312-d5389c040467', N'a70b98ff-3c30-4399-a084-925af7f2c774')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (477, N'57447a54-040e-44ea-b312-d5389c040467', N'5ffb1216-3810-4ad1-bb73-1d66c7c462ec')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (478, N'57447a54-040e-44ea-b312-d5389c040467', N'ff5c7018-2096-43ea-8d4f-0b5a940f620b')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (479, N'57447a54-040e-44ea-b312-d5389c040467', N'57f0dcf6-f956-42f9-84f9-346a3da174e7')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (480, N'57447a54-040e-44ea-b312-d5389c040467', N'f1d10c94-e815-4682-840c-010e456380b6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (481, N'57447a54-040e-44ea-b312-d5389c040467', N'7db22b4b-0fa7-4fb9-9ec3-6af6447f9071')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (482, N'57447a54-040e-44ea-b312-d5389c040467', N'cc6dffc4-4e38-4a89-bd8e-35d1b84b4249')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (483, N'57447a54-040e-44ea-b312-d5389c040467', N'ffdcdc8c-b009-4a49-bdee-9d7bd491c078')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (484, N'57447a54-040e-44ea-b312-d5389c040467', N'09710c22-d9d2-4ba0-8c86-69e32e94e8d0')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (485, N'57447a54-040e-44ea-b312-d5389c040467', N'13999894-0b6e-4052-afc1-a90ff4a7bb33')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (486, N'57447a54-040e-44ea-b312-d5389c040467', N'628631ff-fa4d-43f7-bfd1-372acddbce64')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (487, N'57447a54-040e-44ea-b312-d5389c040467', N'2d816bc2-5248-44af-b226-2839daeda5f8')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (488, N'57447a54-040e-44ea-b312-d5389c040467', N'e2e945c0-6479-439b-81b6-26434497e68d')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (489, N'57447a54-040e-44ea-b312-d5389c040467', N'd29f7bf7-9e6f-4e48-be6e-2e549a35b26a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (490, N'57447a54-040e-44ea-b312-d5389c040467', N'7a9962d0-830b-4b0b-be07-7bd8eddd3529')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (491, N'57447a54-040e-44ea-b312-d5389c040467', N'2b9611ca-2046-4879-a8b0-7993cc25f57b')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (492, N'57447a54-040e-44ea-b312-d5389c040467', N'2f55368e-b8f9-4b26-81fe-02a170d5af17')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (493, N'57447a54-040e-44ea-b312-d5389c040467', N'428ac73e-e029-4dd9-b944-5205473bd0a8')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (494, N'57447a54-040e-44ea-b312-d5389c040467', N'e2207879-7a81-4e91-88bc-10650fa2b061')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (495, N'57447a54-040e-44ea-b312-d5389c040467', N'aa6df866-7e91-4140-98a0-42f89c3e99cf')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (496, N'57447a54-040e-44ea-b312-d5389c040467', N'741ea582-a64b-471e-91a8-d2b3731e1e4e')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (497, N'57447a54-040e-44ea-b312-d5389c040467', N'2857f5ac-afa9-4a51-9d26-d5f4a5639fe6')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (498, N'57447a54-040e-44ea-b312-d5389c040467', N'73b5e68d-c09c-4aa1-b8ef-018b8b3af054')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (499, N'57447a54-040e-44ea-b312-d5389c040467', N'1fc8faea-5cca-4457-bb81-5cd4b5bf0bbe')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (500, N'57447a54-040e-44ea-b312-d5389c040467', N'e5698e34-5f71-493c-a5de-cf98fdf9ad5c')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (501, N'57447a54-040e-44ea-b312-d5389c040467', N'3f78e781-11b5-473f-bf05-6379b58d475a')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (502, N'57447a54-040e-44ea-b312-d5389c040467', N'5d29c0ee-3b71-4f50-b257-6a4d73a4ef31')
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (503, N'57447a54-040e-44ea-b312-d5389c040467', N'2dcac56d-b39d-45cf-a345-a238341c0ca8')
GO
-- Leader Teacher role menus.
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (504, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'ad5dc7e8-b610-4130-9ca5-6d01636c34b6') -- Valid. Inserts a "Ana Sayfa" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (509, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'598af2e2-c286-4805-89bd-c577085bb621') -- Valid. Inserts a "Mizaç Profil Analiz " record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (510, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'adae9c7e-6b57-4535-9a85-d0bef85ab583') -- Valid. Inserts a "Öğrenci Mizaç Profili Analizi" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (511, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'fa9f6eb6-42e7-4379-93e7-80fec8ec7565') -- Valid. Inserts a "Yetişkin Mizaç Profili Analizi" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (512, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'15c79218-0ced-4dd9-91e4-173ffade25fc') -- Valid. Inserts a "Kişisel Gelişim " record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (513, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'901d6329-3099-411c-90ff-18079ee7fa61') -- Valid. Inserts a "Zihinsel Gelişim" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (514, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'66c536e0-9db9-4c6b-837f-882a37391712') -- Valid. Inserts a "Kişilik Gelişimi" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (515, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'21318e97-d106-4696-bfc9-e27e7a5f1eb4') -- Valid. Inserts a "Sosyal Beceri Gelişimi" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (516, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'1b970988-6650-4dd5-9a91-f5f35249f644') -- Valid. Inserts a "Evrensel Yaşam Becerileri" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (517, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'4ad466c0-a850-4032-83c1-cb6316b84e5c') -- Valid. Inserts a "Değer Farkındalık Gelişim " record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (518, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'909f112e-400c-4721-921e-bf19d495c8b0') -- Valid. Inserts a "Davranışsal Değer Gelişim Takibi" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (528, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'd3ee7993-7ab7-4283-a237-0fa64d833a41') -- Valid. Inserts a "Rehberlik Danışmanlık " record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (529, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'6c4b11cb-a1b5-4fcb-858b-4ee7a8e71d65') -- Valid. Inserts a "Mizaca Özgü Anketler" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (530, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'bc652726-b975-4ab7-82b2-5447fe919de6') -- Valid. Inserts a "Öğrenci Danışmanlık Havuzu" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (531, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'ad9d7ff2-1a08-4439-aa46-468eef0d5a50') -- Valid. Inserts a "Öğrenci Danışmanlık Listem" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (532, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'ad9d7ff2-1a08-4439-aa46-468eef0d5f45') -- Valid. Inserts a "Veli Görüşmeleri" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (533, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'f399136e-d3b9-42f3-b977-674803dbc7f4') -- Valid. Inserts a "Mizaç Testim" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (535, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'5d29c0ee-3b71-4f50-b257-6a4d73a4ef31') -- Valid. Inserts a "Anketlerim" record for Leader Teacher Role.
GO
INSERT [dbo].[RoleMenuActions] ([Id], [RoleId], [MenuActionId]) VALUES (536, N'574d2187-d602-4188-a63c-c2b9dc5133df', N'2dcac56d-b39d-45cf-a345-a238341c0ca8') -- Valid. Inserts a "Küresel Yaşam Becerileri" record for Leader Teacher Role.
GO
SET IDENTITY_INSERT [dbo].[RoleMenuActions] OFF
GO



SET IDENTITY_INSERT [dbo].[Settings] ON
GO
INSERT [dbo].[Settings] ([Id], [Key], [Value], [Name]) VALUES (1,1,0, N'maintenance')
GO
SET IDENTITY_INSERT [dbo].[Settings] OFF
GO 