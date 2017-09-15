USE [OTSystem]
GO
DROP PROCEDURE [dbo].[Ins_Upd_User_Credentials]
DROP PROCEDURE [dbo].[Sel_User_Credentials]
DROP PROCEDURE [dbo].[Del_User_Credentials]
GO

-- =============================================
-- Author:		Jonathan Wilson
-- Create date: September 11, 2017
-- Description:	Read User_Credential records
-- =============================================
CREATE PROCEDURE [dbo].[Sel_User_Credentials]
	@Id				INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [Id]
		  ,[UserName]
		  ,[Password]
		  ,[UserId]
		  ,[IsActive]
		  ,[CreatedBy]
		  ,[CreatedDate]
		  ,[UpdatedBy]
		  ,[UpdateDate]
	  FROM [dbo].[User_Credentials]
	  WHERE 0			=		@Id OR
			Id			=		@Id
	  FOR JSON PATH 
END
GO

-- =============================================
-- Author:		Jonathan Wilson
-- Create date: September 11, 2017
-- Description:	Insert/Update User_Credential records
-- =============================================
CREATE PROCEDURE Ins_Upd_User_Credentials
	@UserId			int,
	@UserName		nvarchar(225),
	@Password		nvarchar(225),
	@IsActive		bit
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		IF ( @UserId = 0 ) BEGIN
			INSERT INTO [dbo].[User_Credentials]
			   ([UserName]
			   ,[Password]
			   ,[UserId]
			   ,[IsActive]
			   ,[CreatedBy]
			   ,[CreatedDate]
			   ,[UpdatedBy]
			   ,[UpdateDate])
			VALUES (
				@UserName,
				@Password,
				@UserId,
				@IsActive,
				@UserId,
				CURRENT_TIMESTAMP,
				NULL,
				NULL )
		END
		ELSE BEGIN
			UPDATE uc
			SET 
				uc.[UserName]		=	@UserName,
				uc.[Password]		=	@Password,
				uc.[IsActive]		=	@IsActive,
				uc.[UpdatedBy]		=	@UserId,
				uc.[UpdateDate]		=	CURRENT_TIMESTAMP
			FROM
				[dbo].[User_Credentials] uc
			WHERE 
				uc.[UserId]			=	@UserId AND (
				1					=	@IsActive OR
				uc.[UpdateDate]		=	(	SELECT
												MAX( uc1.UpdateDate )
											FROM
												[dbo].[User_Credentials] uc1
											WHERE												
												uc1.[UserId]		=	@UserId ))
		END
	END TRY
	BEGIN CATCH		
		 INSERT INTO [dbo].[System_Log]
		 VALUES(
			CURRENT_TIMESTAMP, 
			CASE WHEN @UserId = 0 THEN NULL ELSE @UserId END, 
			ERROR_NUMBER(), 
			ERROR_MESSAGE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE())

		RETURN ERROR_NUMBER()
	END CATCH

	RETURN 0
END
GO

-- =============================================
-- Author:		Jonathan Wilson
-- Create date: September 11, 2017
-- Description:	Delete User_Credential records
-- =============================================
CREATE PROCEDURE Del_User_Credentials
	@UserId			int
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		IF ( @UserId > 0 ) BEGIN
			DELETE FROM User_Credentials WHERE UserId = @UserId
		END
	END TRY
	BEGIN CATCH		
		 INSERT INTO [dbo].[System_Log]
		 VALUES(
			CURRENT_TIMESTAMP, 
			@UserId, 
			ERROR_NUMBER(), 
			ERROR_MESSAGE(),
			ERROR_SEVERITY(),
			ERROR_PROCEDURE(),
			ERROR_LINE())
		
		RETURN ERROR_NUMBER()
	END CATCH

	RETURN 0
END
GO


