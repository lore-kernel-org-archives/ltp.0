Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C72FA0C32
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 06:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776233318; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=rSQRm9YFSnnPbbj5Jmpuf6PG3Y0Wv8BKBuSf0ORLnbw=;
 b=frOsMrklqFvIZLFq2PGZOXdERqf91FR6wWjO/1UUQf491IMXqkz3rFFCD9vZv9cRFBop8
 wsWeg5Gxns7y0l4PAO0MwhfOOd+omAFQL4SLDPx6anz68+YH0zlgUl2mpRGfwYVwMY1WQGu
 7DitzKwL/sPHvKuUzdwYENGUwLF8P3I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E98123E2143
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 08:08:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF6133E2662
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 08:07:35 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6220960047F
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 08:07:35 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d72875729so2105503f8f.3
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 23:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776233254; x=1776838054; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LtRleJbLmAib+ER61qN9f126OHiS1mbhSLPvhYyOU4=;
 b=BX+jshHjaGMyDC1cRaMOSb7CR6Z43fKDkz/Kfupv1UAdi+TfDx0v2KGxuQOiKj/MsW
 SuSzmPC6xQHlk0PaRqDlKcCclciO+4PeC2uSDgqcnWBmNWY3wbumeim1ZqHfqcjsRwTG
 wbu5SGuj8GTbfW4kyxI74N5WAMdbLznt5MJzCCxLQArrzLZoAgIoztAiavPKSc9aAwas
 VVvepgrtHFjJveC/Yp+YaUh5dLJUYmBX+8ULT8twLOpRDtwHNvlUr7qpspAkoOZ5no10
 nJxtnu5Rz1W3c3wbpwW4U4Gels6NqQ+Jdpx31WZw7kG0kgCRH8Lbt2n/fzPLIajQanjZ
 jkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776233254; x=1776838054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7LtRleJbLmAib+ER61qN9f126OHiS1mbhSLPvhYyOU4=;
 b=bG0ZVgx/qyjca76irsAWkHpcYA+oPo/AAW2snXfH9gVoJuWmsvx4vTBfpOa3csGzSc
 WCKk3ElYMuPy6TIp9HKj63QopHLZsMLZ6vYTZhC2rTvGkA4vyx+vQLEdkMKVwdUj6K4/
 2vMRb/szFJy3cijXw0J1KqxuP5OA/Oyhx9dqV/GS6XuaO7AyIXxpV7vNQHVfX1bjW9Ch
 OuV04GV0LcXaEeblXhVqbI2xu0Ods0/Evq2nI1E5Kzbq6YhbJNHYb4r2HlzE3K3dfAzu
 pcdkUSus4yKXBUHHG8NXZsOMlpwgWcf4Al7v48p2QLtFJCFkCXx5qI/lxXb48gBXoPRs
 zI2w==
X-Gm-Message-State: AOJu0Yxid6wfoHiNR8nkWuW9oHfHhAFrkg3ZDGasmWCzBg7bC73rtJiu
 J46ozXXQ76DIsii7erFFpn17sVoRVsk4rmbCIZVncB9O2t44a/ehcoVQxjNkBZ2DXEH34LNoJ1j
 5NKA=
X-Gm-Gg: AeBDietel/K72yXvaOkEk2xhVFkUOkr+mIuOZrUsSUbLBLHKXsTH19adrt858z+sPrH
 /zFNZaY6FQ0Vi2GmHmqRSX1qrTsG9iTZ/8klaAYsjHVuBzFbhGtT6wwG/Y0IIFa2z9ve0++t5Z5
 z5d30qvJTURjC2RTpyQxoE7WUdo+aylWXBxso/YBwSStcTlzDCmov3SXn4+deLwInsf1/Y0tIIx
 aDxUeoy1rd3PXbbVJjqQ4W8RHqJU2YUB/HBHldZxFQifsgcwuxmJdV/wR5kNrHnOy02rMzy0PD7
 tionNa7cd84+ADY/quDjiEoueSKsKbKd+tOOBnRBhLt/hLUVV7J3ygHvFa1Jy54wxxMSHs1M6sw
 QPBdF55eoGqSex9VBKbx8qMJ4XI82tlXNtQ/77H0M2I1R81Q7usPGwBJa9/uWvswe5wIk4mFq0+
 NYuTyN8KgvnMY=
X-Received: by 2002:a05:6000:144c:b0:43d:7667:2c1c with SMTP id
 ffacd0b85a97d-43d76672e26mr16805683f8f.51.1776233254502; 
 Tue, 14 Apr 2026 23:07:34 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43ead3ebaaasm2126362f8f.32.2026.04.14.23.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 23:07:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 15 Apr 2026 06:07:17 +0000
Message-ID: <20260415060728.21662-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415060728.21662-1-wegao@suse.com>
References: <20250723154610.3860563-1-wegao@suse.com>
 <20260415060728.21662-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/2] open16: allow restricted O_CREAT of FIFOs and
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
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 129 ++++++++++++++++++++++
 3 files changed, 131 insertions(+)
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
index 000000000..9ec6515e7
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
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
