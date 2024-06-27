﻿PRINT 'Inserting Application.Cities Y'
GO

BEGIN TRANSACTION

DECLARE @CurrentDateTime datetime2(7) = '20200101'
DECLARE @EndOfTime datetime2(7) =  '99991231 23:59:59.9999999'

INSERT [Application].Cities (CityID, CityName, StateProvinceID, [Location], LatestRecordedPopulation, LastEditedBy, ValidFrom, ValidTo)
VALUES (37968, 'Y City', [DataLoadSimulation].[GetStateProvinceID] ('AR'), 0xe6100000010c162532bd0e5e414056945c0ff08457c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38069, 'Yorkana', [DataLoadSimulation].[GetStateProvinceID] ('PA'), 0xe6100000010c61fa038afdfc43406242716c622553c0, 229, 1, @CurrentDateTime, @EndOfTime)
     , (38070, 'Yorkfield', [DataLoadSimulation].[GetStateProvinceID] ('IL'), 0xe6100000010c4647cdb282ee44403969d086b2fc55c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38071, 'Yorklyn', [DataLoadSimulation].[GetStateProvinceID] ('DE'), 0xe6100000010c195cce0072e74340295547333beb52c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38072, 'Yorkshire', [DataLoadSimulation].[GetStateProvinceID] ('NY'), 0xe6100000010c6d6bb015d94345402668dd50429e53c0, 1180, 1, @CurrentDateTime, @EndOfTime)
     , (38073, 'Yorkshire', [DataLoadSimulation].[GetStateProvinceID] ('VA'), 0xe6100000010cf7555e978665434045509033a85c53c0, 7541, 1, @CurrentDateTime, @EndOfTime)
     , (38074, 'Yorkshire', [DataLoadSimulation].[GetStateProvinceID] ('OH'), 0xe6100000010c47489341a4294440cc199b67b61f55c0, 96, 1, @CurrentDateTime, @EndOfTime)
     , (38075, 'Yorktown', [DataLoadSimulation].[GetStateProvinceID] ('IA'), 0xe6100000010c8fa5b4a3dd5d4440d7b7dd150bca57c0, 85, 1, @CurrentDateTime, @EndOfTime)
     , (38076, 'Yorktown', [DataLoadSimulation].[GetStateProvinceID] ('IN'), 0xe6100000010cfaa534513a164440256ab3fb9f5f55c0, 9405, 1, @CurrentDateTime, @EndOfTime)
     , (38077, 'Yorktown', [DataLoadSimulation].[GetStateProvinceID] ('VA'), 0xe6100000010c51de228b8f9e4240a909ec7b9e2053c0, 195, 1, @CurrentDateTime, @EndOfTime)
     , (38078, 'Yorktown', [DataLoadSimulation].[GetStateProvinceID] ('AR'), 0xe6100000010c06f2ecf2ad0241401d99fd7046f456c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38079, 'Yorktown', [DataLoadSimulation].[GetStateProvinceID] ('TX'), 0xe6100000010ccd78b6a228fb3c4042f6306a2d6058c0, 2092, 1, @CurrentDateTime, @EndOfTime)
     , (38080, 'Yorktown', [DataLoadSimulation].[GetStateProvinceID] ('NY'), 0xe6100000010ca98999d8d7a5444012bd8c62b97352c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38081, 'Yorktown Heights', [DataLoadSimulation].[GetStateProvinceID] ('NY'), 0xe6100000010c8f4bc1bfada244405411b8bfc47152c0, 1781, 1, @CurrentDateTime, @EndOfTime)
     , (38082, 'Yorkville', [DataLoadSimulation].[GetStateProvinceID] ('NY'), 0xe6100000010cbaf770c9718e4540b5ef9b0c58d152c0, 2689, 1, @CurrentDateTime, @EndOfTime)
     , (38083, 'Yorkville', [DataLoadSimulation].[GetStateProvinceID] ('IL'), 0xe6100000010c63d0aee710d24440ef6a5e7aa01c56c0, 16921, 1, @CurrentDateTime, @EndOfTime)
     , (38084, 'Yorkville', [DataLoadSimulation].[GetStateProvinceID] ('OH'), 0xe6100000010c239b502dc71344404cbca882762d54c0, 1079, 1, @CurrentDateTime, @EndOfTime)
     , (38085, 'Yorkville', [DataLoadSimulation].[GetStateProvinceID] ('TN'), 0xe6100000010cc341e7dabc0c4240c268fbfc9c4756c0, 286, 1, @CurrentDateTime, @EndOfTime)
     , (38086, 'Yorkville', [DataLoadSimulation].[GetStateProvinceID] ('WI'), 0xe6100000010c0aad3da2f85e45407f092648b60156c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38087, 'Yorkville', [DataLoadSimulation].[GetStateProvinceID] ('GA'), 0xe6100000010c079a2a734ef640407f092648b63f55c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38088, 'Yosemite', [DataLoadSimulation].[GetStateProvinceID] ('KY'), 0xe6100000010c2713b70a62ac42405e9cf86ac73455c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38089, 'Yosemite Lakes', [DataLoadSimulation].[GetStateProvinceID] ('CA'), 0xe6100000010cb88fdc9a74984240018a912573f15dc0, 4952, 1, @CurrentDateTime, @EndOfTime)
     , (38090, 'Yosemite Village', [DataLoadSimulation].[GetStateProvinceID] ('CA'), 0xe6100000010cf16f86d162df4240f2b1bb4049e65dc0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38091, 'Young', [DataLoadSimulation].[GetStateProvinceID] ('AZ'), 0xe6100000010c20e39bb7fb0c414000bfebd8adbd5bc0, 666, 1, @CurrentDateTime, @EndOfTime)
     , (38092, 'Young America', [DataLoadSimulation].[GetStateProvinceID] ('IN'), 0xe6100000010c0434b67cc9484440ac2d86bc2f9655c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38093, 'Young Harris', [DataLoadSimulation].[GetStateProvinceID] ('GA'), 0xe6100000010c43f5204e71774140968d734037f654c0, 899, 1, @CurrentDateTime, @EndOfTime)
     , (38094, 'Youngstown', [DataLoadSimulation].[GetStateProvinceID] ('NY'), 0xe6100000010c9f8724c4a69f4540aa91a7f633c353c0, 1935, 1, @CurrentDateTime, @EndOfTime)
     , (38095, 'Youngstown', [DataLoadSimulation].[GetStateProvinceID] ('OH'), 0xe6100000010c7da4d299c58c44408647d1b9912954c0, 66982, 1, @CurrentDateTime, @EndOfTime)
     , (38096, 'Youngstown', [DataLoadSimulation].[GetStateProvinceID] ('PA'), 0xe6100000010c6c14483fd0234440f04c0dd965d753c0, 326, 1, @CurrentDateTime, @EndOfTime)
     , (38097, 'Youngstown', [DataLoadSimulation].[GetStateProvinceID] ('FL'), 0xe6100000010c05e165e1465d3e40facf3f660c5c55c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38098, 'Youngsville', [DataLoadSimulation].[GetStateProvinceID] ('NM'), 0xe6100000010ce8757a9400184240922c16759ca35ac0, 56, 1, @CurrentDateTime, @EndOfTime)
     , (38099, 'Youngsville', [DataLoadSimulation].[GetStateProvinceID] ('PA'), 0xe6100000010cb240608a17ed44406783a7eb64d453c0, 1729, 1, @CurrentDateTime, @EndOfTime)
     , (38100, 'Youngsville', [DataLoadSimulation].[GetStateProvinceID] ('LA'), 0xe6100000010c28a4eb7882193e402306cb225eff56c0, 8105, 1, @CurrentDateTime, @EndOfTime)
     , (38101, 'Youngsville', [DataLoadSimulation].[GetStateProvinceID] ('NC'), 0xe6100000010c0046860b2f0342405992f2495d9e53c0, 1157, 1, @CurrentDateTime, @EndOfTime)
     , (38102, 'Youngtown', [DataLoadSimulation].[GetStateProvinceID] ('AZ'), 0xe6100000010c74d602d605cc404092f1834e63135cc0, 6156, 1, @CurrentDateTime, @EndOfTime)
     , (38103, 'Youngwood', [DataLoadSimulation].[GetStateProvinceID] ('PA'), 0xe6100000010c5ad427b9c31e4440ca98ccc2e8e453c0, 3050, 1, @CurrentDateTime, @EndOfTime)
     , (38104, 'Yountville', [DataLoadSimulation].[GetStateProvinceID] ('CA'), 0xe6100000010c192543e9663343406b63ec8417975ec0, 2933, 1, @CurrentDateTime, @EndOfTime)
     , (38105, 'Ypsilanti', [DataLoadSimulation].[GetStateProvinceID] ('ND'), 0xe6100000010c1ee3e54416644740ef6f75a50aa458c0, 104, 1, @CurrentDateTime, @EndOfTime)
     , (38106, 'Ypsilanti', [DataLoadSimulation].[GetStateProvinceID] ('MI'), 0xe6100000010c83f7faffdd1e45407149c44a3be754c0, 19435, 1, @CurrentDateTime, @EndOfTime)
     , (38107, 'Yreka', [DataLoadSimulation].[GetStateProvinceID] ('CA'), 0xe6100000010cf4ae303322de444016116a2b9ba85ec0, 7765, 1, @CurrentDateTime, @EndOfTime)
     , (38108, 'Yscloskey', [DataLoadSimulation].[GetStateProvinceID] ('LA'), 0xe6100000010c036674f684d73d40bdf3d59f0e6c56c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38109, 'Yuba', [DataLoadSimulation].[GetStateProvinceID] ('WI'), 0xe6100000010c03bcbb84f9c44540932930ae829b56c0, 74, 1, @CurrentDateTime, @EndOfTime)
     , (38110, 'Yuba City', [DataLoadSimulation].[GetStateProvinceID] ('CA'), 0xe6100000010c3326b330fa91434026a36f777b675ec0, 64925, 1, @CurrentDateTime, @EndOfTime)
     , (38111, 'Yucaipa', [DataLoadSimulation].[GetStateProvinceID] ('CA'), 0xe6100000010cfca9f1d24d0441408b19e1edc1425dc0, 51367, 1, @CurrentDateTime, @EndOfTime)
     , (38112, 'Yucca', [DataLoadSimulation].[GetStateProvinceID] ('AZ'), 0xe6100000010cf990a630a56f4140c26856b68f895cc0, 126, 1, @CurrentDateTime, @EndOfTime)
     , (38113, 'Yucca Valley', [DataLoadSimulation].[GetStateProvinceID] ('CA'), 0xe6100000010c984572439d0e4140f14bfdbca91b5dc0, 20700, 1, @CurrentDateTime, @EndOfTime)
     , (38114, 'Yukon', [DataLoadSimulation].[GetStateProvinceID] ('OK'), 0xe6100000010ca9d18a3c60c0414050c63f06077058c0, 22709, 1, @CurrentDateTime, @EndOfTime)
     , (38115, 'Yukon', [DataLoadSimulation].[GetStateProvinceID] ('PA'), 0xe6100000010c68caf385351b4440ec83d151b3eb53c0, 677, 1, @CurrentDateTime, @EndOfTime)
     , (38116, 'Yukon', [DataLoadSimulation].[GetStateProvinceID] ('MO'), 0xe6100000010ce8b4b810f5a2424081107f0349f656c0, NULL, 1, @CurrentDateTime, @EndOfTime)
     , (38117, 'Yulee', [DataLoadSimulation].[GetStateProvinceID] ('FL'), 0xe6100000010c303bd56bc4a13e40951d2cadd06654c0, 11491, 1, @CurrentDateTime, @EndOfTime)
     , (38118, 'Yuma', [DataLoadSimulation].[GetStateProvinceID] ('CO'), 0xe6100000010cf3a55c86a40f4440b2af86d569ae59c0, 3524, 1, @CurrentDateTime, @EndOfTime)
     , (38119, 'Yuma', [DataLoadSimulation].[GetStateProvinceID] ('AZ'), 0xe6100000010cbb3c4272d75c40401daed51ef6a75cc0, 93064, 1, @CurrentDateTime, @EndOfTime)
     , (38120, 'Yutan', [DataLoadSimulation].[GetStateProvinceID] ('NE'), 0xe6100000010ca1ffd42e5c9f4440bd3ac7806c1958c0, 1174, 1, @CurrentDateTime, @EndOfTime)
COMMIT
GO