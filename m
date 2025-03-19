Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67212C35FFA
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742394221; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=M/LAuP3IHf9WBfF6Mslz0Kmo2/dROHdME5V+ywNAnd0=;
 b=AMeV6wfBfFuyo2V1Whkn+daKV8lcaO9GuqvrxQI1PJnRjdZ2OguP/bMdW/487qk8Z/tim
 S3ZdTB0TVnDkWXp96+QWDJPDF9eJH3mFpQGORENFBqC0KG707IANksu1KlYCBWaNmzfTVPN
 GFijOp4vWlc1XQIuj/UisDjAjo6GCeg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73B633CAD01
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 15:23:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 232403CAC72
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 15:23:19 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 41DA06002CE
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 15:23:18 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so573626f8f.0
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742394197; x=1742998997; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0ctap1AcGAliWqzALjKj52iPdmNosXCVzrg2y8xxEo=;
 b=HzRcTxGMOy9uj1W3Bl6iY2gcc61Wlz00u9A5c0yVyismF9zduJ6xNIuMhCqJbh1lKg
 mh4pJD1SN1/tEZUtao/9iLt79lBdLdW1ARTJ8z+Y9sKg+hETnIaBs8aj46sE4ObTCh5E
 DFLQflTA+gdtNrQudz+HhdWhJ8MabtCYTG3P9jpdCpH68I7Sqz3NVJ13IkohHECThZJV
 MZOOrV2HgVllFmsW2FYqd7xk1P2x9YN0EeGYT0EufbBF27eoaVtV9GKGCJrc2rmqNYBR
 H3sbpjEfBeL208pmhKe8jkmrKI1rop2cF3WGYKqYFCP8s3nfrTRVP3uYM/BCcl/vAMYQ
 xq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742394197; x=1742998997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0ctap1AcGAliWqzALjKj52iPdmNosXCVzrg2y8xxEo=;
 b=weB1ciMg6VOMT5JRa133sc7u4XhHyh3d9W1NKBA3zPTMOuUe7ksUpvFS3wtfTjgQoz
 ZkrQw1MoCE4VMh1C5cCRx+g006c4CiTSsjqDMBKx4+wGVhvPLFw8XrjPHgJXmiHu/ede
 YlcKIbf9POXtRu1r8oZmqCnVfvla8s9K7m5f5hhKWBn/oeJU7kMWC7TElKfWNxWQ6SO8
 5w1+oQLzkSkd8RF4PAH39L1BcU00W7YLupmObYE2Myx0/mRH+9wnxZyNZZR4NZHqSxmT
 9xlc4lrpluPpUtGZO7ItoeneSW0ZcWTJcLYtG52Gv8cLJoNUMJUDmFTubhniBh0n9bPc
 qoTA==
X-Gm-Message-State: AOJu0YxeI9IYuEpAYqzsPgqUwh5DaDMB1THEj+pupAYD+9zndqkWWM7J
 XYg6pdfD17MRuMNMadbl+2MXHyf1kXFfyjIkbyL01Fy375o03ZHuh+S5R6pGsclOpYGC/AI8ZIS
 ra9yP
X-Gm-Gg: ASbGncvUdAnrdXoWMmK/fg3T0o/MrCK/7H7u19hyz/2zTCxqTwDGH3UGJgNHy1YEVBK
 B7NxFG7u7gTwdSquUZxzkt/BKePwxFpIjibWdmIoHehSMjV8hp4wteffGBWhZU1yH3rCMUffJMr
 h9cLYV3Aw6qgB7rPELAlphO4OYUBhpcczi5U/UAl7L2WRxERPxvZbkawSJBsi6Y0XqTaMco9VVA
 ywYlzMOaXJiwO9JqkI6BykS0ZWZVV4YGc474iNP2gLf68j07/Kv9AEA40TNQKFPsch0mwjaXslZ
 s6+iQat4QIwG0HllENFYqVLskdWlNDPbJtP9QwdHLnr3
X-Google-Smtp-Source: AGHT+IGlhoOC3zUOPh5ieOCqYXDXafl9z5h5j6oIUmfEg9NzJFdQKHw8xG5cPSD4Sz/HmrrsFVxPlQ==
X-Received: by 2002:a05:6000:1543:b0:391:4bf2:6f0d with SMTP id
 ffacd0b85a97d-39973b423a3mr2961910f8f.52.1742394197417; 
 Wed, 19 Mar 2025 07:23:17 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68aa815sm114933095ad.102.2025.03.19.07.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:23:16 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 19 Mar 2025 10:23:10 -0400
Message-Id: <20250319142310.30036-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240603125514.683-1-wegao@suse.com>
References: <20240603125514.683-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] open16: allow restricted O_CREAT of FIFOs and
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

Signed-off-by: Wei Gao <wegao@suse.com>

This commit adds test cases to verify the security restrictions for opening
FIFOs and regular files in world-writable sticky directories.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 121 ++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 839c23d0a..7a1a64c01 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -974,6 +974,7 @@ open12 open12
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
index 000000000..709c5c87f
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Verify disallows open of FIFOs or regular files not owned by the user in world
+ * writable sticky directories
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
+	SAFE_UNLINK(CONCAT(DIR, TEST_FIFO));
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
+		{"linux-git", "30aba6656f61ed44cba445a3c0d38b296fa9e8f5"},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
