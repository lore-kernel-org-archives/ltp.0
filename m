Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BCEC4451C
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 07:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784619770; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=s3VewR5/XKP7tU99cCQGkg/mG6wzvMABpswfF/9ZqLk=;
 b=HFovDhCMHb/vPXrmuRDnFxu/5AE3Vy/xOQLy/mKVtp1/r1sz8OxR2Dju1QdCWM3gYuRU0
 3yNrtTF041u5FyRqwrBwID/U3PxrntHg22jLOTEydn5jrg9l78AdShamoJ8xybaSCEkqZqJ
 znvCFwxwY4xNL3reBOyxWu8ql5rbBlQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E79C3E2159
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 09:42:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E09703E2159
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:41:52 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6B8B86007AF
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:41:52 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so18782305e9.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784619712; x=1785224512; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xUfCkgx/AVHWhgvvLxoFn6+Hc9lJUjdgpLaH1h7PZP8=;
 b=RFltKV7jeGFbJ6l5VikEDLkHcS/SDJnB/TKoRpelCXKL4XpA4akZjQXI47t0voGpDS
 0D1EV9n3UMQ87i3+3Gsncfd0F+luj/rtUAf/Nik5vPTFy5r9dRLmRc2wuleBiN3iDsMr
 q75uss1G3Sacqu340qblKlvHZd0MVfZKiZdGMmCzJ3f0bvLfp6WA5wVsfQy2Y7TlLIhb
 gEHQ+K8KWaxFCo7b0Hs1LS6KFfV6oTWjibViIrucd4a75hXfZvjbAz3mEIeHjU4/ZxRJ
 QS/XMzDEYcrHodYtDngOUSu63syMXCLOfKQjAZBu404ad2B8LNGuH9272QgdsaUhO2sM
 LMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784619712; x=1785224512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xUfCkgx/AVHWhgvvLxoFn6+Hc9lJUjdgpLaH1h7PZP8=;
 b=lPFKwccxiB00B4taXdYVCLwav0E0kcsz6VBxI/SB8lX4uulR5c/M52Vl93LUS2QaZ8
 9tk6ym1wEp64nG0ubWxkQOsRJ+f2G/uHS57+fpVSOiDRSz5qU9BvI2Zl9o6p7eckuTET
 8WE+uLrd0AghhnH6ujPkVgqgAYnDniLN/jSZAgvOANy36L0tP7EIXzQ8lL8xES+VKeK6
 0vK5YWxPNvTx9SLG0Jy4yAlDfqbXsy+ayP98ej/uWxy1WbDVjpftIqVcMRr2D4gKgrdg
 UyFHEEMDEODqbKZqnDdSrftwjRIEr8cIg11J+hCUpULkP3A+BI8MTGvdb0K+AnCHOwRn
 TgsA==
X-Gm-Message-State: AOJu0YxhIeDUYBtMxZETaK5tigQl9M0MivBYIlPCZcJa+4mz0s3KknFo
 keIhNsKC4n450+9MqsG+xYV7vsi+5JSVEBnXUot2F7yrxuAg14Kv40UK3XMF1KRCSycD5ujGvIq
 S4/k=
X-Gm-Gg: AfdE7cml2afJhzYPnqYqd5yoxhfR/sSE0aBHUpBB8olWyeJUJxZ0kWoWEBTw+Ljf+7i
 +6QyLlLfmHs8gUwph5aSNQI/NDsfHZw+DZe3g/VgNkgqgMAUgOthRdZK7GSNgIrLpABGpsH/5VV
 C0x3lVE7kLuACvr6EFfCPr1fe/tEk7ebfU6Dn7MOGQ98s7SSlSDaUCgf6sP1IkN/JSpwJSEVfKM
 L61mzkq60Ofl5/05hIW7L+z8Bq/RfwT1DHrHeLES3VUto6SjVlZFvs3kQXADO8f4WFvBpNj+tFh
 1mHxWMjauTAZT3odGm7+JN+h7pkhjRklVgsVulLaK6OqhVmR2lnTuT2x7D0/iw6JQe5Tcf42S+u
 GrD/6vr/GjYEfL4FOnCDZUezl078g1fwd2SS4IidAs02s7/TR5VTEG/im/XGe2xdi7g==
X-Received: by 2002:a05:600c:a48:b0:492:6f5c:fd8c with SMTP id
 5b1f17b1804b1-4954a33dd95mr192910245e9.15.1784619711833; 
 Tue, 21 Jul 2026 00:41:51 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49565373200sm44739625e9.5.2026.07.21.00.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 00:41:51 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 07:41:29 +0000
Message-ID: <20260721074146.2779-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721074146.2779-1-wegao@suse.com>
References: <20260707054804.24232-2-wegao@suse.com>
 <20260721074146.2779-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 2/2] open16: allow restricted O_CREAT of FIFOs and
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
introduced protection against spoofing attacks via O_CREAT of FIFOs and
regular files in world-writable or group-writable sticky directories.

This commit adds test cases to verify these security restrictions (Level 1
and Level 2 protections) for opening FIFOs and regular files in world-writable
or group-writable sticky directories when the file is not owned by the opener.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 135 ++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

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
index 000000000..c74601032
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Verify restricted opening (:manpage:`open(2)` and :manpage:`openat(2)`) of
+ * FIFOs and regular files in sticky directories. This test covers the positive
+ * case where access is allowed when protection is disabled (level 0), and the
+ * negative cases where access is disallowed (EACCES) in world-writable (level
+ * 1) or group-writable (level 2) sticky directories when the file is not owned
+ * by the opener.
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
+#define PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
+#define PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"
+#define TEST_FIFO_PATH DIR "/" TEST_FIFO
+
+static int dir_fd = -1;
+static uid_t uid1, uid2;
+static gid_t gid1;
+
+static struct tcase {
+	char *level;
+	int exp_errno;
+	uid_t owner_uid;
+	int use_nobody_gid;
+	mode_t dir_mode;
+} tcases[] = {
+	{"0", 0,      0,  0, 0777 | S_ISVTX},
+	{"1", EACCES, 0,  0, 0777 | S_ISVTX},
+	{"2", EACCES, -1, 1, 0030 | S_ISVTX},
+};
+
+static void verify_open(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	pid_t pid;
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%s", tc->level);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%s", tc->level);
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
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_SETGID(gid1);
+		SAFE_SETUID(uid2);
+
+		if (tc->exp_errno) {
+			TST_EXP_FAIL2(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777),
+				      tc->exp_errno, "openat %s (Level %s)", TEST_FILE, tc->level);
+			TST_EXP_FAIL2(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
+				      tc->exp_errno, "open %s (Level %s)", TEST_FIFO, tc->level);
+		} else {
+			int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
+
+			if (TST_PASS)
+				SAFE_CLOSE(fd);
+
+			fd = TST_EXP_FD(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777));
+			if (TST_PASS)
+				SAFE_CLOSE(fd);
+		}
+
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
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
+		{PROTECTED_REGULAR, NULL, TST_SR_TCONF},
+		{PROTECTED_FIFOS, NULL, TST_SR_TCONF},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "30aba6656f61"},
+		{}
+	}
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
