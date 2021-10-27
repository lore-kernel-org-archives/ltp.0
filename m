Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B5C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:30:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4687A60F5A
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4687A60F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B25463C6AA8
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:30:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BBA93C004E
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:56 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6BD68603471
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337795; i=@fujitsu.com;
 bh=9EEgLG/RqpY0m44X206kM7t/FjD2zoRhrCoSyEFVDfA=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=CliXUvJTDOK1jhOkETOUEO+sd/CV9PpeMzIUoG2dZYFRFAHksdrkTOX2qiF7l036+
 tvNw9mws8Bj2kRmHMWZUlAbW+Sl7Jvzix2LawKf5uxgHUpSGav4oduh1QG7/hhKFiD
 oEOzdqQ8kX/0e4UDJU0WJ68NHSsk4daB2Q1FsRUbLq0sq/WuV9P5V4ZaGJWWi+sQeK
 ZGsgQWZNR4/gE5C0HBb6fPQVr8//+UVj6TT2W3Z5IEGUfsPXjUzyj56+7opcMlDR3h
 lDYYGkhkirSB9Ou09li6QGrOscUzeVGxcJN9O402AWBWXXeYcKUUGpGGjoo2Y3Biji
 V2kZt/Xc6is8A==
Received: from [100.113.3.109] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.symcld.net id E5/55-15394-34649716;
 Wed, 27 Oct 2021 12:29:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8MxSdfZrTL
 R4Mo3HosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPrjiaWgn/KFX9Wb2FpYLwp38XIxSEkcJZR
 4siMGcwQzk4midltV5ggnD2MEtvWHGftYuTkYBPQlHjWuYAZxBYRkJDoaHjLDmIzC6hLLJ/0i
 wnEFhaIkNh67AJYPYuAqkTvvuVgNbwCHhKz9v5jAbElBBQkpjx8DzaHU8BTov/KKSCbA2iZh0
 TTyxKIckGJkzOfsECMl5A4+OIFM0SrosSljm+MEHaFxKxZbUwQtprE1XObmCcwCs5C0j4LSfs
 CRqZVjJZJRZnpGSW5iZk5uoYGBrqGhsa6BrpGpkZ6iVW6iXqppbrJqXklRYlAWb3E8mK94src
 5JwUvbzUkk2MwBBOKWT4s4Nx9ZsPeocYJTmYlER5A3QqE4X4kvJTKjMSizPii0pzUosPMcpwc
 ChJ8Ga6AOUEi1LTUyvSMnOA8QSTluDgURLhzXEFSvMWFyTmFmemQ6ROMepyXL4+bxGzEEtefl
 6qlDivMkiRAEhRRmke3AhYbF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMwbBTKFJzOvBG7
 TK6AjmICOYFaqADmiJBEhJdXAZNW8c0aY04xNqVNkBaZPWmt45v6Ou0LPNI99fuT5ZLJbB+s0
 05zAi/GbyryCE6cJrWqfv1vlcon3C8UNmRun/Jh0NK9+PwdDwo2Z1XOXZT3WnxNpMvvln2f9C
 7bv/Pdk6hde/Rtb0lVXSqw59zMupTTyRFZGOLOC7R0ftsmftl5Q0spUZ5gW9mBV3/XthsvTXt
 s/Mu+YHdg58/Jk66+cz7XS20sW5l54xMpQZFfx5NyyzWwLLi270VNbmBXbumv5dim36R9c5xz
 ++/SQg4mZZ8p6pajDvCL3lm++weO0lrPT8Kg4f49vedexUwavDRzC0rJu/1Hx315+/1hCXt0p
 rtuM074cVdST3c/yJEJxp4gSS3FGoqEWc1FxIgAJhl+2aAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-232.messagelabs.com!1635337794!3306231!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7240 invoked from network); 27 Oct 2021 12:29:55 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-4.tower-232.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:29:55 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 9FEEC10046D
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:29:54 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 907EC100459
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:29:54 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:29:40 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:29:30 +0800
Message-ID: <1635337770-4889-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337770-4889-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337770-4889-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 13/13] syscalls/quotactl: Move common code into
 quotactl_syscal_var.h
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
 testcases/kernel/syscalls/quotactl/quotactl02.h           | 5 +----
 testcases/kernel/syscalls/quotactl/quotactl03.c           | 4 ----
 testcases/kernel/syscalls/quotactl/quotactl04.c           | 4 +---
 testcases/kernel/syscalls/quotactl/quotactl07.c           | 5 -----
 testcases/kernel/syscalls/quotactl/quotactl08.c           | 5 +----
 testcases/kernel/syscalls/quotactl/quotactl09.c           | 4 +---
 testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h | 4 ++++
 7 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.h b/testcases/kernel/syscalls/quotactl/quotactl02.h
