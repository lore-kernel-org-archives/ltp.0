Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A837BC25B79
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716541009; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ysqf6sU6glW11Rap7VYckaH0dfsfLxgHBl8M9F/Hy/A=;
 b=LyBmjzTNMuG04wrrrrFzX9r0u3lfQSBs5nA09w6uhIVhLMb2+X4dnekfGL8Jo507GOJKV
 +d5g/+nUWWGOmRASxqdv7zXKOzEm3iIpnXvaUlwBe7ec/CfAqbNHpbVg89pC3ZxVPYU6LFU
 D9DUlMX2xznc6wPouSzZ32fX0YE/xGE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3E023D01B9
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 10:56:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA0623D0155
 for <ltp@lists.linux.it>; Fri, 24 May 2024 10:56:27 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C532263C556
 for <ltp@lists.linux.it>; Fri, 24 May 2024 10:56:26 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f465so380503a12.1
 for <ltp@lists.linux.it>; Fri, 24 May 2024 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716540985; x=1717145785; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHe6nA+O+V2L8EqwerVFzt8pC6V7Or1umOcPIo0Lx3A=;
 b=XKKLDW5dsJZr4rw6wGKkGI6LDgDSB4dnMkjewn1r0j3HwavIXeDBhiXplCJ/GM9L9Q
 42LWk6Oy8d59Q1+ZKpqq4ZKcolAN0z8R8iW2yAnBnJ5B/ciaGGmuGl2wuvLRSlnkwOa5
 u6I7AmRuYStrkHGsMZvFif6lx7pnpgBkTS8MOM/cYcZXShISoPbFAauO/fdkGk93eRKw
 rVVG/pxdGOSE4joPzHvSv6Srct6FtWrO9LFODODHTMhdQCNyTizSTLByuGYTP/GLqRj7
 WPYOdGw6dqPSGkT1rhwapCzKMrS9w/CboR/fAvSBQvfOfL7gbd2SbjH0LnPLHlwPMiTD
 VpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716540985; x=1717145785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHe6nA+O+V2L8EqwerVFzt8pC6V7Or1umOcPIo0Lx3A=;
 b=FpUP9KCrqpP3u99xJ77+dgW5klKvSxrvdqnOM9Zof6RB5nhXGNITfWK8fROAfYe1Mb
 cFJowt3H624s6SH/a0S1PZgUFiugauJpofedFjEtJo2VrYunc2WFgb5gr+qFMD+xP89g
 iUwudNs2+h3sL35rG0TRGE+j/UDNAEXbTB0h4NABRkGBadix9LMExV6urUJIeTcZEOxC
 1Hxm22BKfGxGqsdP4VDJfdYzFal/IxkLeDxkduJ1lF347VBYpXW8oYHFH3+WpKewEJd2
 ad6prDyyQ7ChvUHPUjJkoCtzT5FGjABJKNiBjQai7vYjr4WAivd3HT/xgEZAQRfHzKMI
 CDTQ==
X-Gm-Message-State: AOJu0YzDd8EhLeoapMqAPqfddPBnpO+wFvG/HQcVI8ApWd/yHj07HAmz
 Rhu0CAMDwAwWYhGowMLmjPhX/wRUfxChLWDZhrQIkuRi7AFu/NCXv9/cuDLyncxog/RWbnCVIk0
 =
X-Google-Smtp-Source: AGHT+IE7ApJELYsLZPmv/3dnOSuaSE7+2lMFPf6JhKb+dEUxd2pkGhri6/xtFBTPybdRl33HwY4TPQ==
X-Received: by 2002:a50:8ad2:0:b0:575:d74:338c with SMTP id
 4fb4d7f45d1cf-5785192fc65mr933797a12.10.1716540985495; 
 Fri, 24 May 2024 01:56:25 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524bb79esm1290869a12.92.2024.05.24.01.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:56:25 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 24 May 2024 04:56:17 -0400
Message-Id: <20240524085617.32303-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240510002331.31431-1-wegao@suse.com>
References: <20240510002331.31431-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] chmod08.c: Block mode changes of symlinks
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
 testcases/kernel/syscalls/chmod/chmod08.c  | 67 ++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 testcases/kernel/syscalls/chmod/chmod08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fe9ad0895..5754d8195 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -70,6 +70,7 @@ chmod03 chmod03
 chmod05 chmod05
 chmod06 chmod06
 chmod07 chmod07
+chmod08 chmod08
 
 chown01 chown01
 chown01_16 chown01_16
diff --git a/testcases/kernel/syscalls/chmod/.gitignore b/testcases/kernel/syscalls/chmod/.gitignore
index 27ddfce16..f295f4dcb 100644
--- a/testcases/kernel/syscalls/chmod/.gitignore
+++ b/testcases/kernel/syscalls/chmod/.gitignore
@@ -3,3 +3,4 @@
 /chmod05
 /chmod06
 /chmod07
+/chmod08
diff --git a/testcases/kernel/syscalls/chmod/chmod08.c b/testcases/kernel/syscalls/chmod/chmod08.c
new file mode 100644
index 000000000..368a1d635
--- /dev/null
+++ b/testcases/kernel/syscalls/chmod/chmod08.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test for kernel commit
+ * 5d1f903f75a8 ("attr: block mode changes of symlinks")
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
+	TST_EXP_EXPR(stat_file.st_mode != (unsigned int)mode,
+			"stat(%s) mode=%04o", TESTFILE, stat_file.st_mode);
+
+	TST_EXP_EXPR(stat_sym.st_mode != (unsigned int)mode,
+			"stat(%s) mode=%04o", TESTFILE, stat_sym.st_mode);
+
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(TESTFILE, MODE, NULL);
+	SAFE_SYMLINK(TESTFILE, TESTFILE_SYMLINK);
+}
+
+static void cleanup(void)
+{
+	remove(TESTFILE);
+	remove(TESTFILE_SYMLINK);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.min_kver = "6.6",
+	.mntpoint = "mntpoint",
+	.all_filesystems = 1
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
