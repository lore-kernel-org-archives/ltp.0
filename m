Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AE8C433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 03:32:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABCFA3C9350
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 04:32:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EAA23C1B7F
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 04:32:12 +0100 (CET)
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 8B1961000A10
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 04:32:09 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3A/4FdYam2FoGmbniGsU3isnLo5gy6JERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzEDmmJMXTqPOvfYMGP3ed4iboi+oE1SuJSGy9ZnSVBk+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ2MhcvJq/E?=
 =?us-ascii?q?19wbuvOicwTThtZDzpje6ZB/dcrJFDm65bNnxKbIiGEL/JGSRte0Zcj0uJrGUl?=
 =?us-ascii?q?K9OcEM3YJbxael6S33NqTT+B2msUlasXsIYgfs1l70CrUS/0hRPjrW7vN/9Jc9?=
 =?us-ascii?q?Cwtnc0IFuS2WiazQVKDdzyZO1sWZAhRU8l4wY+VarDEW2UwgDqoSWAfugA/FDB?=
 =?us-ascii?q?M7YU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3APRs2TqMrotvMfcBcTjOjsMiBIKoaSvp037Eq?=
 =?us-ascii?q?v3oedfU1SL39qynAppQmPHPP5Ar5O0tQ/OxoWpPwIk80nKQdieJ6UItKNzOGhI?=
 =?us-ascii?q?LHFu5fBPPZsl/d8jPFh5Zg/JYlY65jE8fxEFQ/qc775TOzG9EmzMLvytHPuc7u?=
 =?us-ascii?q?i2dqURpxa7xtqyNwCgOgGEVwQwVcQbUjEp703Ls/mxOQPWQQct+gBmQIG8zKp9?=
 =?us-ascii?q?jwnprgZhIcQz4LgTP+6g+V1A=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; d="scan'208";a="122687592"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 16 Mar 2022 11:32:06 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
 by cn.fujitsu.com (Postfix) with ESMTP id A56A94D16FD6;
 Wed, 16 Mar 2022 11:32:03 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 16 Mar 2022 11:32:02 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 16 Mar 2022 11:32:02 +0800
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <pvorel@suse.cz>
Date: Wed, 16 Mar 2022 11:32:25 +0800
Message-ID: <1647401546-2898-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-yoursite-MailScanner-ID: A56A94D16FD6.A65EE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@fujitsu.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/quotactl04: Use correct min_kver version
 check
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
Cc: ltp@lists.linux.it, martin.doucha@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ext4 supports project quota since kernel 4.5 instead of 4.10.
Also Q_GETNEXTQUOTA is supported since kernel 4.6, so add
a check for this command like quotactl01 does.

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index fdd1c9b50..3eb6e4a34 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -47,6 +47,7 @@ static struct dqinfo res_qf;
 static int32_t fmt_buf;
 
 static struct if_nextdqblk res_ndq;
+static int getnextquota_nsup;
 
 static struct tcase {
 	int cmd;
@@ -125,6 +126,11 @@ static void setup(void)
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+
+	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, PRJQUOTA), tst_device->dev,
+		test_id, (void *) &res_ndq));
+	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
+		getnextquota_nsup = 1;
 }
 
 static void cleanup(void)
@@ -145,6 +151,11 @@ static void verify_quota(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
+	if (tc->cmd == QCMD(Q_GETNEXTQUOTA, PRJQUOTA) && getnextquota_nsup) {
+		tst_res(TCONF, "current system doesn't support this cmd");
+		return;
+	}
+
 	TST_EXP_PASS_SILENT(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr),
 			"do_quotactl to %s", tc->des);
 	if (!TST_PASS)
@@ -166,7 +177,7 @@ static struct tst_test test = {
 		"quota_v2",
 		NULL
 	},
-	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
+	.min_kver = "4.5", /* commit 689c958cbe6b (ext4: add project quota support) */
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
-- 
2.23.0




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
