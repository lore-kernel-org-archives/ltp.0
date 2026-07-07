Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEF7C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 05:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783403327; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=p6oD6/I37sO2KOyVhR6k+CgDcPQZ0JeBjFp9/vEl5lA=;
 b=ehKX8QPjF8jaAake7ivjdwzGOrGBWb4lzlK10JDaPzPfrlxYl3FOg/9xDt4zOgYXKv02/
 U4OhGTnZzyUkPBJs3faXXo/KhP0yh1tTFMGfzWAW/+WB+OjnBsoxwmBANqtkvfc1S3Tu1ga
 x1PvrJbAbQULaUE1wsl+28UxFaYP/vI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6A133E2A4E
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 07:48:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 230943E2A4E
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 07:48:10 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78CB210000C3
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 07:48:10 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493b6f1b14bso14232395e9.0
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 22:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783403290; x=1784008090; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C81VAIjewBaocRLEg7h6hNm2CodcArGpjt+eO6dg+M8=;
 b=Z/7P+yhdGdijYFsXLtaPQdGqY589ArS8SHcTOIHS8LziST34c2GuqROKe8V5fuTABb
 kBdFhMaGoQOkjiG6qgPlIFY8+ry9CSUZstFGkKeBsgMzpF2KDCx0RJJqeV33ikW7YJLy
 znPGPpUsYYWC+184VPwDCP9tOPbsWpWXNGgmPfcpGgJRqnJ5qk64jE26gU09j0T65kHb
 bwkRdu4A/QWbbHF6zoV5Fw5xyUcggtZfZ+dTk8hOub3xqHoEg4uD5Kq1meAls7DrDBo3
 Egg9hzdjl73lEAucDztRHgu2kTzgejKhhrqqMkzsEPxTO5NTPR1PLkIqqUFiVxCiqmD5
 zn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783403290; x=1784008090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C81VAIjewBaocRLEg7h6hNm2CodcArGpjt+eO6dg+M8=;
 b=DdTXfkyz0VYb/pEgOTY90Zu+CVc8AcfyS2QrUzl8DFcx631iIwvtwsKGgUV06FI66g
 jMbiNMi+r8VuSYrLKa3RIAz85B8BWuq+VGwKjEXHJ86c5XZo2Q8rWToCV4OzvBz+dsc/
 1ilZRM6tGfY/w34TZShkX3c69EegVniDLXdYh29GHi7EbTnja7MSekEUlP9LVmEG/zbz
 i0HcMXcBErKCd3C3Va424ZIM5937PHjn5FrBbu3jcxiEkiSzVTTwrMl981x4WrlR13ja
 fedjZFszu/6Xdd0FbMRbpfFVBNM97wgsut+UDNxfOcEKQwIF8DVqMe8NN+GMwR5S40S3
 86Nw==
X-Gm-Message-State: AOJu0YxT4ttqC+ppev2jwpx1hJAkMH25G9mb+DR/47teaHj3gj/0JQUw
 OXj6d/md7gtXhNFEknTycNBw0bODl5c29N+duD/Ba4LcZvcHsqncjhoX1zHgw1zhtFA3GyJrr6+
 ngkw=
X-Gm-Gg: AfdE7ck59qMutIjdVRIlgiUH8Nvp9UB79M2jSeHxnc5c5kAYbEe6uyex6neYvsKCK7s
 DYUUtIEFrhG/jjHgiSc+Wnpn58huUfY46DpTvzxKanM4Kf7aW4zqfehysiPoStRaE0S7czIL5Ua
 ywLixy2MzPSNII64ibtbnuUH9Ezy7ErzPJukd6I1fi0BzgMQaprWoE6HyhIFEAn6AlBxO+v+f7D
 THgLFftNhr8RAwZMLdFisNdX5zRWYI2Por3JOmtX3ZoP47mxfmx/Bn84/NaLq8Z0Pp9M5IrOFnb
 Rv5n5lA+jH1crfB0FrVatF2HfIeDP8Kpp0uGroK7F1xXVgWWVzNoHBUkQ5BKLw7TGtEN+ZVU/eS
 +YFi0DLQBB7sxf/mUCPiLe03dj/ZHDUVE8bQ3r5NPApmuVs3POJsxOtQxPQxmV5EPXH9hdys5ER
 15
X-Received: by 2002:a05:600c:4f81:b0:492:4c2e:9613 with SMTP id
 5b1f17b1804b1-493df08ca62mr38307195e9.18.1783403289874; 
 Mon, 06 Jul 2026 22:48:09 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493e0fccf2dsm27695345e9.15.2026.07.06.22.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 22:48:09 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  7 Jul 2026 05:47:54 +0000
Message-ID: <20260707054804.24232-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707054804.24232-1-wegao@suse.com>
References: <https://patchwork.ozlabs.org/project/ltp/patch/20260707022959.24088-2-wegao@suse.com/>
 <20260707054804.24232-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 2/2] open16: allow restricted O_CREAT of FIFOs and
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
regular files in world-writable sticky directories.

This commit adds test cases to verify these security restrictions for
opening FIFOs and regular files in world-writable sticky directories.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 134 ++++++++++++++++++++++
 3 files changed, 136 insertions(+)
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
index 000000000..2e45d7f12
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Verify restricted opening of FIFOs and regular files in sticky directories.
+ * This test covers the positive case where access is allowed when protection
+ * is disabled (level 0), and the negative cases where access is disallowed
+ * (EACCES) in world-writable (level 1) or group-writable (level 2) sticky
+ * directories when the file is not owned by the opener.
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
