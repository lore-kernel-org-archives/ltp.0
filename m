Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DDCC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:29:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112DF60F9D
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 112DF60F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B294C3C6AAE
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:29:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCCE73C6A33
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:01 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 46C10200349
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337740; i=@fujitsu.com;
 bh=AJs6S6OP3UXzMDK6wEPSTQyl4LGVtRYcjhqhyRGTLjo=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=FN39o7Wok6wGUdzCOGTkl/2zm1GT//Yw/Y18aeZGsFBmobXX0kwxBwcjzEsc97FFb
 JETlYn5lZj5fdngOusqM8RncF1WkPki9zwNXgUiXC/HrgyJvLrythDDrbSCq29ekpA
 0rYJEefBvxvNeK1eHbvL4n6QsYmRc8UVy2EmJEHZaPL/+hi5OlCutW8GhESeAMJGJn
 uCvXmoFB3ZnLhOCbpqwdHKngBYeFCNrx+g0aVekQcfMRqLYLVBV5k8KT+i5Hs9gCOg
 OUsAqS4wf6gaVoy0U62/s+Mk2L0gQAykvG7bShCWCru31KqwhB0kjvCgoYZ6egu6GW
 uiojNbJb1p2VA==
Received: from [100.112.195.149] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 52/27-17143-C0649716;
 Wed, 27 Oct 2021 12:29:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8ORqMvtVpl
 o8OeSlcWK7zsYHRg99v1exxrAGMWamZeUX5HAmrG7+RFjwSaBimlb25gbGL/zdjFycggJnGWU
 OHJAq4uRC8jeySRxZ8J1FghnD6PE3alPGEGq2AQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9Y
 gKxhQW8Jbb/nwZWwyKgKrH43mUWEJtXwENi9677YPUSAgoSUx6+B6vhFPCUeLJmB1ANB9AyD4
 lZa0sgygUlTs58wgIxXkLi4IsXzBCtihKXOr4xQtgVErNmtTFB2GoSV89tYp7AKDgLSfssJO0
 LGJlWMVokFWWmZ5TkJmbm6BoaGOgaGhrpGlqa6hqaGuolVukm6qWW6panFpfoArnlxXrFlbnJ
 OSl6eaklmxiB4ZtScHj6Dsb+Nx/0DjFKcjApifIG6FQmCvEl5adUZiQWZ8QXleakFh9ilOHgU
 JLgzXQBygkWpaanVqRl5gBjCSYtwcGjJMKb4wqU5i0uSMwtzkyHSJ1i1OW4fH3eImYhlrz8vF
 QpcV5lkCIBkKKM0jy4EbC4vsQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmDcKZApPZl4J3KZ
 XQEcwAR3BrFQBckRJIkJKqoEpY1/5BuXLAc8CjydZBr/PTY4QtmFuPSAxm1NuptPWN23vNhh9
 sm9fuCZt+aTDCoqd/+9GMn4qsTm6dOMey9oJXZtCbIs3bX2zqfLeuqc5J9KTozJ9q196PN6f4
 bDwvFhYlJPPBU4lsT791bXfmqbsm12hFntWxF9WIcx+1USbSPPqY0x1vHJn7wVPftI58+zylx
 Zqy375n12g6Pw54XCZyTJxvVedLyuOm+fXSh+f/enDprq7VkoLhE98FPvxSWhauIVM8cLoVYl
 BS33fLTBQLrYp4qxU5LKYzXI4553Cl5ojLh/tjwq8aF138v43luqzCRzXHToSUyL4c6TvpP89
 2yZ/5f4Bw8Yz72I2GNgqsRRnJBpqMRcVJwIAbwCR5WYDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-271.messagelabs.com!1635337739!295689!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17087 invoked from network); 27 Oct 2021 12:28:59 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-11.tower-271.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:28:59 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 7CC3810023F
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:28:59 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 70E98100231
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:28:59 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:28:41 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:28:26 +0800
Message-ID: <1635337706-4788-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337706-4788-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337706-4788-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/13] syscalls/quotactl03: Add quotactl_fd test
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
 .../kernel/syscalls/quotactl/quotactl03.c     | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index e0e4bf5b2..0c4c50b42 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -23,20 +23,22 @@
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
+#define MNTPOINT	"mnt_point"
+#define TESTFILE	MNTPOINT "/testfile"
+
 static uint32_t test_id = 0xfffffffc;
+static int fd = -1;
 
 static void verify_quota(void)
 {
@@ -44,7 +46,7 @@ static void verify_quota(void)
 
 	res_dquota.d_id = 1;
 
-	TEST(quotactl(QCMD(Q_XGETNEXTQUOTA, USRQUOTA), tst_device->dev,
+	TEST(do_quotactl(fd, QCMD(Q_XGETNEXTQUOTA, USRQUOTA), tst_device->dev,
 		test_id, (void *)&res_dquota));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "quotactl() found the next active ID: %u unexpectedly",
@@ -63,7 +65,21 @@ static void verify_quota(void)
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
+	.setup = setup,
+	.cleanup = cleanup,
 	.needs_root = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_XFS_QUOTA",
@@ -72,8 +88,9 @@ static struct tst_test test = {
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
