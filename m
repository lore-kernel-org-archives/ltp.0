Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F08FC433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 07:27:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D656F3C8977
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:27:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 940663C8C37
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:26:47 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8764E1000A12
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:26:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639380405; i=@fujitsu.com;
 bh=yaHU5Y+z6tuguFfJNAPUvA5YK4UBE2aOgVuTE58SOIY=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=fk+BmmdzJ3z+Pv85jSmW8of8oFB4g7FjXWGSvImKOYDJq37Ya7v9AwH2RpK37KjM9
 DKKGO8fccJKZRhzFsHdPf/GTnnY3Cuy0BjjlWz7DtBxoWnYXi4RyZ7lt0VohPvjKDY
 LY1v07GCJIaF17IO+QU2XG2dJ5MYr/ENtNpw9uRuTSF2s3Kh9gk595p23mclR4x9O0
 UJtmXg180IX9PZx0QemHXJ0wHq+lFquqeXlogTlUOzQVooHdhPNU3Hbsvn5i4HMBcs
 Qqx1Xe8Qzuw1PwMRgqb7kPdpBS41a08Gs361pue37ye7pXBCGWhfEGVkaepS+WqcaA
 s7+qsKFMrDvEA==
Received: from [100.115.39.64] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id DE/37-16537-5B5F6B16;
 Mon, 13 Dec 2021 07:26:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRWlGSWpSXmKPExsViZ8MRorv167Z
 Eg/XL2C1WfN/B6MDose/3OtYAxijWzLyk/IoE1oxDK6azFxzlr7i9p52xgXEObxcjF4eQQBOT
 xPO3h1khnD2MEu0T17B3MXJysAloSjzrXMAMYosISEh0NLwFizMLqEssn/SLqYuRg0NYwFPiy
 i9hkDCLgKrE3deXWUBsXqDwr1fdYOUSAgoSUx6+BxvDKeAl8e7CfUYQW0ggSWJC62wmiHpBiZ
 Mzn7BAjJeQOPjiBTNEr6LEpY5vjBB2hcSsWW1MExj5ZyFpmYWkZQEj0ypG66SizPSMktzEzBx
 dQwMDXUNDU11jU11DE0u9xCrdRL3UUt3y1OISXSO9xPJivdTiYr3iytzknBS9vNSSTYzAoEwp
 Vp66g/H0qp96hxglOZiURHm/MW5NFOJLyk+pzEgszogvKs1JLT7EKMPBoSTB6/VlW6KQYFFqe
 mpFWmYOMEJg0hIcPEoivK4gad7igsTc4sx0iNQpRl2Oy9fnLWIWYsnLz0uVEufNAikSACnKKM
 2DGwGL1kuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHkDQKbwZOaVwG16BXQEE9ARjJWbQY4
 oSURISTUwTax632uXcXFSzuHH17M+rjTbO3n5tPsrO6Xjb3xekcirFHKeoejGlthYC/+wHa6f
 TvQcCppZflrS5sYB675P8ee+6YSU/f73dpqH8K7D0X9SC3ZtfXQ7Ru4b2+3KzbGLbrxO+Z5pa
 qSjaro3bFoMR9hizmn26u/vmt3uFzN55po0QcVjZ/qD2Babm9mdc9XzT2+zquh9scvy7ZmOTU
 UdG7aG+T8+uM2ib2Xk+403Tk278GLztrblBXOnf1EqXfCg5JV5gNDeXzNStkunxIVX/RJV/yp
 j5jytlFO15/MSH0NTs2X1oh+ddF4oT/i9aGr16uImt4sSAQtDlHezt6841HQ50lMs9t3D6MNP
 2bY+11diKc5INNRiLipOBACBT/+jUQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-571.messagelabs.com!1639380404!199462!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19640 invoked from network); 13 Dec 2021 07:26:45 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-5.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2021 07:26:45 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1BD7QbIZ029294
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:26:44 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 07:26:35 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 15:26:51 +0800
Message-ID: <1639380414-24390-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/6] syscalls/quotactl03: Add quotactl_fd test
 variant
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

Also remove dupcliated header file.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl03.c     | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index e0e4bf5b2..22f5496b6 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -23,19 +23,17 @@
  */
 
 #define _GNU_SOURCE
-#include "config.h"
 #include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/quota.h>
 
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
-static const char mntpoint[] = "mnt_point";
 static uint32_t test_id = 0xfffffffc;
 
 static void verify_quota(void)
@@ -44,7 +42,7 @@ static void verify_quota(void)
 
 	res_dquota.d_id = 1;
 
-	TEST(quotactl(QCMD(Q_XGETNEXTQUOTA, USRQUOTA), tst_device->dev,
+	TEST(do_quotactl(fd, QCMD(Q_XGETNEXTQUOTA, USRQUOTA), tst_device->dev,
 		test_id, (void *)&res_dquota));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "quotactl() found the next active ID: %u unexpectedly",
@@ -63,7 +61,21 @@ static void verify_quota(void)
 		tst_res(TPASS, "quotactl() failed with ENOENT as expected");
 }
 
+static void setup(void)
+{
+	quotactl_info();
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
 static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
 	.needs_root = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_XFS_QUOTA",
@@ -72,8 +84,9 @@ static struct tst_test test = {
 	.test_all = verify_quota,
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
-	.mntpoint = mntpoint,
+	.mntpoint = MNTPOINT,
 	.mnt_data = "usrquota",
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "657bdfb7f5e6"},
 		{}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
