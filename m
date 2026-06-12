Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E2DCD98CE
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:21:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CF743E1CF6
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 14:21:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 297923E1CF6
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:21:14 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 58A501A009AD
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:21:14 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2c0c1e0b0faso5993685ad.0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781266873; x=1781871673; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VFmdkLLcFdQC7fuSukvMBrR4Np7lz1U0tyE6O9ZNMJ0=;
 b=XtH4+EBW4fDJ9zjJ9Cf1Rxf1LVMugsDvZbc57UTjUk0cGhxBi1xf0eyEwkDIcgIm/w
 EoCe1vcP9FsCstiqtUSw06pXZmnbeXzx3Hb8fQRgqrpwqVzwjlgpRduxYqP46ZgI0eyW
 768QTrXeRPGEoeQsfvPYWcODONQsbS6vt8oeHpJb4z37+JsTf+UjV9IcQRsK+xK+G7Vt
 bv6+2hiyNrkmzMKms7VuPojPPDLS0nksVy5HDRLXaSaXiOheFIPC9M3SOwpnBZ6r2ni0
 hoYxN2/SD+rXN7pmjKtgV3xhb/DD5/WJar2pwpKARJP6+i0yp2zleRzvxr1i7hL/Mp26
 Co8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781266873; x=1781871673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFmdkLLcFdQC7fuSukvMBrR4Np7lz1U0tyE6O9ZNMJ0=;
 b=ql+k7NU2+4dFcreCvVOAzBQmsFvsPLrwYHJtM8YVeMmugAzb3XW6JauVz+651mmG8x
 4Jr8pftAHfwYsi9GdOatinaILeF6q2suVbJbw+ZbTvXZU9XapLV869nY5jK/s2rPdYiC
 jiYN3Gl6FgF5SHTbxCxLEiH8X/AcO72ktZjpP7jI96RkxPSRXPzPlJ5hXoKrJXu1HQWL
 7Brzkiakv15FQsSlwPB9bRv9VDfIb/Op2Undf2+sabyV4R7/ky5GWUJEmRWKPKW985ae
 ei6f4ATBLjqwaHGfOQ9/zvMuibHx30te2+jNFf37HA29XgPb1LLK8tSp9RzTNXUll9s1
 EGNA==
X-Gm-Message-State: AOJu0Yyekku7BeIFppg0CxLiZCR6jOdwOrdR4Lr7YY91VHG3b0w9lzlC
 wF9ZKqFgJtBTUYkVRaEDP/sXMM6Bny9t8jszKt56i7m5QoNCjegvijX5En+ODnHOhA==
X-Gm-Gg: Acq92OGEBHFGgMnJ/1FKIvmT9BnovoQxyqACjBVshdT6E/aqIjSwVYmO0/hWDMNwPqb
 D/hOvvh1/zmQXvzC2TcxIiyLb+O7n7ihEAKkbCqJY1+kbBUux3Mbh+1Ve7+Iy9WzCHCIT806kHC
 udgC95zsn/9IjNDmhyEKP6B8nHn2V07sykxeHGs05FALOdOeHolwaPuZBd3MVBiYHmwAxcB/jOt
 OiUm4KfjffnQ6kTGKvA7TTL2XwL38fPVsRlkmVpA/4LCnHZE7A58ng0otLbXJGtB8OYmJE4Rr30
 DnpekqcJhBZ6P6uFiAra0jWCbMjS/PuPaGpP4vD66h5yUXNlY/RsMyUUfdiFeB337wrkwRub1Qb
 T2bb+jX380WjjbAhgcGLixesBO1klcUtygJhH2YhlfKjDSc3zO4qpjn9m1TxjzQb22P7tMzOEzU
 QAS6kA2rzxDuu0ppvt5pgWvlluu749G1XZ6RsGqm2d+w==
X-Received: by 2002:a17:902:f78a:b0:2c0:ca99:3d73 with SMTP id
 d9443c01a7336-2c410bdd02dmr38093065ad.8.1781266872596; 
 Fri, 12 Jun 2026 05:21:12 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e52b5sm19881745ad.7.2026.06.12.05.21.11
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 05:21:12 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 21:20:44 +0900
Message-ID: <20260612122045.14962-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] power_management: rewrite runpwtests04.sh in C
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

As part of the ongoing effort to reduce shell-based tests in LTP,
rewrite the cpuidle sysfs smoke test in C using the modern LTP test API.

The new implementation preserves the original test semantics while
removing shell dependencies.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
Changes in v4:
- Fix patch application failure reported by CI.
- Link to v3: https://lore.kernel.org/ltp/20260611145911.3752-1-always.starving0@gmail.com

Changes in v3:
- Replace SAFE_OPEN() with open() to convert ENOENT to TCONF.
- Add a cleanup function.
- Link to v2: https://lore.kernel.org/ltp/20260524154221.2064-1-always.starving0@gmail.com

Changes in v2:
- Update runtest entry
- Clarify commit message
- Link to v1: https://lore.kernel.org/ltp/20260516200015.12689-1-always.starving0@gmail.com
---
 runtest/power_management_tests                |  2 +-
 testcases/kernel/power_management/.gitignore  |  1 +
 testcases/kernel/power_management/pwtests01.c | 67 +++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/power_management/pwtests01.c

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 4da57ee72..7a31cde36 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,5 +1,5 @@
 #POWER_MANAGEMENT
 high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
+pwtests01 pwtests01
 runpwtests03 runpwtests03.sh
-runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index 03f0c83e4..e07cda0c5 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1 +1,2 @@
 high_freq_hwp_cap_cppc
+pwtests01
diff --git a/testcases/kernel/power_management/pwtests01.c b/testcases/kernel/power_management/pwtests01.c
new file mode 100644
index 000000000..ae4ed0651
--- /dev/null
+++ b/testcases/kernel/power_management/pwtests01.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+
+/*\
+ * Basic cpuidle sysfs smoke test.
+ *
+ * Verify that selected cpuidle sysfs files are readable.
+ */
+
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+
+#define CPUIDLE_PATH "/sys/devices/system/cpu/cpuidle"
+
+static struct tcase {
+	const char *name;
+} tcases[] = {
+	{ "current_governor_ro" },
+	{ "current_driver" },
+};
+
+static int fd = -1;
+
+static void verify_cpuidle(unsigned int i)
+{
+	char path[PATH_MAX];
+	char buf[32];
+
+	snprintf(path, sizeof(path), "%s/%s", CPUIDLE_PATH, tcases[i].name);
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			tst_res(TCONF, "%s not available", path);
+		else
+			tst_res(TFAIL | TERRNO, "open(%s) failed", path);
+		return;
+	}
+
+	SAFE_READ(0, fd, buf, sizeof(buf));
+	SAFE_CLOSE(fd);
+
+	tst_res(TPASS, "%s read successfully", path);
+}
+
+static void setup(void)
+{
+	if (access(CPUIDLE_PATH, R_OK))
+		tst_brk(TCONF, "%s is not available", CPUIDLE_PATH);
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_cpuidle,
+};
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
