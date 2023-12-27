Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA9EC46CD4
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 13:06:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B91F23CEC28
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 14:06:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DBAC3C890F
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 14:06:13 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 05C6B20025E
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 14:06:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S61DmNWXhEk+GLnsZSfAJZxjS9MXFfonA8hQuFm3Nz1YD8RPTSevHL+BagtK69wszM3WXswZ0Ves/mu5ofyA2Hbq45mz6AEFXHFm26tmcAVJdtf+KPaowJNU89JHSnx69CZw5wXhe0+hhqgfqKf/MbKUwilHVevmYFUNADiGeZ7EWJ6rkI8yTwa5VZkBMMlDnozUuMne3P8ssNAGCsOPfWgQnPmZVGBtDQBwYnm1SXAQY2gMMj0zH2xcmw8ZW5HRbzQT5svr7hpyMSZlQon3jgxGVUk2wDvMurTCZljU7CKUjhwonj2SfSk/+XYNkWUKOOliholZyq9eOQ0XqhBY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHMPm0VH1PwHv+l56HsHWeGe5FjNakhDxAYVnjMX6PU=;
 b=b8UiW1ebI4iVUwCw8L199M2v/i1YU5rMCBkeMfUlZNZZ2xcKQy7+GWoi9XexzIyvePGTryfNucZGMs3dj8WgSgPF4IMet/kH+4hf+GjBNdUMZh7OiA7b7D7yCE5akckMPJAo02+bLv2fzyA+uN9p6JX69yXmuoM0Jr21Nj2QkVNJI/gaw1/xtirZYVCl94nVi37t0J6dsLuztmWHmMUtWfaYqGu4ch7MMsC57bmQlTmqwXHxZwPDVvq6rgK8ftaN04ivRM16X6Gp3OATekJoRFrLXdGfCrfTm7Di/rNMENj+Ee3dFAn/8xoRyc4ZpbVZWdNpFGAce55YhumR9o54sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHMPm0VH1PwHv+l56HsHWeGe5FjNakhDxAYVnjMX6PU=;
 b=QxIUoYRXC8FV012J4je6QL1XDJ8TXlWxy1tb82cJjmGe0uga11kkOd98xRr9J2rD5QHt6DqvfLk9+9ldamswfh1DuC/mOARBQVLoWaOklrPURK0QprjJfp6bHNQZTxYrpzCdPHL/DHSCtFig3XtJMHXP9MAsaFN2laVg5nyXkZ5tGPXBpD5qKK1I6eLHFCyqENAyPQIVrHv5kCy1wBRbinRu5Pu7/mWtjXK2aQHzIkKGnWiM8J8HHY7huPcUhhmWJGRiEdDl2EmkBsRcr6WFeHQL3BWx7tpEMa6sH/5Y1jgPf2phojW0vCfMSxVXF3/QmKbII9cxd4y38O0KJidVow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 13:06:10 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 13:06:10 +0000
