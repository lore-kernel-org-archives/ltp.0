Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F163C021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 04:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741061189; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=scb+eKesxw6YDsR+IeHU9wrwdmfp/SCma8tq1tGVucE=;
 b=UTJUaDLSGRLV5Lwm4nWGbWYo0+1shvaJc6oIJf3WLchPs02wQa6YOPjiROIGtyGdexhfT
 Azj7ztZdrn+r3JCzSZoA2ybUzcISunHAOU1Q9oz7HDoB16YmdxLsMZUw2+sBA9sW/bemeNV
 dkRYmGDJanpHA/ftttf3gBFO5mf5iWg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 063AC3C9CC4
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 05:06:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76D1B3C1B60
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 05:06:06 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 522E3630B18
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 05:06:06 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso32957875e9.0
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 20:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741061165; x=1741665965; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSBf+4R4qRF+HrNIxi3Y8kNKFXe/CdpopO/Sw2/vdfc=;
 b=WJOL8aodVZpURLyhk8G1uTOiYiK9S2ohqPm2kh2CnuRThzuglYCfY9DBITPYUKWqw8
 xqCu/9+5oKpLmrHgXfIZ12t4fkcqQIcRcU2cXfmpc22JP1xz5MvIRv/KstTwUumY1WBB
 EpUFjvaLfYxhUrMJbYcxCzCX1dBFRLP7RsOH56EPlXAT2lrAq+99nNsGpoRDbp+vuV40
 /zyjm0JEnJX9MzWDaBQgmA+FYctgU7zzxpfdZoAGGbucVtDD88YVDHzB+Rnt8bpAFyZf
 63Vd25Ys6HZgip0cjvRfCl5UNIHIifmKZD5GAGVqyfz9xFRPDGhpFsmjmeaAKvgrlIuN
 ynkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741061165; x=1741665965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSBf+4R4qRF+HrNIxi3Y8kNKFXe/CdpopO/Sw2/vdfc=;
 b=vUdk0HteCQBen9eivxAPSGB8KfEJ9iMyBIEXMojUts1Ckd6iopxxQFvTP9Tl1lTAko
 ziWHOQUmBmifR2PUZz0H0zaGtGYX7Xj+ZKai96W5+RTRfOwLb/XxgfZaHohUUn4P7MfY
 z88aIZ66ozW6bkjBLYBfDFaDd8Dt6nc73pN87GyoB9n/2VPG5gviYLHw9h04DRuLDhsq
 QVSFXfEwHYLPec9Zkvb4OY+2GRz7/ecyzcoX+aEJIeUert9PaiycKO9orREOpNnPFQjG
 ThAK9GBjirE5L6daRnnXGwMD/c1CGqahHpOOP+3aKSJuqIGjTpOpiarWYtAbMZuhMlgo
 Ap4w==
X-Gm-Message-State: AOJu0YySI+HmAQUERW1qHwawdUQrrBOdGLXIpx2Gd+EYB80lQQq1l4lg
 rka4+H2xFyBkoi3N6fcR+0daEdFTMgU+m5CSQjmg6J6Qt5JOsfSnHwrjVZw+ZYCWRznouGQJ7sp
 OAQ==
X-Gm-Gg: ASbGncv2Qc9a6TPc4b1BjiKHt1eqlES8a0s+BImtS+JWhHiokzA7KmJkvUFgXyM5twg
 9K8wY87RZNEroVzBzargP7S/m2LBbch0r1sLevbFtDSiqdp09ceS2AaCHJssUSkWmrNmNYDUI+R
 OIe510ODgUEgF5mIB/N9pK+qUj/+Xg4ObB3ToEE5iiQ/tkKQ/vPQDxPDNuVf16YdyjqEcH7eDB6
 w+tPkbp/7MnffBfeeQSofcgF4ZOPQcM49pEbOVIAqjO0jqqgMBaQkjIK9RFTtVoJLjZTUxpbrS6
 s8WpCWYYjivc26CbfLk6o6ZsSO+leCPD60BcnBZyK8hc
X-Google-Smtp-Source: AGHT+IEOda5LkXHPCiz8FJX3hNYeY6NTzL9JJDHaQON0GdTVil6VnezqCitCbvdU7V+YzIXpMQbz9g==
X-Received: by 2002:a5d:59a5:0:b0:390:f734:13b1 with SMTP id
 ffacd0b85a97d-390f7341455mr10629852f8f.23.1741061165518; 
 Mon, 03 Mar 2025 20:06:05 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba57145esm209187365e9.30.2025.03.03.20.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 20:06:05 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  3 Mar 2025 23:06:01 -0500
Message-Id: <20250304040601.23920-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250304034348.23389-1-wegao@suse.com>
References: <20250304034348.23389-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] unshare03.c: Add test coverage for dup_fd()
 failure handling in unshare_fd()
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

Add a test case based on kernel self-test unshare_test.c to check that
the kernel handles the EMFILE error when a parent process changes file
descriptor limits and the child process tries to unshare (CLONE_FILES).

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/unshare/.gitignore  |  1 +
 testcases/kernel/syscalls/unshare/unshare03.c | 77 +++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 testcases/kernel/syscalls/unshare/unshare03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ded035ee8..10800c1a3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1715,6 +1715,7 @@ unlinkat01 unlinkat01
 
 unshare01 unshare01
 unshare02 unshare02
+unshare03 unshare03
 
 #
 # These tests require an unmounted block device
diff --git a/testcases/kernel/syscalls/unshare/.gitignore b/testcases/kernel/syscalls/unshare/.gitignore
index 855ffd055..e5b5c261d 100644
--- a/testcases/kernel/syscalls/unshare/.gitignore
+++ b/testcases/kernel/syscalls/unshare/.gitignore
@@ -1,2 +1,3 @@
 /unshare01
 /unshare02
+/unshare03
diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
new file mode 100644
index 000000000..c1f13bcd5
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare03.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Al Viro <viro@zeniv.linux.org.uk>
+ * Copyright (C) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * This test case based on kernel self-test unshare_test.c to check that
+ * the kernel handles the EMFILE error when a parent process changes file
+ * descriptor limits and the child process tries to unshare (CLONE_FILES).
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "config.h"
+#include "lapi/sched.h"
+
+#define FS_NR_OPEN "/proc/sys/fs/nr_open"
+
+#ifdef HAVE_UNSHARE
+
+static void run(void)
+{
+	int nr_open;
+	struct rlimit rlimit;
+	struct tst_clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
+	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
+
+	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open + 1024);
+
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
+
+	rlimit.rlim_cur = nr_open + 1024;
+	rlimit.rlim_max = nr_open + 1024;
+
+	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlimit);
+	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
+		nr_open + 1024);
+
+	SAFE_DUP2(2, nr_open + 64);
+
+	if (!SAFE_CLONE(&args)) {
+		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
+		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
+		TST_CHECKPOINT_WAKE(0);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_root = 1,
+	.test_all = run,
+	.setup = setup,
+	.needs_checkpoints = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{FS_NR_OPEN, NULL, TST_SR_TCONF},
+		{}
+	},
+};
+
+#else
+TST_TEST_TCONF("unshare syscall is undefined.");
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
