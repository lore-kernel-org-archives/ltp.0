Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CCFC433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:55:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04B861178
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A04B861178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B7B53C07B5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:55:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A40D33C04C2
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:55:09 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 10FD914125F0
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:55:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455308; i=@fujitsu.com;
 bh=yaHU5Y+z6tuguFfJNAPUvA5YK4UBE2aOgVuTE58SOIY=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=lRLiJH4BKjNFDNgOG/xsdpwxQ/dFmQJZ4K7IvD1dfte3x50Zx73B9rH/7vmEX+rtI
 31LcALPxuVJBuaQJ93Qty6dqIoNOFEWZumVinbfoZZZ+SO0QDQ12/CypvS6VSULrBb
 i12kgjG+QvxM0KQnNLYjL2fXViuPBIKDgthfVDhliArYheMHpRfsP+Rnm1pCv6OyYm
 fkcmuWCpWYbF6FbWjb6WUJnG2/rdiG6MAT7Fo8C7iuXe/2AYJJl33QKQbSy2wKFlcp
 dvPbX7eurlxVxCWetaa0FQU03yauV1U1f0cjkiPb+4MUTzwXjEx5W6ogFCprIZQvNY
 RvQYesaWWr37A==
Received: from [100.115.35.109] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id 24/8D-02703-C835A816;
 Tue, 09 Nov 2021 10:55:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsViZ8MxSbc7uCv
 R4FWfucWK7zsYHRg99v1exxrAGMWamZeUX5HAmnFoxXT2gqP8Fbf3tDM2MM7h7WLk4hASOMso
 sWnuQ/YuRk4gZyeTRO8CD4jEbkaJy1+6wRJsApoSzzoXMIPYIgISEh0Nb8HizALqEssn/WICs
 YUFvCU233zOAmKzCKhIHJv2gxXE5hXwkPi+cQIjiC0hoCAx5eF7sDmcAp4Sey/8Z4FY7CFxa9
 pJqHpBiZMzn7BAzJeQOPjiBTNEr6LEpY5vUHMqJGbNamOCsNUkrp7bxDyBUXAWkvZZSNoXMDK
 tYrROKspMzyjJTczM0TU0MNA1NDTVNTbVNTQ30kus0k3USy3VLU8tLtEFcsuL9VKLi/WKK3OT
 c1L08lJLNjECwzilWHnNDsb2y9/0DjFKcjApifJeFutKFOJLyk+pzEgszogvKs1JLT7EKMPBo
 STBm+APlBMsSk1PrUjLzAHGFExagoNHSYRXzwcozVtckJhbnJkOkTrFqMtx+fq8RcxCLHn5ea
 lS4rwpQUBFAiBFGaV5cCNg8X2JUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvp0CgKTyZeSV
 wm14BHcEEdMTBL+0gR5QkIqSkGpjqW/8HH/0bynZsoWakVFONjK6P+8x1fa47p+2U/lUhYcRj
 5vi/UbZUe3VZIZvEVJUzml+vP78RN9/lXeWJ8ot7f510/pTAf+NKUaKBUtznVS6yybzK4aYnD
 PzDPJnTAm/W/A93mfHVbNb50y9kH33lClDhvPIyLu7S7ufLdZ+e9vDtyTFf1blA9/ceoVN/F3
 zvlcide1NC47Dj/EX23ieurP+SpR916O+VV4d9dwb+U9KdlGw56ZfOEn222O8LWpaK93Q++dR
 77KTyW4U6HttHu6Qnd7cfeHTkzacz26fY3livfmD6o/QHrtsN3BV0n6XOiNWN5vwpFLFWnfuK
 Zs4G5tLzR29esJbtWWFQFnJAiaU4I9FQi7moOBEAILAYPWoDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-565.messagelabs.com!1636455307!345344!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31597 invoked from network); 9 Nov 2021 10:55:07 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-22.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:55:07 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 7DB3510046B
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:55:07 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 6F852100460
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:55:07 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:54:50 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:54:45 +0800
Message-ID: <1636455285-8372-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 09/12] syscalls/quotactl03: Add quotactl_fd test
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