To: ltp@lists.linux.it
Date: Wed, 27 Dec 2023 08:05:55 -0500
Message-Id: <20231227130555.29035-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231009112047.2359-1-wegao@suse.com>
References: <20231009112047.2359-1-wegao@suse.com>
X-ClientProxiedBy: TYCPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:405::22)
 To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f39ab6-95a5-4a8f-b567-08dc06dc98a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20zeOOErOtov6mkVrX2Q90TrY9aMWOsnu8IecDbeQiAnPbuiIosv0txwvHfcGUh7WLRkqMXzTF1NLRioFCvE9ws3uOr3E0jKGLRZqTzS18lq2vU7CjdCEB+UeyUgs3PRchFgGdiw/9qCBxsA3/k5SeRDMBt08NydX3vzdsGIsU6l15jS40Ja9nJEturezJNH/pMTT1me1Sl9IpzkQNFSvOLA4ImcMS6oBOvrDw+UbEek0eOLgHJwMv2Y6sG5982KD8sK1sVo70LVDEl/vu8SEIGTIYQi3rTRiwWYeXoiFMPZHd+QL1KxXdPIoQmaz/Q7TVxqZWPPfuyvcGDFzyuCpBuvdwHl3CGteEZMpZb749qF69AzSIC9Edt8OTehixRkhDzJd/sP2P3P1Ha5A1vRS1+4vGW5Aoc/nPjaGy86ahmYPWpYrHJDDfG5P05pKMuNuN35okSFlP1BB4+JUjfU3eNszKYZFDgK74l1FwNctkXOO9i3lNLnW76BJk9T/ZQhjlrQ7r14FIXQMFWKwXpAnCy0EepQrk/x6/jeAo9jPKB348hJDvgfWqQ+tNH9+QXt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39850400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(6512007)(6506007)(6486002)(38100700002)(66946007)(66476007)(6916009)(316002)(2616005)(66556008)(1076003)(6666004)(478600001)(86362001)(8936002)(8676002)(26005)(4326008)(2906002)(5660300002)(41300700001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YV0yNTx6I2/Ld2yPGGYDTaiNfCIsvCyGlR/v++NKWkXzu7hBxPyzAlSNFBhz?=
 =?us-ascii?Q?Or+X2dj6lQZj8BHv5tr9gd9SxprK2YwiCP61Rfer8VGeJcFvmt75+60B5RM6?=
 =?us-ascii?Q?jqdOK0Stk8PBY9vCprH4BfwmDJjhqA0IuVY4eL5/en1K7qHjO8Nf9Q4tqO+E?=
 =?us-ascii?Q?PIMVXKg4xzcHz7kc9BUg6MQA4zQTwDbcSWm4hFzJMYgzL0KXbo1QaV1l8Rsj?=
 =?us-ascii?Q?RjL6rCh4xX84MAb89Xb8T2dBbwqGXYotH4Zpz82ny+JQBl2AAh5/9UQPXIOl?=
 =?us-ascii?Q?8mKTAMRrKH3ETjEH6IxcYyvpoNhp4/vSnF9G/Lwkvvnv4cyXOneM7LGhwokn?=
 =?us-ascii?Q?kYdqbRJJF68ARDSs+I15WyJsh88tKXDbSy+JDNNPiSDPuOAdhLh1cEz26igP?=
 =?us-ascii?Q?XyGPKrz+ud5VMsOQM/TiUMNsWJThxl/lDKXcdm6ALbQE0knYL8HYSKuZqJhj?=
 =?us-ascii?Q?X5rkg3Q20DJj7aqvjMJkFptwpfOOZvfqPJzBVNBD4fap8mkOPD5DrJUK20r2?=
 =?us-ascii?Q?LbAfedegDqKYDxpi7WPa/Ia6f96f7Olat+BR6zFSpX6Cyo+QGx9p7CKvlXqN?=
 =?us-ascii?Q?TrrwlXdJ4eIr+xlX48YIBaoSYSgVFF9MBCzn68+eSZ3NPQJVDWLYJG52TZWG?=
 =?us-ascii?Q?eeJd3vffEE5dKot6dtnX+7GR474Fp1/P3fLvzu2enntFNRF39FJJ/0u0l/hJ?=
 =?us-ascii?Q?ddSdP6x0e6xsfHn3xh0nilN/XxZ5lKIxEOPK7dhZ8qwL9/FPengQ5M19u25S?=
 =?us-ascii?Q?NykgbTyQgIF46DyJ2VgPPSPga1y6dkOMEUFk1jkb+NifTzHOr78ixoA+KjmC?=
 =?us-ascii?Q?xLcgWlYlSHPwHedxaLt8qd2pvMuwvdgkacnVe1ydod1Vp9RaNBdS9KiTnprP?=
 =?us-ascii?Q?XAp5mVOclt1cdhetc8VaTyaSiPROTpmJ2NgraPPWznpZn+DjcoPqQvw1ebhH?=
 =?us-ascii?Q?4fNzAD/jK1ImsfPnIJK9mcj8Ojys9Ta8ZfaS8kN2nJvzrgS0Zm3o7Xy159d1?=
 =?us-ascii?Q?VzxRmnmfpr2YaFolE3s1YXzvX24IN/9aSn17oj3dCAZmuCLCPR8kfHGUWHFo?=
 =?us-ascii?Q?bvqJH1CScq+LT42gCmRhp9fhKgpFGnx8Lcl3ZhSNQyAPupcewig+y+qosx/O?=
 =?us-ascii?Q?Jys1wTy3e75Df2q/HWxWUM5rNf8kTA4bTOrKAKhF+PFieNfSwat6qeI5ilp3?=
 =?us-ascii?Q?dJn4xGKSngyuxe0rG2ComWaWxzRJtCbhX/5e4puP8wb8/txitvrdKQau6KhA?=
 =?us-ascii?Q?0b6xKcLnWojpsxdGOp4ep+dA0c/byY+4VQfvenxkcwyyCbrLxly/oTh+ZhsO?=
 =?us-ascii?Q?TfAdFmxh16jGVEEhwpgtetd7U85SKFJb7TcjV2K8fqw0NLyOvhosSJfXFU0u?=
 =?us-ascii?Q?591QcFPZVECQ/Sb35InCpTYtqCxvEciiZuVYGTqbXLSUCVXPx9oY1vLH2twT?=
 =?us-ascii?Q?F5tu6MgdpJJ2z9jGRnXnhCnuM2iAuKgOuqW6IJCE7tBSIZQa47yMa/Jyj5en?=
 =?us-ascii?Q?ZG/pziR4CpFuCJBMu3n/XSk+5Px86M6RQsaTYQegBp/cy1iAv7oUlJ6wi57k?=
 =?us-ascii?Q?vMK9YwEhMNlhVSOkeRA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f39ab6-95a5-4a8f-b567-08dc06dc98a7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 13:06:10.4938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Awh2Z0JWYdJjxepH3abW2feP8V4CVkW7WzEIwUJu73YFkf2j1L8BvV/AETavP9km
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] open15: allow restricted O_CREAT of FIFOs and
 regular files
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
Cc: s.mesoraca16@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix: #574

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open15.c   | 138 ++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open15.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4f1ee1f34..4152e1e5f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -935,6 +935,7 @@ open11 open11
 open12 open12
 open13 open13
 open14 open14
