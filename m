Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C366C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 12:23:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 254773CF334
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 13:22:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D0883C81C8
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 13:22:47 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2607A204713
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 13:22:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxX1eWOVYb32jg6TsU43aFbGK4TywRlumTIBIgCkQgya/3uqjS+fV7rVo3snBwTosp1ytVjRRCJcBEUBYfKKIR6Zt2Mmf9OTzV0X2jrR9OY/ebzXSDi6z/Xu8dCJA2l/AHUYOBeMJE2johIQEfu1ikIo9DXH5joRlxFKQEhdR1FSTC776Zw7s/jwKaWaEUC0giporzl+7cGBEcjL1Un5Ze+B8kpvrq5t27QW+w5oFSEktvQgMeMehtzjCuFqoQ1fI7f1ehW67L7ZKkTZrsL3KQOi9wlYLpbkSdiEvQHWCHZp97o51iFGH/IPg7Vi1tGhsF07QwwUerXujf1AnXhjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPlBbSsUX7Y6SEdt2NINW9GLPMGrn83mqz40Qs35bPk=;
 b=O1oGL0IhP8/E9vS4S9vEO83nlG/bEop/rZYaGhXTfJRWW3346zyL8HYcUqvLtWq5EDMCuScapDGdSIYCZFEKm/fbpyVrbuz+9Ob2SL/t3B5COvBDQM91fZg3jAMzYsr0b8VEG2fe/XCexvoE87fEvxAF99rU5zyRVwdYEKffRiNa5obPL3ui2R2txu0UB4yDt0sMukesVdBfuGB/1LIDaAkcpYD5QFo8zoafTjDsH/YVZiTPNQAWcWmKEKH36sC1lUuuFXT5B7hItLhEjH0wqnIMYTG3XP+r9nOdPpbRtHtT+aH3HNuuKuDz18prU5JnxAHgFIG3puPdkaXD7RhoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPlBbSsUX7Y6SEdt2NINW9GLPMGrn83mqz40Qs35bPk=;
 b=SvcJN8u+MGpNDmPvKJ37aI8Df3ngcgCvX/N7adpr5h9IT8OEfOstBhCj3xN4YfC94AxfSgXjtlFYba8BzLc+KEgJ9SlvEvo9ZD+G7WJa0XBpijwXh5JV9hKC2H5SnEmxa76uY1iv7alKlAvNGfEBQre7XDwa7hnVy5jfcKP73we2UHAqXVPI5N//1nKv1+Jt3CcrpScl17Y4zoroeSXwgILkLVtMzXZKhDlUW//T7eorP4RwXTyOqdypb0tVAJA1qg9GJjF+XlRlQFqPdLR7/S7eA+0GuFpBW2bAb3agGyXwZvGzUyLn7C/GmVs6k97QlB9aQx5Yqj48+wwc3cEbLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 12:22:45 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 12:22:45 +0000
