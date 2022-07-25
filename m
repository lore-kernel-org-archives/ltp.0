Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41C6C43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 15:15:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCDEE3C9D51
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 17:15:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 419C93C9809
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:15:09 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9811B60032E
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:15:08 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id j22so21185740ejs.2
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BaSad2Bie0SsyU6fTSWB4e91cfoh49c/6Iq8mPVxfU0=;
 b=MBBvX2RG9834OykXPoCPGvp0wZJcZRy6S2ld/vapv8IKmMLFRwEcOsZpP1f4WyNHgD
 e5fyYOmIThiX9LQen7dR1114gJPlhU9DM4CMM7Ji7YDgYqnIc9S73Y/csTrU4d8UrWdB
 jGBq0fb5RZcQCENds+Kk+IdKFZ9PF2kBtBNmqpDqM+yfPkZRdxHwgiFhAkrF0Ei25Zzq
 PQmUNXNBGAkVn85dfciSPoYqBf9cGjbeUBFeNe/scPkGRg1O1w7up7WpA4I1YjubYj6x
 xi5Jr8AV7UDsfXQ9ybpX6p0Umdy/vycSIG4dYcNbPHBrUOoYVnU9hxZzxiQbIbMS6j1B
 oXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BaSad2Bie0SsyU6fTSWB4e91cfoh49c/6Iq8mPVxfU0=;
 b=O54vYTqAeR9op9ya5UhW7JSo9F+wovo1gLqnFuaQeJxeevnNUNnyKcyeh1VGf67l5E
 DftvXeLOLJOmOniP8glLnlZjPEDuRgXfVjxgjfb9XTqhMfz2e/szjtzyOmtD3g50npXF
 kodCT8IltF+qczsqujGTr6xl287R7WDOBKr0pNLlPqz/RxcbzCd8GxplGV0ywdKwriXX
 kr4x6BgncHWS6CNoSB+jSuHu+dUStnSeTbU4IdN8sdPdGszx5DFU69CPvOzxjRbCRDWZ
 fMBVk+V0nvPCjW7DWXUvYDb4GXDviqrMTmwIUq1QRVOn5otzO4yLU3vtgnpLGMtZTyNo
 /drA==
X-Gm-Message-State: AJIora+uP6kK/yOJC/Oi8PqDVuCC7sMWWvBy5oSiGiZqmIlTEgJXVaBJ
 N/526zi1gEEn9JdwFgjewDMCAMPYPKUmaw==
X-Google-Smtp-Source: AGRyM1tErsqrN6XzR9txgyMSh5DiiSiUuId+8hwcyScN7lWcihgbBUKl4uLPNH0WHzFF6H3Rd4lisw==
X-Received: by 2002:a17:907:75cc:b0:72b:4a96:69fe with SMTP id
 jl12-20020a17090775cc00b0072b4a9669femr10767306ejc.276.1658762107867; 
 Mon, 25 Jul 2022 08:15:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.kpn
 (2a02-a45a-4ae9-1-ded3-af6f-ecdf-f6f4.fixed6.kpn.net.
 [2a02:a45a:4ae9:1:ded3:af6f:ecdf:f6f4])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a17090670d600b006f3ef214e27sm5422966ejk.141.2022.07.25.08.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jul 2022 08:15:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jul 2022 17:14:53 +0200
Message-Id: <20220725151453.3846227-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725151453.3846227-1-amir73il@gmail.com>
References: <20220725151453.3846227-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/fanotify14: Add test cases for events
 not allowed on non-dir
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Dirent events are meaningless in mask of non-dir inode and so do
the flags FAN_ONDIR FAN_EVENT_ON_CHILD.

With fanotify_init flag FAN_REPORT_TARGET_FID, they are also not allowed.
Make sure that trying to add them to non-dir inode mark mask results in
ENOTDIR error and that trying to add them to directory or filesystem
mark does not fail.

Also add validity check for legacy FAN_MARK_ONLYDIR and add more
information to error when safe_fanotify_mark() fails.

Reviewed-by: Matthew Bobrowski <repnop@google.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h |  4 +-
 .../kernel/syscalls/fanotify/fanotify14.c     | 73 ++++++++++++++++++-
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 0ad7ef21b..a118fbd9e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -48,7 +48,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 	rval = fanotify_mark(fd, flags, mask, dfd, pathname);
 
 	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO, "fanotify_mark() failed");
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "fanotify_mark(%d, 0x%x, 0x%lx, ..., %s) failed",
+			 fd, flags, mask, pathname);
 	}
 
 	if (rval < -1) {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index b9ef2fd91..020e01ddf 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -13,6 +13,13 @@
  * mask value has been specified in conjunction with FAN_REPORT_FID.
  */
 
+/*
+ * The ENOTDIR test cases are regression tests for commits:
+ *
+ *     ceaf69f8eadc fanotify: do not allow setting dirent events in mask of non-dir
+ *     8698e3bab4dd fanotify: refine the validation checks on non-dir inode mask
+ */
+
 #define _GNU_SOURCE
 #include "tst_test.h"
 #include <errno.h>
@@ -31,6 +38,7 @@
 		      FAN_DELETE_SELF | FAN_MOVE_SELF)
 
 static int fanotify_fd;
