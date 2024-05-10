Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B3FC10F1A
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 00:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715300650; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=h60X75ABuddqflkmFfcJU1lMJSFdzSTPXUThKHvNpTw=;
 b=ZgPPwBd0J7c8OS4rU7TIUO9SHD91GxiocNO8qL9BCR+AZRiztGet0sQICJmOkzQlNDy3Z
 zmnJ1W0na1NRw+KJ9CEmAtCfkDw0SVwpg7gEszqx2luRYPIa7DsjXiHsZ2Qsv1TU8smLoEi
 zxcScJyi3mqnfbk27S2rHC4ej5u45H8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B10173CE333
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 02:24:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E4113CC2F5
 for <ltp@lists.linux.it>; Fri, 10 May 2024 02:23:49 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9200B602995
 for <ltp@lists.linux.it>; Fri, 10 May 2024 02:23:48 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41f9ce16ed8so15235225e9.0
 for <ltp@lists.linux.it>; Thu, 09 May 2024 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715300628; x=1715905428; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yOVNuFyi+ArCKOvvJS9W21PCSTTZJJwtbFdBg8HMij0=;
 b=GZpTnIxWsWkJBRImLgNHl7nHcklA0lhkdw5bwFhXlIXpNjvgoReQ5w0L5+ZZtLbxsl
 q+PeC5Z5ZckXEdfWqEvbZ9LMiiXLBwPL3pBPBd1YseyPKsT92ONO/N5WBsr5WtYc+5Lx
 Pw0arge3pgEgD0pVCizOiujRieku0a6FTsbvVQwlqScslMLPHF8ehIUtqtQDn/WljNzc
 Nr7XSIEmpX3K02q7hUNjV8u5WYu4G0oG9IPkwtfE/mLLB2t0Psnmq3xfs2l1N/bwH2mD
 jG+rpyuzrRAo6P6rVnQzCJqOzowRBVpWlCg3hsZEOIjtLMWadz1mFLkHZcjJFcrsjcJT
 00TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715300628; x=1715905428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yOVNuFyi+ArCKOvvJS9W21PCSTTZJJwtbFdBg8HMij0=;
 b=XU6/Akg3Cd+lOIp9bB/1K7xot1J6RuyrtrobIGKjVX0To67HIVThJD54EE57dim7I0
 8zW9vPsmF08wDyRJoLhE5B3ohn7RFDoKmdWpXgmPHtrJ8KolglE741+OmKSlZIlS6Krm
 xhVnF6CJt8CBdDkfk7ClPQg+CLRlA0xQP/flYa9dZ6uLtUOsbPguBd1gRBPak8Rj3iyF
 TO7HEunSru/fKVqk/uBs8JEH8+wVUcnW4P8R9bhrl2LGrMA9j8ejFM8TflFKuteaujzY
 m4tkGsBlJiiC9WZui/WWnQSgSEEOVEDVKCltFYK63O9t+0TmsmHQKIZLhu451+wlPY4l
 p+2g==
X-Gm-Message-State: AOJu0Yxf0HpiVIWUF8pWt16yzup5E3636UwGg9D7b5QlQYLxo3AUHBGP
 TV8lq4E/XJLIgdkZolJfXX82hrBQx7Z3qw441gKgtJ2xT4BSk5oN2eYu8OgfuqkN7yBDKceAfX4
 =
X-Google-Smtp-Source: AGHT+IFdu9SHO8oV6dRb3ur+SOwHSnG5Vm8zlrIFML93tRgzV6BDCz35JpFgmRAQJai3yIV4Jfwhlg==
X-Received: by 2002:a05:600c:190c:b0:41a:47db:290c with SMTP id
 5b1f17b1804b1-41fea93a099mr11665045e9.5.1715300627703; 
 Thu, 09 May 2024 17:23:47 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccfe1363sm40584795e9.43.2024.05.09.17.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 17:23:47 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  9 May 2024 20:23:31 -0400
Message-Id: <20240510002331.31431-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] chmod02.c: Block mode changes of symlinks
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
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/chmod/.gitignore |  1 +
 testcases/kernel/syscalls/chmod/chmod02.c  | 68 ++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 testcases/kernel/syscalls/chmod/chmod02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fe9ad0895..b8f1d53d5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -66,6 +66,7 @@ chdir04 chdir04
 
 chmod01 chmod01
 chmod01A symlink01 -T chmod01
+chmod02 chmod02
 chmod03 chmod03
 chmod05 chmod05
 chmod06 chmod06
diff --git a/testcases/kernel/syscalls/chmod/.gitignore b/testcases/kernel/syscalls/chmod/.gitignore
index 27ddfce16..9cc923e69 100644
--- a/testcases/kernel/syscalls/chmod/.gitignore
+++ b/testcases/kernel/syscalls/chmod/.gitignore
@@ -1,4 +1,5 @@
 /chmod01
+/chmod02
 /chmod03
 /chmod05
 /chmod06
diff --git a/testcases/kernel/syscalls/chmod/chmod02.c b/testcases/kernel/syscalls/chmod/chmod02.c
new file mode 100644
index 000000000..412c78e9a
--- /dev/null
+++ b/testcases/kernel/syscalls/chmod/chmod02.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test for kernel commit 5d1f903f75a80daa4dfb3d84e114ec8ecbf29956
+ * "attr: block mode changes of symlinks".
+ *
+ */
+
+#include "lapi/fcntl.h"
+#include "tst_test.h"
+
+#define MODE 0644
+#define TESTFILE "testfile"
+#define TESTFILE_SYMLINK "testfile_symlink"
+
+static void run(void)
+{
+	struct stat stat_file, stat_sym;
+	int mode = 0;
+	char fd_path[100];
+
+	int fd = SAFE_OPEN(TESTFILE_SYMLINK, O_PATH | O_NOFOLLOW);
+
+	sprintf(fd_path, "/proc/self/fd/%d", fd);
+
+	TST_EXP_FAIL(chmod(fd_path, mode), ENOTSUP, "chmod(%s, %04o)",
+			TESTFILE_SYMLINK, mode);
+
+	SAFE_STAT(TESTFILE, &stat_file);
+	SAFE_LSTAT(TESTFILE_SYMLINK, &stat_sym);
+
+	stat_file.st_mode &= ~S_IFREG;
+	stat_sym.st_mode &= ~S_IFLNK;
+
+	if (stat_file.st_mode == (unsigned int)mode) {
+		tst_res(TFAIL, "stat(%s) mode=%04o",
+				TESTFILE, stat_file.st_mode);
+	} else {
+		tst_res(TPASS, "stat(%s) mode=%04o",
+				TESTFILE, stat_file.st_mode);
+	}
+
+	if (stat_sym.st_mode == (unsigned int)mode) {
+		tst_res(TFAIL, "stat(%s) mode=%04o",
+				TESTFILE_SYMLINK, stat_sym.st_mode);
+	} else {
+		tst_res(TPASS, "stat(%s) mode=%04o",
+				TESTFILE_SYMLINK, stat_sym.st_mode);
+	}
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(TESTFILE, MODE, NULL);
+	SAFE_SYMLINK(TESTFILE, TESTFILE_SYMLINK);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.min_kver = "6.6",
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
