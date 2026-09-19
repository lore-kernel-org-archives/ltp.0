Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D648C982D8
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 01:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789782890; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tWuK76pCVlZBbYiDL9QRN+WZcpl0P2SD0AcSHlIv0xU=;
 b=ieUmd4v9oGiIe8JVvdNNq0cEc6GuPRMJ2gcYoqYyDBLF4o4Sxq/ulIsUiD3fUgRBVETVK
 UUg7PH8fn5U4B/82Ii0f4toyVMuVwNNm1lEQSAAoOQS4JE1i9ZjcqBb9awGxVeudWdczmB2
 0H3QboELX7wYDIiZ+KWAN3fRvumj7p8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07E513EAE26
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 03:54:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09BCC3E72AB
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 03:53:39 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 59A711A010F5
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 03:53:37 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so17768395e9.1
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 18:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789782817; x=1790387617; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uL5WFGP2/UGs3Abqa2gHkrKHstj2Ci+aQ5Yb6ElYNtM=;
 b=di0qr8l5VqZqwQIFEQFLakxoUhxjAQiWpd/pOq8qfnotOU4kjthfF+a4PKfHgjul5u
 jOuIq7jgVz4Q+HFzXPD6E71hqI9XRnlXoLc0dZ7nzRvYIPasSpnaNN2t8y48deiVxkuB
 cMniHsfD2ydH4jeb9nrnoHFOu+ixg/GrUUahxEU14Fkf5GimU7vbCib1kOXc7epm2z04
 wveBSWcNnTsVmgcHK1gQcvm8gpRiw6Z9sIYhvI91R6efW4NdJPSuePEKSQ8wlrzuaYhr
 /7f8ft33TJEJBiO5k4pQ39KqJzSd94tQ/SzNF0ia1PFUokBTNOPAuQ1h9zaRb5977ii7
 cwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789782817; x=1790387617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uL5WFGP2/UGs3Abqa2gHkrKHstj2Ci+aQ5Yb6ElYNtM=;
 b=aX5pNaFr2dCSXPH54yniL+spUrJUM5BVYMKPBChh/Vgg+hmNddXJkmOxDqWzJTnzji
 Z1ym3m/0+PBFNDfkRnzGWbWS7YSjNRpeJUV+RDBhA5w5K90twwn/RNtoLBHPpFM3G0T2
 4RmyscpeixMtCMlgTdhMRo0Nkj9MyEC3/1BycGXx1Dm8IJBJc6NqJIvturVGEVraorkJ
 wbXfWZ4ZT0oATFN3d2KBc+NLnktKmRw7MCBvmUHd9dGVkqQZsYZYoaHc0yipGrzozdrD
 EHLtfrPq7lVRKbw6R6j/S9DTYNdpTup+xtQHytwQbFI0qc+D3F042EbQbkG/UUFd+L3j
 l06w==
X-Gm-Message-State: AFuF++mmULaXzTnr7MWBxpeKtcCL3diGO/Iy5jNtncOqzDPnwPWEQpWX
 ywFkCA7+myRwlLcJJy5xrS057ddB+4Sb4kvKFwkt60mj0HPqwVJFUdW6D5YQh+2zK/jtorFNh62
 kQyk=
X-Gm-Gg: AYBFou3ha/ICwfpEIvor+xyMrdYGEo91hcYWisb2CwblMevKLeBp4c+nKd0kDwClPLE
 /17enEvr8wQjn1IzbZDgvvSdOaBTh68nDq1HVXQs2E+LpYhP8sdqZudBIQII48xseh7itLsoeYL
 7gGrgLwfPXivkdSJidxH1gDkUbDvIs7rioAKtLW1vea0gqhFYuORuYzD8oQ1CBXRLjZmxpsKs1U
 ohj8xRHI1e0RjfXLpOz7ffkrqPIf5W3I7KqsoVTaWLW3K9B/jYM8pDsTCvTSvGfgal+YpZVDc8s
 npwN/xpITbcXfsptYXag/lyGPoApYLQF2bIZn3wu9FyllnZNvM7+M23C2EGTuBABrxaBPSUr427
 EuahUmR9SfMOpDTveQfPp9FoGa8zpCnSZNqSSQZj2YgpaKSUiSDibRjInJn6lcRlFfbehG8JjM8
 FxP3pN4v6hQTMzUzk7kUQbyLedcaZaXaHTrOV8o39jijudwdEf72FtyPo/YQN3vJ8l1csmBJd//
 OF9PHhUPBTR1bEVYw5j/lgkemh7GCZU23ZlmQoUc0c=
X-Received: by 2002:a05:600c:3492:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-49fc574ef31mr50171785e9.31.1789782816660; 
 Fri, 18 Sep 2026 18:53:36 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49fcd0f8563sm38184895e9.6.2026.09.18.18.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 18:53:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat, 19 Sep 2026 01:53:21 +0000
Message-ID: <20260919015329.22042-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919015329.22042-1-wegao@suse.com>
References: <20260919015329.22042-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v15 3/3] open16: allow restricted O_CREAT of FIFOs and
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
index 000000000..a8d33870f
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
+ * ``/proc/sys/fs/protected_fifos`` and ``/proc/sys/fs/protected_regular`` sysctl values:
+ *
+ * - When set to "0", writing/opening is unrestricted.
+ * - When set to "1", O_CREAT open on FIFOs/regular files we don't own in world-writable
+ *   sticky directories is disallowed, unless they are owned by the owner of the directory.
+ * - When set to "2", the same restriction also applies to group-writable sticky directories.
+ *
+ * This test requires root to modify ``/proc/sys/fs/protected_*`` sysctls and
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
