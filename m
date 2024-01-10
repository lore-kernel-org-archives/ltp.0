Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A435C4707B
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1704896490; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Kp1yQ177Yr13lzGxYobxIX+4IfZOcEDBy1HSWtYljX4=;
 b=F8uN25UuWLmy/tMvPpLtoLSyy4sazBAqYRwQ1gFvpQbveh1gegYwcAPoSyRM6UH9j1j05
 ej1Q09TK/d8c+nVPugW4mpc/P4km9/75aAXVO6mvcRLT9Xi/lQAeSkFmSsDeFfgFKeu4SjA
 gB3f+tzhBJOE3mJyyjDgSR4iDJmb9fg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 632223CE49E
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 15:21:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B7AA3C08CF
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 15:21:09 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0310214098AC
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 15:21:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmlDyT3FlnVnphhzvsxewT7LfGU2tyGXv04qmkdQqtP5SUlViyEl0EcmllNCNXWQqFaHeUWjSnVUnCqD5CoqkVE4kTLLSZ9O7N4l8kKVKvxG+t0+wyXD8LQcj+XhPSSdUR3MXxk4emEehznn6rlr3cEKSb4jxpxOYzqkTPDrmtzYvLXJiZGkDLr3g/262pj8GahUNP+Zqs99jG4spVruEZvl1XBEUzc/w3EZjqV3qqLtvUuiBzW/6pJs3AmTr2SCPo5wiGlTXuuQdqhdHX9XW6GEEyfYU1Wd/eVD3EJDCiuvGG8CzSEVh8+QhNga3CQrY3iyDZsyGDA5k+CVFm6gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpvIe+XEZylFH5rMZUygWQ6gFtuy4P43w0YuJpzIhVU=;
 b=ZiYcoR31kmSqcOHVr+a30DTPMmDtSpPb4hHFCfpPW+fj61LvgVyi1ya6idKxdo+xnUaxjr7LZsFrWwkbGy0BMboWA4jiQAAHMMxHMHQ9RVC7goFpC6WyMujijx89crz6lkQhwKMh6L63uI9zujKinXPtruDPpiylFnn38mELvbTB/mL/gpESj4AvVuc1p9PHLPB0WeyXsydr4f4fD5ikRwJXhtSTPBn9y/djC+uc9CvjGI2J7S2+QKt9lVI/mmb/aZgzoYuD7qztb25Ci2rWtXwlb/kGwTzpRq5yDYyUPLwx81DeQw87aL/Ny8aDoUQPcDTAq4tlHDv5kaNU1CFxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpvIe+XEZylFH5rMZUygWQ6gFtuy4P43w0YuJpzIhVU=;
 b=DUU23FBh2TyUxbIxZ4jJk8ukHk00jrt0pzLphry+Q5bQCCC4C1/BHRuopji3nMgp6tnsZnxzuV/PBybOrm1Sur1oKJ/uSNJUKbDSuBRD6hnavQKKSa9KqgaEvZzB6lQkZABdujDGFR+1qd4VC73EjO4kPKeWpgueCXPZ6YrcGmTnKECUxY1q43W14uYCmmYI+1YytfCtbV3NSTj76Kaz2IP/2nmcEjt8HlMSfPovtbTlF3+6OhZS4sVevxBEVgaOaWDmWQg34K3Pmcwgu3+hFEkJJiWhi4cpZyRIeZ6cUU70+WhwYmChIVR02cIBGTNjq1xOk92E/cz7qGxeOks4ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8801.eurprd04.prod.outlook.com (2603:10a6:20b:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Wed, 10 Jan
 2024 14:21:06 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::c9bf:bb1e:181d:a2f4]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::c9bf:bb1e:181d:a2f4%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 14:21:06 +0000
