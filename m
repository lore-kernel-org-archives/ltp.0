Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB127D6EBFD
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 10:36:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4ED083DBFF7
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 11:36:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C626F3DBFC9
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 11:36:36 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 775056342DF
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 11:36:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUHhmao8AEWsj5Wq/Mj9g/kUVgUUToDlxXD6QrsgydnUfJnuVvEUllv+3XiHb2wBR4ExP6XDBHCpTT1y6cLEfjWYUPv1jhOTXoccbGhi/Ft/uPlsmVIkRd7TZu6MHZWr5Xm7iyC+AMa4l5WfgDJn1Jw/ZfN4fwgS9byfQTwttxTQL4kcJd/IypoDYT2DfztLA9IEtjS0BKmU5APIpqa4JjcZm9poFMWJcur+47Ym8f0uamfWSG8/VV2iO0Rn3a3iZVwjGpRkAFUmOPep03dO4YFBNln2cPVcalelST9fzHGrvhdluieljWpuT7rtPC42T9MsuYeenpWp8YmKCqD9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrMGUuiphL+zLaiDgaJrqkAYjPrlRgfliZ9wZHdVh6A=;
 b=VLsi9AX+Je5stcdwczdrqv3Der1JhDNgsNFuPLMBxJ2S7ClbUAKI6utN1mxEAQuhaBVwyqPJEp6221QL9cdKMtXlWpkUitFf+dnHC9z62K9e8VX/tfZHHEejVn0vyvqHeKUHzAfEnzS46MQb7ezUQBMUPwHyEb+L5SZRUEHx7TgBEKdY8+Wuw1WpU8q2L9d7hWlxdw//CZzozYrS1DUGKF0KROIDccqqOyU7WaSDZVim97A+s/C8ZIEDf5OQT23UzPwg9UWMmIwLN/VymaW/rVFy2UOlrpaoxF+ufq+GRKQzVpyYC1F5QZ9AYXJEaiwccH7MY6hIH5qnzjMWNJbO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alifsemi.com; dmarc=pass action=none header.from=alifsemi.com;
 dkim=pass header.d=alifsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alifsemi.onmicrosoft.com; s=selector2-alifsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrMGUuiphL+zLaiDgaJrqkAYjPrlRgfliZ9wZHdVh6A=;
 b=lGS0wb+y7pMOh77TgaFN4fDyiF5TyMOeWIBBxB/WtdHNgudvL13Btqq9un2efO/Ks03+3zyjVkxZ6opKVPtug7EMLexL+8ev582PCfDDmHlex/PD5Ahwe+6kP6Ti0r/W0mQScSw+/zUQVt/KXb6TcHi1sWGxmdkpYP9b8OojiyM=
