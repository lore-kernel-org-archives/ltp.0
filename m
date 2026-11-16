Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEA606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=gtFV1e4v;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AHkhDSjq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794819435; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=YUWpiL6PNfnSbHKfqL+6XvELVduu0bWUEpqDQ1ufMjc=;
 b=gtFV1e4vWTHxOEA8b6H/Se9IaLsK2HkjYmJo1vGZarncLjaqh5KKpLcWRR/+gJrYXNPG0
 sssJKAr8e8e8nsxA7t5V5FOpiLRGdz/LPPxe8D76JIwH8s5OoYA5GZrVuPcl2ezsWXRU9Ul
 ZkNRV5UlG/TeukooGUEW8229IcjhtBI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 335903C3078
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 09:57:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B33F43E940A
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 09:56:19 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 340F46002D3
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 09:56:18 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so1962401f8f.2
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794819377; x=1795424177; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=slo83xJyQi7HiUuwAp6JbU8tEPThX9At6cMCL5W7H9M=;
 b=AHkhDSjqKDWUwtcpEYvf2pT6TlItcrMa4B+Z+GG8WLniDrcAjF+PYrY0fNCbCVxUf4
 +8L+0dqdGhoDU6A3tgdsexRE4Vw2IKAO40PpYubFM1nD2uHufPCXltFu4vjze2QyTFRx
 Ay0zigDUBdzTRNaGP8Xhsl0+fBfLnQZiVklwMYD0SHxm7qjIVgGbWzWHLTeiFgpjsMPC
 6XbLPbkA+VozHYMIsC0gpVWSj+JUujmrdVy6tNkvooiddFKSQqzXZO1sNJRkTYJshqkU
 Yfcyta18fQ/L9ysrLMA3D3nyWUlWy7uyVtrJQO+g1t6+hdW/64CuJEzjcga2rOu2fvbc
 sSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794819377; x=1795424177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=slo83xJyQi7HiUuwAp6JbU8tEPThX9At6cMCL5W7H9M=;
 b=M3HdGmnrJ8359ij9aLX+8hGM+7rESq49QFkbhvbeN1jif/zonCw5XVRtxcep/hUySz
 ooUItN5UCabUdjkok5Hpv3tug7nMtBuQEFzugIcR0dwivA5hIoDe/m+jvGMiUJh9GxHc
 vJTsQ8pN+NisH1Z7C2wzlWGL+n3xeTYf4KrYG3NUlcBt0vUZYnJXvtPBF+ohob/Pyrsm
 2xMVgNxekb+tB5DxlXu1k0t+BFOKGN2u8ycdErw99kWSaVSH7VEqXsMKXLt8EGOoKzKy
 bHcBsTuQqPkKN/uabgSGvzDOd4Bu3XYfmQVlOffqbkrzPs1/VKBBA5I42+pyietm9GQg
 TQnQ==
X-Gm-Message-State: APuU4Z/chSbC3FJLhwjxKG9T4j1zcjaqm+Yb9etdNQPtEdwMzwHx0Mmd
 xPG2ABfy9MwpMWKGlNfNTzrBdQYaHP4yXHRX3KdypXjYswwCOywmwV0yyju+w+xq2W5D3HdSIVL
 zvn1hMjiY
X-Gm-Gg: AZFdTZfqNSS0o4qUFXkj9uiBArciW16IihTSoeMtZyUFcskf7vypGJYGgxavU68zqjT
 4cz1l9sfsQ57MPyx6NQwBS2EyotjLqSy/jK8Ayhhqbi2PZR+8/Qr/0xBypiqTsDZ1TpoXFON9eh
 6bkX026YfKA2VhqDMCJqWAId3D8A8qCsrPOg707/gkrV/FQ3BjgNFKsIhBa0g2Ee8Rt/p4cKOyw
 uuF0fJUbOCdIv04wex850SLIbLD3svvU3E4ol+KwaWeRMJGQVbusfpmvIqVcckVPFHXDNrP+6Y5
 kCysNbBi8GzgvXrp5eOsT47c330jPSCdndl4LnbfB6sLg6i0z9+pfVnBZhMsum5SL44lfjj3Vxn
 pVhWxc1njzU2gifnGjg4f16T79jHhKBqymukCcx48/1zsjTJnCHTmCLGOyn86G18ICIKzkJXUgk
 29HfjN03mVPCx6NA5rAeuWdC7gYCpBDF/t35vR53zchfq2Prfeqf1/scO1N0rtRMRAG37idYRW1
 rdcvZX5KqshfXRZneVRpG/iY7laJP+pnpmjs/sqY6SkAIWcqlRqRxRhcR6n/HzhYrpuhSH9CMl1
 Ya6dVkpE3xP95bPaECftDy5NGg8t2wMB7/z3ZRjtPL7g+wC48QfehKxSpoBbWjwHx8mSTWOmNts
 SFw8nBMbAqjq9zYvRi9SKeMTJozODNfQ8WS8/KlD4tyK78RO2lt/sn5w=
X-Received: by 2002:a05:6000:4707:b0:498:c419:3728 with SMTP id
 ffacd0b85a97d-49c713ae367mr21367417f8f.22.1794819377491; 
 Mon, 16 Nov 2026 00:56:17 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-49c5f5972a7sm19909786f8f.21.2026.11.16.00.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:56:17 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 16 Nov 2026 08:56:05 +0000
