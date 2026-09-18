Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF4EC88E75
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 07:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789718036; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=xbv7s0lf2eZ9ev+p75rR6eyNYhTbILT3cAukqlobIR4=;
 b=AfybCzLfKFci4OT4QyxfgDoDTNyRx8OjELF4e6ehqtMy/a2ODYtK/YGLVVrFQ0XbsnoSX
 h3ReLAmoSHpegenp2g9qbz4hAqSp6Fjv2J7EbVAXIk0DsNbHXraH/O+4wA9MrDpgAPUFK6l
 cgtHB9YkUMsJP6TKRd/hotidOqB4ZEE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEAFB3E73E7
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 09:53:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCDB33E7283
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 09:52:45 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 40E36200AF7
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 09:52:45 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so3124075e9.0
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789717965; x=1790322765; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZgPyatQKzwEVg1OwIWeMTY+GUmjKNuc3+kC5+JXxYpE=;
 b=WF6GX7hurjqNWtL6fDjxN88Ec2Rnv8T9bejwNtLOgRUqp8rXajQNvrFuHuur8mTT8O
 ewQdieu9Ebqd7YXcqSH6Bm0O2DSzk8xnb82O6mvgtVmbJUf5oAPaTeeHpX8v8+QbJFl5
 yOwbMOE5+Us9O743hBO7KAJYLmBo2KNEYGjixi3VSSFmL6mC3IFIoimNZxYBETW6i46f
 rLC9Nby451zI+uzzLuDwFHSWl0AbQmbhP0lAYaF2CAoPDELlVsyOp0owrNXLq7Fh4boZ
 1tSActK/DrUH/MMuP9//AkwYuM/ZQw0ynqjVUpRtk1NDJbQHnSrbosDS+XXeITfljAw5
 1lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789717965; x=1790322765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZgPyatQKzwEVg1OwIWeMTY+GUmjKNuc3+kC5+JXxYpE=;
 b=aTfuwcR2J8Gr8S8L/xI8Y1AVNrcQ/3vT9jgQoEaVGsb2VWTR7klMWY7uhqiT56rNNc
 yshUhkO9jtR2t5L/0V13pZYmRj96xfnA2ZZxpAEtNFttwTXP5o21DqHKcqhXt2JxdUjz
 FGgmkZraRGNoa4PPJjPyWT2cN8D2Me18zW55Ntray2aic6uFYLS16cULv3UfH4KQtoXs
 N5DSuvR4oNS59Zb8EwxXu2xqtVzPNVvJgCNa02jN0ex6sqcm2ejXhW8VPQIhcz/fokGA
 4hqn6ShiDs/JGHRwW3HkWDGOoAAgbFE/iYxWP8d1pZdQoc2LF4xJt10lMzEu3qlq0uEH
 AqMg==
X-Gm-Message-State: AFuF++lAyVIeGBFIsYxASrvteXv5+tsGqa2K+dzaUdQVH4MAQ6ceu33J
 7IYwrj0vDJ7NCmGUh4w+VRkOgyjgcdOitF0gvF487TwrC2r8696v7Nrxqp0sb7NGX75EZeORUrU
 tyhY=
X-Gm-Gg: AYBFou01bteWWas4ZSsw1Sjv6H3l1YWDmR/ehgiF2JtZKTC0a7VyqflNNRUE9pObuBy
 6urkz5JM8Lr8PdEzmYG95NE70UoVazImM8MT4Po8g2zz1IYd9UktaDefGuQlHEwsVnvsGK4rbMO
 9DxELIUClnYYXJ+IpthVOdPJRhpg3IdoGBPBLcPuZvbU/v0PTVwopDb4TIINcch9D6W4y9prhSf
 FGxTRSh+mBpzoVb367K5klpSuYLMrFobzdbBjC0jVktE+dsnm4hGqHi0kHjILkas+2x3eY7uetI
 b52ydqkLpnn99sF8IG40gNLXyZhsAQzbX7M7t7jzfDIvRpeocB1LSAIpOuFtCBv5r6bdEaQMN6X
 LwOxv2z302mGYFMZAEarcpHdIBCrdmHC5dFLwY0UmUsF6H3tAkRM3xyfSYqUa2R+SZYlUQIeN8D
 BGCv/r10cX4JNaNk+ep6GgzaskfvXXi7Wge8TeLGimnVFpP8KX/dGvzCVWTWuHez4kzOkzFN/CR
 13CDTJ1Jrdxr3Ji3p0lFTFtoiqypC/dlLfqGYozhbo5
X-Received: by 2002:a05:600c:34cc:b0:49e:6c27:d093 with SMTP id
 5b1f17b1804b1-49fc56dbafdmr18505505e9.15.1789717964623; 
 Fri, 18 Sep 2026 00:52:44 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49fc7cfd3fcsm30656025e9.10.2026.09.18.00.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:52:44 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 18 Sep 2026 07:52:23 +0000
Message-ID: <20260918075228.21423-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918075228.21423-1-wegao@suse.com>
References: <20260918075228.21423-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14 3/3] open16: allow restricted O_CREAT of FIFOs and
 regular files
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

Add LTP coverage for kernel commit 30aba6656f61 (Linux 4.19), which
introduced protection against spoofing attacks via O_CREAT of FIFOs
and regular files in world-writable or group-writable sticky
directories.

