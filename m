Return-Path: <SRS0=2GLJ=P6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B6C433EF
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 08:32:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF71611AD
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 08:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECF71611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45CFC3C6EA2
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 09:32:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12B133C2485
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 09:32:28 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78378601B12
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 09:32:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636619546; i=@fujitsu.com;
 bh=p8vWHAv6CnNMrsvsAgxmCCnxbsS/DXciWPZ5tzj/vPs=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=KZ+iVk9UE+USSmh9ZFR2cpWPAaJQlSoI+doO/8znufbAcWp0zqH2MqEa4L43e7Afj
 VpFlY/6Pty4S9sz5PG23FnDR/BWiQr3JpRdrCiiKGdbKY1pwrZxj9ebrn4WMfhqPjm
 Z5qQV43qzrN8UjNND+IOCON4BbnR5nOcVeGdJ7P+SsYzunLIb4GcXpGgi4G5wemr62
 rqQicz8nPUqyqMtTlYQLkbLZT+Fw7TCRly14vGo3YKKvxwm8rLbg4+PxS6zZ8bG7ND
 v3hWMut58DWc3cGl9OCptqxwyqa8ENPrst2o1JY9CMp3/DOEMvHWZYvk67Fm7IGAjK
 QucWHyYh1HGfA==
Received: from [100.113.4.66] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-b.eu-central-1.aws.symcld.net id C2/7F-14220-A15DC816;
 Thu, 11 Nov 2021 08:32:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRWlGSWpSXmKPExsViZ8ORqCt5tSf
 R4Psxc4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPGhm1sBfPdKg5/nsDSwLjQqouRi0NI4Cyj
 xOffpxghnJ1MEnP7/rB0MXICOXsYJXa2R4DYbAKaEs86FzCD2CICEhIdDW/ZQWxmAXWJ5ZN+M
 YHYwgKeEj1/1rKC2CwCqhITlm1gA7F5BTwk+hYtB4tLCChITHn4nhkiLihxcuYTFog5EhIHX7
 xghqhRlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRG/llI2mchaV/AyLSK0TKpKDM9oyQ3MTNH19D
 AQNfQ0FjXVNfIwFAvsUo3SS+1VDc5Na+kKBEoq5dYXqxXXJmbnJOil5dasokRGJIphawndzBO
 evNB7xCjJAeTkihv4ZKeRCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvFcuAeUEi1LTUyvSMnOA8
 QGTluDgURLh/QOS5i0uSMwtzkyHSJ1iDOd4s3bJImaOt2Cy7d5dINkOJmcuOLiamWMWmLzffg
 hIPgCRQix5+XmpUuK8Cy4DjRMAGZdRmge3DBb/lxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCo
 J89aBTOHJzCuBu+kV0LlMQOfOe9kNcm5JIkJKqoEp88kE7tQZSd85ZTRvcHI8XDplC7/lPieF
 dz9/z+8X9tl3+cPd7WqXVlbv75dWdOp5cbdn+vzvzhcu7fj++/sa98zFtY2t8WH14YXSvN6ag
 jF6f10sp/Uqsm/imsgpf9vU4gLv8nyjDZuay7dO39k089oWg7+sfFJfjep/fFhtOp9ZbvO+pY
 eanXu6Hxg4ME0smqWh4ZWT4SH3Rq6heqrRC6/k5VerN2teWyf20iVf8kpar6jK00qpkxkvPO+
 yq/S93v7bwmA1D7duvc9arWeOZuKN6xIfzuoM/Be+w6rD7Wj8hlsX7fj+28Se6vxl3tfqf2T3
 fetL5oKi+st7A97leTJ1ztpmevHEVKFjBZ1KLMUZiYZazEXFiQBDMVb9egMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-245.messagelabs.com!1636619545!172389!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27107 invoked from network); 11 Nov 2021 08:32:25 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-20.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Nov 2021 08:32:25 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 649C6100243
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 08:32:25 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 583DC100229
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 08:32:25 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Thu, 11 Nov 2021 08:32:03 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 11 Nov 2021 16:32:24 +0800
Message-ID: <1636619544-2369-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls/statx04: use stx_attributes_mask before
 test
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

stx_attributes_mask shows what's supported in stx_attributes.
Set supp_{append,compr,immutable,nodump} attributes only on filesystems
which actually support it.

Also merge duplicate code and document the kernel commits that ext2/ext4/xfs/btrfs
supports statx syscall correctly.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v3->v4:
1. add kernel commits into top description
2. docparse formatting

