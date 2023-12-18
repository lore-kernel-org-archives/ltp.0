Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C28C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 13:12:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B3763CF329
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 14:12:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 568DF3C9DB1
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 14:11:54 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7EAD9600055
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 14:11:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut7fXNtZsq4RoxN6B2WBWSvlSyWIcaIJLcHTa8Ny9Xa6viN1nRWX85t/hBJCcf9yz5cuIhVHLJRUSkqhLbhGWPCxurlam1R/u75bbHZDFUT8IvHJrBIAs9amCtIC4clQEO0xR5XjXlYw4COIMxXze33G4nQ1GgnzaZbGJ16Zbs/JcVErxy8O+U8+BISKh2eDZa1hnoZ8TiL19JtQWN1MLaaDFhKahfV3VE5O9MQu4hBJrzutO5V9xufTXds8BWGPvxqo5DMDecLEmOdoHBvYbYBTO6clas4G7iWXHS6JJTE4pnIRywK9nd2RXF+l9VBBOQ2YmIMlGaZ4N+7NaqtDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTMkLK6lkKyUiVQIamm3eGrJUrgxrFnEEweEqq78aJc=;
 b=hahwxLOAIHi3RP5NZefnjVUifN8vNBPzP7fNsRuThWNWEZgco3e3NbE2dQgljuHmvozIJIBwLltVPoOZ8bo9VgL/ffQsD5MqdjtH7+pXuoQkXgOTymCZmGl61hdi6nn1NbP1wQkS/6SvCLldQRgMsn/iguMcqibGVv/PtcXO3lE6qUtVw/kl9MnQPF62Ga47nsqCOJc9wQ9aFdXsSdQnF0cw4pHxILv3SI2YBugGkVUqUcrqEcFteIFb/5yB4oKQD37UQXfPOrNGYVtG2My2nr55TnR+yTXbBiT+CNu0G9V0eLBVyvpEBurhKJ1YrhKTfYximsDwOohTeet1TtEyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTMkLK6lkKyUiVQIamm3eGrJUrgxrFnEEweEqq78aJc=;
 b=cY20GFCoP5pzgKbHV5t2RR3HFy7Uiw47BJPUYIFSOHMNQ9y9BTWUPs8Yb53ijav0PkNu1Ul2PzweYmIBmwREtmBI5fEuROllu3YrMAntg9d4bSDGE7bcroukd9Snq/VOkZE14o6r5HBr/8f+8El0RICyl8Vnh1/0tX1QDY6TTHLpVdoo089keF1UCcI0rvz9AxVad+DA1OBavCyx141G+d8035hxI5bP5qH9THjh4hYsnrDFDJrFcO3Ioi13UiV0z61TV6dy9uGaExxGJ16xyP1JQY2My341m5lMbD+Al1M2tQmi22ucW5zK76fjRgO3R5aPJxKU28UVk3Nr7hyQoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 13:11:51 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 13:11:51 +0000