This commit adds test cases to verify these security restrictions
(values 1 and 2 for protected_fifos and protected_regular) for opening
FIFOs and regular files in world-writable or group-writable sticky
directories when the file is not owned by the opener.

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_path_defs.h                   |   2 +
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 143 ++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 1a60028d3..2995150be 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -47,6 +47,8 @@
 #define PATH_FS_PIPE_MAX_PAGES			"/proc/sys/fs/pipe-max-pages"
 #define PATH_FS_MAX_USER_GROUPS			"/proc/sys/fs/fanotify/max_user_groups"
 #define PATH_FS_MAX_USER_MARKS			"/proc/sys/fs/fanotify/max_user_marks"
+#define PATH_FS_PROTECTED_REGULAR		"/proc/sys/fs/protected_regular"
+#define PATH_FS_PROTECTED_FIFOS			"/proc/sys/fs/protected_fifos"
 
 /* VM */
 #define PATH_VM_DROP_CACHES			"/proc/sys/vm/drop_caches"
diff --git a/runtest/syscalls b/runtest/syscalls
index a021c79da..4fd62efa8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1008,6 +1008,7 @@ open12 open12
 open13 open13
 open14 open14
 open15 open15
+open16 open16
 
 openat01 openat01
 openat02 openat02
diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
index af5997572..d2cacc02e 100644
--- a/testcases/kernel/syscalls/open/.gitignore
+++ b/testcases/kernel/syscalls/open/.gitignore
@@ -13,3 +13,4 @@
 /open13
 /open14
 /open15
+/open16
diff --git a/testcases/kernel/syscalls/open/open16.c b/testcases/kernel/syscalls/open/open16.c
new file mode 100644
index 000000000..3f79e46e0
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Verify restricted opening (:manpage:`open(2)` and :manpage:`openat(2)`) of
+ * FIFOs and regular files in sticky directories. This protection is controlled via
+ * `/proc/sys/fs/protected_fifos` and `/proc/sys/fs/protected_regular` sysctl values:
+ *
+ * - When set to "0", writing/opening is unrestricted.
+ * - When set to "1", O_CREAT open on FIFOs/regular files we don't own in world-writable
+ *   sticky directories is disallowed, unless they are owned by the owner of the directory.
+ * - When set to "2", the same restriction also applies to group-writable sticky directories.
+ *
+ * This test requires root to modify /proc/sys/fs/protected_* sysctls and
+ * to manage file ownership and permissions in sticky directories.
+ */
+
+#include <pwd.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+#include "tst_uid.h"
+
+#define DIR "ltp_tmp_check1"
+#define TEST_FILE "test_file_1"
+#define TEST_FIFO "test_fifo_1"
+#define TEST_FIFO_PATH DIR "/" TEST_FIFO
+
+static int dir_fd = -1;
+static uid_t uid1, uid2;
+static gid_t gid1;
+
+static struct tcase {
+	int exp_errno;
+	uid_t owner_uid;
+	int use_nobody_gid;
+	mode_t dir_mode;
+} tcases[] = {
+	{
+		.dir_mode = 0777 | S_ISVTX,
+	},
+	{
+		.exp_errno = EACCES,
+		.dir_mode = 0777 | S_ISVTX,
+	},
+	{
+		.exp_errno = EACCES,
+		.owner_uid = -1,
+		.use_nobody_gid = 1,
+		.dir_mode = 0030 | S_ISVTX,
+	},
+};
+
+static void verify_open(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	SAFE_FILE_PRINTF(PATH_FS_PROTECTED_REGULAR, "%u", n);
+	SAFE_FILE_PRINTF(PATH_FS_PROTECTED_FIFOS, "%u", n);
+
+	if (tc->owner_uid != (uid_t)-1 || tc->use_nobody_gid) {
+		gid_t gid = tc->use_nobody_gid ? gid1 : 0;
+
+		SAFE_CHOWN(DIR, tc->owner_uid, gid);
+	}
+
+	if (tc->dir_mode)
+		SAFE_CHMOD(DIR, tc->dir_mode);
+
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETGID(gid1);
+	SAFE_SETUID(uid2);
+
+	TST_EXP_FD_OR_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777),
+			   tc->exp_errno, "openat %s (sysctl_val=%u)", TEST_FILE, n);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+
+	TST_EXP_FD_OR_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
+			   tc->exp_errno, "open %s (sysctl_val=%u)", TEST_FIFO, n);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	uid1 = pw->pw_uid;
+	gid1 = pw->pw_gid;
+	uid2 = tst_get_free_uid(uid1);
+
+	umask(0);
+	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
+	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
+
+	int fd = SAFE_OPENAT(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777);
+
+	SAFE_CLOSE(fd);
+	SAFE_MKFIFO(TEST_FIFO_PATH, 0777);
+	SAFE_CHOWN(TEST_FIFO_PATH, uid1, gid1);
+	SAFE_CHOWN(DIR "/" TEST_FILE, uid1, gid1);
+}
+
+static void cleanup(void)
+{
+	if (dir_fd != -1)
+		SAFE_CLOSE(dir_fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_open,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_FS_PROTECTED_REGULAR, NULL, TST_SR_TCONF},
+		{PATH_FS_PROTECTED_FIFOS, NULL, TST_SR_TCONF},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "30aba6656f61"},
+		{"CVE", "2000-1134"},
+		{"CVE", "2007-3852"},
+		{"CVE", "2008-0525"},
+		{"CVE", "2009-0416"},
+		{"CVE", "2011-4834"},
+		{"CVE", "2015-1838"},
+		{"CVE", "2015-7442"},
+		{"CVE", "2016-7489"},
+		{}
+	}
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