+static int fan_report_target_fid_unsupported;
 
 /*
  * Each test case has been designed in a manner whereby the values defined
@@ -79,6 +87,26 @@ static struct test_case_t {
 		/* FAN_RENAME without FAN_REPORT_NAME is not valid */
 		FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID, 0, FAN_RENAME, EINVAL
 	},
+	{
+		/* With FAN_MARK_ONLYDIR on non-dir is not valid */
+		FAN_CLASS_NOTIF, FAN_MARK_ONLYDIR, FAN_OPEN, ENOTDIR
+	},
+	{
+		/* With FAN_REPORT_TARGET_FID, FAN_DELETE on non-dir is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, 0, FAN_DELETE, ENOTDIR
+	},
+	{
+		/* With FAN_REPORT_TARGET_FID, FAN_RENAME on non-dir is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, 0, FAN_RENAME, ENOTDIR
+	},
+	{
+		/* With FAN_REPORT_TARGET_FID, FAN_ONDIR on non-dir is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, 0, FAN_OPEN | FAN_ONDIR, ENOTDIR
+	},
+	{
+		/* With FAN_REPORT_TARGET_FID, FAN_EVENT_ON_CHILD on non-dir is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, 0, FAN_OPEN | FAN_EVENT_ON_CHILD, ENOTDIR
+	},
 };
 
 static void do_test(unsigned int number)
@@ -86,6 +114,12 @@ static void do_test(unsigned int number)
 	int ret;
 	struct test_case_t *tc = &test_cases[number];
 
+	if (fan_report_target_fid_unsupported && tc->init_flags & FAN_REPORT_TARGET_FID) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
+					    fan_report_target_fid_unsupported);
+		return;
+	}
+
 	fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
 	if (fanotify_fd < 0) {
 		if (errno == tc->expected_errno) {
@@ -117,8 +151,10 @@ static void do_test(unsigned int number)
 		goto out;
 	}
 
+	/* Set mark on non-dir only when expecting error ENOTDIR */
+	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
 	ret = fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
-				tc->mask, AT_FDCWD, FILE1);
+				tc->mask, AT_FDCWD, path);
 	if (ret < 0) {
 		if (errno == tc->expected_errno) {
 			tst_res(TPASS,
@@ -129,7 +165,30 @@ static void do_test(unsigned int number)
 				fanotify_fd,
 				tc->mark_flags,
 				tc->mask,
-				FILE1, tc->expected_errno);
+				path, tc->expected_errno);
+			/*
+			 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
+			 * Try to set an inode mark on a directory and it should succeed.
+			 * Try to set directory events in filesystem mark mask on non-dir
+			 * and it should succeed.
+			 */
+			if (tc->expected_errno == ENOTDIR) {
+				SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
+						   tc->mask, AT_FDCWD, MNTPOINT);
+				tst_res(TPASS,
+					"Adding an inode mark on directory did not fail with "
+					"ENOTDIR error as on non-dir inode");
+			}
+			if (tc->expected_errno == ENOTDIR &&
+			    !(tc->mark_flags & FAN_MARK_ONLYDIR)) {
+				SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags |
+						   FAN_MARK_FILESYSTEM, tc->mask,
+						   AT_FDCWD, FILE1);
+				tst_res(TPASS,
+					"Adding a filesystem mark on non-dir did not fail with "
+					"ENOTDIR error as with an inode mark");
+			}
+
 			goto out;
 		}
 		tst_brk(TBROK | TERRNO,
@@ -165,6 +224,9 @@ static void do_setup(void)
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 	SAFE_CLOSE(fd);
 
+	fan_report_target_fid_unsupported =
+		fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME_TARGET, MNTPOINT);
+
 	/* Create temporary test file to place marks on */
 	SAFE_FILE_PRINTF(FILE1, "0");
 }
@@ -183,7 +245,12 @@ static struct tst_test test = {
 	.cleanup = do_cleanup,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
-	.all_filesystems = 1
+	.all_filesystems = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "ceaf69f8eadc"},
+		{"linux-git", "8698e3bab4dd"},
+		{}
+	}
 };
 
 #else
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
