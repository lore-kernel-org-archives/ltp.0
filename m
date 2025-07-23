Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C37C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 03:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753242447; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=T33W4YNMz7Z1gIpZR4VaKBoJ/SVi/zRs897BTOUJi+A=;
 b=KYoc9rQ7+7rzT9gWOiy1jkvTsU4tu9FV3EBoAkCfvXL/lyttLaTK34v/5OXZ5y7X1sqLV
 tudoThN9/z0tyr4AFvFK3xO6EMLDH8tvs32MvNNb5qP4EPnfAmqnguK1+HXgrav/yxT3Waj
 kGucKQ6MsD1EJ5DBb1RCIvhRlqZAM6g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99DFF3CCCCC
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 05:47:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CF073CA60D
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 05:47:06 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B7C2D100036C
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 05:47:04 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-455ecacfc32so28214645e9.3
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 20:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753242424; x=1753847224; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ti0JIbQTtGQ3Jp1WIJKlWICAGQlqsxj59rfIKMTeBg=;
 b=CPxRgFvfY5MoaX3AJHifgYvvZZjRpKlUedtwj/zMUwKG439tLTer0hIpgmWaLQJ/Ba
 SzkTp54iROCsfwyyrkQOGeu8XaSBd8SagrjMrlA1UpwuoQejGj9R74AUJ8++UZ/9SI4Z
 Hb4a4MeDjDDyvrfi6txRJk2RD/PpMATolPsIapYuTlGniKgso+1pZ3Qz7YzIlhCnqHzD
 J8jr+0PxaDwNvmirabaTkjhvI0e37g9fEBHPbDs2ie9ABhiddFiClzaKDonoN7NjuI4v
 DDoXEm3EJLX4/JItqgqEUFwMG/TpbsAeIwnwFEgbvZ3W68m4IXWrmGGkQnxnIgo78K3n
 KgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753242424; x=1753847224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Ti0JIbQTtGQ3Jp1WIJKlWICAGQlqsxj59rfIKMTeBg=;
 b=f5nLVDRk8hNqNJrmB4vyOTELFfkvi4Lq6jS5EFhW+021+dfowI3yEQ8sLmER8fhZfx
 kgKPi6bjPDBfuy3JRPuJysveglnaYsemHlh0MmWi3bJfSkgQC8HylP/uXCYao0LLWrO+
 QoGmGhLqfFzApS2fOPifIsHnYYymAB3ccyLpwGjY+Dw2Yu9iRcL9RpnM//JLrUgc8pOi
 +V83dKCLk0CNCqtmcWoI/I6BSIRymLLjoWNMPmeSpBYYYqcSf6AwSeaKuxkYLPOozJfD
 5MM7jBGfvWFclYlG/ib62F3MQVUOlV4zuDEs/BE5NiUdK/6nSOLSNDdX4HqPq07CnWH9
 skFg==
X-Gm-Message-State: AOJu0YwXPkkR7KKGk8iXXDdgikyJuZvszBDzp4K+7gsoU3m6g5Z8w6l4
 i49hGrhaz8rD3bkiD1wv94tU/Ydylk4uQhQsTnB+4kpfSEZRdskDVNtmzmBvHIjE5qCsmSqLQd3
 EKbc=
X-Gm-Gg: ASbGncsbzT99iTiObZMKZpKb5zzofQaHHNovTQd5rXU5b2y6Z+gn9YP5w/8vYUsG7NY
 FN+1FyzKqHiSwV1kaiAE23MZusJNL0m5Oo3BYLSQMdYdHwtysYDKg56wRfuR/miyeYXzzpbK46M
 oVPUzSPjvfhQ9dDcFwL9LnAf+H6JLWFLf3qbedWqLowaWYzTY0rbPbO4DB+NrIqlk1IsgWfJKS+
 4CV6W2H4Y6zTfcRrca0rd/0RI2MhhmlOEM0bFtZsB42nJwgL6HGjDmYi8gnj+qVzpsPa/nB3Dj+
 ox44FLjiB+aDzOsp9OTTo45wwTL1n735gE60s05BF9HDGju0Lf+4huG0Upz2At/PhTNVwcaVxS9
 h4et1wJyPHC/AIbMrT6Uduw==
X-Google-Smtp-Source: AGHT+IFZ1ZMZI3FYMxgFnpP5ZYK6QdWG93ERhfH+x6mFXUC7RLZNmu5Fv+BN1TkwXgkNH8PetOCgyA==
X-Received: by 2002:a05:6000:4382:b0:3a5:8a68:b82d with SMTP id
 ffacd0b85a97d-3b768f079fdmr1017960f8f.43.1753242423893; 
 Tue, 22 Jul 2025 20:47:03 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23e3b6d23aasm85769435ad.167.2025.07.22.20.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 20:47:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 23 Jul 2025 11:46:02 -0400
Message-ID: <20250723154610.3860563-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319142310.30036-1-wegao@suse.com>
References: <20250319142310.30036-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] open16: allow restricted O_CREAT of FIFOs and
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
 testcases/kernel/syscalls/open/open16.c   | 124 ++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3531c2a3c..0de9bfaef 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -984,6 +984,7 @@ open12 open12
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
index 000000000..6e01dde26
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,124 @@
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
+#define FILENAME  "setuid04_testfile"
+#define DIR "ltp_tmp_check1"
+#define TEST_FILE "test_file_1"
+#define TEST_FIFO "test_fifo_1"
+#define LTP_USR_UID1 1000
+#define LTP_USR_UID2 1001
+#define PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
+#define PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"
+#define TEST_FIFO_PATH DIR "/" TEST_FIFO
+
+static int dir_fd;
+
+static void run(void)
+{
+	SAFE_CHMOD(DIR, 0777 | S_ISVTX);
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "0");
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "0");
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(LTP_USR_UID1);
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
+		SAFE_SETUID(LTP_USR_UID2);
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
+		SAFE_SETUID(LTP_USR_UID2);
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
+		SAFE_SETUID(LTP_USR_UID2);
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
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
