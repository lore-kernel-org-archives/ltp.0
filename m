Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F48C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:56:29 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3B861054
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A3B861054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBFE43C06DC
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:56:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BC1B3C04C2
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:56:18 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA0DB60157B
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:56:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455377; i=@fujitsu.com;
 bh=Kp5lnxM2KN10+a+vDkQlUl4mV37rg0OH7iOsGvdqsJI=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=rI8c7amNaOu3BnKwC5G5FAlU15GCRnjz/ldEOHecLkwpZO8XRyUlJKabgfwFygUfo
 vTD3ffXDJmlRvg/1QEBpB+2yrt8pXLbAgpQ4bW733RXZSiyBWyRkSk0QalSB1lZmDu
 8OeBTMT4bfuh5u7B9No/WQHUerXinru2U4TQcWZMS3yAsHewAj96esjns6z3TupyOE
 KQaJ30LP17ODEUbB/Hdw/LEMa5EDpnszBuiuPhVSePo55AI6PnuOcAR1asqso/iw8l
 xiVtSEv1H5MrINoAWFGsdVL4ZV3Gup2JxmoDLvu7b8wyCWv780tcrg8gRDmUibCjiK
 fCCT/J5jiE3iQ==
Received: from [100.115.36.144] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id 99/C0-02703-1D35A816;
 Tue, 09 Nov 2021 10:56:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRWlGSWpSXmKPExsViZ8MxRfdCcFe
 iwYZDOhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aBlvnMBT0CFY93fWZtYLzL28XIxSEk0Mgk
 cfD+c2YIZzejROfft+xdjJwcbAKaEs86FzCD2CICEhIdDRBxZgF1ieWTfjGB2MIC3hI3vv5h6
 2Lk4GARUJH4NI0DJMwr4CHxYs9hsHIJAQWJKQ/fM0PEBSVOznzCAjFGQuLgixfMEDWKEpc6vj
 FC2BUSs2a1MU1g5J2FpGUWkpYFjEyrGK2SijLTM0pyEzNzdA0NDHQNDU11jc10zU31Eqt0E/V
 SS3XLU4tLdI30EsuL9VKLi/WKK3OTc1L08lJLNjECQyylWMV7B2Pj5W96hxglOZiURHkvi3Ul
 CvEl5adUZiQWZ8QXleakFh9ilOHgUJLgTfAHygkWpaanVqRl5gDDHSYtwcGjJMKr5wOU5i0uS
 MwtzkyHSJ1iVJQS500JAkoIgCQySvPg2mAxdolRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO
 +nQKApPJl5JXDTXwEtZgJafPBLO8jikkSElFQDU9mcf2bfm5/JLrV6nVIv7eq4QCNMXmj1u9s
 72gXXZV2+OyPavJqXY4PB4+Vr9z/0i372zCdS5Hd53q0uq5a1X/nvcLWGHJ9t4W3EtfvFlU1r
 Z+1m5HYW2fVv5eVDW92482L3/GSYJ+he4dF/64mt+alV//g1JhyL2FaZpl0pLSrpf3vBU/E9x
 m8uRlbwCN302rfrjfWrAxZuIceFPm/aO2HDlrh1hY6+e5RsO9OVtj9PufgiguH6P673oQqu1R
 d5F7Hviy8sN3Tjdj+REfB0pcGS109NPn3NfK2kciv3NO923o9HGtTytize25uwbu1mxkuqzRd
 rfkw1fXdux73j3nvkXjgFM/Ascz1u+FTqhK4SS3FGoqEWc1FxIgC8Pc2XLAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-548.messagelabs.com!1636455376!345176!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15056 invoked from network); 9 Nov 2021 10:56:16 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-20.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:56:16 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1A9AuGmE018878
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Tue, 9 Nov 2021 10:56:16 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:56:14 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:56:34 +0800
Message-ID: <1636455396-8508-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 10/12] syscalls/quotactl04: Add quotactl_fd test
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

Also remove useless geteuid.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index dab61cf4d..f71016967 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -29,10 +29,10 @@
 #include <sys/mount.h>
 #include "tst_safe_stdio.h"
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #define FMTID QFMT_VFS_V1
-#define MNTPOINT	"mntpoint"
+
 static int32_t fmt_id = FMTID;
 static int test_id, mount_flag;
 static struct dqblk set_dq = {
@@ -125,7 +125,7 @@ static void setup(void)
 	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
 	int rc, major, minor, patch;
 
-	test_id = geteuid();
+	quotactl_info();
 	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
 	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
 	if (rc != 3)
@@ -135,10 +135,13 @@ static void setup(void)
 	pclose(f);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
 }
 
 static void cleanup(void)
 {
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 	if (mount_flag && tst_umount(MNTPOINT))
 		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
 }
@@ -153,7 +156,7 @@ static void verify_quota(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
+	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
 		return;
@@ -183,6 +186,7 @@ static struct tst_test test = {
 	.needs_device = 1,
 	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.needs_cmds = (const char *[]) {
 		"mkfs.ext4",
 		NULL
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
