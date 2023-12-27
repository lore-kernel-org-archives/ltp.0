Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2EAC46CD3
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 00:04:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6D553CECD3
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 01:04:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7B73C972C
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 01:04:42 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE9DE600060
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 01:04:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBGDsugVcxx8zfLllR6qC6XPQ/RjtWqRNPmmjgjlYk7vKySIZa6wM826Igg8Ei+8Ikb+jK6zZ1CjaejVlWPNuzgLog5vXoWZxeE68JJd3lvjFoXubS9PvNOigxjCVMXxytnaaw7CUXxdEZVnYA8z10468Z28pr55fezvItmvJYBsVK3jeqgKbHSuav3fcY/ORIkSz/qpR/8PSkiiYKfQnMIzdh25qGpZDOikZo9uMmRl3OSB5CXLpoPhF3LlJL9Jx/LxhfW6aJyxUO/G0qqQeQzK/tQ20b+03TNwJ8zgugeRc/Y8KoErBmp21D8MihLAZJOMP0Gqku9OgptyZ7Vm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXQf3ClZoxakbn23BEZUo1t+jo8YK1BQWYCljdesLTM=;
 b=IhxBFKLXsz/HoUL/fyF9zJWRZi6tNXZudwu/Pa9y0Ucivg3aFoSc5kzVHkvzqT4PBd3jXoXLbT8FSTY8/G1PGeAHmSloi9Z/TNoyw8wEAavLK/pPibhzR9E2QXkOxG88ei7qabSDqjZ6qS78QBirOm4uiuHAvJ+hEXXyr+RMezyjCt0HHFYQr28TBhNl4kq6HWwXhNEk87mbk0Jd0zruLNvAKnqZjVtP4uejXmyUQAnC/XNyYRaBeYfgaBSr/rjBw1qGoxZez6YW2yMj7xlW5U/sJ9E2Tw7b4Qh0PCmU7gHyyEyl7Kc/HGzfhRl7YKCLUWmXd/6al7B3tbknhNvuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXQf3ClZoxakbn23BEZUo1t+jo8YK1BQWYCljdesLTM=;
 b=OUbt8gd5uZATPmdQ3/bSy86K19jKO34M1ZvMIikSRwncxeSTnZTEuO43MbqNzFWrOC3mL8tzL3P9eRG45WdNglHx3MrKVHZkpAjK1xNprStUO8X/DDZJEDAflkmc5eQ3tIWolHywmcFRLD6u0kphh1nznNPJrhsCpWiTCBcgM0oH2mclKVfhINfw8PoAQqMvuVHOeSWzRrw/c5SJxog4LPgrR5jFCFvXq7MopEPoPBJ82dHctp9bPxSVZbjMqZrOhcmG72PJlv8NFfgTxey7kgNS7PxAGqs/OtYsw6f4W7N1EgDW8w1341lawR9FWj1AGVzMwbSCmPKt+49BwgWAfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM9PR04MB7601.eurprd04.prod.outlook.com (2603:10a6:20b:285::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 00:04:39 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 00:04:39 +0000
To: ltp@lists.linux.it
Date: Tue, 26 Dec 2023 19:04:30 -0500
Message-Id: <20231227000430.30224-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230913101542.18550-1-wegao@suse.com>
References: <20230913101542.18550-1-wegao@suse.com>
X-ClientProxiedBy: TYCP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::13) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM9PR04MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: ea865785-0a84-4068-6f2a-08dc066f6b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lizGS/057Qj+puosADS0Zq38IOyVXh2avH2awtTUSujn9MkEI0WIBR9X5oKKp3T7pfuRYk29O/66UnxtZMqu27Cxnqe7C7/EbyuOAG4ezBeMPOGBP7m8I616CcAp58F5WqX+9kOCo/ME2oCMVCKnFRopUQqrWP/Ub17VSDfpq4LYz3JoWXCRsncznFRX5Vrh1lHbX8f57M4XTO27M+vEeE7VhMHDFqw5hwQakh77o+uYQ2e3cfG45CPbVFcXwX64EDGESQooI+3FY0gM9dtiAYynlEW6X0yYcWUBfpvB6L1EEX3/AHsCIaEUudRr9qlXD6T47edxO+LW0ZVY3Gt6VRZJjGVZ/p7bZkhVX2KvITtzD3YD1UuUBDIQxZodLHkMmLFa51bQ2z73mLJSgUWN2wCDoDIvxOVA78U4UiRSPK3wqiMaiKDK/7tlX7Dw47u5u1/ftH98SleHYtQJNXV7gQ/0+H8GCvOpmN9020l3Ly8roNrusSWW7tVNUDTi4ddtvqsveyI94rcSXuzmStNElhTQPOTcYzuCSvvX7+wjZpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(6666004)(966005)(6512007)(6506007)(66946007)(66556008)(66476007)(6916009)(6486002)(86362001)(41300700001)(26005)(1076003)(38100700002)(83380400001)(107886003)(2616005)(5660300002)(2906002)(4326008)(8936002)(478600001)(8676002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5/qk7Jy4ZSDI2/y02yyb+HNCwRJ8zC782FGNsbeh1XAynPRiWqwXK4sp20Ed?=
 =?us-ascii?Q?7eK7Y+475V3cpMSZoKZDIYzVXhIN5fAd6FDybsFprukNYOf6Yf1bqZpWAt3s?=
 =?us-ascii?Q?OrkPsNIV/kvn4oPtgZ2V6HJbsOXq6b8dwx7P5tnAAKFx9Ex8uZKkeHcJuv+e?=
 =?us-ascii?Q?albSTamu6yu4OT8Ivz7WKc+YO8FtcDROYyIi58CWYqW1KgcY4T0UdRRw87E5?=
 =?us-ascii?Q?wcQaUKHs4CtFsy7Fu89UT9Kl0gMNC84hQe7dkdatMr8dB2U+M0gW4HftX5sB?=
 =?us-ascii?Q?zHGKKC7Hgf5iuElgqqQGAFJxGR/BQFW/ntz8gWFW2v5HMZskKMzj5iR6EZcm?=
 =?us-ascii?Q?7zJuZiQz2vHfxVOb/z0tCYvgtQ6vYAcqeZf/DpeOhF/06TlpYRg9ZRVDQuqs?=
 =?us-ascii?Q?4qanOZOzm+euNEJNrN7gwuhchO1ACbY3O+8NS31wD0+c8aFX9N2bXXCSde/b?=
 =?us-ascii?Q?7UZ5mSb1j9TeKdZ9QO7hqlpk07AnpcmvipVvidqUg2GrKcS2TDerDkjeNUZo?=
 =?us-ascii?Q?GaQl+oVyIGMfzGrvadDedPTHTE/s2xKnS++uQ9ZTj77uavi6rD/RDFpf29zu?=
 =?us-ascii?Q?+uFrpiPvyi62zsgP57p6yDh1zoKXmCG7ZtYL0VdnHmjFeNufGA+3gEa1AwOI?=
 =?us-ascii?Q?ekXEEo0SH0izyG1kgM07T2hpb5TWsifIa1lqyFwvYNda5jLP/H8FFpNU3ZwF?=
 =?us-ascii?Q?GUfJeydgf1+IXX5fi7hNKvtNo5eZnNL/YLlJjhpSHCa6ft2vGoWSE0TGV+TI?=
 =?us-ascii?Q?+XvC3Kc9tN/XYjrWpoMIzcBFAdm/3JHDir1dcpz+/lQolcBq7nDouTwWuZpg?=
 =?us-ascii?Q?dT0ZM1p7yPxJW7b+d9Tz6zic+hcsqPrvzFt+jVHciJQD9KkpppNGNhi6yTfO?=
 =?us-ascii?Q?9ApCTaltmVb9XpZpNQSUL+/74rKrgNXxFcq0/5NMj6hsa94XqkiqoAcXoFWr?=
 =?us-ascii?Q?DodTel9x7//tMJ1PmTJziI3ald0+Iho754b3DkplBuF9xVs3ghQm6aOnaKAo?=
 =?us-ascii?Q?+s4kWAbA+bF/hxHjj52NBwrXevUZEPeeKALemKt5/+RYMsC/iJ8QLpZflebg?=
 =?us-ascii?Q?5FzdLyWaY8pD6awmSUDZ76pwkAYW5aa+uZHHQX8H5EB6JqCjFz1rK6OBO/Pr?=
 =?us-ascii?Q?Ewy2N6z72L6t0A0P+LS6vVSRNWxq71MZ1SzzmsSkkNGJyrUjUCnAtgZFn8or?=
 =?us-ascii?Q?LX7XAlp1q2G/hOQTMS4ZkViOaRkapM/y0nWK7KFRPKx4joMRfp9rprEIUaPz?=
 =?us-ascii?Q?FOkCjsFQmCeiOq9HgwN02Ij4ssp7KwonB9okGxkX3Z25+l3znviEZA6Hn6SS?=
 =?us-ascii?Q?Ks8PgmLkgLCa7uqWGiWVctks1xjbe/3YmMDu66yicXL7MtCJFCoTUFlTm519?=
 =?us-ascii?Q?qze7+9y5HGSRUhIpuS/7GPMukCxIJ08pS8WDPNCEXSz9kSfprIvjSmktS3b+?=
 =?us-ascii?Q?f/Ag7MKHdq4F9dTag/dmqOGNG6srD57lk6EP4bnS4jHDvFr/CC+xrX1oP8+2?=
 =?us-ascii?Q?KPEz/Ho7DUA/z4m+vwe4aBeCjFHSggPShOfzKBSz9361svHcWtRo763FVwaN?=
 =?us-ascii?Q?lJ4N6XUpvM/Yl6g3HZM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea865785-0a84-4068-6f2a-08dc066f6b4c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 00:04:39.5424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocL2RJ4JgayEvr5k7tvGBpxbRptAj8Wa4vXgMw3vdfya9hn1Vi4HeJB6ArhzoXSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7601
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] move_mount03: check allow to mount beneath top
 mount
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
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/move_mount/.gitignore     |   1 +
 .../kernel/syscalls/move_mount/move_mount03.c | 111 ++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b1125dd75..04b758fd9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -824,6 +824,7 @@ mount_setattr01 mount_setattr01
 
 move_mount01 move_mount01
 move_mount02 move_mount02
