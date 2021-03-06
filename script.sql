USE [master]
GO
/****** Object:  Database [Scuola]    Script Date: 5/13/2021 3:52:35 PM ******/
CREATE DATABASE [Scuola]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Scuola', FILENAME = N'C:\Users\catal\Scuola.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Scuola_log', FILENAME = N'C:\Users\catal\Scuola_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Scuola] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Scuola].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Scuola] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Scuola] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Scuola] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Scuola] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Scuola] SET ARITHABORT OFF 
GO
ALTER DATABASE [Scuola] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Scuola] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Scuola] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Scuola] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Scuola] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Scuola] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Scuola] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Scuola] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Scuola] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Scuola] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Scuola] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Scuola] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Scuola] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Scuola] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Scuola] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Scuola] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Scuola] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Scuola] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Scuola] SET  MULTI_USER 
GO
ALTER DATABASE [Scuola] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Scuola] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Scuola] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Scuola] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Scuola] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Scuola] SET QUERY_STORE = OFF
GO
USE [Scuola]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Scuola]
GO
/****** Object:  Table [dbo].[Persone]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persone](
	[IdPersona] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](50) NOT NULL,
	[Cognome] [nvarchar](50) NOT NULL,
	[DataNascita] [date] NOT NULL,
 CONSTRAINT [PK_Persone] PRIMARY KEY CLUSTERED 
(
	[IdPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Docenti]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Docenti](
	[IdDocente] [int] NOT NULL,
	[TitoloStudio] [nvarchar](50) NULL,
 CONSTRAINT [PK_Docenti] PRIMARY KEY CLUSTERED 
(
	[IdDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaDocenti]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaDocenti]
AS
SELECT dbo.Docenti.IdDocente, dbo.Persone.Nome, dbo.Persone.Cognome, dbo.Docenti.TitoloStudio, dbo.Persone.DataNascita
FROM     dbo.Docenti INNER JOIN
                  dbo.Persone ON dbo.Docenti.IdDocente = dbo.Persone.IdPersona
GO
/****** Object:  Table [dbo].[Studenti]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Studenti](
	[IdStudente] [int] NOT NULL,
	[IdClasse] [int] NOT NULL,
 CONSTRAINT [PK_Studenti] PRIMARY KEY CLUSTERED 
(
	[IdStudente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classi]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classi](
	[IdClasse] [int] IDENTITY(1,1) NOT NULL,
	[Sezione] [nchar](1) NOT NULL,
	[Classe] [int] NOT NULL,
 CONSTRAINT [PK_Classi] PRIMARY KEY CLUSTERED 
(
	[IdClasse] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Classi] UNIQUE NONCLUSTERED 
(
	[Classe] ASC,
	[Sezione] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaStudente]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaStudente]
AS
SELECT dbo.Persone.Nome, dbo.Persone.Cognome, dbo.Persone.DataNascita, dbo.Studenti.IdStudente, CONVERT(nchar(1), dbo.Classi.Classe) + dbo.Classi.Sezione AS Classe
FROM     dbo.Classi INNER JOIN
                  dbo.Studenti ON dbo.Classi.IdClasse = dbo.Studenti.IdClasse INNER JOIN
                  dbo.Persone ON dbo.Studenti.IdStudente = dbo.Persone.IdPersona
GO
/****** Object:  View [dbo].[VistaNumeroStudentiPerCLasse]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaNumeroStudentiPerCLasse]
AS
SELECT dbo.Classi.IdClasse, dbo.Classi.Sezione, dbo.Classi.Classe, COUNT(*) AS NumeroStudenti
FROM     dbo.Classi INNER JOIN
                  dbo.Studenti ON dbo.Classi.IdClasse = dbo.Studenti.IdClasse
GROUP BY dbo.Classi.IdClasse, dbo.Classi.Sezione, dbo.Classi.Classe
GO
/****** Object:  Table [dbo].[Cattedre]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cattedre](
	[IdCattedra] [int] IDENTITY(1,1) NOT NULL,
	[IdDocente] [int] NOT NULL,
	[IdClasse] [int] NOT NULL,
 CONSTRAINT [PK_Cattedre] PRIMARY KEY CLUSTERED 
(
	[IdCattedra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cattedre]  WITH CHECK ADD  CONSTRAINT [FK_Cattedre_Classi] FOREIGN KEY([IdClasse])
REFERENCES [dbo].[Classi] ([IdClasse])
GO
ALTER TABLE [dbo].[Cattedre] CHECK CONSTRAINT [FK_Cattedre_Classi]
GO
ALTER TABLE [dbo].[Cattedre]  WITH CHECK ADD  CONSTRAINT [FK_Cattedre_Docenti] FOREIGN KEY([IdDocente])
REFERENCES [dbo].[Docenti] ([IdDocente])
GO
ALTER TABLE [dbo].[Cattedre] CHECK CONSTRAINT [FK_Cattedre_Docenti]
GO
ALTER TABLE [dbo].[Docenti]  WITH CHECK ADD  CONSTRAINT [FK_Docenti_Persone] FOREIGN KEY([IdDocente])
REFERENCES [dbo].[Persone] ([IdPersona])
GO
ALTER TABLE [dbo].[Docenti] CHECK CONSTRAINT [FK_Docenti_Persone]
GO
ALTER TABLE [dbo].[Studenti]  WITH CHECK ADD  CONSTRAINT [FK_Studenti_Classi] FOREIGN KEY([IdClasse])
REFERENCES [dbo].[Classi] ([IdClasse])
GO
ALTER TABLE [dbo].[Studenti] CHECK CONSTRAINT [FK_Studenti_Classi]
GO
ALTER TABLE [dbo].[Studenti]  WITH CHECK ADD  CONSTRAINT [FK_Studenti_Persone] FOREIGN KEY([IdStudente])
REFERENCES [dbo].[Persone] ([IdPersona])
GO
ALTER TABLE [dbo].[Studenti] CHECK CONSTRAINT [FK_Studenti_Persone]
GO
/****** Object:  StoredProcedure [dbo].[InserimentoDocente]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InserimentoDocente]
	-- Add the parameters for the stored procedure here
	@nome nvarchar(50), 
	@cognome nvarchar(50),
	@dataNascita date,
	@titoloStudio nvarchar(50) = null
AS
BEGIN
	insert into Persone values (@nome,@cognome, @dataNascita)
	insert into Docenti values (@@IDENTITY, @titoloStudio)
END
GO
/****** Object:  StoredProcedure [dbo].[InserimentoStudente]    Script Date: 5/13/2021 3:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InserimentoStudente]
	-- Add the parameters for the stored procedure here
	@nome nvarchar(50), 
	@cognome nvarchar(50),
	@dataNascita date,
	@classe int,
	@sezione nchar(1)
AS
BEGIN
	insert into Persone values (@nome,@cognome, @dataNascita)
	insert into Studenti values (@@IDENTITY, 
	(select IdClasse from Classi where Sezione = @sezione and Classe = @classe))
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Docenti"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Persone"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaDocenti'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaDocenti'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Classi"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Studenti"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 126
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaNumeroStudentiPerCLasse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaNumeroStudentiPerCLasse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Classi"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Persone"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Studenti"
            Begin Extent = 
               Top = 7
               Left = 532
               Bottom = 126
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4776
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaStudente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaStudente'
GO
USE [master]
GO
ALTER DATABASE [Scuola] SET  READ_WRITE 
GO
