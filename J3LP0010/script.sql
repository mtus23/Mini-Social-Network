USE [master]
GO
/****** Object:  Database [NguyenHoangMinhTu_Lab1]    Script Date: 12/8/2020 11:34:54 AM ******/
CREATE DATABASE [NguyenHoangMinhTu_Lab1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NguyenHoangMinhTu_Lab1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\NguyenHoangMinhTu_Lab1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NguyenHoangMinhTu_Lab1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\NguyenHoangMinhTu_Lab1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NguyenHoangMinhTu_Lab1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET ARITHABORT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET RECOVERY FULL 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET  MULTI_USER 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NguyenHoangMinhTu_Lab1', N'ON'
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET QUERY_STORE = OFF
GO
USE [NguyenHoangMinhTu_Lab1]
GO
/****** Object:  User [user]    Script Date: 12/8/2020 11:34:54 AM ******/
CREATE USER [user] FOR LOGIN [user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tblArticle]    Script Date: 12/8/2020 11:34:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblArticle](
	[postId] [int] IDENTITY(1,1) NOT NULL,
	[image] [varchar](max) NULL,
	[title] [nvarchar](50) NULL,
	[mail] [varchar](50) NULL,
	[status] [int] NULL,
	[date] [date] NULL,
	[description] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblArticle] PRIMARY KEY CLUSTERED 
(
	[postId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblComment]    Script Date: 12/8/2020 11:34:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblComment](
	[cmtId] [int] IDENTITY(1,1) NOT NULL,
	[postId] [int] NULL,
	[mail] [varchar](50) NULL,
	[cmtContent] [nvarchar](max) NULL,
	[date] [date] NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_tblComment] PRIMARY KEY CLUSTERED 
