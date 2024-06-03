Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04364C25B76
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 12:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717419346; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=iCDm3uMr94qHEEo1YBRarWCrCQo8jLR5LCNN7P+8bpA=;
 b=XIS1SUSRKYppmYXIHBW1CBp4d80NRP+y/Lr/aaZNAn3NxmuPoymZaZnYJV3Lq8cWuxnXm
 EXie2ooKRNl571eKd9lK2VbdgDsyHtyIXc3hU92DVpabgcYrsAvgO94YUe/jV/+R7ekSzLy
 FxGGoBPMlzwFBJm3PO3DLgXWjcMbU8Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D9A43D08DD
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 14:55:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3265D3D08C5
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 14:55:24 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 00A2A600A6F
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 14:55:23 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35dceef429bso1772624f8f.1
 for <ltp@lists.linux.it>; Mon, 03 Jun 2024 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717419323; x=1718024123; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKXll26dVDS4Nq3TGBQ7aYJVyqFv3B30Bwq+lSFf9Xw=;
 b=UelOdlXmp7FOUpdYwSFJ/fIipZ+3NrPTbwOk6GqrGp3ASwuZ3a1qqK+aTvaApkeQ0I
 kUh24zDsdfoXWYHvm5yoNqMoR34zp3Y82sCGcOjkUSb9C58hNB7suPPXiBLSxZfZZJgP
 yOeIaiCBQJbLpG8hOgAxTUUYGXOMtQqwxrLg36fC6OvbfQW1+jy0bQ6ne8ZlrsbUd9kG
 qMqT+ZWQkCnVBBtD3v/pYaR7MzUKpMYnB1Br2dbrynS0ZfdWlDZj+v1i03vQzv9YkWXO
 noK70OGOVABfZutjzwCXrVSSPAcs8x3bmAKggXFC6QWaDQg+B1zY6Ghzndb4JPOW//Wf
 Nf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419323; x=1718024123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKXll26dVDS4Nq3TGBQ7aYJVyqFv3B30Bwq+lSFf9Xw=;
 b=wK5nxgYEvbHBT468sXyFLu8h7mPMICl4wWMBjX1NC3WAtcx++Pt5mFh+7bl+/1vzOz
 vzCexf9YPmEC9IEG4w+nmB6jKcXhLuJMv9N6FBm6uiFEl2gr8xtEeL5A2jz6YO5jo1ed
 GA5Ety9IpccM486CCF80pTxyxm6zPWTLNsCGgnuqg40TFCkZ/MrsU9ulHvVKsKobJpqu
 KY/KNbCOoyYt6b7aHmPvPoJLikBtgXyqg913lYcL8KKYKET2uc9swXX9CaH5bBh2mATb
 93QHwWK0trcpCm0E3j69FPPjizfd03axmoFApW7TPcUX/i0ql64jO+KqFQYiXgIId/2h
 3ZQw==
X-Gm-Message-State: AOJu0YyuHRV+P/LqqFeVhRW3H+/3YFMbTycFlihAE2uiPGZf7B7h66iP
 I8mkSBx8QiHlOkp+AESjny3kPAGSn/OgP0IcTOuvxZiEfJCnFmrJ2aZPMhmosSJk2Mf5bj3DGg4
 =
X-Google-Smtp-Source: AGHT+IG55Ft+8N3AG2tWcabWJUIovabzL1Q4JfNdpvFjD9tN2BffnZ5xnJOTPl6Qu60x9i4ccsxmow==
X-Received: by 2002:a5d:4745:0:b0:354:f4a9:b88a with SMTP id
 ffacd0b85a97d-35dc7e5fa9emr10167596f8f.21.1717419323092; 
 Mon, 03 Jun 2024 05:55:23 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c35a88bb71sm5272545a12.88.2024.06.03.05.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:55:22 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  3 Jun 2024 08:55:14 -0400
Message-Id: <20240603125514.683-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231227130555.29035-1-wegao@suse.com>
References: <20231227130555.29035-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] open15: allow restricted O_CREAT of FIFOs and
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

Fix: #574

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open15.c   | 125 ++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open15.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4f1ee1f34..4152e1e5f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -935,6 +935,7 @@ open11 open11
 open12 open12
 open13 open13
 open14 open14
+open15 open15
 
 openat01 openat01
 openat02 openat02
diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
index 001d874d6..af5997572 100644
--- a/testcases/kernel/syscalls/open/.gitignore
+++ b/testcases/kernel/syscalls/open/.gitignore
@@ -12,3 +12,4 @@
 /open12_child
 /open13
 /open14
+/open15
diff --git a/testcases/kernel/syscalls/open/open15.c b/testcases/kernel/syscalls/open/open15.c
new file mode 100644
index 000000000..de5325e01
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify disallows open of FIFOs or regular files not owned by the user in world
+ * writable sticky directories
+ *
+ * commit 30aba6656f61ed44cba445a3c0d38b296fa9e8f5
+ * Author: Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ * Date:   Thu Aug 23 17:00:35 2018 -0700
+ *     namei: allow restricted O_CREAT of FIFOs and regular files
+ */
+
+#include <pwd.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+
+#define  FILENAME  "setuid04_testfile"
+#define  DIR "ltp_tmp_check1"
+#define  TEST_FILE "test_file_1"
+#define  TEST_FIFO "test_fifo_1"
+#define  LTP_USR_UID1 1000
+#define  LTP_USR_UID2 1001
+#define  CONCAT(dir, filename) dir "/" filename
+#define  PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
+#define  PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"
+
+static int dir_fd;
+
+static void run(void)
+{
+	int pid;
+
+	SAFE_CHMOD(DIR, 0777 | S_ISVTX);
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 0);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 0);
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(LTP_USR_UID1);
+
+		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
+
+		SAFE_CLOSE(fd);
+
+		SAFE_MKFIFO(CONCAT(DIR, TEST_FIFO), 0777);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(LTP_USR_UID2);
+
+		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
+
+		SAFE_CLOSE(fd);
+
+		fd = TST_EXP_FD(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777));
+		SAFE_CLOSE(fd);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 1);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 1);
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(LTP_USR_UID2);
+		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
+		TST_EXP_FAIL(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777), EACCES);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 2);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 2);
+	SAFE_CHMOD(DIR, 0020 | S_ISVTX);
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(LTP_USR_UID2);
+		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
+		TST_EXP_FAIL(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777), EACCES);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+	unlink(CONCAT(DIR, TEST_FIFO));
+}
+
+static void setup(void)
+{
+	umask(0);
+	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
+	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(dir_fd);
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
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
