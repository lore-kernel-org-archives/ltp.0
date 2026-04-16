Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD14EF433D2
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776301036; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=pTkFTz0HCpz+r1/v/WIPFtDYaLGmCHEK6nZbPl57AIw=;
 b=q3GcIg90kTF1n4jDEsUPyeuXJ6O78Ea5zxqTj/F6wKMjSHsOVMcjQ3mNNF8IJGxm0Yba/
 bc+/Rg8P+RONePHtzpetHCi+jPn2rgeV7JIo6/CCIka30oEsjxX9KO8Nng8qnjzNMULjF+e
 oha9J4bpSaj7V9QPfLCCNU9R8yFn0zc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DA143E5DBA
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 02:57:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 115973E5E02
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 02:56:11 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D0EE600843
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 02:56:10 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso69622605e9.3
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 17:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776300970; x=1776905770; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHpPnGO5cAEXVKDaHsMWMzTrVg9+mdbldsNdPllyUUs=;
 b=gh2tjlFxsK+w5au/65vcSJUDqxIwpN3yiZrUbrRNLyU57qjl5C+torB9NN6NlfIaWJ
 P4+eUZGAA2xWy02mf9hLWoWQb92+trRKpy308Ju4kbu8lIExml1dkRVRxU1g6nxf0+0s
 5/xpxmQ+DIaEeo2/guMaEh318yDkItd+shoWuNaGTkvLd36CjISJ83PfRRnJIUtXC8gS
 4zmxZOCExRpaWzYKHxfxyjIB7AnSxHdD4ijfNRSIuMstHsn23SgFEiJ4Nzw2zpGgSdn5
 maZiSEvQPWm83UKBtUJY79G1QXGJOJf4TplgUo3BehUxICFctIo/FzhpdjSQ6muyCpIi
 BArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776300970; x=1776905770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kHpPnGO5cAEXVKDaHsMWMzTrVg9+mdbldsNdPllyUUs=;
 b=RFgeeI9WEI+RtuvR4vWaRN9Vm0YnxLoI8C7McxqMVVQaI38LoIOUMYOLZusCNE1VHb
 gJCOFOQ3FQ/Ri4L4jP4nmpTI5R1e/CPf24PtkO4XpimnEuGgWSSSQpM0wbmLwIzczJvw
 I4dlqcLVJPZDW3qyg+O/WbeI8Je/z3aP0e4VrgGLpyEm6g2ueXhR0/e4xP/ki1psIHTq
 QJ8jv6fIYbtw7407RM+piWL1Bvabd3kxhknd3ivJqVKScXLHRzzkrzMhcPV1iZwf8b1Y
 73CoPHz5ZMLsUvEAP8GsRF9xo2vcS229nbQWJ1rxJUvsTEp5+3yXtCCukgE2LATi1HXN
 IdSQ==
X-Gm-Message-State: AOJu0YzWQB7p8HKJy22h1Svv9sEFYhPfqgij5tz8x9czBfnOroaAKlAz
 RkX5L95VTr0j4Q/AEp3ur53HEp1eiWAKKRa9KbB+pTecca9TL3Hq0ItHYUMaQCB8re/hrYLCqN5
 lsh4=
X-Gm-Gg: AeBDieu13ABE6LvaRIUWIV1oCFl2RXg/xpkA9jV7QB/hF+XXCUphBbdN3k9eyNr5JOW
 elFyQHxK/XQvH76eDanRJoM//vHaSbqi+yRRwIK8VooOB0kHq4lJZGKCMy5V8sRMgOsGTADcPKF
 oej2xnkLIVbu9d1BdQ1W1x7fQqP3l5lYrlytMJHRS8TdxCp/iexZsJqbOLqEfjEtHTMYULKL+tV
 wXCUqFYxZeF1ZOJSSTFAH3mUw6lv6eHL+KKfispALw16/QARhp/Tq0768DNtUOQzprhxj90RMKs
 +tborAcAMh5ALhvfr8Rql47xP7YjfjCl93/uJZmmgqshatV2phEwizM19bCgsbHfG12p6BJMGGQ
 ExOwpsuyeaF+1+sIg3G3S8HyZpUxKXD3OPFf3MzHjSRCOyrr2Em35dZFY/Hg/I1Jx/rsGUvBdCi
 xn4LMtyNDNeIA=
X-Received: by 2002:a05:600c:a105:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-488d6839821mr229754925e9.19.1776300969827; 
 Wed, 15 Apr 2026 17:56:09 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488f58233f6sm8557115e9.10.2026.04.15.17.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 17:56:09 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 16 Apr 2026 00:55:23 +0000
Message-ID: <20260416005603.22427-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416005603.22427-1-wegao@suse.com>
References: <20260415103812.21999-2-wegao@suse.com>
 <20260416005603.22427-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/2] open16: allow restricted O_CREAT of FIFOs and
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

This commit adds test cases to verify the security restrictions for opening
FIFOs and regular files in world-writable sticky directories.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 128 ++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d72fceb5e..c14ebb3a0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1005,6 +1005,7 @@ open12 open12
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
index 000000000..8ba2d9ec9
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,128 @@
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
+} tcases[] = {
+	{"0", 0},
+	{"1", EACCES},
+	{"2", EACCES},
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
+	if (n == 2) {
+		SAFE_CHOWN(DIR, -1, gid1);
+		SAFE_CHMOD(DIR, 0030 | S_ISVTX);
+	} else {
+		SAFE_CHOWN(DIR, 0, 0);
+		SAFE_CHMOD(DIR, 0777 | S_ISVTX);
+	}
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
