Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5F8C76195
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 12:13:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E4C33CE2CF
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 13:13:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BCC33C03E4
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 13:13:45 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C08DD200961
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 13:13:44 +0100 (CET)
Received: by mail-pg1-x52a.google.com with SMTP id k15so11633582pgt.10
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679573623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9DUazj302HIueDHtfm+oltq+UrbLcUumN2LKZ8WMQ74=;
 b=P6l8NONiAtlcvl9oWtcf3+I5Ma9v2Qt2L8PSePvV5p5GM6OtssEWDc7Qp+mYBLPT7P
 DJ1OyW8ollMMxjM507htlceXL394AgKiq4Et4PhoumE9o8tbLOpSk5QpX2teueC+T7Qa
 mKi2n+kQxaPqrkBmgGU+8B0t9lR2pW3unrtacuxVIfkSdGeE29A9Oej91YhYmCsG0Zxv
 klan99j/CEcSvzrj2HJ+v+sbBNrNIVA9swIWsDaivfwCFO5QrWLieVqo7sZHy5y6ulbi
 amttHbfzJdRymxl1/FFzyba2RmkRxKbBF9uEEuE0Ics0+qOHndO8wojr9FIdnuLmPKQ8
 7Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679573623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9DUazj302HIueDHtfm+oltq+UrbLcUumN2LKZ8WMQ74=;
 b=qJ0vlklCFrxeVIy9N1VpUUQuOl9++/UwvXOp2GcXqZ1HzV7SRivk0w20P69PO3ws57
 FkAnKcHbP2YbgCwvnFCLNqRh9QgLlzRLGwESsdKI2w+oY0ognUKCHr3yfAzQDvihBnAP
 sBpEJk/Io5lEz0Tu3kj2Drti3V2NG9r/7GAA5xQ9cBZkO3ejmRikQlYkfYj5Jf1Tk10+
 +cTMO8+0YW2CkBYU9XQ6D4CnvYfetOST8I8ZSkhCuESyH+MCDdeL3FaljIJ1a1MaOmmR
 Z0eertA7/ythooE7lY82Yrvyx5FmMo1YN4/6pjjYaOELl0GkmX7CVZoVFchHrPCJj3pD
 c8vg==
X-Gm-Message-State: AO0yUKWubZCMkYMtU+F2Y8/ntGUCF/wCgA51Mf/rZH254927NT+9sUm2
 JUNU+hHK6Fimq8IGI97kWGzS5KpZvc9Mzg==
X-Google-Smtp-Source: AK7set/w24pNJWnK51S8f1oeW0wXhGG+gzAzA/AZuclYVp8xfP19mNJCiMRT5LKEN/7e/2UwXz355Q==
X-Received: by 2002:aa7:9597:0:b0:592:de72:4750 with SMTP id
 z23-20020aa79597000000b00592de724750mr6665001pfj.23.1679573622819; 
 Thu, 23 Mar 2023 05:13:42 -0700 (PDT)
Received: from localhost.localdomain ([210.18.157.59])
 by smtp.googlemail.com with ESMTPSA id
 w129-20020a636287000000b00476d1385265sm11566602pgb.25.2023.03.23.05.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 05:13:42 -0700 (PDT)
From: paulson <lpaulsonraja@gmail.com>
X-Google-Original-From: paulson <paulson@zilogic.com>
To: ltp@lists.linux.it
Date: Thu, 23 Mar 2023 17:43:30 +0530
Message-Id: <20230323121330.92244-1-paulson@zilogic.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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
Cc: paulson <lpaulsonraja@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: paulson <lpaulsonraja@gmail.com>

---
 testcases/kernel/syscalls/mmap/mmap20.c | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap20.c

diff --git a/testcases/kernel/syscalls/mmap/mmap20.c b/testcases/kernel/syscalls/mmap/mmap20.c
new file mode 100644
index 000000000..ca5bfccd7
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap20.c
@@ -0,0 +1,61 @@
+//SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Test mmap with MAP_SHARED_VALIDATE flag
+ *
+ * We are testing the MAP_SHARED_VALIDATE flag of mmap() syscall. To check
+ * if there is an invalid flag value, the MAP_SHARED_VALIDATE return
+ * EOPNOTSUPP. The unused bit in the MAP_SHARED_VALIDATE is found, and by
+ * setting the unused bits of the flag argument the flag value becomes
+ * invalid and the error EOPNOTSUPP is produced as expected.
+ */
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <linux/mman.h>
+#include <errno.h>
+#include "tst_test.h"
+
+#define TEST_FILE "file_to_mmap"
+#define TEST_FILE_SIZE 1024
+#define TEST_FILE_MODE 0600
+
+static int fd_file = -1;
+static void *mapped_address;
+
+static void setup(void)
+{
+	fd_file = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, TEST_FILE_MODE);
+	if (tst_fill_file(TEST_FILE, 'a', TEST_FILE_SIZE, 1))
+		tst_brk(TBROK, "Could not fill the testfile.");
+}
+
+static void cleanup(void)
+{
+	if (fd_file > -1)
+		SAFE_CLOSE(fd_file);
+	if (mapped_address != NULL && mapped_address != MAP_FAILED)
+		SAFE_MUNMAP(mapped_address, TEST_FILE_SIZE);
+}
+
+static void test_mmap(void)
+{
+	mapped_address = mmap(NULL, TEST_FILE_SIZE, PROT_READ | PROT_WRITE,
+			      (1 << 7) | MAP_SHARED_VALIDATE, fd_file, 0);
+	if (mapped_address != MAP_FAILED)
+		tst_res(TFAIL | TERRNO, "mmap() is successful, but it should have failed.");
+	else if (errno == EOPNOTSUPP)
+		tst_res(TPASS, "mmap() failed with errno set to EOPNOTSUPP.");
+	else
+		tst_res(TFAIL | TERRNO, "mmap() failed with unexpected error.");
+}
+
+static struct tst_test test = {
+	.min_kver = "4.15",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_mmap,
+	.needs_tmpdir = 1,
+};
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