To: ltp@lists.linux.it
Date: Mon, 18 Dec 2023 08:11:42 -0500
Message-Id: <20231218131142.12464-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
X-ClientProxiedBy: TYCP286CA0132.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::15) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d12fa40-c3da-4e12-749a-08dbffcae5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8DIGlsg3H92yMYRmb7Ys00mrawxjeOuojr3fRBX+dmTB//2wpaFzTsw2k+nG6e0xc0gvd58U9OeyDSYDCggxyLShvq4Eo3AT0qfvfjrb98LZvs0cOmOhIR9E3xOUECn+Lf0J2Ud29zFthXxAVL0zv4grQLy4qF+ZJP2nWgC4icdYollZfi8i76eWkAtKF9a3Z17qakMtwpyK3lLjJjBtnds3WWYhexh72vXpjDKdB+RuDpi+UrDiK0UPGLjmsfQUZV0l7bjaR0/iGtq6FzEFnaKnF2sUxswtcnYsB10Eg5gX9aUYpO237kNkIiLe0L8YrU0iTqDNSl4RJH7rm5NLn4CChX9uxjSxFVOXGGb/evOlM3WTrSeMm281T953U5ZPbrMGJZxfEpgXjjjqNmaiPkc9QnuAUU5hPkuFEi5q0y7Q+mo4+V8+uDD6m+M0TR4EZurVs5ogq779hEBWRMu7OxAnq/rjpUxLIYGMn2By+0yFLKXgWgaUefZ1Ia0/HuFGSsBJbTNDvXj9emrYuJI+QL+TniZSNfPrxzc+w3IITBZSOG5jN19dQlezALZIhtG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(366004)(39850400004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(8676002)(4326008)(38100700002)(5660300002)(2906002)(6666004)(6512007)(66556008)(66946007)(6916009)(83380400001)(316002)(66476007)(41300700001)(478600001)(1076003)(6486002)(6506007)(26005)(107886003)(86362001)(2616005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uq5rS4fPA3dB9BjXo23YO4hR7rGVPX+nSULhwyBL66pQwA4sBTVn6FbqSUI8?=
 =?us-ascii?Q?BZovcVnwjq6rrQLRT2nxvsRRo3HCh1MEv7aUTDmTGWpBBCIjMn8ULWgyeCLX?=
 =?us-ascii?Q?ehysKo9wnMRi5L8E0RAkWlmcGYOql9RFdIDLw3+Ifn445J9Xp5OrT87tdh5L?=
 =?us-ascii?Q?cBdjShGaAvUw4kmU4Dma5NesW5j7/lFwu8g23dqvOafp09YwnNv7k/OCAOQk?=
 =?us-ascii?Q?0TEt3e1onBUzQihe3MswMRhq1T8kvTAhaMD24lJx0ZbfbLnEpLRhPYY5zL0h?=
 =?us-ascii?Q?TKAuOUBb3HRhqKzRM4+thIoOsX1QTZrlmwNhAOs53pclbs3z3JMnNAnKVzgk?=
 =?us-ascii?Q?cBa85Sd2pMm4EGQ7qHGBWxuRXssVygOO+lHDyEgnLy6ldNXyMoZXnUWGHlXD?=
 =?us-ascii?Q?MyAHF267cKi/PcBqyZW0mH3hljoVuxuyH4C5wBD2H+hZ66LBUQk+nVK2iVjf?=
 =?us-ascii?Q?G8hE1m2QMjJxUO5wLiEqq+nLyt8JctEar9j4RRjW1CKqTmHcCoKKvP5Wb2Hp?=
 =?us-ascii?Q?OAI6X04kRqfZY7geR9MMuMiqP8H5lA6uMqaCGV9ZYBlZQpC1zxOj4pc5BHMF?=
 =?us-ascii?Q?rtz53ibSo+xDrcEn8y/76oZKS33hI9xKdcuXV65RAtvwFTs4JV6EEE/Mx+bK?=
 =?us-ascii?Q?s0rd/wZROVOWmtuIqYwkC5bNdH77sxnYvaLjsxZEJ9CraaW6cJYnt8/FCguV?=
 =?us-ascii?Q?Dx5swRTqUZAFy5C2lLPL5C3q3RlNbyUSuCHzX+XBEtSZmrCBfHz5Gaah4FXb?=
 =?us-ascii?Q?9jMzVGa5t/Lbu0cr//xjXJoV3C3jVxfp22unfvyeASCYn5cgATXpRERg/6v2?=
 =?us-ascii?Q?8KR9zDSidzofDSQ/lz3uMR3ZTnKPOdgIa7c7/BdVTA8sAUzhYR0gPThnq30S?=
 =?us-ascii?Q?dDI2HGsj97Zb5gDpSkk05S84PmeTV9sjFen6nMBbsvcH6/Lq75jcNV4Amnvy?=
 =?us-ascii?Q?I1O0Ab+v6Tb21xnZ3h2QIGq/iddbEpheErVNz6LvCby4u3JVTibzVcIGgdt8?=
 =?us-ascii?Q?fSBO51SiHAOJIzb8yLns5jY7w+HQoeygngyB4EdoYV7WjItaneau/rAAAUqW?=
 =?us-ascii?Q?sh+jpL6KtFXFrXGFGV1ivrQinieAHt+VZacr2XgqEmCG7ZpU9DJakfeDx20b?=
 =?us-ascii?Q?rBfAK3/6ridmtuMQKXTsweXwQJw13ZMgv35aDfDMYKgXWkufMBPbFv2iPT50?=
 =?us-ascii?Q?3rSHBTcOXG/eFeDEJuGAAIhEKpA9JNoxTN/r060hnFnuLGaFHQto9VQPkwBO?=
 =?us-ascii?Q?MXgC4EmL7Xux3gv0FAO4KUDMx9bl5rOsmflnToUqY73H2xViRGyU3eVS3agL?=
 =?us-ascii?Q?PcAvdyRLQODagcNPdBv84YUlgGYnHzdqma4qGw8fLIUafdMxPnLNeSajm4QN?=
 =?us-ascii?Q?eoG4ROV4I8Azy8lrOMQi/PlZ5b5tSOnm2fdiKicQZubC7zxH5pO+VctcWa5c?=
 =?us-ascii?Q?BRIxiH5qVlG0VCqFEI0AVXRFofsFEc0V5Rc98qsIVnLmiJOetpNtMTM7+Ij+?=
 =?us-ascii?Q?vi4sc6keLintXtr9/NHERd4mcflZvWeJ8eCR/26ajsEB6IVTyQVxnjbUnll6?=
 =?us-ascii?Q?MAX7n6U8iYt7NT75fCc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d12fa40-c3da-4e12-749a-08dbffcae5db
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 13:11:51.0904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLQRJcGSvylT/tz3P5rPK4th7sUqbcTCIzhPXA5GsD+GtEk5cFgfDb7jh2q3gMwc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fs_fill_btrfs: btrfs fs_fill test set mkfs.btrfs
 -s 4k
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

