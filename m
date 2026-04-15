Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396FAF4198C
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776249563; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=skciPJk3F7+KlNUVeABxJHm3HFbUbcOCHXn052DD4a0=;
 b=eiG8NjaG/A8oOoRnL5Bt0p5n/ddIyNjFRm25XhTR1L0NH9QR4kNfMv2jo4laA0YKUlrDp
 lLH0bIurSyGyqIjtgckeG4rrvK807YYaUsLPJJMQMxc1j2uNtyn09js5ElJrvWBOFXnkZAs
 /3uwK5Gv8gkA3+K912emKMOxP2fXWl8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C42D3E5B67
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 12:39:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35FFA3E5B75
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 12:38:20 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A27911A0090B
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 12:38:19 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso69825145e9.0
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776249499; x=1776854299; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eq8wnsrb5213CVnsykm51rlAon8hFVwEWzizOYaexlI=;
 b=PYJcUFywM3oxp0NeuTHDC1cpupMrGBlofKZPuXXNbKvm+KSSX58f8WdlInrRlj/dNI
 lHjNX4QGIoOtLtu4r5XvX3y58bj2HhJsrUXHRqXXokRHwoSftRLMZ2JKBc9vV5FnwbUx
 3jExpGZkeQ/RIGRtHSF7Ap2e173sYYWKWaNqltqq9m1d7HvGZFy9WL5wa0ziBiIzP6Qg
 TptRNSg2bjwFq7pEYhScHXxjgj+dAHc/FWr2NweaBLzlD2zDNl2kCS/j3rOyurpOqZBX
 XxfyhrK6lZsvRpA4EYwtrVogSxSXy5TZ7GqC1Iq/7ohcUFnLe/018j7S1644A1eJZIDh
 qStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776249499; x=1776854299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eq8wnsrb5213CVnsykm51rlAon8hFVwEWzizOYaexlI=;
 b=AHOVNNEMx7nNzWEA89U1U9tIWEdn521/C4Xd9psSzCmSrfzY3FXyKcrDsPBNFxGtjl
 AIUanuYqWegihRzfvDI1/ApFyK2gSFwc0yQsBnrumsz8ZKCvRSPxajQ814Y57MMvS81M
 BjrCpQJ7WSyG/WYX9j98/G3EfIxwmG9Vq/cGRrvt7NeIkAfeq7tWIyCSD2JCwINnvhMm
 M/8LwLaQpEOtZD4iMcld2UJSQJuCXExQustVI3njhDmhEWTjmP6wiI9bi5L1tlHGuA58
 J77XPTyF2eu42tjv8l1ETOe903t1rlckugujVflKlvoE2YaBDedyugT/3MQeMYEU/IK/
 fcZA==
X-Gm-Message-State: AOJu0YyGm7selSBDaS60EAkeewp+ZyGK06Ur530PlXSIWiu2xzc2oIHc
 4tn5CYG5EVPjyZ2JISSCadDVpvKUYekb1NxWGy9krr+ZeWSX0tvyQI0qIUyRaVWmNnwahH5S9rM
 Tg04=
X-Gm-Gg: AeBDieu3TPM4EpLpZbHCnHJIE8AQtM2jh0ljmubZkeQXn6sOULRxUBw44MqTBD5PvIT
 spj6IsfqIHI414EiJ5q95aHZJEP2MwYjtHZDN2/5C8jguwraYgchQ0ut6SCDmtmFDNJXcTZo/O7
 kCn6RIdGo0No91vcF8oUdEjkF94JKnI3ehd/JUT+RzBx1hDdtZc3Ls2yCSOC4TteqJwybMc1VM0
 B2VjMLo84WLfXdHyc8VzAJkGdQbHTY8kd42mHNQ4vnF1vg/hUJQxmc2w0T0W8VOMDJo8l5N8dGa
 vnX1q/L1yQAXuYtYJcKvNAY9C5oLo8BnM3Til9UCmJcXx6Uu6YNlg8egxuNHghYTimNLtBgiFnA
 s1M2EhNbIeMey85n/b9e/fYgHhITeH0zhCwo66PgFFLHOUp3NcbOD3AhW/MMW/4Lkmr/4Xt26WU
 5Th+dD/VOzeAuPdTbbFQGGaw==
X-Received: by 2002:a05:600d:a:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-488d682bb48mr212092715e9.4.1776249498797; 
 Wed, 15 Apr 2026 03:38:18 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488f1dd8806sm39417955e9.3.2026.04.15.03.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 03:38:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 15 Apr 2026 10:37:55 +0000
Message-ID: <20260415103812.21999-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415103812.21999-1-wegao@suse.com>
References: <20260415060728.21662-1-wegao@suse.com>
 <20260415103812.21999-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/2] open16: allow restricted O_CREAT of FIFOs and
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
 testcases/kernel/syscalls/open/open16.c   | 132 ++++++++++++++++++++++
 3 files changed, 134 insertions(+)
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
index 000000000..726b05df9
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,132 @@
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
+
+static void run(void)
+{
+	SAFE_CHMOD(DIR, 0777 | S_ISVTX);
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "0");
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "0");
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(uid1);
+
+		int fd = SAFE_OPENAT(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777);
+
+		SAFE_CLOSE(fd);
+
+		SAFE_MKFIFO(TEST_FIFO_PATH, 0777);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(uid2);
+
+		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
+
+		if (TST_PASS)
+			SAFE_CLOSE(fd);
+
+		fd = TST_EXP_FD(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777));
+
+		if (TST_PASS)
+			SAFE_CLOSE(fd);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "1");
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "1");
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(uid2);
+		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
+		TST_EXP_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777), EACCES);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "2");
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "2");
+	SAFE_CHMOD(DIR, 0020 | S_ISVTX);
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(uid2);
+		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
+		TST_EXP_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777), EACCES);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+	SAFE_UNLINK(TEST_FIFO_PATH);
+}
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	uid1 = pw->pw_uid;
+	uid2 = tst_get_free_uid(uid1);
+
+	umask(0);
+	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
+	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
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
+	.test_all = run,
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
