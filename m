Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAE2C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:15:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE4B6103D
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3CE4B6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF9413C2FD0
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:15:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2926E3C4BD9
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:15:26 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 83B7D1400C48
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562924; i=@fujitsu.com;
 bh=jR0735Dq+6/4ZqTnioflGYEa/5F8zwbmtmnr67RpRC4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=zJjfpSjhpVcBOouy2Np0ysvUlUk22YF4mnNa1+pXGWX9hGNSaI23Nwi1bysyOQ+yU
 oIrEbhC7CW7E6k0YiQRtLscTzhts0W075ii9aNrydEkFwMJuN4IHJFaezfZQgMRNcl
 w6awo/7rIW8pVNZpzK4q0eNqCCC0L0U0FEBPmL0hFKJSqY1QkAMgbigk9JSaLOlc3r
 gYcWbA+J1taul5SKi+hLJ/A0D76ly91V61naJubSUPFZGu3qz+Etkx4xp33oXpdbXF
 J3ZfVNUdE55l669FRx6Gkul/NQN4cl0pIcozE7xlcydmn5f3xDSEj5Ghn8LYL6EIpx
 Fyt6/mK5rpQZw==
Received: from [100.112.196.248] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-b.eu-west-1.aws.symcld.net id AB/B7-17571-C637D616;
 Mon, 18 Oct 2021 13:15:24 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8ORqJtTnJt
 ocO2ggMWK7zsYHRg99v1exxrAGMWamZeUX5HAmrH44Azmgq98Fdc2XWZrYLzJ08XIxSEkcJZR
 YuaefnYIZyeTxL6TjVDOHkaJlas7GLsYOTnYBDQlnnUuYAaxRQQkJDoa3rKD2MwC6hLLJ/1iA
 rGFBbwlzuzcyAJiswioSjT92AHWyyvgIfG/9zYbiC0hoCAx5eF7sDmcAp4Si4/PYwWxhYBqzm
 +7zARRLyhxcuYTFoj5EhIHX7xghuhVlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRGwVlI2mchaV/
 AyLSK0SKpKDM9oyQ3MTNH19DAQNfQ0EjX0NJc19DYXC+xSjdJL7VUtzy1uETXUC+xvFivuDI3
 OSdFLy+1ZBMjMIRTCo527mD89eqD3iFGSQ4mJVHefqXcRCG+pPyUyozE4oz4otKc1OJDjDIcH
 EoSvKfzgXKCRanpqRVpmTnAeIJJS3DwKInw6hUBpXmLCxJzizPTIVKnGHU5Ll+ft4hZiCUvPy
 9VSpyXtQCoSACkKKM0D24ELLYvMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLm9QZZxZOZVwK
 36RXQEUxAR1x1zgE5oiQRISXVwGRwOuRp5ouD+XfvntsfUfZV4+j1/OuT2+4xTfmRXro6mI//
 c6NIxNZ4pcerDzmdvNjZZ/Fl137ra0353xTvmRg/ED64aMrWNd+ueRftcRF52PHwkqRokFHfw
 Q7LS/tuJ6srRK5hfvP1/qbbrHeuTZxTNUPU9O+SuYcC5OtvmuXlVl/ZGPIsZvOtdddmRR7gX3
 Jm8rGtcqnvE4szFyxY7OGrFvC+xaHhb1prk2y+Z8iOX57lOx1WhOQXGm++GLHUPOydotmE12U
 nD2yVaJWY/ej4PuWyVfedd3Kbuwcetn4i58XreFnZtWSf/+lZ3Xts9sy31fz0pETkhfrK+v0t
 GwT//VikPin57V+3B5mackErlFiKMxINtZiLihMBIqMvTGgDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-287.messagelabs.com!1634562924!760!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10177 invoked from network); 18 Oct 2021 13:15:24 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-3.tower-287.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:15:24 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C598910023C
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:15:23 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B9A61100230
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:15:23 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:15:04 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:14:46 +0800
Message-ID: <1634562888-5987-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 09/11] syscalls/quotactl03: Add quotactl_fd test
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl03.c     | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index 9711b7f07..019e7c646 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -28,15 +28,18 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/quota.h>
-
 #include "tst_test.h"
 #include "lapi/quotactl.h"
+#include "quotactl_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
-static const char mntpoint[] = "mnt_point";
+#define MNTPOINT	"mnt_point"
+#define TESTFILE	MNTPOINT "/testfile"
+
 static uint32_t test_id = 0xfffffffc;
+static int fd = -1;
 
 static void verify_quota(void)
 {
@@ -44,7 +47,7 @@ static void verify_quota(void)
 
 	res_dquota.d_id = 1;
 
-	TEST(quotactl(QCMD(Q_XGETNEXTQUOTA, USRQUOTA), tst_device->dev,
+	TEST(do_quotactl(fd, QCMD(Q_XGETNEXTQUOTA, USRQUOTA), tst_device->dev,
 		test_id, (void *)&res_dquota));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "quotactl() found the next active ID: %u unexpectedly",
@@ -63,6 +66,18 @@ static void verify_quota(void)
 		tst_res(TPASS, "quotactl() failed with ENOENT as expected");
 }
 
+static void setup(void)
+{
+	quotactl_info();
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_kconfigs = (const char *[]) {
@@ -72,8 +87,11 @@ static struct tst_test test = {
 	.test_all = verify_quota,
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
-	.mntpoint = mntpoint,
-	.mnt_data = "usrquota",
+	.mntpoint = MNTPOINT,
+	.mnt_data = "usrquota,grpquota",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = 2,
 };
 
 #else
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
