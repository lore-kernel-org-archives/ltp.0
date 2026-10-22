Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91F606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=httkIm8q;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CfiBBgTs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792636667; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tWuK76pCVlZBbYiDL9QRN+WZcpl0P2SD0AcSHlIv0xU=;
 b=httkIm8qclWclIQsE4VmoXiY+W2ecnUYno4Cpa3ULN35ufrWTGWRBZimGR1bPEVsKuvuG
 r4vb62zEsaBrw+WNqjEX2E3ptYP6yfzD75+y7y04zPIADgnFy53/PvCwzOglX7qB4+KjaW9
 mXNQ2aDx7+IrLPb8katzMTbeZ6b+QhQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 044B73CFDF3
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 04:37:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5172A3CFDC4
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 04:36:53 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8650D600A66
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 04:36:52 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so2290715e9.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 19:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792636612; x=1793241412; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uL5WFGP2/UGs3Abqa2gHkrKHstj2Ci+aQ5Yb6ElYNtM=;
 b=CfiBBgTskignKOXLx8CRf1iwtbAQzK/7Y0pCKZD+HAIwPzbqGyTxqSIY06flG5s3tf
 0A7dNu4OsS1y61SQJ9W5FpkQm8nQlqOD1Ga8HqGP2oZe0TWI2eO3QoSDfWKjKcMEKWg+
 pFJRCjTijdxyOpIHvy22iZmM75zPvh0jXyAUorrMbBokXZ+zbz1iy3ilV0/lpkrjeo2I
 5yL4EFFx4fq96xlJo/Sg2fWpZ6dDxoLZvlT3ssTovBnGhWO+tZ78ZguqpqWdCPy4MnsH
 hWpp7tozm8QqDRT9HQ7GJhsBxFDcHwpSFqqyIEU4kGCtN3UF4f26WpyukxMxKqHgPWYQ
 RkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792636612; x=1793241412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uL5WFGP2/UGs3Abqa2gHkrKHstj2Ci+aQ5Yb6ElYNtM=;
 b=1rTzpNNN9h93h4SrzfecbkW6f05Z8zc3+ETLQG0s5sHnWb2wskFCfmYf2DNMLQ6gKd
 976mzjitKTOo6jqMvg4krit2OPL9Me2klQgy0fpN45kqFgqx9drH8EWZ5eAZF67kzmmk
 xlkQBZbMv3wdtth0Hkw98/e7UJtG3p45ej3kedQJf+E2rtrr84EdQIf++z6EOn3m2e0I
 Yr5d96LqfHgHFMFKMo7jkyCySgsGk7Q69t73u7OZXzU67xionQsmQdjsuUbS4k2PPMUS
 fD4Z4tRNaiAERR462T5JKPCuk0uuT/svlZNqyAjU89CtkJjNcjt6UZj3UTrsgPUZ3Mw4
 UjCw==
X-Gm-Message-State: AFq9FYK/Zn7fb3PmrTrhvnuiJ2L35eBmP5FA6mpOoxZKA6yWF0/HDLBu
 6xt6ZLWIHJ9Tga/S20P+Zo+gvzXqcPKaNf1cq/jQD7kyXurR+gIWJTeLUyb6GMzuzgJ1fpJ+g1i
 HW3I=
X-Gm-Gg: AYBFou2qiDk33ulERmi34WX+NZ7SVRFscoSd+MBkwSA38Q1xQwR+FqEV3bzgyxworaX
 VQ/t5SSMlrcE5ZXDU+cXrJM/NsbHonY+k2+8QgWubv+2dotZh0Iu/kh+fyH6uOipUwdfuIyf5I/
 CcMwyGs8i57fpVty92k7K2hx6htU8mhEJDJQiHwlg3N/b96gNde1rDDrkJaWfxaUw89MaFaldQO
 V05ks89n7RHr7yXZo+eXeweFGYB1RBPGGjX76aLtHnjgQ6NnhxvXK39JgwU3aUCPjj61EwgFt9v
 USZXbv1ug2B+0BV7OpN1Jgn5KL9c5rsYUnqTPueY1wG3ZjASM5dhBTQF90tnOzGUcbcQoIP7Tas
 2aXPK8uwIiSLs4ZsbuJr529KhilbtlBWj7ygcecd6PFTKoWM/Xpp4P52rDUgeV+Ih7JeEiGgU70
 F455WovYt93DtmrBdh0C7iHdjKJYY2l7v5DBmB3Iz9hUJA5IriXQzjNOFFgU5bbkhkba4avj5vi
 ZIhJWtzxZlLbJSc3ETnmKqfQ5XhkBKMSJYmkzaXeBtGv9af7m63FtKyFb86ZjK2/9zcUfj1x/js
 CDVt2bHRtiZtbw0PvdaxbngzgBjNQEblqsO9TyC81OrZ7Q==
X-Received: by 2002:a05:600d:864b:20b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a204bb595amr13948025e9.17.1792636611806; 
 Wed, 21 Oct 2026 19:36:51 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a1fcd59482sm66797015e9.4.2026.10.21.19.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 19:36:51 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 22 Oct 2026 02:28:21 +0000
Message-ID: <20261022022824.19735-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022022824.19735-1-wegao@suse.com>
References: <20261022022824.19735-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v16 2/2] open16: allow restricted O_CREAT of FIFOs and
 regular files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