Received: from LV1PR22MB6014.namprd22.prod.outlook.com (2603:10b6:408:2b4::11)
 by BY1PR22MB5600.namprd22.prod.outlook.com (2603:10b6:a03:4b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Fri, 29 Nov
 2024 10:36:30 +0000
Received: from LV1PR22MB6014.namprd22.prod.outlook.com
 ([fe80::ec4a:ae17:b696:7dc8]) by LV1PR22MB6014.namprd22.prod.outlook.com
 ([fe80::ec4a:ae17:b696:7dc8%5]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 10:36:29 +0000
From: R Akshay Dharmapuri <raghavendra.akshay@alifsemi.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Regarding LTP testing on target hardware linux kernel 5.4.25 arm
 32 bit
Thread-Index: AQHbQkndA+Lmm7lhb0a9z5uKmY9cQg==
Date: Fri, 29 Nov 2024 10:36:29 +0000
Message-ID: <LV1PR22MB60148DD23B9B82A8673231BEF52A2@LV1PR22MB6014.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alifsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR22MB6014:EE_|BY1PR22MB5600:EE_
x-ms-office365-filtering-correlation-id: 5d9578d4-e42e-44fe-67f3-08dd1061af0a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+PbTtTwk0ORP275b6C0D9V+QGo/WJp5sGsZqBdu6b4EU2a3Vgl35tGfVNP?=
 =?iso-8859-1?Q?iPN4y6dfs7Kq7ptfJMOZPq7az4ATF/QCGU+E6tFBdo13/r/g4nVIZkuQwx?=
 =?iso-8859-1?Q?9129hv7n7iZKRTXp+7k5RBlviEDbr+Cnl45bGVOmdcmNtL0AsNDWVr34Yb?=
 =?iso-8859-1?Q?3bZXbpbViu+Q+X30DiS6cPg0H8mmRUMIedRzdDzqq05sq3WoTzvAHIPuGv?=
 =?iso-8859-1?Q?YHrA1iaKkdA4DnE6z2q1girATq9wQGG8mMOTRPvo7dgkSq+0BYcg+GIMRL?=
 =?iso-8859-1?Q?Ooc6KJfRxvSq+XpuWdAYGX/ZpsZAUeXpNyLvTz340Sx3HWNRsP1OHahMr8?=
 =?iso-8859-1?Q?l/zoNoPbwn7RFvcSt5GSOxxGXnKJjwqO1bYOKFN6y5ItBbPyQ5+iemfgpK?=
 =?iso-8859-1?Q?X74RuyAg8S68zC638LLzhBg2Nj1c6NJgUpkq+vxKWCiyVIYVoomX+HEuj7?=
 =?iso-8859-1?Q?GbPRknAsZhNeQJI6XP/jyn1hMHydwFTSx7SiXoi3SZqdRBIlUBWh37crIY?=
 =?iso-8859-1?Q?czno8Qvgf3bLjDk6JNToRzsDW7w5LT0VSqM/5KTyu3nyZHVoMex3b6PyiF?=
 =?iso-8859-1?Q?S/qEg//u1OsZEetN8RTWmNmwkH3Xk/qKgY6MQacjdyV8Cgf2uWbuHh3U+M?=
 =?iso-8859-1?Q?Xx0I4w/+GqXw+Ay+RcBhbi9DhsKXs1DRq7jodHcg04fi4tRa0dEAx0QZR+?=
 =?iso-8859-1?Q?DmKJy1MFS01/f344iSh1LZuaAWj9SA4eTJ3QshAv8STWX6C2+QLNv9Jgm/?=
 =?iso-8859-1?Q?XxteJTq+5a7hLzz4NJ61hhuSIk6V+ewx2/wpBrxy9Na+hiCmsiof7FKXJx?=
 =?iso-8859-1?Q?jfHAI3jnBuvsRuBMtgpAdWyvcvdlkbi8zvv8dpiuTXflpgmPanFN6W9Moy?=
 =?iso-8859-1?Q?e3LZLchiVTBO8Rv9z6zfbe7007cgGrsM7wkoqlt5RXlIVjsPZ5fCNRTUrS?=
 =?iso-8859-1?Q?j3WS+QDtCyGAl9Bu4PtjOvL/FUnF5QPeuBeNxrjss1yuh4WzeXx/dMM5tZ?=
 =?iso-8859-1?Q?qq8MOeQwlKfe2JtkkfVpa3ed/rOkn1c2/w7/w0W6w4aABTaZtiF3NVvQKP?=
 =?iso-8859-1?Q?FA82GxxgiTAIWXvjd6dqv60LL+99crYNTVSApWfplr3G+eG5Npd/MgC75o?=
 =?iso-8859-1?Q?cv4hW5EE6Fo8lgcGU98i6IynZNNo4KvxT2+n114edlRVurpF0kFNI/pxqu?=
 =?iso-8859-1?Q?do8MLCgmWa3WmlxPqKxtPCJvrJnahr7+9p9pVh7Mo4dnFfkahvCaC6lwoB?=
 =?iso-8859-1?Q?3XcIyLV8cSaLWXhyS5EpUApZAkcSqE0pQbyrqSGR+PjPAXKbkrzEUpejnW?=
 =?iso-8859-1?Q?oLDnfwV1XB6FzxWgJZ6QqUYTeDK08Coly/04G5vN7i/Wqmk3+MtvumBFhU?=
 =?iso-8859-1?Q?nMIlgI7Ac3MiNFRbOXMMp+m0OTKyby7sjG49Kberh6qfQtUdUeEyTxw8X6?=
 =?iso-8859-1?Q?W1z6C++jGCgRqVIpvKEY3437KKSaT/nsxzQqtA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR22MB6014.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+DrHxSpyIDjkcBBIHkzYgZNJZFMBoDzEKG7GHsx7rmVx/NcP6ypTUStyfg?=
 =?iso-8859-1?Q?cxiXtTK5jsgSK8zWB5zs6Mkq8j6Y76maR9q4zYSaYDNkvSp01QePdrxv/s?=
 =?iso-8859-1?Q?JinIaKcEQwUmn13+Sm/EARY+qM0S+jFo7w32NKFloDbwz/IVgGZVgLemYG?=
 =?iso-8859-1?Q?GSqsTBwY2tEbdAfceFksPAomynso/aptcLlGuqr0cKTa6lCp/jQVyWJpC/?=
 =?iso-8859-1?Q?PmD/7pL6QPdag/biNe/6AFavmIi/hY4fp+Lvtw2u1CfaH2w7zRkSAbXcdB?=
 =?iso-8859-1?Q?qazJXnCafl6wpr+KszjCAai4mRnsqjUoBo87QqfE5RYnOeoQIC8B6a4OmD?=
 =?iso-8859-1?Q?xCapJ1VpXIEz9nnQ2e+2z66b8WUqoqnfoY8xGml146QpEcyuvhITBytGq2?=
 =?iso-8859-1?Q?WGVjJ9Pbo4b4pZi2jMx5dMKIUMaFV2R4w75eNpMFk5K2gFltvvCtal7fL8?=
 =?iso-8859-1?Q?wNgTvit9Xl+hwEzfvQK3ja/QTqflpOpiVUex29hNUa6PdCkHvGeTmjicS7?=
 =?iso-8859-1?Q?Pxi4pxkLMRS0L+sQUPhtHaU0Syt0KDLDQUyy6GReMn1CewdqY7QZ14Wird?=
 =?iso-8859-1?Q?ZhaA/Z4/zhTv2YUC/UGcScPlzRh7I6ezH/e77+XY+3dncwxutvC/zszrll?=
 =?iso-8859-1?Q?XsdP0wwBQs9k7u6nJ8VKp+lAcF566FHEBLlJIPBbOyDXjJyB6DdcIHE53l?=
 =?iso-8859-1?Q?0UsE+348Vjc2M58wZkD4MQ20pRROnLgkcn3RP0B7jKvkLBsB7OMH7MkvO/?=
 =?iso-8859-1?Q?+3AIcLTWDacxAWODIvCB2hxjuIQ0LJdziUKDjcZuLfqIT7MYUjvW9eW0yq?=
 =?iso-8859-1?Q?ZxcPSOTmEcpd04uKE0B83o7yn0irH1b5M8gSvFc+w5CwWPu4a8hEW1+XTz?=
 =?iso-8859-1?Q?Q9f5nvjowuUsu0Jgm+/SPHjHCNxYEJb6CYFRQ38cLvLBguTe19hE9GuDsw?=
 =?iso-8859-1?Q?cbgcm0GsZsyRTzHB7+UFFuAneuM95pSUArwATi9P9qOJnyq/UPvCoyfq0t?=
 =?iso-8859-1?Q?QDvq3lKV3uqInNGKPgNsZ1Ljf4vjGoGyVoCo6o8YT2S99jharbokiOaG7V?=
 =?iso-8859-1?Q?11HI23xV0ytLLavk9BXJ885YQVDtdTwyPqxzk/WRJXXxZI7/HDWGzz6+E1?=
 =?iso-8859-1?Q?sYEsdeq85b+IxI4cG73VSwVk2i6IJvQ4c6HG/onlnk+BBxKCAH60PSsXDR?=
 =?iso-8859-1?Q?CFv8ggB6tvgWQl28cCuwumryfZ0dmcCMc2e8nrLlhkJeLCpDXtA01UVKcD?=
 =?iso-8859-1?Q?IskM8I2TviE6G2Klh+MAcgu/EEyBkDQdWP7cf5yUCYsqFUOkLm/wk7wURk?=
 =?iso-8859-1?Q?dF3g9ZipMIn5kZcwax4Ba50JwH3Yqcdi/q+GOQUcc16lQ7u4wXlo/XtyoR?=
 =?iso-8859-1?Q?8EMWY/hbMv77zjuaTJKD45n1a4XPIb+knwqvnoENTPaODtiRhvm1B5PKnX?=
 =?iso-8859-1?Q?eiheRGpgOO26/4mx6aepu2whfQcIc0pxEyFXBBVUPGBg8yUaUdEK71sb6g?=
 =?iso-8859-1?Q?48DR8kMjbh3R1V8lgjepiowR22Yw6DiAfbjQiMOqRghAjff+EKHCbYtGJB?=
 =?iso-8859-1?Q?/kqKvMf11agxO0GoQ8EuTKR/cyy+3cpMEj3KItPUl5VGb07i+jA2y0oy6j?=
 =?iso-8859-1?Q?x+DWUBdNwj04+MQveCtIEo9ZqySFCrlPoC0EVA/g+IRM+e7Ed4SYPt6Q?=
 =?iso-8859-1?Q?=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: alifsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR22MB6014.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9578d4-e42e-44fe-67f3-08dd1061af0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 10:36:29.0771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b00baf25-129f-4e99-a1ef-bdc77ebabee5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbPBvhGz5TmGW2ucemXsZcyjVwwDyVzBs+Fa0RQvtZYJsuTXM+Q4Zib5iTYDfxgLSn4RQVJXMpBUXOLGF4yZq/rpIUB08FAY7zrBAWrqdz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR22MB5600
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Regarding LTP testing on target hardware linux kernel 5.4.25
 arm 32 bit
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

Myself Akshay from Alif Semiconductor working on LTP(Linux Test Project).I am using environment-setup-cortexa32hf-neon-poky-linux-musleabi (Musl C) for our target board.
I wanted to enquire how to test LTP on Arm 32 architecture(board architecture).We are using linux kernel 5.4.25 to deploy onto the target hardware.

Wanted to enquire in the apis regarding running single tests :

cd testcases/kernel/syscalls/foo
$ make
$ PATH=$PATH:$PWD ./foo01


cd testcases/lib
$ make
$ cd ../commands/foo
$ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh

The above folder foo is not present in syscalls and commands..Also wanted to enquire in process of running single tests. How does it test and difference between single running and installing all at once.

Thanks and Regards
Akshay Dharmapuri

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