index faee5d282..145ce7039 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.h
@@ -17,15 +17,12 @@
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
-#define MNTPOINT "mntpoint"
-#define TESTFILE MNTPOINT "/testfile"
-
 static struct fs_disk_quota set_dquota = {
 	.d_rtb_softlimit = 1000,
 	.d_fieldmask = FS_DQ_RTBSOFT
 };
 static uint32_t test_id;
-static int x_getnextquota_nsup, fd = -1;
+static int x_getnextquota_nsup;
 static int x_getstatv_nsup;
 
 void check_support_cmd(int quotatype)
diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index 0c4c50b42..d13bc694b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -34,11 +34,7 @@
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
-#define MNTPOINT	"mnt_point"
-#define TESTFILE	MNTPOINT "/testfile"
-
 static uint32_t test_id = 0xfffffffc;
-static int fd = -1;
 
 static void verify_quota(void)
 {
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 4dc68c2ae..50ba445ca 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -32,11 +32,9 @@
 #include "quotactl_syscall_var.h"
 
 #define FMTID QFMT_VFS_V1
-#define MNTPOINT	"mntpoint"
-#define TESTFILE	MNTPOINT "/testfile"
 
 static int32_t fmt_id = FMTID;
-static int test_id, mount_flag, fd = -1;
+static int test_id, mount_flag;
 static struct dqblk set_dq = {
 	.dqb_bsoftlimit = 100,
 	.dqb_valid = QIF_BLIMITS
diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index d29a56ee4..6e8c3ecee 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -21,11 +21,6 @@
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
-#define MNTPOINT    "mntpoint"
-#define TESTFILE MNTPOINT "/testfile"
-
-static int fd = -1;
-
 /* Include a valid quota type to avoid other EINVAL error */
 static unsigned int invalid_type = XFS_GROUP_QUOTA << 1 | XFS_USER_QUOTA;
 
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index 6912378f1..e37a474d2 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl08.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -40,11 +40,8 @@
 #include "quotactl_syscall_var.h"
 #include "tst_safe_stdio.h"
 
-#define MNTPOINT	"mntpoint"
-#define TESTFILE	MNTPOINT "/testfile"
-
 static int32_t fmt_id = QFMT_VFS_V1;
-static int test_id, fd = -1;
+static int test_id;
 static struct dqblk set_dq = {
 	.dqb_bsoftlimit = 100,
 	.dqb_valid = QIF_BLIMITS
diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
index 1a3a7005d..e7aad7b9b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl09.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -27,11 +27,9 @@
 #include "tst_safe_stdio.h"
 
 #define OPTION_INVALID 999
-#define MNTPOINT "mntpoint"
-#define TESTFILE MNTPOINT "/testfile"
 
 static int32_t fmt_id = QFMT_VFS_V1;
-static int test_id, fd = -1;
+static int test_id;
 static int getnextquota_nsup;
 
 static struct if_nextdqblk res_ndq;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
index 92a7c45db..bf2b06ffe 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
@@ -10,6 +10,10 @@
 #include "lapi/quotactl.h"
 
 #define QUOTACTL_SYSCALL_VARIANTS 2
+#define MNTPOINT "mntpoint"
+#define TESTFILE MNTPOINT "/testfile"
+
+static int fd = -1;
 
 static int do_quotactl(int fd, int cmd, const char *special, int id, caddr_t addr)
 {
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