Message-ID: <20261116085612.20171-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116085612.20171-1-wegao@suse.com>
References: <20261116085612.20171-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v19 2/3] newlib_tests: Add tst_attach_loopdev test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a unit test in lib/newlib_tests/ to verify the newly added
tst_attach_loopdev() function.

The test covers:
- Concurrent allocation of multiple loop devices without collisions.
- Parallel worker stress testing to exercise the exponential backoff
  retry loop upon transient EBUSY conditions.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/newlib_tests/.gitignore           |   1 +
 lib/newlib_tests/runtest.sh           |   1 +
 lib/newlib_tests/tst_attach_loopdev.c | 145 ++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 lib/newlib_tests/tst_attach_loopdev.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 3a6e1643c..2d4b3d43f 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -11,6 +11,7 @@ test11
 test13
 test14
 test15
+tst_attach_loopdev
 tst_capability01
 tst_capability02
 tst_cgroup01
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 71808ef8b..18b64c07a 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -16,6 +16,7 @@ test_zero_hugepage.sh
 test0[579]
 test1[59]
 test2[04]
+tst_attach_loopdev
 tst_bool_expr
 tst_capability02
 tst_checkpoint
diff --git a/lib/newlib_tests/tst_attach_loopdev.c b/lib/newlib_tests/tst_attach_loopdev.c
new file mode 100644
index 000000000..37bbcc6b9
--- /dev/null
+++ b/lib/newlib_tests/tst_attach_loopdev.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * Unit test for tst_attach_loopdev().
+ *
+ * Verifies that:
+ * - Multiple backing files can be attached simultaneously to distinct
+ *   loop devices without collision.
+ * - Concurrent workers attaching and detaching loop devices in parallel
+ *   succeed without unhandled EBUSY race conditions.
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#define BACKING_FILE1  "test_loop1.img"
+#define BACKING_FILE2  "test_loop2.img"
+
+#define DEV_SIZE_MB    1
+#define NUM_WORKERS    4
+#define WORKER_LOOPS   5
+
+static char *dev1;
+static char *dev2;
+
+static void cleanup(void)
+{
+	if (dev1) {
+		tst_detach_device(dev1);
+		free(dev1);
+		dev1 = NULL;
+	}
+
+	if (dev2) {
+		tst_detach_device(dev2);
+		free(dev2);
+		dev2 = NULL;
+	}
+}
+
+static void setup(void)
+{
+	if (tst_prealloc_file(BACKING_FILE1, 1024 * 1024, DEV_SIZE_MB))
+		tst_brk(TBROK, "Failed to create %s", BACKING_FILE1);
+
+	if (tst_prealloc_file(BACKING_FILE2, 1024 * 1024, DEV_SIZE_MB))
+		tst_brk(TBROK, "Failed to create %s", BACKING_FILE2);
+}
+
+static void test_multiple_devices(void)
+{
+	dev1 = tst_attach_loopdev(BACKING_FILE1);
+	if (!dev1) {
+		tst_res(TFAIL, "Failed to attach %s to dev1", BACKING_FILE1);
+		return;
+	}
+
+	dev2 = tst_attach_loopdev(BACKING_FILE2);
+	if (!dev2) {
+		tst_res(TFAIL, "Failed to attach %s to dev2", BACKING_FILE2);
+		goto detach1;
+	}
+
+	if (!strcmp(dev1, dev2))
+		tst_res(TFAIL, "dev1 and dev2 assigned identical device: '%s'", dev1);
+	else
+		tst_res(TPASS, "Assigned distinct loop devices: '%s' and '%s'", dev1, dev2);
+
+	if (tst_detach_device(dev2))
+		tst_res(TFAIL, "Failed to detach dev2 '%s'", dev2);
+	else
+		tst_res(TPASS, "Detached dev2 '%s' successfully", dev2);
+
+	free(dev2);
+	dev2 = NULL;
+
+detach1:
+	if (tst_detach_device(dev1))
+		tst_res(TFAIL, "Failed to detach dev1 '%s'", dev1);
+	else
+		tst_res(TPASS, "Detached dev1 '%s' successfully", dev1);
+
+	free(dev1);
+	dev1 = NULL;
+}
+
+static void test_concurrent_contention(void)
+{
+	pid_t pids[NUM_WORKERS];
+	int i;
+
+	for (i = 0; i < NUM_WORKERS; i++) {
+		pids[i] = SAFE_FORK();
+		if (!pids[i]) {
+			char file[32];
+			char *dev;
+			int j;
+
+			snprintf(file, sizeof(file), "worker_%d.img", i);
+			if (tst_prealloc_file(file, 1024 * 1024, DEV_SIZE_MB))
+				tst_brk(TBROK, "Worker %d failed to prealloc %s", i, file);
+
+			for (j = 0; j < WORKER_LOOPS; j++) {
+				dev = SAFE_ATTACH_LOOPDEV(file);
+
+				if (tst_detach_device(dev)) {
+					free(dev);
+					tst_brk(TBROK, "Worker %d loop %d failed detach", i, j);
+				}
+
+				free(dev);
+			}
+
+			exit(0);
+		}
+	}
+
+	for (i = 0; i < NUM_WORKERS; i++)
+		SAFE_WAITPID(pids[i], NULL, 0);
+
+	tst_res(TPASS, "All %d workers attached and detached loop devices concurrently",
+		NUM_WORKERS);
+}
+
+static void run(void)
+{
+	test_multiple_devices();
+	test_concurrent_contention();
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
