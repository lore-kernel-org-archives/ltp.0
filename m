Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1172C46CD4
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 02:56:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3AF63CEC63
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 03:56:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA7F93CC4B8
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 03:55:58 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F21B200B83
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 03:55:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noGICJRilZfFOmq7mX140XyCkKyzO+I1BHEhW/i5gkTZ+4XSPBWgcr5DtrsJASQ2+EWsr0KFeuWj/iwB3q46sSWFiDSZbmHGfVITPAROtTjtRv8O6RKYpwtEfJmFrEpC8bO/1JC0rcNx1MbXxgvsIr4FT7NQZ/xWycVCaBOgKjbGDjpDhRuwpv21R7CIbODAFt0EZQuN01wAM+GDKrfrkDiuvMu8VllinFR1sOVF0TGIhvwCkz80SYmezAY2s46ube7cMQQXxsPATM6RxNa08yDnRXDp/eCzL1B1Q5W8a4zNODjz6iuw2atbQPoDOjxpQd5eSfP71Ur9cvCn6r6IDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46DRGKD51m2r0l8JPEKGt9ryexIDoS+bkwe4nXfuqGQ=;
 b=JW7elQPQonV6eiXxrepb4KYoALs6XluIoPMmZkYmNRDdKqUlgQq38sRLublQz/VoOYbvGitY4j6xULGGlyF/N3YJs6vEPcGO7U91GUbSWIZQR/N81DSgWipgOPQTrRB7SPGPX1LexLtt4fynKTWKiLN1F5cLXYBTuYGvTNCBoUjuQBcu6i589YTJCoNkqZDJLfry2KfM3wAHMMU0NxUWhh77KM5Q4tjo7aMVH7do82EKBcJJ+SIEXRQ+2TrwCKCFAAf3/1ZxUWDcFfo8clH7UkJ1gxEgLBY7dCazVFoRt9Bj/pBUaXJeAhNnarB3h1he86u/2yK0duM7RlPcKaMzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46DRGKD51m2r0l8JPEKGt9ryexIDoS+bkwe4nXfuqGQ=;
 b=A9QAwKtHUcA3zR5xKb5uHjgzz57fun1YgSpUQvXxgz0fOgNzw81C4pA7zvvHu3/NO63uPnGd+LN3Pu9meq2wFKPqn4YpgoZi6QdHNHR0QcySqQCyrs/+E+RkR67Gj4KDLzt/6l7an6dHCscAZR13+zMlLbhqYWMcqtX4BKDfrvzwz2Y4BwUnUtKik0npJQQqYh/sC1LO1op/CGZpJeiE2rv3X2SqYq4tItqXIatcQkUpE0dkrk+nECinmq7iQMCkt0obW5x0h39jbhAbdXDNMAE6hIJp2Njk3ishy5EpJYt82/S3hS+4nYrmklTmyL6WfEJkcogp8ogP2Qz3HPALJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DBAPR04MB7463.eurprd04.prod.outlook.com (2603:10a6:10:1ad::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 02:55:55 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 02:55:54 +0000
To: ltp@lists.linux.it
Date: Wed, 27 Dec 2023 21:55:37 -0500
Message-Id: <20231228025537.28807-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231227000430.30224-1-wegao@suse.com>
References: <20231227000430.30224-1-wegao@suse.com>
X-ClientProxiedBy: TYCPR01CA0105.jpnprd01.prod.outlook.com
 (2603:1096:405:4::21) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DBAPR04MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: dd974704-5fc4-4427-83bb-08dc07508210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uB3qJzwga9hYVQTWwGqOF4jWJytua2PvcVn0nnmPpeXLluSw5ovP5ErjtscDcOv6QSDT8BJRjQVasbnuIIZtjQY3saV2lKd5QhqsVOmd+qD1ZPXvjXoAUp1FlO44oAKAA5ZzdoKeghbShGox5M3c825WCKk6RV79NupGZ6SDfslmzg4xgZgPNuQY8ZtXFImYpvNgp5JmbVoJnxbYsgnTuZO+bNKBTuMoUeeWJcC9dogrzDSI0pDK+qA0GLW1FZ8exazIt5x9/o+3uC/UChnfcsDTW8XSZVjBZeDF7Q4RKGigOfnmUGCPwwymMlvK+L6kgYVoUO30TTxH2reo7V4EISmUk6HK2fMQ9a2eQfl+fn+9Mj3/neanYUOfFKnr+04AzmVVsI+f8Du/01MMlM6N0gLZu3nv78jULT7C5fu6U8n4nSTTPHb6cHDkZ0GUvdaLDDLBwYbpEA6/orzWBms7yctITTgZ3o7V+4IocEse0T16TD77RXOG4QgqR2Qy9Nfc9Ohz3WyZOsan1QeB/eDI8JefpUFL50Dvzv5YtsQ4kcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39840400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6512007)(107886003)(6486002)(86362001)(4326008)(66556008)(66476007)(66946007)(6916009)(6666004)(36756003)(2616005)(6506007)(41300700001)(316002)(2906002)(478600001)(83380400001)(5660300002)(966005)(8676002)(26005)(8936002)(1076003)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tvazhaD/VUUbnvpGpaLUiwlaGyG6Pny8latf5uFRpotuPQSPc+9l8sqrPBhF?=
 =?us-ascii?Q?uNFbNxTrCSMYjwiZzZMOSxK9Gw5Al05w6U5EykO+RX5dHryOT9dK6EfznJLT?=
 =?us-ascii?Q?jXULq2XWRsVnAJXMZ/zYPkVOIVZDWzudLQWemIekuTa72o2unVbfwICvqtBY?=
 =?us-ascii?Q?2xyyxjBE9/X55D4UatyxiUl0oMlwW8jdQwOWTZGEbx8pZJMhGPx1yYuoO+C2?=
 =?us-ascii?Q?N73l+kpckkNrCb1Eml8g95Fpv5AZe42YvfvC7Ipcrgf2jwpwlIofShdIVZh7?=
 =?us-ascii?Q?SF8vrS/1Nqxj7WCHqT+fq5kaccrP8vzbhBeA+HyiX8yVJJePKcncTS8H4ZmO?=
 =?us-ascii?Q?B/qdinAshoddnmfWOG4lCchjg/nJ0cK83wbWvkiBGNvGhCauPEXpZf+TgN+7?=
 =?us-ascii?Q?en37UBSSS1ngy0ffn8oMJO0n4qIc7vU78AKKgm4QxvMUu0jPlRDUo2uDyQxI?=
 =?us-ascii?Q?+787T2C967EcAkUuAqlDBOMVEezYmDeqjD5UTvbZWVl97lNbdvxlfJuMbLhE?=
 =?us-ascii?Q?QcktM58vFdMXCVAbejbzrrZHeGac1T4Ldtd4uMZRIGAYv2nE4jJSlHlLRj1O?=
 =?us-ascii?Q?HlVpzKGNPseGrZCQjeSDMcLGmYVT8gE8zmkHpg9ZOwbllPXYdfnyf5G2iEW6?=
 =?us-ascii?Q?lV0T82SfGm29A3D9GrjSOZQWBajqaKyU8GHrl46YcCreYyeahqsdjjjYMvij?=
 =?us-ascii?Q?CXvpHjPOMuQMHObPMrK3vj4SWQnnGkMo4lBYT/KUNNGkCeacntCVqUl+kGW8?=
 =?us-ascii?Q?Cr+6mACw3NMALQiZkxb3Mji4QMVybYiOZeUOmKF5i4NoKDmNA27dtey8D1Wq?=
 =?us-ascii?Q?ZKHml39uDQqrEotOQTM9albQE3KqjeQ90854bmOX7tA3fhIkiD3yvf4JgHWN?=
 =?us-ascii?Q?4BPvdZJgTaLO8qaNVUbJ4gkjGqSXQE1bK+TFKi7/eZlQTSbDVfwA4MZ5yxnS?=
 =?us-ascii?Q?yN3dX8a2cD5JP7lTAlCSO+lhTjLM57NjZ3hcDPc92gmDo0/uMUv8cmgIdiyD?=
 =?us-ascii?Q?kBXeN4kBNDVQoiYsMP6TkoQFw73V7y7uLNdwSThxobgWeM3aXHz+UGFNXF5L?=
 =?us-ascii?Q?Som5FjqtpFftServVi3/Zl7KuNr1QSCIOHS7hQLV01GYs+aTc193ExVmvCem?=
 =?us-ascii?Q?brXT+LHVJayMu5putSISj2kZKstnJVtIMDUJLwxjK/v+wIGTWXhDOoSe/JM6?=
 =?us-ascii?Q?V3Rc9JFUiK+XDeJAAAR7yjTblSHlDeGBjnXVd0o+J42y20bRR5ShZrcopCGW?=
 =?us-ascii?Q?tctCEZWNaAadSvoTKfVCjXmE5Gmfh184rB4XQiXtzZt+W1mxtPKnX3htzRRP?=
 =?us-ascii?Q?1f0UrV6gaCpwEPLmvDNQIlaGlG8sLA+LnQWDKCDptPMVQiHgmh0nv6ACABg+?=
 =?us-ascii?Q?5r5Xab8wODmNNVmMNh94ptpy+yH8J4o9h26dJpA1h6MA4kI1AIrri9mouYbe?=
 =?us-ascii?Q?W/4yzrLgk5rsGwK2Ouc/VQtxc4VZdPF+j+fVbpS0zXtWQxgfPyPwqtn8gjbX?=
 =?us-ascii?Q?CuHbdEsDHjeYF6M51KTjPP3knTfkYtSfYbttipSCldLusVmk06vyvzamz1xF?=
 =?us-ascii?Q?VmieImPhmmo/OSBBKYs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd974704-5fc4-4427-83bb-08dc07508210
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 02:55:54.5641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnnsS7lme+YK2nxgJmHP0+1ZRUewRL6+ZZFbhG8/qkF/ouPKlcmhnZSAYUmRh1PM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7463
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] move_mount03: check allow to mount beneath top
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
 include/lapi/fsmount.h                        |   4 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/move_mount/.gitignore     |   1 +
 .../kernel/syscalls/move_mount/move_mount03.c | 128 ++++++++++++++++++
 4 files changed, 134 insertions(+)
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount03.c

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 07eb42ffa..216e966c7 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -115,6 +115,10 @@ static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned i
 }
 #endif /* HAVE_MOUNT_SETATTR */
 
