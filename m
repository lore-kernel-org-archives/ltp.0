Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC2606A31A
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=C25KI5dV;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L/45e5H5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795428644; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=9m3KWN1HT9Fe8wPbu05sXCSojp3q7vUdcAU+l8KeIVU=;
 b=C25KI5dVm89imV0YW2XMAaYFuKjz3UjoF3tkPiLwu6sSHXO4Tm34QzpcHEY1yLW9JAneI
 uTVTBu8iEqW/FOp4xtEjL2sXSixAnFvXyl7ffSSp6vfl7vvykToBXZkNGnZnIUznuJ0oKkA
 sqU6Od//irBihmVQdO2tE/tj7iGf4Ck=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75CF33E919A
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 11:10:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 895433E9FAE
 for <ltp@lists.linux.it>; Sat, 21 Nov 2026 01:37:11 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB706600D39
 for <ltp@lists.linux.it>; Sat, 21 Nov 2026 01:37:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtO7qStG7olD055LIH11ByYq8SuIdNW8BAH+wnUlL1i8vXj+EnaAECJobOMLac2qqABt3fmg6vDbPUHPvOOvq1i8gJH6lNBOFdzpvhj0wOolv4O9py1KZ8pgZ4sDKonb3cb71zFDZPubToP0gaRpdcq25CHZdaiuIt63ASGPnCKCbnXcJDHJDEuq5mIGYKYahq8umKnl3KZoBfOZIv5sQI1CLJ/5Oz3sCAMY3fpH1iAEphdNwpVbtXymD6RSyzQIb19M2QXjj+J5RSWt6wXEqFXdfibPGoNO//gtD1t4mp3rPgXRKaH/yTzp9fo1FMzRXxd4hpf9NXwJIo8gbrqFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isZpE5fAaWSm/NdCP46E8fjdQLS9lUrIEuHvHhm20Rw=;
 b=RNQiua7Z+00jnQPNITsIcGO+IZAyYQpqNq6qYrJ/D0CiMgJjPfXNegA+AtnwqURQWbY//jdwXZFfyYsM7FKX0by3l6ACLlZ/f5Uls7oH75VkMnDECXoopmtWDzEOIYg21VYwqGpm0RrQD3vMfpgqlkFilWQSYImfS2PoGPkTe1cQdzmp4N87P3MqP6bG8mNjMoHLfWRcGj2mf0kZTTS0qSvCbadiDqmsv7J13TXAYwCSJ4VH2mE9gl8iiKjJZTbNsKFC89LuAEIt+TuOHik7sBhIFzIumEOhH6ScWLAKuDAXxVAPNkdqN/9CHovM/arA6rbIB/Fq3jFTEVrgso36Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isZpE5fAaWSm/NdCP46E8fjdQLS9lUrIEuHvHhm20Rw=;
 b=L/45e5H5yFky/BrIBdDVdByoJN4/TICaAvj800iYScCue6iJZdu5l42gcVbKX3ce5OGOgi4kiDuJOwg2xmTMhDkbkBN20VzyskbawtrQEImu6ZAeuDyh9zkjqJENrYgq0b2dqe1hHUbQCquSwwH13RZTHD9PhYkrOtmrYbPDKewvA1FKdNa41ho7ne7VI/XTt/GEytum1jFK7a6/BxdczmwPS+xFDL47Q7R2dyBG0KoteEZlrT/PoYGRGqKw2cdrtG9JHcQpPliJN72HpVZO6SIIRBzl7wYOfNEf+sfsTLnM52Br5iVewfbMLAavebicOlbo1SeunmlxT767VprQ9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Sat, 21 Nov 2026 00:37:05 +0000
