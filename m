Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6379C282CD
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740994993; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zL7CKT7EavmwVqs/EnGvqxfxJuyQ0sLqQq3jA7mKYHE=;
 b=Irejc9Iw9Dzs0FUi5hZv4B5zBB0a0f4Zfm+mT3C38rC1x3Y8f0cGWAODkEl4iKdRyDy2y
 nQPke/o9woPZeyCGrWRlkRIroWEWcG1t5WzIOapGCHd8EZS0RLXnzuXox3BRFcPHTPmC/fS
 ytAhA2GvPn+Y0ADjWS1dEkUITh21Bcs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AECC3C8466
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 10:43:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F292A3C5EF3
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 10:42:50 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D22151BBEF1F
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 10:42:49 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bbd711eedso7673125e9.3
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 01:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740994969; x=1741599769; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTknueZtcCx+L2eMg7p+xM624t+h6ZYE0oMj8uVVUDA=;
 b=CozU67ydq7HR2Z+cxAh8Ut0Gps3oAmulSa4cv2D5aF1c1q2UHmwafbhImEYzSsiIVr
 Gt7igsa5JQA+0udTZbjCwxlgilkM84BR4dPQWg154i2WmmnzfJu2h25kSUVvK46PA7Wh
 VpHvpwoiXwsHzzGCTSH+tUBPHsAC6JkUCGzS5m1sxWcB0rvYw+Stdj6uuCcwueqw/Tzc
 b/y72KeEoLDP7KXkSXAmLc9q3clt7FEc/hNbdttALMzTDptQexuyKrgnS0RHy24iKJxz
 HEMJTcKW6BAcr8thZsWaqx1+k8kr4W4iEZVakB1rk8jHDGBL/5EYRrEWx8ci1Dw0Omvt
 NZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740994969; x=1741599769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTknueZtcCx+L2eMg7p+xM624t+h6ZYE0oMj8uVVUDA=;
 b=GUyuudMbEeNtEKEtqhC61ybJ8FSManOg9o5DR2ydOtK9l+tKpxQrigDyww2aJdG+rS
 IoVluE0qKeCkB+j0nl2w/bF48vK5HZNBi1N6RjFyqp9lZ2e3EkPOSGBQ+ZkbHeWsT1KK
 fReVnX82QBV4sqw7H2F/hPrq89dUpGQXzzhhPH8xUYL507kYmovOw4Pk4frBif+eLkh/
 m9BZWCVm/BeX7fIFoygOGUJMjY7gvfUirqQfKNb1NTJDIm0Xv5B8bVcLnL8UaANu32sQ
 fb+mauer/dCP/043v+v2K9ke9U5oTHTOkqnIgetZmZg3DHSuCeepoSroGTrDRnnt1XHq
 WQsA==
X-Gm-Message-State: AOJu0Yzp2vbF4cRxESP/MEhjM2Mt00v4We2n2sCfCwXQM+l44/2TaTes
 vaZpW9k3IhH6an/dYLYB6vPMZT0Peagwi5e+ybn6+QoyUwEjU7hLx09jzhoOfpZi3qnjji75sSA
 xNQ==
X-Gm-Gg: ASbGncu0caAjiCCqKy2+HOA6/d6P0hr3uWcz3Lbw4sRxpn0XumZb70lmUs8priXj5Nb
 yvZ8TOF1dmQ6+7Ud/xwyEDcSVQQAOw16hfMVXzHv459b6m4w+wniZ55vNQrkOx+T5ezRnNY7u80
 vQo0MA/OO4dibnPuy72JV52r6axWP9QvFlpW1+At2owsgew0w+uYSs57BHTLU8kpTwqT7v1ipL+
 mLbgFx17FvLyshjOjHSZ3dUUqc4gXhElvbr4mjg5ooM9eHODWIyMv5Mp4yyjTV1JiKG+SnW6141
 PaH30maYxDDa6MdIMAPQWIVbU+SiUj7hscQvunDq4s5R
X-Google-Smtp-Source: AGHT+IGAYaKfLDLjsslEPRPw5qjSoYtxjYbuNh0cxhW3LGlLm3pPq5DpKsZJXm7q/YtxG00yCJdzOw==
X-Received: by 2002:a05:600c:5102:b0:43b:c0fa:f9eb with SMTP id
 5b1f17b1804b1-43bc0faff85mr23874935e9.17.1740994968908; 
 Mon, 03 Mar 2025 01:42:48 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f990esm158397195e9.5.2025.03.03.01.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 01:42:48 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  3 Mar 2025 04:42:43 -0500
Message-Id: <20250303094243.5782-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241219081951.8340-1-wegao@suse.com>
References: <20241219081951.8340-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] unshare03.c: Add test coverage for dup_fd()
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

This is new test case adapted from the kernel self test unshare_test.c.
It verifies that the kernel correctly handles the EMFILE error condition
during file descriptor table unsharing, specifically when the parent
process modifies the file descriptor limits and the child process attempts
to unshare(CLONE_FILES).

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/unshare/.gitignore  |  1 +
 testcases/kernel/syscalls/unshare/unshare03.c | 75 +++++++++++++++++++
 3 files changed, 77 insertions(+)
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
index 000000000..c8baecc10
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare03.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Al Viro <viro@zeniv.linux.org.uk>
+ * Copyright (C) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * The test is verifying whether unshare() raises EMFILE error when we
+ * attempt to release the file descriptor table shared with the parent
+ * process, after opening a new file descriptor in the parent and modifying
+ * the maximum number of file descriptors in the child.
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
+	pid_t pid;
+	struct tst_clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
+
+	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open + 1024);
+
+	rlimit.rlim_cur = nr_open + 16;
+	rlimit.rlim_max = nr_open + 16;
+
+	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlimit);
+
+	SAFE_DUP2(2, nr_open + 8);
+
+	if (!SAFE_CLONE(&args)) {
+		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
+		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
+		TST_CHECKPOINT_WAKE(0);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+	tst_res(TPASS, "Verify EMFILE error pass");
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