To: ltp@lists.linux.it
Date: Wed, 10 Jan 2024 09:20:58 -0500
Message-Id: <20240110142058.31359-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
X-ClientProxiedBy: TYCPR01CA0179.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::14) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: f051c3db-d544-4ea6-4271-08dc11e761d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Npxt5cmoHnc3rogvdrHleaTmmTbsCiD2B4v2byyKygb4Fn4YgrAGqXmiuZihGgnkUzUV8MOxb6ZSss9mdhaMmOTLuj1FEK2Sl7NP188poxveKJKIZ0o4Stdg2KSDx6kbJP+IxQS+tTKk+V2fSrL9MVMtDpeGVFi6xl6em1qkw2h7qWZJYYRvj+3m9Sp/wXEuJI5vCfQFA6wjDF0ZHmxhPp6xt0++8cnQf6XCLwyzl1zRJ9/AjcKdOYR1FzROfGd5eOqxfiWpYe24bAjHda7xfMHNzXGWk3wcaC4iBP2gQJT6k/xEMRwjtHCuPPTNa7b6SGXSBCAI400dFQJ71F8MdVvQtJzZ7B+PJk3boVx86LdiUQineJeW1lE4v0SpTctj/HvA02we5kHIEQjIwLNpSk1SBsik0fGLK6nsC/06TL2kJBQX1lmDgAEuzG679BXDzI+AqHLAe/Ufqn6gqdEfdgaipivAjKbUbs0Yy1bNA90m8hmAB+JVi2A88DRAj3oqvn+YaBMfsxoLmmdtMdCW+hkd40zCUbFC93RS5evKzs2zcGhUlsOZMIK0LFqN8pfn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(107886003)(1076003)(5660300002)(6506007)(6512007)(2616005)(26005)(38100700002)(4326008)(8676002)(8936002)(6666004)(2906002)(6486002)(66946007)(478600001)(66556008)(6916009)(316002)(66476007)(41300700001)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?28Yv/WUWhVEh4Adlng3uiSKXyk7jpLZp1Os2b7InsnyMkMHBNbfluakDnINh?=
 =?us-ascii?Q?PlG5TdOWdnf2+Br3uWc/jdVkdWfGkuevg1GfOKZ2nVqh10Wp2dj5SwOGySxy?=
 =?us-ascii?Q?LtlDsegr7fpzR+pwL+2tMmzctszdO36cRYeCPCGEN4auJMYW/5AxKBYdrpSd?=
 =?us-ascii?Q?jZ7z39fphyLqcB8i9Pw6vtAUUwZuWzywWKCRT20tBTetqAgpZNbIhbXJ2uQv?=
 =?us-ascii?Q?cizwAoaEdsa+3U/qW/KIOEAkn7RYiFnjuXBfvMlRi6jX2MKVaqllRCGISilm?=
 =?us-ascii?Q?hbOOojiDd6z7mf855PI3G27Jt7t7X//MypzFKEPLJ6fxM7xnA3u2MFR3ArjQ?=
 =?us-ascii?Q?vqJnklAGW4yDd9R7ybN2oF49mREIuVL5ch8BVJXi+tDWJeDl5IsPh9/OrrCP?=
 =?us-ascii?Q?3mkgjoXdrZPAYuWRXaAaEk8gW5ETnl7uq8pjjPzTgdDMuwJUP+gXRxQzKPy8?=
 =?us-ascii?Q?TSKIXbfkN7AB2pJoovsLzJb6Jg5wG3aH+edK2QVEEXQsJrYzwY1V7aVkHhLO?=
 =?us-ascii?Q?rdfA2ElrZRqzaSGLUeCdAf0kRd+tCYhGv81/Xf5i8jBUVPFGJaZsDN+qmi84?=
 =?us-ascii?Q?ZwdmUMdvFmXBY70YUZwCU2hxxCBNb+nF7Qf7XufyKSofbMtDLfAt7xxw3qvC?=
 =?us-ascii?Q?Hg3GWXKam9Yi9qKa3rPAgyR/HqVw3W8X75JXaKTnI3JWTWNp/QfKQKElXQwm?=
 =?us-ascii?Q?nlCMJiz9hV23b16mH7IAjOETNS0OzKi2KwZt1IXq3FUxtX6GWY9mNPah122f?=
 =?us-ascii?Q?CMSYhJe5SjT4j2GQp2hbXx3T4pu8X3FQwmkQRBOcsDcGCLnCg4InmtfCErmf?=
 =?us-ascii?Q?TOcts5TooZYnFKbYUEaFLOKWZoN3X07OQBAvXhEU/2sSUsUKu/Gk1H3PaiOp?=
 =?us-ascii?Q?g0NAynwL6yhcYpnfPKTEMHsceZEhc5Lv8U2H8dMPJZhgsl4xGf1dmlZqZ1yc?=
 =?us-ascii?Q?as0IykAwrYSiS49hdyrVgyaDTZDVMrAmGRQU0SczMK26CUxYY+bqNTir/B29?=
 =?us-ascii?Q?5G5Kimh2EaV0iSCPf5+WbSlphWIPYHCcTC0ucwbZOW1ouIlJOftvrxuXKzGd?=
 =?us-ascii?Q?U0wm/9tll4vjtQdholPcTBo04wSX92JPGtCydSWOBi73Swbc11CUdpOOHZp/?=
 =?us-ascii?Q?2L4c5QQzewv2tcLKQVYyUDqfaDcvNFYPloBeLqHtZ8GFCOZi/IzHwOVWZq2O?=
 =?us-ascii?Q?XpDwWlEpdhyJ8z+ZduMDdK/q5N6Xq/vE9YKDuAk+ffaatY1iBUC2g8HIY6ik?=
 =?us-ascii?Q?opnlU1o0bRpSn7Fyx2r6r2DvzwOsZap8YH/dZcV8itBCq1OgdTYWDpatqbcp?=
 =?us-ascii?Q?UsptfoP4kpAyJUfyYaFl/zQ8sDi+zsG950hZB2xt3mimla83sVpp5A9l7c4a?=
 =?us-ascii?Q?EawMF87qMfyWFwIq8MeTUGMi/rquHAz48odD1xS+5a+SOyUZ89K7kyxLqU1W?=
 =?us-ascii?Q?rCxX6juP1M5KvlIrd1jp7WOBJKJQiJqOQpwumdPI/AfU7TBASID7Gi1aaS1Y?=
 =?us-ascii?Q?G84Ni5yUgcWCYok2NyAvp38IYf14M/VX4u+GfvVYLN53LFteOK1t7GHfXvCf?=
 =?us-ascii?Q?7ul5iF/lzFg5j4GoSUk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f051c3db-d544-4ea6-4271-08dc11e761d5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 14:21:05.9704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BftgMlHp7WkiYwFo90CJp8gJdBP/QGQngJ3QRrChLRcVUo3f1PhsbboAyBQ9pIK3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8801
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] getcwd: Fix description format
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/getcwd/getcwd02.c | 12 +++++++-----
 testcases/kernel/syscalls/getcwd/getcwd03.c | 14 ++++++++------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index cb111a698..e3df22ceb 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -3,12 +3,14 @@
  * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*
