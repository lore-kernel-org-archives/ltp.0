Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B40C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783391468; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=nQoqmnrgudBZ45wUmRD6tBl4GFHt4blqwDoXjlfB414=;
 b=jtDUio2Ax9e9CTWdPyigX/JHDV+xVTxSDv8Vluv/4KAqzdhaNtOhGH47pB6433aHuRsdI
 9Tx1PDkrpqIjQNtzOkieDjdrpih9e9GPLYzJE9MDe8+eYFwEzudFQUoDzvZj+RK1YleTW9N
 aQsK91we/Ik9HMNAFXQqAlJzD/21kvQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85FBE3E61CF
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 04:31:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEB7B3C92BA
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 04:30:26 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 131021000752
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 04:30:26 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so23137415e9.1
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 19:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783391425; x=1783996225; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lXj6ySAUXJHG6RqAj/ZeyO8BUwel3KG/HWRA6uRDE48=;
 b=TqGoV7QGbGRUpH5RESxM/nz2UeyvLoM8zy3DEcVUqz7WAsM6zRg75SIxW8uJhHbOau
 vj0P/99HZQE4MedCBTrr/X/gnhexgrWizcE97aVAy4j7JqtrCuhgvyTHtfsmoNekvjtz
 WZFfBaF3kVCqlwj3KhN8rzIfXI1RAdeTyXuAGV0Xu/AVki8XpgeuWp09Wg82bkoorHlH
 chCYSTyW0o4QXKWmnRoZlHVX1+aOTSC+XQQJWvTtP7sYgtWpGC7y3Spa83/QOGaAONGa
 ynN0dB+ceGMiXHjm6Ygf6I2qrxnYIhAqngaxetQOxdGgcXPRUks1CQmo1FVnIFsLRPSE
 D1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783391425; x=1783996225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lXj6ySAUXJHG6RqAj/ZeyO8BUwel3KG/HWRA6uRDE48=;
 b=mOa55TANSYK1UlIEHkBZAo6jaTP0As5oDIv0O7Pg/1OA54NvirRXmYvtKucXoV2DVr
 cgDv/QPafQLjLGFiaYu/Ghs9nJv34S/Csr0Q5I6UTLNCWE+3Xy8z+5H4UW6yTI31dNSl
 N0zIAYWBtVi7Pn1XNsLvZYtNatA8CHxBxIBbKkjbuzmGGdh4OHHJx0JcMFv33rTEkOwK
 bL2RbwyBt1pfJ/lF01NOifs6NaP7gJ93En6TdSaYvWYqgPQqijA178sNwfMO+A9HyyIq
 EkhlvjrKqRAb5szpejj+sr5JQL9mBJ2iQr6UXczh6tuSorw2Lf5f32Obx9ekWJZIBOkq
 q4+Q==
X-Gm-Message-State: AOJu0YygvoKVuQtORrCge4Ct/Fa+JM4lSPfnU+3D3o8LZ6TMjSioJCXS
 Sre7EqBpPx1pwEmZpFiJioGOb+hC0KFck8CRAsqwmGT69fFZHsj2uuO9KlwKvUe5smkJqwQsaZX
 2GTU=
X-Gm-Gg: AfdE7cmsqlmyreeeAKCZZs3zFJffy1YmvBE5nVrxDwpgNNMwMoEMWvDamgUcdI/IuSC
 rNQkJK8uuzcArj0NwJBeKvdM3m7l2tiPoAVacSQRPkBP+4x/ik2oP+1pWfOt/8Futqo+A046Yp8
 /Ii2EGKMdJ3tzEDdUaD9W1tBIwji76oxtblLbtExm2dcPNbEh9fbmaZjp96J61kQfNAo+mnSzET
 uuokrDVdyxmlaYXGGM2TZ2W5uf2By/rXAStLc241+/RRNBM/rrB3C3+JVdfzLVIrw1oMC98dCqa
 Y2HawEGUaaoOt+zolHcC2tUhaRY+hHZ9R/b2G6wilOkeMpUPZ3Y4gwM+TfItaJdDoZn1mqekxCq
 E5yQqeLyvWQ7bTru6NQ7hNzvrkKMXErvUrAXEDjNKng0VPD+7XBgxE78fI2j7NlgFTyjGXWILPv
 uY
X-Received: by 2002:a05:600c:4ec7:b0:493:be0e:377c with SMTP id
 5b1f17b1804b1-493df0910damr31388965e9.24.1783391425516; 
 Mon, 06 Jul 2026 19:30:25 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493e01d21eesm22100115e9.2.2026.07.06.19.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 19:30:25 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  7 Jul 2026 02:29:42 +0000
Message-ID: <20260707022959.24088-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707022959.24088-1-wegao@suse.com>
References: <20260416005603.22427-1-wegao@suse.com>
 <20260707022959.24088-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 2/2] open16: allow restricted O_CREAT of FIFOs and
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
 testcases/kernel/syscalls/open/open16.c   | 131 ++++++++++++++++++++++
 3 files changed, 133 insertions(+)
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
index 000000000..c786cf097
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,131 @@
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
+				tc->exp_errno, "openat %s (Level %s)", TEST_FILE, tc->level);
+			TST_EXP_FAIL2(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
+				tc->exp_errno, "open %s (Level %s)", TEST_FIFO, tc->level);
+		} else {
+			int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
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