+move_mount03 move_mount03
 
 move_pages01 move_pages01
 move_pages02 move_pages02
diff --git a/testcases/kernel/syscalls/move_mount/.gitignore b/testcases/kernel/syscalls/move_mount/.gitignore
index 83ae40145..ddfe10128 100644
--- a/testcases/kernel/syscalls/move_mount/.gitignore
+++ b/testcases/kernel/syscalls/move_mount/.gitignore
@@ -1,2 +1,3 @@
 /move_mount01
 /move_mount02
+/move_mount03
diff --git a/testcases/kernel/syscalls/move_mount/move_mount03.c b/testcases/kernel/syscalls/move_mount/move_mount03.c
new file mode 100644
index 000000000..dadb19178
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/move_mount03.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Christian Brauner <brauner@kernel.org>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify allow to mount beneath top mount base following commit:
+ * commit 6ac392815628f317fcfdca1a39df00b9cc4ebc8b
+ * Author: Christian Brauner <brauner@kernel.org>
+ * Date:   Wed May 3 13:18:42 2023 +0200
+ *     fs: allow to mount beneath top mount
+ *
+ * Above commit has heavily commented but i found following commit
+ * contain simple summary of this feature for easy understanding:
+ *
+ * commit c0a572d9d32fe1e95672f24e860776dba0750a38
+ * Author: Linus Torvalds <torvalds@linux-foundation.org>
+ *       TL;DR:
+ *
+ *         > mount -t ext4 /dev/sda /mnt
+ *           |
+ *           --/mnt    /dev/sda    ext4
+ *
+ *         > mount --beneath -t xfs /dev/sdb /mnt
+ *           |
+ *           --/mnt    /dev/sdb    xfs
+ *             --/mnt  /dev/sda    ext4
+ *
+ *         > umount /mnt
+ *           |
+ *           --/mnt    /dev/sdb    xfs
+ *
+ * So base above scenario design following scenario for LTP check:
+ *
+ *         > mount -t tmpfs /DIRA
+ *           |
+ *           --/DIRA(create A file within DIRA)
+ *
+ *         > mount -t tmpfs /DIRB
+ *           |
+ *           --/DIRA(create B file within DIRB)
+ *
+ *         > move_mount --beneath /DIRA /DIRB
+ *           |
+ *           --/mnt    /DIRA /DIRB
+ *             --/mnt  /DIRB
+ *
+ *         If you check content of /DIRB, you can see file B
+ *
+ *         > umount /DIRB
+ *           |
+ *           --/mnt    /DIRA /DIRB
+ *         Check content of /DIRB, you can see file A exist since
+ *         current /DIRB mount source is already become /DIRA
+ *
+ * More detail can be found in following link:
+ * Link: https://lwn.net/Articles/930591/
+ * Link: https://github.com/brauner/move-mount-beneath
+ */
+
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "lapi/sched.h"
+
+#define DIRA "LTP_DIR_A"
+#define DIRB "LTP_DIR_B"
+
+static void run(void)
+{
+	int fda, fdb;
+
+	SAFE_MKDIR(DIRA, 0777);
+	SAFE_MKDIR(DIRB, 0777);
+	SAFE_MOUNT("none", DIRA, "tmpfs", 0, 0);
+	SAFE_MOUNT("none", DIRB, "tmpfs", 0, 0);
+	SAFE_TOUCH(DIRA "/A", 0, NULL);
+	SAFE_TOUCH(DIRB "/B", 0, NULL);
+
+	TEST(fda = open_tree(AT_FDCWD, DIRA, OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
+
+	if (fda == -1) {
+		tst_res(TFAIL | TTERRNO, "open_tree() failed");
+		return;
+	}
+
+	fdb = SAFE_OPEN(DIRB, O_PATH | O_NOFOLLOW, 0666);
+	TST_EXP_PASS(move_mount(fda, "", fdb, "",
+				MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH |
+				MOVE_MOUNT_T_EMPTY_PATH));
+	SAFE_CLOSE(fda);
+	SAFE_CLOSE(fdb);
+
+	TST_EXP_PASS(access(DIRB "/B", F_OK));
+	SAFE_UMOUNT(DIRB);
+	TST_EXP_PASS(access(DIRB "/A", F_OK));
+
+	SAFE_UMOUNT(DIRB);
+	SAFE_UMOUNT(DIRA);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.min_kver = "6.5.0",
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