Received: from MN0PR12MB5786.namprd12.prod.outlook.com
 ([fe80::ae61:c9b4:847b:4854]) by MN0PR12MB5786.namprd12.prod.outlook.com
 ([fe80::ae61:c9b4:847b:4854%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 00:37:05 +0000
To: ltp@lists.linux.it
Date: Fri, 20 Nov 2026 16:36:51 -0800
Message-ID: <20261121003653.179935-1-bmak@nvidia.com>
X-Mailer: git-send-email 2.53.0
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To MN0PR12MB5786.namprd12.prod.outlook.com
 (2603:10b6:208:375::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5786:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: ce53e7d3-28d3-47f1-bd93-08df476790fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|261009223027099003|11063799006|261026140227099003|56012099006|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261022115727099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: iEDYg1mKHdm4HI5gGVrGjoL9C+aOT0+06HTHArwQUoph82GBghasV24RhESJXHKrKiWLxEE0XttGCNEg5BYE8G286IVo+LbTOj0qazImbps1k9bFZ1jvNXGm7gxIt2JhxH4gpoRzzB2rrRBem5amr3Fu1c1M+TZ+/ClaWoDsijRhsCOS73rBFiZRVO7o/psPA+UQmyHIyqrARrwEP8P8GrvCyo42wFthGOZZ8qf1QPzsqu7NDRWpWyfLe/o3eD7Vz7cnuD6tetOTnYZE7onTyflnrRdyVy/fQ3HRSsIJFmQ4KQVwuAiqV0PwFyAqHl9XB05hynB02WaV8OLG3RnFDZ/N8gQsqJAYTT6L7j+krT8Khe7uxqVZJrdd7Q3JeOLKQ2FK5iBuHH6DiZOuanQiTva85IcrRWRTdBmyMAiYpIxFsQae/W7Dhxege7nfckAtFIlpwsiXjcph7ufsw7pxFCPpQPmhBy1H9WGBOXXXOmaziHDGN6fRtBrcXOxwf/W6Sx4T5F0R/bppW+azwA/WuE+/HXnWaGSOs/QhzZObYvEUNkEQGHKVm1SsYEF70J6qE6vR5E0kV5VLykbMEEE8hEq/w+CCOSPq4V8bmsuEi4/7fIdD5XMQJ45oenZTuECLZfI2HylWFu6B8E9kIwz+8oYRcDQB+PxZjqHUsCrdhlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5786.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(261009223027099003)(11063799006)(261026140227099003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261022115727099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TSTisYzMBmUc+JL+XH63LJy7pwflzvzSseKIN1AT8Pdt2UNnlupD19Lyp1Py?=
 =?us-ascii?Q?T8SfQfGXv6Q04GYEmx+gNYPGqVGnHZ+nh0G9qp2UjJC2PaSV7lx+Q5qlxffD?=
 =?us-ascii?Q?gpKSn+0KyR7i+R01a6SpakJVqI0AgvmQBqVtC1w4oyO0/x2LyDO0ivuWZBT/?=
 =?us-ascii?Q?KM2Xi83ZlxQM2D0pSZtcyfJXYtTAqCN46UR7PvLcigeg4u7L06HGlvTFDfcl?=
 =?us-ascii?Q?RDCdk3YIi3LLqXQ+DufLuslq+8m1kAQhNuznLBOJbf8BsVQc3g25i2+Duadn?=
 =?us-ascii?Q?CGSNINhoLu6JPK6rqZccVZRuwcItg+oMg46RzEVoMLylQO+1+q+OyFCnpsnp?=
 =?us-ascii?Q?Q8L96kzJL5X0gDCHkDCxdqp7itWMrt2+EsykAlke3LMKAwR+dl/F1V/qRoNL?=
 =?us-ascii?Q?3GqaRarDuq5Ro8lvbHYlLcwjScUOZ+wzuEPnFkcz7EGQNmIdnivbm6ZmKfPI?=
 =?us-ascii?Q?a6MB94SYjeGRn4tOifQsd5z1opxr5PZBiPzHfWxl+JSLYJ1R7sTMkbET+aRI?=
 =?us-ascii?Q?0DmbtROZEK+21yfd9gUqBOf2I8eF1wBVfBSc7tx4SKSlxJMcAZWA9tohEcso?=
 =?us-ascii?Q?u9jabaetKolrPNh1i1stJ/x+P5CrVU37y341LbYeiENklJv8PqZ+5T1c5vNO?=
 =?us-ascii?Q?fbxOAR+O1LcKE2NuvTn3T1Y6LCFgVuFmX7gNpy5LSAVXbbrtXuqlxnRPP65l?=
 =?us-ascii?Q?U0hhu7VzixvikEPtxhBDO2Gg9/RVIWdh+TWoomg2dE+gZrL/MOJSd2gd99wn?=
 =?us-ascii?Q?I4qwRzIUkjWNG8hh2r4evf0kxLKEsSFiSqArVWPhyQWqbtjwuC1fv0CaEXUO?=
 =?us-ascii?Q?HzeqY75fbqqZ9F1dO+VG051fOulrvSHjAlVbu+zBHpzxJFaVUhvzmwMrx8YO?=
 =?us-ascii?Q?vemCP4cqJqVtxtSihaMOUR1iJPBqBHVI+YFBXxEGgL3X3U/lDYn3GS7T6Ort?=
 =?us-ascii?Q?UMmbyh9WsFZuYtt3Fy44omGK354wOGUJbbgxk606ZxJ9oNDt4JzAZiEBR4ed?=
 =?us-ascii?Q?3vCRV//k7DXgEBmGZbc1aUpiC2XSgZJqDUEKUoyFrucq4V/lJtOQPXhJdCjG?=
 =?us-ascii?Q?S0vnW6q/IPDB73mQnAhKbllVgumUgo77xgljmJBLQgv5iqr3xz2ObdEyKxuv?=
 =?us-ascii?Q?nTGYStT8P41z1bvk0Aw/x6J0ifSMOMNGwWCyU2siop4/35CFtN3hVzENGClz?=
 =?us-ascii?Q?JfXgYgTX20uq2T5IlPb5ylDBNBjD3OknwzG5iLdv4b0Xt4DE0I+vuSj2Ly3a?=
 =?us-ascii?Q?kzKqVwiUgKThmgcs7t33tiei7jLFq9B/WRCnAzUxi2exvmyeBlphtB7dwFfa?=
 =?us-ascii?Q?ieOdEhTEiym84nPvND8uzy6jykvc4Od5HdOX4VXAANFpoEAwIluDTYvmbRnD?=
 =?us-ascii?Q?kaTiYvSTKXuI1AMl0S2sKQFRIN2ZupTW5amLCgDxogx1VH811DRWkryLshM3?=
 =?us-ascii?Q?5SRDbK1P2eMyvmveHOkfEybJFlkvjdqzDVdNI31TyZlDiAUP7EK7kH330J9M?=
 =?us-ascii?Q?dXAZgdR0jTJwXVkYZfMAJiWb19ryZvAtvNJkapYHwz0U/O57DXH1/t3+emHj?=
 =?us-ascii?Q?CtM5ODmD0J6sNab7vZuHuYIMQY+jgrYZZTOY0C0WALxzLm78rySn54Ked2KY?=
 =?us-ascii?Q?SK3AAEi9gcMwPsveqst6lLxwXeyCJ5SCYoQNma7eOOhtW/7jYySz3ZkmcTku?=
 =?us-ascii?Q?wMUUdPOwHRIU3Fo45kZmOCPGelyYmRvTLPGVafad9TIi8uxBUYSER1oNhESx?=
 =?us-ascii?Q?n4ZSPqGKjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce53e7d3-28d3-47f1-bd93-08df476790fb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5786.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 00:37:05.1494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtS+l90eQUQdwTXRACJewvbR/UXlMh0+pbRoPVQDuko2NAfvVUOS3a0MQYLIllgR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Nov 2026 11:10:24 +0100
Subject: [LTP] [PATCH 0/2] ntfs3: Add magic and fix swapfile creation
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Brian Mak via ltp <ltp@lists.linux.it>
Reply-To: Brian Mak <bmak@nvidia.com>
Cc: Brian Mak <bmak@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch series adds the ntfs3 magic, allowing prints to show the
correct filesystem name. It also fixes swapfile creation on ntfs3, which
fixes the following test cases on ntfs3: swapon01-03 and swapoff01-02.

These tests fail with:
  swapon: swapfile has holes
  tse_swap.c:228: TFAIL: swapon() on unknown failed: EINVAL (22)

Brian Mak (2):
  lib: Add ntfs3 magic
  tse_swap: Fill swapfile with zeroes on ntfs3

 include/tst_fs.h     | 1 +
 lib/tst_fs_type.c    | 2 ++
 libs/swap/tse_swap.c | 8 ++++++--
 3 files changed, 9 insertions(+), 2 deletions(-)


base-commit: 3b962a950b3f37153a45bf1240d07d73ab07676e
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