(
	[cmtId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblEmotion]    Script Date: 12/8/2020 11:34:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmotion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[postId] [int] NULL,
	[mail] [varchar](50) NULL,
	[likes] [bit] NULL,
	[dislikes] [bit] NULL,
	[date] [date] NULL,
 CONSTRAINT [PK_tblEmotion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblNoti]    Script Date: 12/8/2020 11:34:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNoti](
	[notiId] [int] IDENTITY(1,1) NOT NULL,
	[postId] [int] NULL,
	[mail] [varchar](50) NULL,
	[date] [date] NULL,
	[type] [varchar](10) NULL,
	[status] [int] NULL,
	[cmtId] [int] NULL,
 CONSTRAINT [PK_tblNoti] PRIMARY KEY CLUSTERED 
(
	[notiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStatus]    Script Date: 12/8/2020 11:34:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatus](
	[statusID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](10) NULL,
 CONSTRAINT [PK_tblStatus] PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 12/8/2020 11:34:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[mail] [varchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
	[password] [varchar](65) NULL,
	[role] [varchar](50) NULL,
	[statusId] [int] NULL,
	[activeKey] [varchar](4) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblArticle] ON 

INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (2, N'pumpkin02amazinglycat_1024x1024.jpg', N'pumpkin cat', N'a@mail.com', 3, CAST(N'2020-09-25' AS Date), N'hello there')
INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (3, N'120346820_1678473412307089_3501600346265187047_n.jpg', N'Grab Cat', N'a@mail.com', 2, CAST(N'2020-09-28' AS Date), N'Hello every one!!!
We''re excited to introduced our new employee!!
Grab cat delivery man!')
INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (4, N'120131883_3874000745960785_1219703760683304606_o.jpg', N'Cute cat for a rainy day', N'a@mail.com', 2, CAST(N'2020-09-28' AS Date), N'cat cat cat')
INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (5, N'120086874_4859279037446333_4297479234120455581_o.jpg', N'Among us', N'meomeo@mail.com', 3, CAST(N'2020-09-30' AS Date), N'there is a cat amongus')
INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (6, N'120303083_812957556128301_2755169614308606674_o.jpg', N'New book release', N'leo@mail.com', 2, CAST(N'2020-09-30' AS Date), N'Adventure curious cat')
INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (7, N'113268907_294966551939155_9138381491625459461_n.jpg', N'fat cat', N'whitecat@mail.com', 2, CAST(N'2020-09-30' AS Date), N'look what I have found!!')
INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (8, N'125899028_253229159478129_5181214306972818046_n.jpg', N'aaaa', N'hoadnt@gmail.com', 2, CAST(N'2020-10-05' AS Date), N'aaaa')
INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (9, N'125532815_255620839238961_6895547065696940650_n.jpg', N'ahihi', N'a@mail.com', 2, CAST(N'2020-12-08' AS Date), N'ahihi')
INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (10, N'129064305_270030521131326_4454831563954557850_o.jpg', N'aaaaaa', N'a@mail.com', 2, CAST(N'2020-12-08' AS Date), N'ahihihii')
INSERT [dbo].[tblArticle] ([postId], [image], [title], [mail], [status], [date], [description]) VALUES (11, N'129467420_270030464464665_6111127722341852453_n.jpg', N'a', N'tunhmse140357@fpt.edu.vn', 3, CAST(N'2020-12-08' AS Date), N'ahihi')
SET IDENTITY_INSERT [dbo].[tblArticle] OFF
SET IDENTITY_INSERT [dbo].[tblComment] ON 

INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (1, 3, N'a@mail.com', N'waoooo', CAST(N'2020-09-29' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (2, 3, N'meomeo@mail.com', N'waooooo', CAST(N'2020-09-29' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (4, 3, N'a@mail.com', N'I could get lost in your beautiful eyes!
', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (12, 4, N'meomeo@mail.com', N'Cat snuggles are the best. ', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (13, 5, N'leo@mail.com', N'I seeeeeeeeeeeeeeeee
', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (14, 3, N'whitecat@mail.com', N'what a cute employeeee', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (15, 5, N'meomeo@mail.com', N'Great hideout!!!!!', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (16, 4, N'meomeo@mail.com', N'sweet dreammm', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (17, 6, N'leo@mail.com', N'so cuteee', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (18, 6, N'leo@mail.com', N'so cuteeee', CAST(N'2020-09-30' AS Date), 3)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (19, 4, N'whitecat@mail.com', N'love the looks on their cute faces.

', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (20, 3, N'meomeo@mail.com', N'love the looks on their cute faces.
', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (21, 5, N'a@mail.com', N'love the looks on their cute faces.
', CAST(N'2020-09-30' AS Date), 3)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (22, 5, N'a@mail.com', N'nice hat', CAST(N'2020-09-30' AS Date), 3)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (23, 3, N'meomeo@mail.com', N'nice uniform', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (24, 4, N'leo@mail.com', N'sooo cuteeee', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (25, 5, N'meomeo@mail.com', N'My cat has the same fur pattern on her head', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (26, 3, N'brownmeomeo@mail.com', N'woahhhhhhhhh', CAST(N'2020-09-30' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (27, 5, N'hoadnt@gmail.com', N'aaaaa', CAST(N'2020-10-05' AS Date), 3)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (28, 5, N'a@mail.com', N'hihi', CAST(N'2020-12-07' AS Date), 2)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (29, 9, N'tunhmse140357@fpt.edu.vn', N'hihi', CAST(N'2020-12-08' AS Date), 3)
INSERT [dbo].[tblComment] ([cmtId], [postId], [mail], [cmtContent], [date], [status]) VALUES (30, 9, N'tunhmse140357@fpt.edu.vn', N'hihi
', CAST(N'2020-12-08' AS Date), 2)
SET IDENTITY_INSERT [dbo].[tblComment] OFF
SET IDENTITY_INSERT [dbo].[tblEmotion] ON 

INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (1, 2, N'a@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (2, 4, N'a@mail.com', 0, 1, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (3, 4, N'meomeo@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (4, 2, N'meomeo@mail.com', 0, 1, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (5, 2, N'leo@mail.com', 0, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (6, 3, N'meomeo@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (7, 5, N'meomeo@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (8, 4, N'leo@mail.com', 0, 1, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (9, 3, N'leo@mail.com', 0, 1, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (10, 5, N'leo@mail.com', 0, 1, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (11, 6, N'leo@mail.com', 0, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (12, 5, N'whitecat@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (13, 3, N'whitecat@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (14, 4, N'whitecat@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (15, 7, N'whitecat@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (16, 7, N'a@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (17, 5, N'brownmeomeo@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (18, 7, N'brownmeomeo@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (19, 3, N'brownmeomeo@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (20, 4, N'brownmeomeo@mail.com', 1, 0, CAST(N'2020-09-30' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (21, 5, N'hoadnt@gmail.com', 1, 0, CAST(N'2020-10-05' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (22, 3, N'a@mail.com', 1, 0, CAST(N'2020-12-07' AS Date))
INSERT [dbo].[tblEmotion] ([Id], [postId], [mail], [likes], [dislikes], [date]) VALUES (23, 9, N'tunhmse140357@fpt.edu.vn', 1, 0, CAST(N'2020-12-08' AS Date))
SET IDENTITY_INSERT [dbo].[tblEmotion] OFF
SET IDENTITY_INSERT [dbo].[tblNoti] ON 

INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (1, 3, N'meomeo@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 5, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (2, 4, N'meomeo@mail.com', CAST(N'2020-09-30' AS Date), N'dislikes', 5, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (3, 5, N'meomeo@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 3, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (4, 4, N'meomeo@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 5, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (5, 4, N'meomeo@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 5, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (6, 4, N'meomeo@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 5, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (7, 4, N'leo@mail.com', CAST(N'2020-09-30' AS Date), N'dislikes', 5, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (8, 3, N'leo@mail.com', CAST(N'2020-09-30' AS Date), N'dislikes', 5, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (9, 5, N'leo@mail.com', CAST(N'2020-09-30' AS Date), N'dislikes', 3, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (10, 4, N'meomeo@mail.com', CAST(N'2020-09-30' AS Date), N'comments', 5, 16)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (11, 5, N'whitecat@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 3, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (12, 3, N'whitecat@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 5, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (13, 4, N'whitecat@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 4, NULL)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (16, 5, N'a@mail.com', CAST(N'2020-09-30' AS Date), N'comments', 3, 21)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (17, 5, N'a@mail.com', CAST(N'2020-09-30' AS Date), N'comments', 3, 22)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (18, 3, N'meomeo@mail.com', CAST(N'2020-09-30' AS Date), N'comments', 5, 23)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (19, 4, N'leo@mail.com', CAST(N'2020-09-30' AS Date), N'comments', 5, 24)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (21, 7, N'brownmeomeo@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 5, 0)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (22, 3, N'brownmeomeo@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 5, 0)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (23, 3, N'brownmeomeo@mail.com', CAST(N'2020-09-30' AS Date), N'comments', 4, 26)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (24, 4, N'brownmeomeo@mail.com', CAST(N'2020-09-30' AS Date), N'likes', 5, 0)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (25, 5, N'hoadnt@gmail.com', CAST(N'2020-10-05' AS Date), N'likes', 3, 0)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (26, 5, N'hoadnt@gmail.com', CAST(N'2020-10-05' AS Date), N'comments', 3, 27)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (27, 5, N'a@mail.com', CAST(N'2020-12-07' AS Date), N'comments', 3, 28)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (28, 9, N'tunhmse140357@fpt.edu.vn', CAST(N'2020-12-08' AS Date), N'likes', 3, 0)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (29, 9, N'tunhmse140357@fpt.edu.vn', CAST(N'2020-12-08' AS Date), N'dislikes', 5, 0)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (30, 9, N'tunhmse140357@fpt.edu.vn', CAST(N'2020-12-08' AS Date), N'likes', 5, 0)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (31, 9, N'tunhmse140357@fpt.edu.vn', CAST(N'2020-12-08' AS Date), N'likes', 5, 0)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (32, 9, N'tunhmse140357@fpt.edu.vn', CAST(N'2020-12-08' AS Date), N'likes', 5, 0)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (33, 9, N'tunhmse140357@fpt.edu.vn', CAST(N'2020-12-08' AS Date), N'comments', 3, 29)
INSERT [dbo].[tblNoti] ([notiId], [postId], [mail], [date], [type], [status], [cmtId]) VALUES (34, 9, N'tunhmse140357@fpt.edu.vn', CAST(N'2020-12-08' AS Date), N'comments', 5, 30)
SET IDENTITY_INSERT [dbo].[tblNoti] OFF
SET IDENTITY_INSERT [dbo].[tblStatus] ON 

INSERT [dbo].[tblStatus] ([statusID], [Name]) VALUES (1, N'New')
INSERT [dbo].[tblStatus] ([statusID], [Name]) VALUES (2, N'Active')
INSERT [dbo].[tblStatus] ([statusID], [Name]) VALUES (3, N'Delete')
INSERT [dbo].[tblStatus] ([statusID], [Name]) VALUES (4, N'Read')
INSERT [dbo].[tblStatus] ([statusID], [Name]) VALUES (5, N'Unread')
SET IDENTITY_INSERT [dbo].[tblStatus] OFF
INSERT [dbo].[tblUser] ([mail], [name], [password], [role], [statusId], [activeKey]) VALUES (N'a@mail.com', N'tus', N'1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a', N'member', 2, N'1234')
INSERT [dbo].[tblUser] ([mail], [name], [password], [role], [statusId], [activeKey]) VALUES (N'admin', N'admin', N'1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a', N'admin', 2, NULL)
INSERT [dbo].[tblUser] ([mail], [name], [password], [role], [statusId], [activeKey]) VALUES (N'brownmeomeo@mail.com', N'Brown meo', N'1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a', N'member', 2, NULL)
INSERT [dbo].[tblUser] ([mail], [name], [password], [role], [statusId], [activeKey]) VALUES (N'happycat@mail.com', N'happy cat', N'1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a', N'member', 2, NULL)
INSERT [dbo].[tblUser] ([mail], [name], [password], [role], [statusId], [activeKey]) VALUES (N'hoadnt@gmail.com', N'hoadnt', N'1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a', N'member', 2, NULL)
INSERT [dbo].[tblUser] ([mail], [name], [password], [role], [statusId], [activeKey]) VALUES (N'leo@mail.com', N'Leo the cat', N'1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a', N'member', 2, NULL)
INSERT [dbo].[tblUser] ([mail], [name], [password], [role], [statusId], [activeKey]) VALUES (N'meomeo@mail.com', N'white cat coffee', N'c565fe03ca9b6242e01dfddefe9bba3d98b270e19cd02fd85ceaf75e2b25bf12', N'member', 2, NULL)
INSERT [dbo].[tblUser] ([mail], [name], [password], [role], [statusId], [activeKey]) VALUES (N'tunhmse140357@fpt.edu.vn', N'Tu Nguyen', N'1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a', N'member', 2, N'8285')
INSERT [dbo].[tblUser] ([mail], [name], [password], [role], [statusId], [activeKey]) VALUES (N'whitecat@mail.com', N'white cat', N'1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a', N'member', 2, NULL)
ALTER TABLE [dbo].[tblArticle]  WITH CHECK ADD  CONSTRAINT [FK_tblArticle_tblStatus] FOREIGN KEY([status])
REFERENCES [dbo].[tblStatus] ([statusID])
GO
ALTER TABLE [dbo].[tblArticle] CHECK CONSTRAINT [FK_tblArticle_tblStatus]
GO
ALTER TABLE [dbo].[tblComment]  WITH NOCHECK ADD  CONSTRAINT [FK_tblComment_tblArticle1] FOREIGN KEY([postId])
REFERENCES [dbo].[tblArticle] ([postId])
GO
ALTER TABLE [dbo].[tblComment] CHECK CONSTRAINT [FK_tblComment_tblArticle1]
GO
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD  CONSTRAINT [FK_tblComment_tblUser] FOREIGN KEY([mail])
REFERENCES [dbo].[tblUser] ([mail])
GO
ALTER TABLE [dbo].[tblComment] CHECK CONSTRAINT [FK_tblComment_tblUser]
GO
ALTER TABLE [dbo].[tblEmotion]  WITH NOCHECK ADD  CONSTRAINT [FK_tblEmotion_tblArticle] FOREIGN KEY([postId])
REFERENCES [dbo].[tblArticle] ([postId])
GO
ALTER TABLE [dbo].[tblEmotion] CHECK CONSTRAINT [FK_tblEmotion_tblArticle]
GO
ALTER TABLE [dbo].[tblEmotion]  WITH CHECK ADD  CONSTRAINT [FK_tblEmotion_tblUser] FOREIGN KEY([mail])
REFERENCES [dbo].[tblUser] ([mail])
GO
ALTER TABLE [dbo].[tblEmotion] CHECK CONSTRAINT [FK_tblEmotion_tblUser]
GO
ALTER TABLE [dbo].[tblNoti]  WITH NOCHECK ADD  CONSTRAINT [FK_tblNoti_tblArticle] FOREIGN KEY([postId])
REFERENCES [dbo].[tblArticle] ([postId])
GO
ALTER TABLE [dbo].[tblNoti] CHECK CONSTRAINT [FK_tblNoti_tblArticle]
GO
ALTER TABLE [dbo].[tblNoti]  WITH CHECK ADD  CONSTRAINT [FK_tblNoti_tblUser] FOREIGN KEY([mail])
REFERENCES [dbo].[tblUser] ([mail])
GO
ALTER TABLE [dbo].[tblNoti] CHECK CONSTRAINT [FK_tblNoti_tblUser]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblUser] FOREIGN KEY([statusId])
REFERENCES [dbo].[tblStatus] ([statusID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblUser]
GO
USE [master]
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab1] SET  READ_WRITE 
GO