+#ifndef MOVE_MOUNT_BENEATH
+#define MOVE_MOUNT_BENEATH 		0x00000200
+#endif /* MOVE_MOUNT_BENEATH */
+
 /*
  * New headers added in kernel after 5.2 release, create them for old userspace.
 */
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
index 000000000..fff95c50b
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/move_mount03.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Christian Brauner <brauner@kernel.org>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test allow to mount beneath top mount feature
+ */
+
+/*
+ * Test create for following commit:
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
+ * See also:
+ * https://lwn.net/Articles/930591/
+ * https://github.com/brauner/move-mount-beneath
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
+	SAFE_MOUNT("none", DIRA, "tmpfs", 0, 0);
+	SAFE_MOUNT("none", DIRB, "tmpfs", 0, 0);
+	SAFE_TOUCH(DIRA "/A", 0, NULL);
+	SAFE_TOUCH(DIRB "/B", 0, NULL);
+
+	/* TEST(fda = open_tree(AT_FDCWD, DIRA, OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE)); */
+	fda = open_tree(AT_FDCWD, DIRA, OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE);
+	if (fda == -1)
+		tst_brk(TBROK | TERRNO, "open_tree() failed");
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
+static void setup(void)
+{
+	SAFE_MKDIR(DIRA, 0777);
+	SAFE_MKDIR(DIRB, 0777);
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted_at_tmpdir(DIRA))
+		SAFE_UMOUNT(DIRA);
+
+	if (tst_is_mounted_at_tmpdir(DIRB))
+		SAFE_UMOUNT(DIRB);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.min_kver = "6.5.0",
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