To: ltp@lists.linux.it
Date: Mon, 18 Dec 2023 07:22:34 -0500
Message-Id: <20231218122236.24917-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231214071321.9863-1-wegao@suse.com>
References: <20231214071321.9863-1-wegao@suse.com>
X-ClientProxiedBy: TYCPR01CA0159.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::15) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 323fe69f-1be3-4f31-6377-08dbffc40a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaCRUI0Dpi6kq5On2Dtpz3g0oPlSrSg0HW+aQtqJ2PDVdk+iPThHcMwnu4YF6rT0YFLIz25rP7ZG8avFqej04YxN/47wrFdPl9tgXPzuS6nOTB3MxSs+sUxuSb3cmQ6BO0gxwihivTmMNf3q28PRjFeKrndkikwC6qz6E7UM+QIo8lO8wq3RYdG82myxzEHFBevRCgltpmpDCViDJiJV+8cPBc8/ifKoO2WQ6WC6eqDg08cY2EIgHk1IReZt1Zm9rFXGh9j8/uKrsNT2ewE4ORbBhOFamESPt61KBujGit/jG2+yxbhy8NQCMhVm2lPtrOw2X1zPom2ONppQCQgLTACIoxbfD8jULkx1HOokLG+rgFlZNtp/SnFYvf6C6vCUotETCGnGnwm0e6QFDb1NX/X1fUXiYI1Z4Ee2vaJaHKPfQQclLAyJtw/9B1HvcxgY9PcFxa7Ngv9mWuHLday9/Rck6xLbv17aF6eXYMeaR3oCUZghszdCcHYtFJuLw75Bo1RQBXoT14v6qGxRee2pIuQkI8lUz2drK2Btjtm1tjfJ1dNMDlJsQ2WrHEfxC7i9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(36756003)(38100700002)(107886003)(26005)(1076003)(2616005)(478600001)(6486002)(2906002)(66556008)(66476007)(6916009)(6666004)(6512007)(6506007)(66946007)(5660300002)(4326008)(4744005)(41300700001)(8936002)(8676002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dk/Brnnor5HcEzz9J41iCETFiJKgon9+eNsCoeIIWeNpe6toaN8YTsuEdCMI?=
 =?us-ascii?Q?XZ0YyM43jAObv8M6ye3Z/hbKkYYI/65e4RqJFJpnKYpwWF76cFMAGoaYv9mx?=
 =?us-ascii?Q?C1mcbv9bSlrwY20CHp7PHpOecp+OR6v+134VccWPeCfFG4Zxmt2ZcWSRqa7b?=
 =?us-ascii?Q?SO5o+P0AcyQ5Pss6NeQRRxUckqg3oXTwITe3GUkry/NsZfLHpqsiJcDQ6YN2?=
 =?us-ascii?Q?qUlBMJfnJJULyrNNc4PJk2oA6U18YtOmJ6oBWz41gzRmkRWXsEt9Jvd1+YHS?=
 =?us-ascii?Q?HbFhHtzHduFnR9KvenqsEcanHnwIC48H2DU6C2dxz6/7Mx3yaC9MZpQJo/4S?=
 =?us-ascii?Q?/M5TcClwUYf0BSkrSyPjcUGpALTFpXPKl9WlYiR3zHrmGJMYip++4S+T/b7t?=
 =?us-ascii?Q?7b7H9AEKoNpJQwWYvqzb7wrXExF+beCNkUDpNDsvM0MJHou0DkFZ+HWCp6Mx?=
 =?us-ascii?Q?qVsp8UMtGV0cludwcrVRor9B5NMJ8BGbzSdIA9siW6UOE1GERGyYbrsNTm/j?=
 =?us-ascii?Q?b2LGh/KDGslK/C9c9WH/AJT6sm2wpUjTSMIvfwnvojzrmqYajt1uWYrCTQeV?=
 =?us-ascii?Q?wXpP5aZQwkmdOGMuIjhubbEN5TKcHB1OtUX5FeONLhSzx2padtFm55hMjzbu?=
 =?us-ascii?Q?AEWDtmKxzwqtxyo4J9LGweJeIvT8cMGuriW38lsptb3GptDDXA6rYR7w/i2b?=
 =?us-ascii?Q?EmUApXqRS1qA2LDTCx0BPYZAuxc/LMiF+ho4W8qVNzD7t31ydT8q2XaUr+zq?=
 =?us-ascii?Q?e50sQyFwXhgVHTowfW06fZ2TCVz6e4+leL4Qal+QOh9Ty8R5MP0wDgDjpdfm?=
 =?us-ascii?Q?vitjDyXZsc7F5n2PpijL30BLsPiFnI915ZxC49WMSR5P5yaG1yTZgviiVWtz?=
 =?us-ascii?Q?HiIAScTc/a+NwumcNAlUER5pD+sHCJB7Vhvxfr3eayQUEguZSI7JIWmkvjNl?=
 =?us-ascii?Q?OOiIe94mesW903TLCcDDIX8a1Fx7/AmkJ2PwJmlzAR2lafjHuFy+EJ+vuV38?=
 =?us-ascii?Q?QhXNP4fWfHMgZ+JlwPaAoAKWC2aIaUCCO2mBECJzyH/TWh/2Mz5cwOyMMiyk?=
 =?us-ascii?Q?mRdzQeJbIIA/UcNeSxKdJG9uTsrxp3MtnsQWA8XYBiBVSIXrXEfnUr9vXb/B?=
 =?us-ascii?Q?zRhmcaQEcrJ0vwG6OoHqHwJ4DBkT6Uzimf/SZtUo8mgoKcBZoUmorzLkbGDN?=
 =?us-ascii?Q?tbj1VfWwUA4rXXsl2FSSNJps+Z7wso44ysCNVGom4ZPXEpbT5yhkdITyHtnW?=
 =?us-ascii?Q?JMggKGI2588YPRqstbc9A1n8Uf9zvs9cUssyGQsl4qzSLjfWI5kk5bWZCWSG?=
 =?us-ascii?Q?Z4EhDDfre7JzhfX9ckMjgAMAgWYDpkczq97yZuezHJLGgHmuwlWl+wPJQ04Y?=
 =?us-ascii?Q?KbF8GQb8Md7nY7s7T7/8zqBOGYnHHJnH0vnE9GUwph/PiVnkSZGLLZdI06qf?=
 =?us-ascii?Q?IVLo+letAL9d7aQBsb3fp7utEUAier+ari5LXyI7xboxm7kxkL4bS14oUTQf?=
 =?us-ascii?Q?OVwLgM2Tak28d6bjsay8Z6/rRc0kNkfQY1f8dFMahNDZCAfKu+oDPd2X1XVp?=
 =?us-ascii?Q?zvT7kJqqQCOn8FZvnk4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323fe69f-1be3-4f31-6377-08dbffc40a03
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 12:22:45.1635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFjMrFDHZsFnvCqXzyT349ByQSOnEfbi5ZhVV7zcMMACDHLHYNoFtbWrlpxgHOMY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Add tst_print_meminfo function into swapping01
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  tst_memutils.c: Add tst_print_meminfo function
  swapping01.c: Reporting /proc/meminfo during test

 include/tst_memutils.h                     |  2 ++
 include/tst_safe_macros.h                  |  3 +++
 lib/tst_safe_macros.c                      | 13 +++++++++++++
 testcases/kernel/mem/swapping/swapping01.c |  4 ++++
 4 files changed, 22 insertions(+)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
