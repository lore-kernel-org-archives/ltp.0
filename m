Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CEAC021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 03:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741059860; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FTyTkTmJjM+8UJIlP+lAY/oT0O+nQCFWNXEXqxr67EA=;
 b=akUXeUrQb8JiCfyTjIMyiDEDIKySRAk6fS4PHCvwlmvUtk1KC/p/UovFpnXTjYk6P4b81
 WaeDabpLYWxweUE32PjsCqhSY5UmLiPrxK76jxK4bW9A1KZ245Dkda9+19uIgnyFKDfklhB
 YhtoGhJaQ7nyMpHtAe9HLyQgPK1PS7Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D37A43C9CFF
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 04:44:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73EAC3C7B04
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 04:43:58 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CB0311BCAEE2
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 04:43:57 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390eebcc331so2055055f8f.1
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 19:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741059837; x=1741664637; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zstMXldSxNKUC4QBobgTWQsWiRqqdvCOX2NXqggo6+E=;
 b=fQZRHcso0cff0s+lq54KtrkSGE5jovIzSgrS0wX3Y6d02fNprBSxdYCCwc0RBLauXR
 JZHj1lvkHP9iH6wfyRv6KsbiyMF8tRMUT7K68UdFIE8vWVlkx2kTXAwIYIb8+8idkdr0
 pIauV4Iiuo/YFjClpkyqO2JjlTpMETRPvGnkM89yb9cDtlfLX/DW1leNB8vehEFLq5SW
 jW9/UXa9SpCSrtJPOw2pRBn3rJk0+Yce+M+UGodvs8PJ1BBnlsZq/zT55U0xcMxhQX7i
 PnN6fFuvVP2i4q7WNyIO13Jc93IVC0ptsFmq4C2aXrClEe0rQDJfmKtFrvAANW+uPfSi
 ABPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741059837; x=1741664637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zstMXldSxNKUC4QBobgTWQsWiRqqdvCOX2NXqggo6+E=;
 b=SV/Arq72MEZe4gIuLkolmeLgAVAWN4+nEitW1GnuSukhZjSo2tvbGwaAQculBKlQus
 DpZFcbTSQVy7xdEisTTd7Q1gnmSSc+L3vs3mXQZv8Lp2SYtYhDN12Vkyu5Uh4qYyxDwy
 9/SgaXxDV/DgKLd8nDRubOjZudSi0iGZdioxPA9z2wSUf7WhM5eVGMkfFuKCvfRSS33c
 IQFT5qLy10/s7lCt6GeMfZrnJRin4cXPsBfCeg/ZbpE62oKZVpzidCP9ctVyZSEVrdWQ
 lt1hLMv8ldv7g/HR3e/mQnpysT682qekQXmB7dfd096gUT5Uf7QukWHY6vG4ZOQWIUqd
 sIQw==
X-Gm-Message-State: AOJu0YyYe0XJzTbt8zQIUlI5jk9XFOo7tu/Sr1Zn2TPSY5xHD6X0SlCp
 S+qpPozecrb+HBqqPlFoLTL3/KZHsJk9YaLEXIvbIBQAF8pKBaMQW2Z+Asran/rjnevVrwLs/Er
 rcg==
X-Gm-Gg: ASbGncvnIxHVhNhvCwR42/6ZsVnQeqUebhbkTY1D3O82Rto9tVq1vJbuna65tQVYSnh
 QkVnQnL2GearoLo8X8uZ0KhM6rPM4lLNFVx5lC70bgGGoy+fqy/yyb+Y/vHasYZ7q2SUpXuBbUc
 lZJ3MtxbN/rdg0Pdpr+uNQ3Kv3x6WSzq42Bvja55zbAdptlsiWb8SFAOIKgwDpSTLHjknnjdZqE
 rJ9ciHhx41xnAvOIm+yxmeuLI51UYaGSwRnlMqhoieolJ8uRdrlgaRlrD2WcWdjYEKQMWDAaVdy
 nqX2JL0QRzE8HYlAhNMTEdFadPbNCsMp8BEMW2qS/32H
X-Google-Smtp-Source: AGHT+IEO/TY94bdz05BbrBM6BOor72ximcCO36I3FyidgZKW9tDlz0yyvHQ9gk9R17tQDpDa5q3Bow==
X-Received: by 2002:a5d:6d8d:0:b0:38f:3e0a:ca6a with SMTP id
 ffacd0b85a97d-391155f9fc8mr1037312f8f.2.1741059836904; 
 Mon, 03 Mar 2025 19:43:56 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844892sm16375434f8f.64.2025.03.03.19.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 19:43:56 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  3 Mar 2025 22:43:48 -0500
Message-Id: <20250304034348.23389-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250303094243.5782-1-wegao@suse.com>
References: <20250303094243.5782-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] unshare03.c: Add test coverage for dup_fd()
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
index 000000000..15115501a
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
+TST_TEST_TCONF("unshare is undefined.");
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