On PPC64 the page size is 64K and this causes trouble on btrfs
filesystems of small size(LTP currently use 300M), the threads
could compete for a very small number of pages/blocks to actually
write the data. So force the test case with sector size 4k.
e.g. mkfs.btrfs -s 4k

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/fs                                  |   1 +
 testcases/kernel/fs/fs_fill/fs_fill.c       |   4 +
 testcases/kernel/fs/fs_fill/fs_fill_btrfs.c | 134 ++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 testcases/kernel/fs/fs_fill/fs_fill_btrfs.c

diff --git a/runtest/fs b/runtest/fs
index 1d753e0dd..3649a1a82 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -82,6 +82,7 @@ quota_remount_test01 quota_remount_test01.sh
 isofs isofs.sh
 
 fs_fill fs_fill
+fs_fill_btrfs fs_fill_btrfs
 
 binfmt_misc01 binfmt_misc01.sh
 binfmt_misc02 binfmt_misc02.sh
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 2ecd8e2ad..4dcc6d3b6 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -129,5 +129,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = testrun,
+	.skip_filesystems = (const char *[]) {
+		"btrfs",
+		NULL
+	},
 	.tcnt = 2
 };
diff --git a/testcases/kernel/fs/fs_fill/fs_fill_btrfs.c b/testcases/kernel/fs/fs_fill/fs_fill_btrfs.c
new file mode 100644
index 000000000..315d283a4
--- /dev/null
+++ b/testcases/kernel/fs/fs_fill/fs_fill_btrfs.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Runs several threads that fills up the filesystem repeatedly.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+
+#define MNTPOINT "mntpoint"
+#define THREADS_DIR MNTPOINT "/subdir"
+
+static volatile int run;
+static unsigned int nthreads;
+static int enospc_cnt;
+static struct worker *workers;
+
+struct worker {
+	enum tst_fill_access_pattern pattern;
+	char dir[PATH_MAX];
+};
+
+static void *worker(void *p)
+{
+	struct worker *w = p;
+	DIR *d;
+	struct dirent *ent;
+	char file[PATH_MAX];
+
+	while (run) {
+		tst_fill_fs(w->dir, 1, w->pattern);
+
+		tst_atomic_inc(&enospc_cnt);
+
+		d = SAFE_OPENDIR(w->dir);
+		while ((ent = SAFE_READDIR(d))) {
+
+			if (!strcmp(ent->d_name, ".") ||
+			    !strcmp(ent->d_name, ".."))
+				continue;
+
+			snprintf(file, sizeof(file), "%s/%s",
+				 w->dir, ent->d_name);
+
+			tst_res(TINFO, "Unlinking %s", file);
+
+			SAFE_UNLINK(file);
+			break;
+		}
+		SAFE_CLOSEDIR(d);
+	}
+
+	return NULL;
+}
+
+static void testrun(unsigned int n)
+{
+	pthread_t threads[nthreads];
+	unsigned int i, ms;
+
+	tst_atomic_store(0, &enospc_cnt);
+
+	run = 1;
+	for (i = 0; i < nthreads; i++) {
+		workers[i].pattern = n;
+		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, &workers[i]);
+	}
+
+	for (ms = 0; ; ms++) {
+		usleep(1000);
+
+		if (ms >= 1000 && tst_atomic_load(&enospc_cnt))
+			break;
+
+		if (tst_atomic_load(&enospc_cnt) > 100)
+			break;
+	}
+
+	run = 0;
+	for (i = 0; i < nthreads; i++)
+		SAFE_PTHREAD_JOIN(threads[i], NULL);
+
+	tst_res(TPASS, "Got %i ENOSPC runtime %ims", enospc_cnt, ms);
+}
+
+static void setup(void)
+{
+	unsigned int i;
+
+	nthreads = tst_ncpus_conf() + 2;
+	workers = SAFE_MALLOC(sizeof(struct worker) * nthreads);
+
+	/*
+	 * Avoid creating the thread directories in the root of the filesystem
+	 * to not hit the root entries limit on a FAT16 filesystem.
+	 */
+	SAFE_MKDIR(THREADS_DIR, 0700);
+
+	for (i = 0; i < nthreads; i++) {
+		snprintf(workers[i].dir, sizeof(workers[i].dir),
+			 THREADS_DIR "/thread%i", i + 1);
+		SAFE_MKDIR(workers[i].dir, 0700);
+	}
+
+	tst_res(TINFO, "Running %i writer threads", nthreads);
+}
+
+static void cleanup(void)
+{
+	free(workers);
+}
+
+static struct tst_test test = {
+	.max_runtime = 60,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.dev_fs_opts = (const char *const[]){"-s 4k", NULL},
+	.dev_fs_type = "btrfs",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = testrun,
+	.tcnt = 2
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
