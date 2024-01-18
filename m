Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C0BC4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 07:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1705563174; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=iUHgaNbWXXxXbRuo/Wo1hg2zAC9syckdHObL2k2m3ws=;
 b=IfXcyY2LMWbTj85Qlvvvta6Taybqp6HqlbsFckhXugrh7H4rsIyJq9jOUa9qGl8mPRmTo
 TwcFkaeUzN4cmxH9xrIizjv46WrvnMUloTEpetp6Fu25jYmaVkLDUvQ4m3cQdREwoor3KLZ
 bLfWifIi7UEy3HaBtf5kRoUNGMlJvMc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 477E33CE2E1
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 08:32:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D42993CC235
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 08:32:29 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D9721410873
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 08:32:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffgOY/etcK94OVX/QvLkodu8RbjXNYeAGoHTdQ0jMur6D+KbLAnkYE4iV+yzFMXLvNCQ44ztB5YS/XjvrRmgnTjJHkYy4UZEn91RgPsTMsSE1GGYg4js46f2vlXFTgmhS/4xJ1VJE09+8oszNyBoPGtW/WnHCT7m18z5c/flVDgwgVptpSFXxsNtwWtRvk5fr8ghbwaIm64wu5vc6adX1CIyHE+bwg2uhzoTfrQydJoyUSFktZBMjrMJckliWeBZF18mOj+8JfSn4cnlwGwz+/wqTNtvm3FE9YiaSNQa0UNeA+w89qZAdIcdSlsgSXQuneWPvzNPZFe+TeNxFES9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA4yzBKKWRv+J7GqWeAcb7HR00Or09l9HMDsPuI+cDk=;
 b=eXcvxhc5Mi73GjA6Fhm8qhR9ClzvWZly75O6ZrKkNA3DqwduMhA3l5NODhGyRc3BhMrGJ3qYr5rqSmoYY/l5rFVDgyFRqapG3ZaERGtsit9nWoKyXHwhhrvbD7zBq7jgCY0eG1lDf8h2+2JAi/jEUUkvenUAYujynMB5IvvFrn55kgtQsbnhu6g7fLzP1hUObOege3o9RO6NpTwNOMhNB40ArTSZTI5p0pAPDxQay6gySdQ7VG+8Bs2rZrrIRN6vh+KDxoCtRy2nm/cUdkZElrot958zGAzNNdZzG58PKovbAbV4HPmObmHO8lYsNISVkdzzHVP5pTpMng/yHGrw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA4yzBKKWRv+J7GqWeAcb7HR00Or09l9HMDsPuI+cDk=;
 b=WUX5Ti7wXSpInDJC6VvxTHq39PsIbYGKZLrQob2oxdZePIY/8X1Pf9U71LJ8BnqLa/lkMZiEVmCGRBMP2lRcGHpbN2nxOyTvaYBdxaNz2WgTxC/yUSXcgulUAJlcZWP3FQ1Z7HvqcVh9InhWVfHKB89VpyYXWgeKoeTtogZPAsQ11ICk2WFw7kM7r6zlB0Xd2mhvEHUKHucgK5RMiaOunmUbztVuiSkObObYmF6x8UEqGzpZOrpNqUd3O9XTMvWH6po1UPuPS0Uos4pgyvO/F72n2y/f38L3brVIn1/czhnXcO6Yf8XJEjrrocmXFs8UPYM3L5/ARpJVcrXj5ZJFpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AS8PR04MB8056.eurprd04.prod.outlook.com (2603:10a6:20b:288::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:32:24 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::80ed:f1d1:a471:ee74%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 07:32:24 +0000
To: ltp@lists.linux.it
Date: Thu, 18 Jan 2024 02:32:15 -0500
Message-Id: <20240118073215.10026-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018054357.29035-1-wegao@suse.com>
References: <20231018054357.29035-1-wegao@suse.com>
X-ClientProxiedBy: TYCP286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::14) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AS8PR04MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 714dc321-5248-425c-89c1-08dc17f79d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlJnDu9MEJyOpWjP2YjYwedsBQUUyvotYpaWOw1OIPtLAL34hZgHsMGSzZOlzLbgzm8ettkdN842SfK/n2IAdIOzVe4jSROs5GEr+VqBQ7nuI2qi0pXoo63Z8udhzPL48oj3d/XcvnG0hjd/xLvgb297cybagE5zEePCRkyz4dtl4CfG4Nu9mCf+8iV1G8cHcvlooVEbQhS6Wur2Dw9z5ET86dcrtU7h83rxGCy5r/Ihtq6pVRhRt8MPpyUQZVTgd/yurFMCYw17hUxgs9RYz7OJYlrhnKZOz7f30cDIsW/3mk4/0kc6T4FeArVAG9dtHGlAvKoqp5lrmhYKBJLiti4MUr3473OfB/PMZ9eky+wbuCj6p3cZUbruibgeiUOMa0PMuX4MkxpNKcis8SKxnvy3iwN4E3TYrNI5BV6nzNpOtDzxJNc7rBrY3EQIFEI2vsUs2QEHF5Rrov3Pl7uDz+Z2GSwI/wPyvrNZUgsLVcgEqNTkf58G0fOgZuaZwSRZhZjTgrdeS94RfSdXecbpFNxLl9/ZBwixU1C0cZalKBWRootFjNpPCmoo7oA6Gz9O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8936002)(6666004)(8676002)(6506007)(4326008)(41300700001)(26005)(1076003)(36756003)(107886003)(5660300002)(2616005)(38100700002)(2906002)(86362001)(83380400001)(6512007)(66476007)(316002)(6916009)(6486002)(66556008)(66946007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ha28Ve6KNULgVL2OdTB3RC6UsV+r7mjOHaWaT/TC72MoJ17WP2JtK5+RaMni?=
 =?us-ascii?Q?AEZrh2ebhGngM91eplm42qnwCLktIcJiyUEONL60ui0wyiEoqNjMeN8sNEe7?=
 =?us-ascii?Q?834EXJl6RlEPvWu+ok+X6g3/96myIhokO2zr9EdRvCHn6COSzAWns78P1i/j?=
 =?us-ascii?Q?PzPaZEJeLV/bcdW0klgksOkVO+wgqZ7+iM7GfY/z9WNTJUroGbR/KtIzeske?=
 =?us-ascii?Q?cFVtljz6CZteho7qiymx97bkKimnhDWBZM9QytaEIVqVRv3AEFyz6Dv+CWAa?=
 =?us-ascii?Q?SkSahBYfk0ANQGMJIf9u8pKy6RPFdRRz8t5rlH4Teb4IStfTxeRq3mhd5wcb?=
 =?us-ascii?Q?yj4/spPe6+ENlRkHv/XbfmaHdOUKpo5YBN3QBYIADQFvxO3/PYOq3opLAURd?=
 =?us-ascii?Q?fl6gXU9aSYJduXBPNXtF3vY0w4kyJVeypb6Kqeg5bIXOlKDH8IuQGUKZsYNn?=
 =?us-ascii?Q?9vr1odRtLISYN6HXeAZB/bzCExU8yZWiTDpULL69DnIGRcP/YN9uUcje2xvO?=
 =?us-ascii?Q?Jp1riuP2Clku6OFBm8GtoVKZQ1PLBiHwoLPu7yy7BXFg7R5kT4Nu57+SLthY?=
 =?us-ascii?Q?y7Q8faFaR4hpJT8/hCY70G2P/EWkKIIfK/z8VAujER/Zba4m4KM4jEBURoku?=
 =?us-ascii?Q?EypnxHAuGIhTSrvvN427bqLQqyXe6iQ1qgEHgvdj27z6sQ/XduboZ7h18SLH?=
 =?us-ascii?Q?I04YIArq0b/si+f9YjNfB7OQjoMo9RzCqFTneFeewhKu8ZYK35elhnJacReh?=
 =?us-ascii?Q?lmU0dFV3XkJYhWo10bwHC0jO2Uxncod6vQNxmWbx77+6ott6lUgALHSLRBMd?=
 =?us-ascii?Q?pbwfd60iqIQpYRztwP1XoMuyhp3ISEWshGW5QaOWh0lNJAcX1tFWddfMeRNe?=
 =?us-ascii?Q?5Vt0AKrim7KWzVFDy5aS5gdC5z2lCzcvrZ4YUjaCQ0jLF9/5t9VyuhSbZw4L?=
 =?us-ascii?Q?oxoSmYXf6lNJ6GIumwPG28HqdZWYLaakWwHweEBmzqeyKwVZweXUKUL+RWHf?=
 =?us-ascii?Q?9kPFzvZbmsoyd8x+ifVsOEKauAl72aLd1wTqoS26fOupowLdNBcf8Wnz0Bc7?=
 =?us-ascii?Q?FXcu70DFZ8KRIxdO38l7rDpIIkqFUCWFHhKzOq/jfBlcGRzo/kDaYyzTXUnD?=
 =?us-ascii?Q?riz8w5wW6jYB48aODriOAoUpKh0UQRNI8/mQWZWpz3GMKVx2HLv7cVIvPE9s?=
 =?us-ascii?Q?wSg1no1XREwN00DyBmhHbNC753oPzyRS8oXjZkcq9WC4sAqLWqh+lXpQvmHG?=
 =?us-ascii?Q?yHBRrtaxbXhssq+XYB1zxsjh7KM4rxmLBGHJyA7Mva+e+nEuzMSbmeQIspys?=
 =?us-ascii?Q?nSrtHviJ9B3+TaSVGlIR9N7zi8J3XQXooNWpJ/Q3ACDpqcLf2ioaeuWOeHQa?=
 =?us-ascii?Q?Rv4ZFdZTaH72t/jqrw1E32ReP6K10p0wwTL9WnYahH9U9OoweAoEtC9byObn?=
 =?us-ascii?Q?vgJxKYLt0WBVDR1rg0CvXMMO0RjM9Y0uDncWRScJtMNTuAuvnsvAc0ttboBY?=
 =?us-ascii?Q?OnP9KzxR9OPFcocRAAv31ej38YYx7PyFz3Io0lOxntqYsgERTqyp6u+fryIO?=
 =?us-ascii?Q?p6GCtBoswsJdLE4hG48=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714dc321-5248-425c-89c1-08dc17f79d43
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:32:24.4496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUix6jF+eliX4ubRlSimuqNYpF+mZP9gzet4v/FgpP+AZowNvgfp8C7n3AmNCUZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8056
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl_fiemap01: New test for fiemap ioctl()
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

Fixes: #535

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 .../kernel/syscalls/ioctl/ioctl_fiemap01.c    | 116 ++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..4e6ce5aef 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -589,6 +589,8 @@ ioctl_ns07 ioctl_ns07
 
 ioctl_sg01 ioctl_sg01
 
+ioctl_fiemap01 ioctl_fiemap01
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 5fff7a61d..64adcdfe6 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -22,3 +22,4 @@
 /ioctl_ns06
 /ioctl_ns07
 /ioctl_sg01
+/ioctl_fiemap01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
new file mode 100644
index 000000000..a626bb03c
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify basic fiemap ioctl
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/fiemap.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#define TESTFILE "testfile"
+#define NUM_EXTENT 2
+#define FILE_OFFSET ((rand() % 8 + 2) * getpagesize())
+
+static char *buf;
+
+static void print_extens(struct fiemap *fiemap)
+{
+
+	tst_res(TDEBUG, "File extent count: %u", fiemap->fm_mapped_extents);
+	for (unsigned int i = 0; i < fiemap->fm_mapped_extents; ++i) {
+		tst_res(TDEBUG, "Extent %u: Logical offset: %llu, Physical offset: %llu, flags: %u, Length: %llu",
+				i + 1,
+				fiemap->fm_extents[i].fe_logical,
+				fiemap->fm_extents[i].fe_physical,
+				fiemap->fm_extents[i].fe_flags,
+				fiemap->fm_extents[i].fe_length);
+	}
+}
+
+static void verify_ioctl(void)
+{
+	int fd;
+	struct fiemap *fiemap;
+
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
+
+	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
+	fiemap->fm_start = 0;
+	fiemap->fm_length = ~0ULL;
+	fiemap->fm_extent_count = 1;
+
+	fiemap->fm_flags =  -1;
+	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
+
+	fiemap->fm_flags =  0;
+	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
+	print_extens(fiemap);
+	if (fiemap->fm_mapped_extents == 0)
+		tst_res(TPASS, "Check fiemap iotct zero fm_mapped_extents pass");
+	else
+		tst_res(TFAIL, "Check fiemap iotct zero fm_mapped_extents failed");
+
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, getpagesize());
+	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
+	print_extens(fiemap);
+	if ((fiemap->fm_mapped_extents == 1) && (fiemap->fm_extents[0].fe_physical == 0))
+		tst_res(TPASS, "Check fiemap iotct one fm_mapped_extents pass");
+	else
+		tst_res(TFAIL, "Check fiemap iotct one fm_mapped_extents failed");
+
+	fiemap->fm_flags = FIEMAP_FLAG_SYNC;
+	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
+	print_extens(fiemap);
+	if ((fiemap->fm_mapped_extents == 1) &&
+		(fiemap->fm_extents[0].fe_flags == FIEMAP_EXTENT_LAST) &&
+		(fiemap->fm_extents[0].fe_physical > 0) &&
+		(fiemap->fm_extents[0].fe_length == (__u64)getpagesize()))
+		tst_res(TPASS, "Check fiemap iotct FIEMAP_FLAG_SYNC fm_flags pass");
+	else
+		tst_res(TFAIL, "Check fiemap iotct FIEMAP_FLAG_SYNC fm_flags failed");
+
+	fiemap->fm_extent_count = NUM_EXTENT;
+	srand(time(NULL));
+	SAFE_LSEEK(fd, FILE_OFFSET, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, getpagesize());
+	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
+	print_extens(fiemap);
+	if ((fiemap->fm_mapped_extents == NUM_EXTENT) &&
+		(fiemap->fm_extents[NUM_EXTENT - 1].fe_flags == FIEMAP_EXTENT_LAST) &&
+		(fiemap->fm_extents[NUM_EXTENT - 1].fe_physical > 0) &&
+		(fiemap->fm_extents[NUM_EXTENT - 1].fe_length == (__u64)getpagesize()))
+		tst_res(TPASS, "Check fiemap iotct multiple fm_mapped_extents pass");
+	else
+		tst_res(TFAIL, "Check fiemap iotct multiple fm_mapped_extents failed");
+
+	free(fiemap);
+	SAFE_CLOSE(fd);
+	unlink(TESTFILE);
+}
+
+static void setup(void)
+{
+	buf = SAFE_MALLOC(getpagesize());
+}
+
+static void cleanup(void)
+{
+	free(buf);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ioctl,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