+open15 open15
 
 openat01 openat01
 openat02 openat02
diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
index 001d874d6..af5997572 100644
--- a/testcases/kernel/syscalls/open/.gitignore
+++ b/testcases/kernel/syscalls/open/.gitignore
@@ -12,3 +12,4 @@
 /open12_child
 /open13
 /open14
+/open15
diff --git a/testcases/kernel/syscalls/open/open15.c b/testcases/kernel/syscalls/open/open15.c
new file mode 100644
index 000000000..4feb1bb08
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify disallows open of FIFOs or regular files not owned by the user in world
+ * writable sticky directories
+ *
+ * commit 30aba6656f61ed44cba445a3c0d38b296fa9e8f5
+ * Author: Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ * Date:   Thu Aug 23 17:00:35 2018 -0700
+ *     namei: allow restricted O_CREAT of FIFOs and regular files
+ */
+
+#include <pwd.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+
+#define  FILENAME  "setuid04_testfile"
+#define  DIR "ltp_tmp_check1"
+#define  TEST_FILE "test_file_1"
+#define  TEST_FIFO "test_fifo_1"
+#define  LTP_USR_UID1 1000
+#define  LTP_USR_UID2 1001
+#define  CONCAT(dir, filename) dir "/" filename
+#define  PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
+#define  PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"
+
+static int dir_fd;
+
+static void run(void)
+{
+	int pid;
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 0);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 0);
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		SAFE_SETUID(LTP_USR_UID1);
+
+		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
+
+		SAFE_CLOSE(fd);
+		fd = SAFE_MKFIFO(CONCAT(DIR, TEST_FIFO), 0777);
+		SAFE_CLOSE(fd);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	pid = SAFE_FORK();
+
+	if (pid == 0) {
+		SAFE_SETUID(LTP_USR_UID2);
+
+		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
+
+		tst_res(TPASS, "check protect_regural == 0 pass");
+		SAFE_CLOSE(fd);
+
+		fd = SAFE_OPEN(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT);
+		tst_res(TPASS, "check protect_fifos == 0 pass");
+		SAFE_CLOSE(fd);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 1);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 1);
+
+	pid = SAFE_FORK();
+
+	if (pid == 0) {
+		SAFE_SETUID(LTP_USR_UID2);
+
+		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
+
+		TST_EXP_FAIL(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777), EACCES);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 2);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 2);
+	SAFE_CHMOD(DIR, 0020 | S_ISVTX);
+
+	pid = SAFE_FORK();
+
+	if (pid == 0) {
+		SAFE_SETUID(LTP_USR_UID2);
+
+		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
+
+		TST_EXP_FAIL(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777), EACCES);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+}
+
+static void setup(void)
+{
+	umask(0);
+	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
+
+	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(dir_fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{PROTECTED_REGULAR, NULL, TST_SR_TCONF},
+		{PROTECTED_FIFOS, NULL, TST_SR_TCONF},
+		{}
+	},
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