v2->v3:
1.add kernel version check for stx_attributes_mask
2. use test_flag(int) instead of test_flagged and test_unflagged

 testcases/kernel/syscalls/statx/statx04.c | 197 ++++++++++++++--------
 1 file changed, 123 insertions(+), 74 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index f8350ed2d..3c221b461 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -4,21 +4,46 @@
  * Email: code@zilogic.com
  */
 
-/*
- * Test statx
+/*\
+ * [Description]
  *
  * This code tests if the attributes field of statx received expected value.
  * File set with following flags by using SAFE_IOCTL:
- * 1) STATX_ATTR_COMPRESSED - The file is compressed by the filesystem.
- * 2) STATX_ATTR_IMMUTABLE - The file cannot be modified.
- * 3) STATX_ATTR_APPEND - The file can only be opened in append mode for
- *                        writing.
- * 4) STATX_ATTR_NODUMP - File is not a candidate for backup when a backup
+ *
+ * - STATX_ATTR_COMPRESSED - The file is compressed by the filesystem.
+ * - STATX_ATTR_IMMUTABLE - The file cannot be modified.
+ * - STATX_ATTR_APPEND - The file can only be opened in append mode for writing.
+ * - STATX_ATTR_NODUMP - File is not a candidate for backup when a backup
  *                        program such as dump(8) is run.
  *
  * Two directories are tested.
- * First directory has all flags set.
- * Second directory has no flags set.
+ * First directory has all flags set. Second directory has no flags set.
+ *
+ * ext2, ext4, btrfs and xfs support statx syscall since the following commit
+ *
+ *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
+ *  Author: yangerkun <yangerkun@huawei.com>
+ *  Date:   Mon Feb 18 09:07:02 2019 +0800
+ *
+ *  ext2: support statx syscall
+ *
+ *  commit 99652ea56a4186bc5bf8a3721c5353f41b35ebcb
+ *  Author: David Howells <dhowells@redhat.com>
+ *  Date:   Fri Mar 31 18:31:56 2017 +0100
+ *
+ *  ext4: Add statx support
+ *
+ *  commit 04a87e3472828f769a93655d7c64a27573bdbc2c
+ *  Author: Yonghong Song <yhs@fb.com>
+ *  Date:   Fri May 12 15:07:43 2017 -0700
+ *
+ *  Btrfs: add statx support
+ *
+ *  commit 1b9598c8fb9965fff901c4caa21fed9644c34df3
+ *  Author: Luis R. Rodriguez <mcgrof@kernel.org>
+ *  Date:   Fri Mar 1 08:14:57 2019 -0800
+ *
+ *  xfs: fix reporting supported extra file attributes for statx()
  *
  * Minimum kernel version required is 4.11.
  */
@@ -34,85 +59,67 @@
 #define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
 
 static int fd, clear_flags;
+static int supp_compr = 1, supp_append = 1, supp_immutable = 1, supp_nodump = 1;
 
