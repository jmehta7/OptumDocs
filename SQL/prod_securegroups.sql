USE [BTB]
GO
SET IDENTITY_INSERT [CS].[UserSecureGroupRoles] ON 

INSERT [CS].[UserSecureGroupRoles] ([GroupRoleId], [SecureGroup], [Role]) VALUES (1, N'btbcs_prod_portal_admin_role', 1228)
INSERT [CS].[UserSecureGroupRoles] ([GroupRoleId], [SecureGroup], [Role]) VALUES (2, N'btbcs_prod_portal_normal_user_role', 1229)
INSERT [CS].[UserSecureGroupRoles] ([GroupRoleId], [SecureGroup], [Role]) VALUES (3, N'btbcs_prod_portal_ro_user_role', 1230)
SET IDENTITY_INSERT [CS].[UserSecureGroupRoles] OFF
