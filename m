Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6CDC636D4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 13:45:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7A693CBF16
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 14:45:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59A873CB0B8
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 09:34:23 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 99C7314001EC
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 09:34:22 +0100 (CET)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-52ee632329dso176864557b3.6
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 00:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Eg5eKvTCeeudx3FfwlsbsdkPgt/OlX0JaIC6NlDe4y8=;
 b=N6q+PH6C/cRrxjQN3T62JxRZsHPA8mXe1DSfpsXCqyCljvBemi4DFpzSciTON6g1V4
 6OQefNpVWI/2hRU9MP0dHQNRLDvoHmNB0+SfgE5l5FoDAwETbbH1idyFpKE1Y1F5p3J7
 mGlbXb2XoWR1KOD1JOdl9XCI/Pr2+rMwvxukASmQUf7zk7NcSvDxwG5DHcVVpzNMblrv
 82IXJyJ5fvg5Y0VemYOBayE2d5pMsa8I5UjO1gJrkCEjB/WiAyI6SSpnhcwhqzdQLlh0
 ZDep8XvNQLZ21H1RpaT2EvOMscVZmPivK4eWA3kfyRcndD6zaJZrL/eg+EH5F7QLi1Fa
 gP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eg5eKvTCeeudx3FfwlsbsdkPgt/OlX0JaIC6NlDe4y8=;
 b=BVC4UNzBg0159cdIOYvpR/xPifdnNgZYfXVQwYXe5W/nDdZdROsH09SGJpbWjIj1TS
 qFaG6x3I6ClHixtsPO1bg2uZO1js2BDUiW2xWW08Pl3I5tdetCbf1a+7R7mm3mRfPPXZ
 o037ILNCeJNKaWqn/5kBhsk4yV7ovKvK6+sj82zuw7BDEWD7y4InZtoGAUjNBn8tky7E
 aHyzCklm3jhM50DAli4fMZ3DOr8rfCd5z3jo6jC/koeMa2qkvrZFnRcQr86PahGBM4Cb
 nAJzDi601Ft3ejq390Z/EJhPCbWp71h+suVciLOsaqNlBH/dgeUNn0rpHk/s3TLfIxsM
 6hfQ==
X-Gm-Message-State: AO0yUKVPE9eFye1ebFFEAH7WRfMmfXPHP04GIwyqG5ewX/LE3l6qMa7w
 /kWwymBfcUD6eEfDziWslcuSvv3TR49QPW1UTgG8Fn4XkrWf7A==
X-Google-Smtp-Source: AK7set88/JujvvTWx8EV85Zeq5SL0YlqnyN/Dq9N+71ecOFFb5d5PU8KFt7tX4SOanyoxkhKukEEJb/0uYFeechW2hM=
X-Received: by 2002:a0d:ea12:0:b0:523:ce6b:3db5 with SMTP id
 t18-20020a0dea12000000b00523ce6b3db5mr213916ywe.24.1676450061050; Wed, 15 Feb
 2023 00:34:21 -0800 (PST)
MIME-Version: 1.0
From: Paulson Raja L <lpaulsonraja@gmail.com>
Date: Wed, 15 Feb 2023 14:04:10 +0530
Message-ID: <CA+O3cCQk5CEKTqdCkHnMmAwqWF8ePeGOOuHXKBMPqsqwvv7ihA@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 15 Feb 2023 14:45:05 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] RFC:[PATCH v1] Added testcase to test mmap with
 MAP_SHARED_VALIDATE flag
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch adds a new test case for mmap syscall. It tests the
MAP_SHARED_VALIDATE flag of mmap. The code checks of the
MAP_SHARED_VALIDATE flag return EOPNOTSUPP when mapped with an invalid flag
value. It does so by setting the unused bits of the flag argument.

Signed-off-by: Paulson Raja L. <lpaulsonraja@gmail.com>

diff --git a/testcases/kernel/syscalls/mmap/mmap20.c
b/testcases/kernel/syscalls/mmap/mmap20.c
new file mode 100644
index 000000000..2f6dd5d4d
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
+static int fd_file;
+static void *mapped_address = NULL;
+
+static void setup(void)
+{
+ fd_file = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, TEST_FILE_MODE);
+ if (tst_fill_file(TEST_FILE, 'a', TEST_FILE_SIZE, 1))
+ tst_brk(TBROK, "Could not fill the testfile.");
+}
+
+static void cleanup(void)
+{
+ if (fd_file > 0)
+ SAFE_CLOSE(fd_file);
+ if (mapped_address != NULL && mapped_address != MAP_FAILED)
+ SAFE_MUNMAP(mapped_address, TEST_FILE_SIZE);
+}
+
+static void test_mmap(void)
+{
+ mapped_address = mmap(NULL, TEST_FILE_SIZE, PROT_READ | PROT_WRITE,
+      (1 << 7) | (1 << 9) | MAP_SHARED_VALIDATE, fd_file, 0);
+ if (mapped_address != MAP_FAILED)
+ tst_res(TFAIL | TERRNO, "mmap() is successful, but it should have
failed.");
+ else if (errno == EOPNOTSUPP)
+ tst_res(TPASS, "mmap() failed with errno set to EOPNOTSUPP.");
+ else
+ tst_res(TFAIL | TERRNO, "mmap() failed with unexpected error.");
+}
+
+static struct tst_test test = {
+ .min_kver = "4.15",
+ .setup = setup,
+ .cleanup = cleanup,
+ .test_all = test_mmap,
+ .needs_tmpdir = 1,
+};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