-static void test_flagged(void)
-{
-	struct statx buf;
-
-	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
-	if (TST_RET == 0)
-		tst_res(TPASS,
-			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
-	else
-		tst_brk(TFAIL | TTERRNO,
-			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
-
-	if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
-		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is not set");
-
-	if (buf.stx_attributes & STATX_ATTR_APPEND)
-		tst_res(TPASS, "STATX_ATTR_APPEND flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_APPEND flag is not set");
-
-	if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
-		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_IMMUTABLE flag is not set");
-
-	if (buf.stx_attributes & STATX_ATTR_NODUMP)
-		tst_res(TPASS, "STATX_ATTR_NODUMP flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_NODUMP flag is not set");
-}
-
-static void test_unflagged(void)
+static void test_flag(int flag)
 {
 	struct statx buf;
 
-	TEST(statx(AT_FDCWD, TESTDIR_UNFLAGGED, 0, 0, &buf));
+	TEST(statx(AT_FDCWD, flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED, 0, 0, &buf));
 	if (TST_RET == 0)
 		tst_res(TPASS,
 			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
-			TESTDIR_UNFLAGGED);
+			flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED);
 	else
 		tst_brk(TFAIL | TTERRNO,
 			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
-			TESTDIR_UNFLAGGED);
-
-	if ((buf.stx_attributes & STATX_ATTR_COMPRESSED) == 0)
-		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is not set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is set");
-
-	if ((buf.stx_attributes & STATX_ATTR_APPEND) == 0)
-		tst_res(TPASS, "STATX_ATTR_APPEND flag is not set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_APPEND flag is set");
-
-	if ((buf.stx_attributes & STATX_ATTR_IMMUTABLE) == 0)
-		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is not set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_IMMUTABLE flag is set");
-
-	if ((buf.stx_attributes & STATX_ATTR_NODUMP) == 0)
-		tst_res(TPASS, "STATX_ATTR_NODUMP flag is not set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_NODUMP flag is set");
+			flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED);
+
+	if (supp_compr) {
+		if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
+			tst_res(flag ? TPASS : TFAIL,
+				"STATX_ATTR_COMPRESSED flag is set");
+		else
+			tst_res(flag ? TFAIL : TPASS,
+				"STATX_ATTR_COMPRESSED flag is not set");
+	}
+	if (supp_append) {
+		if (buf.stx_attributes & STATX_ATTR_APPEND)
+			tst_res(flag ? TPASS : TFAIL,
+				"STATX_ATTR_APPEND flag is set");
+		else
+			tst_res(flag ? TFAIL : TPASS,
+				"STATX_ATTR_APPEND flag is not set");
+	}
+	if (supp_immutable) {
+		if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
+			tst_res(flag ? TPASS : TFAIL,
+				"STATX_ATTR_IMMUTABLE flag is set");
+		else
+			tst_res(flag ? TFAIL : TPASS,
+				"STATX_ATTR_IMMUTABLE flag is not set");
+	}
+	if (supp_nodump) {
+		if (buf.stx_attributes & STATX_ATTR_NODUMP)
+			tst_res(flag ? TPASS : TFAIL,
+				"STATX_ATTR_NODUMP flag is set");
+		else
+			tst_res(flag ? TFAIL : TPASS,
+				"STATX_ATTR_NODUMP flag is not set");
+	}
 }
 
 struct test_cases {
-	void (*tfunc)(void);
+	void (*tfunc)(int);
+	int set_flag;
 } tcases[] = {
-	{&test_flagged},
-	{&test_unflagged},
+	{&test_flag, 1},
+	{&test_flag, 0},
 };
 
 static void run(unsigned int i)
 {
-	tcases[i].tfunc();
+	tcases[i].tfunc(tcases[i].set_flag);
 }
 
 static void caid_flags_setup(void)
@@ -135,12 +142,17 @@ static void caid_flags_setup(void)
 		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
 	}
 
-	attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
+	if (supp_compr)
+		attr |= FS_COMPR_FL;
+	if (supp_append)
+		attr |= FS_APPEND_FL;
+	if (supp_immutable)
+		attr |= FS_IMMUTABLE_FL;
+	if (supp_nodump)
+		attr |= FS_NODUMP_FL;
 
 	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
 	if (ret < 0) {
-		if (errno == EOPNOTSUPP)
-			tst_brk(TCONF, "Flags not supported");
 		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_SETFLAGS, %i)", fd, attr);
 	}
 
@@ -149,11 +161,48 @@ static void caid_flags_setup(void)
 
 static void setup(void)
 {
+	struct statx buf;
+
 	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
 	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
 
+	/* Don't check ext4 because ext4 supports statx since 4.11. */
 	if (!strcmp(tst_device->fs_type, "btrfs") && tst_kvercmp(4, 13, 0) < 0)
-		tst_brk(TCONF, "Btrfs statx() supported since 4.13");
+		tst_brk(TCONF,
+			"Btrfs statx() stx_attributes_mask supported since 4.13, see test description!");
+
+	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(5, 1, 0) < 0)
+		tst_brk(TCONF,
+			"xfs statx() stx_attributes_mask supported since 5.1, see test description!");
+
+	if (!strcmp(tst_device->fs_type, "ext2") && tst_kvercmp(5, 1, 0) < 0)
+		tst_brk(TCONF,
+			"ext2 statx() stx_attributes_mask supported since 5.1, see test description!");
+
+	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
+
+	if ((buf.stx_attributes_mask & FS_COMPR_FL) == 0) {
+		supp_compr = 0;
+		tst_res(TCONF, "filesystem doesn't support FS_COMPR_FL");
+	}
+	if ((buf.stx_attributes_mask & FS_APPEND_FL) == 0) {
+		supp_append = 0;
+		tst_res(TCONF, "filesystem doesn't support FS_APPEND_FL");
+	}
+	if ((buf.stx_attributes_mask & FS_IMMUTABLE_FL) == 0) {
+		supp_immutable = 0;
+		tst_res(TCONF, "filesystem doesn't support FS_IMMUTABLE_FL");
+	}
+	if ((buf.stx_attributes_mask & FS_NODUMP_FL) == 0) {
+		supp_nodump = 0;
+		tst_res(TCONF, "filesystem doesn't support FS_NODUMP_FL");
+	}
+	if (!(supp_compr || supp_append || supp_immutable || supp_nodump))
+		tst_brk(TCONF,
+			"filesystem doesn't support the above any attr, skip it");
 
 	caid_flags_setup();
 }
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