- * DESCRIPTION
+/*\
+ * [Description]
+ *
  * Testcase to check the basic functionality of the getcwd(2) system call.
- * 1) getcwd(2) works fine if buf and size are valid.
- * 2) getcwd(2) works fine if buf points to NULL and size is set to 0.
- * 3) getcwd(2) works fine if buf points to NULL and size is greater than strlen(path).
+ *
+ * 1. getcwd(2) works fine if buf and size are valid.
+ * 2. getcwd(2) works fine if buf points to NULL and size is set to 0.
+ * 3. getcwd(2) works fine if buf points to NULL and size is greater than strlen(path).
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/getcwd/getcwd03.c b/testcases/kernel/syscalls/getcwd/getcwd03.c
index 97f4f3a33..85a4ecf24 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd03.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd03.c
@@ -3,18 +3,20 @@
  * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*
- * DESCRIPTION
+/*\
+ * [Description]
+ *
  * Testcase to check the basic functionality of the getcwd(2)
  * system call on a symbolic link.
  *
  * ALGORITHM
- * 1) create a directory, and create a symbolic link to it at the
+ *
+ * 1. create a directory, and create a symbolic link to it at the
  *    same directory level.
- * 2) get the working directory of a directory, and its pathname.
- * 3) get the working directory of a symbolic link, and its pathname,
+ * 2. get the working directory of a directory, and its pathname.
+ * 3. get the working directory of a symbolic link, and its pathname,
  *    and its readlink info.
- * 4) compare the working directories and link information.
+ * 4. compare the working directories and link information.
  */
 
 #define _GNU_SOURCE 1
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
