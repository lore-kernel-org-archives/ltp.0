Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDBDE77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734596421; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=DaB8hiB9KKjp93BQjOkZ3WXxrQrq+dLHWopLWnBGOa0=;
 b=b7paeP7sZISPxZX8mzYGmg9ckwXyT52nCAfJIZ3wyLpf25WT/QneAYmt0Gz9ml1+dHxbz
 bcraHpsFXb/Jbsa2foSqwPSiT8p2xFoSf//+B/KY54u3qHiBxwhp5zYi9t3249k90905e0z
 5jw05wqW5QoxDb1n6Ewdi/ZBtbHcGTU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B2873EB9CC
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 09:20:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0071C3E28FA
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 09:20:00 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 492492457BF
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 09:20:00 +0100 (CET)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so774024a12.2
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 00:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734596399; x=1735201199; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mJkGVYNbMyGSgHQvCRtCq0RTUFfCqL59gOib/PTtRG0=;
 b=CCO8vmKjLAmJ4pf5UAWDGSg1IJ3DuBvGv3UhLLltbwlAEY+adCBiYzWdtpsYox2O3K
 SP3dM1eRlMyXJdiwUyBpt0/h1EZB4peRmPaIWZyhZbmCL8auFM4MiDO7TRX2ZgkhN2FE
 Zpr8LlhXDN+05mHie6LU88Rt3mzZr9gXfiKdc81FUSgzZ+f3bxIQwTVfI/HXA8lvAKmk
 INUFGPE5Jlo4+4ur/ud/HVSCNcibvo5/A+mfRXZpFKTpnuPY4zTwGMj9QTLRr2/o3BZj
 NRfn3y5YGUHlgw/JUOhgRGUu3736TRjcAybOjbWl2pT0dmTh7dJBxIQXKVmHfNJxVfBd
 ud8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734596399; x=1735201199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mJkGVYNbMyGSgHQvCRtCq0RTUFfCqL59gOib/PTtRG0=;
 b=pPz7OXXPVdus6DLgo/FNpeEZPhOlGrVoriMqsjryN0hyk1ZeUnvKHBouAxbyJ//iLk
 /gzY/DgVQTFZyMVi1WO9ot2TImJ28V5eymoHJAasPRlT4avAOcE8gvMFvkWDYN0zxsmM
 aujVhUZcOmf4/IuSJVqzQgY2pZa3gZfoI6P4FFrb9ExFDrhOkq02OFCEc+6zkAzW7hwT
 zE+UYmCExhXCb1wxtw3aVQKRmyu/VrMxG6/aM3u/ta05I1PEiOIs6Oy/w6RoSFAciyYD
 kwv76uTOcJHnHS9/WEjaa22WMIYNovwlxYrjwVnq2kHYnSXR9D9hpmUJTfuXpVtaZaBt
 5b5Q==
X-Gm-Message-State: AOJu0YzzhT6rit0/Ok1iQRNwSJq9oYjaK3chuaKaQMj/fdkfx8cL1vH/
 N1lZ3AZCYuGpuHAB+BhwdaSpfKWY/m2a8hGXDI7bNYoVZncZTNw917gZIMw3jDdxGXJs9lSdDs0
 =
X-Gm-Gg: ASbGncvX08fB4jQrMCMfGbgUYiodcv0n8jS8bSvjwoq5Rw6StoWG5cvTMFdO3Z5sBJF
 a9e7l7OraG0wXzm9juzDqsSlkIun1x4LCHvyGX9iEhsGyGFL030OOYhSba59zUsQJrG/lOzQLdc
 orba/7pOjefGDW+lU60v/53Nb1g48x/BEqGl3N4JQkZILTG0BsnOkLbO4x+DnGTPC/l+lzyPLB5
 m+Y3OjeSW9RRGj/p3GZNwpCVcf3Jah4JI+ievkN9eycrg==
X-Google-Smtp-Source: AGHT+IHiDB/TDrmsyAXjeUVbbJHN4Jsm1iK9bzpXJZfjNmhCskXSxaIfsRHXNbSrv8w3WDtciv18lw==
X-Received: by 2002:a05:6402:380a:b0:5d0:b60a:2ff6 with SMTP id
 4fb4d7f45d1cf-5d7ee4060eamr5572555a12.22.1734596399508; 
 Thu, 19 Dec 2024 00:19:59 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806fed4casm410576a12.69.2024.12.19.00.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:19:59 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 19 Dec 2024 03:19:51 -0500
Message-Id: <20241219081951.8340-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] unshare03.c: Add test coverage for dup_fd()
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/unshare/.gitignore  |  1 +
 testcases/kernel/syscalls/unshare/unshare03.c | 91 +++++++++++++++++++
 3 files changed, 93 insertions(+)
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
index 000000000..0ff40b242
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare03.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Al Viro <viro@zeniv.linux.org.uk>
+ * Copyright (C) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test case is adapted from the kernel self test unshare_test.c.
+ * Test coverage for dup_fd() failure handling in unshare_fd()
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/param.h>
+#include <sys/syscall.h>
+#include <sched.h>
+#include <limits.h>
+#include <unistd.h>
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
+	struct clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
+
+	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open + 1024);
+
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
+
+	rlimit.rlim_cur = nr_open + 1024;
+	rlimit.rlim_max = nr_open + 1024;
+
+	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlimit);
+
+	SAFE_DUP2(2, nr_open + 64);
+
+	pid = clone3(&args, sizeof(args));
+
+	if (pid < 0) {
+		tst_res(TFAIL | TTERRNO, "clone3() failed");
+		return;
+	}
+
+	if (!pid) {
+		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
+		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test_all = run,
+	.setup = setup,
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
