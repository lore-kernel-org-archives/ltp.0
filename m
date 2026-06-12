Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DA3CD98CF
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 17:15:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3DEE3E6C71
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 19:15:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 948CB3E23F2
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 19:14:46 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 728291000D2E
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 19:14:41 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-84230ab8857so653642b3a.1
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781284480; x=1781889280; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JUcf3MpXa8Sk667NBB99n93+SfhdXc4cG/79APUF+og=;
 b=iKOnzoo+DimNgQQ6hgUlZ2QRImotXlKFyKMaM7g3/TpjM/UomhIdWKZ0U2WEEA/D/5
 d6VRC0H5eR5f84U+A3USEwsRFJtK4BSPG7rUQU6CxN6NH/X469X8ZURPIgr59Y9882xW
 ZLMQKB303nKWczeHvAdgx7vLVHypxwtCR2je/WOvwzTMj6elG3ppOb9ymRCURoFsubiF
 eoyF8m/TQ7uG85+pkp42Iy1yaomSCoc9ilsfFL5A+KxAQmUc9MRbBEQEO25FqzrLn4au
 7kBoW9XvT65f9IKZxaXZUsYusZmt37660ztm21Uatvmyf9MFLQu5ZGIch0/irCfXmTe+
 7egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781284480; x=1781889280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JUcf3MpXa8Sk667NBB99n93+SfhdXc4cG/79APUF+og=;
 b=NVqhUhKebduTIqXF6PT6HzzGE7U6M3d64EypziF8yxZleuLSA/Xzj7iupwHiCXpe0i
 44e6nXILX67a02dYdSM4o0ggNdp3B26CZlW8V7jkcbV8S8z8l8ClRoG+wcOdH+dXdajI
 YYsKbigETMaBndGTsZmKTPupPbLnN84AUkovzn+952OJW8idMDMcLgw+GTZZ08F0nbkZ
 jIVGpgGwEm/1Kf18vdPw3D1dQvIJY9+xD3Ag+6S5GEWWQimTKbB6Uy3q2o6lQ4VOqSAI
 hpR1DCW8F/Jkiu38DdUy0z2AbsL9Z46nteOZc9tGCrgP3KU0AW9JPPG7OF2F7NlYiZw1
 zpkw==
X-Gm-Message-State: AOJu0Yzi64UByaT5kZk+dK+hKxyD3ol0m0j4ozZT8eTfuTTbHHnPfq92
 vDUQGWAlnEl9ZafSzVdyx7QF+mOviYqXuHX5tTTHluVtTDyNG8DQqePZETdOd3g=
X-Gm-Gg: Acq92OEYb5Myz03aGUgteQ1LNZFxnHJs9xczFVFAlcTx36n6dMAkgaD4PckmPo0VKwA
 nXscmFeLJ2R5c/6rBKyvk24w7dqrXhTzYE01IDuj/S9+2MViuldPOQ0EXy3ZNHhrtlkaHfS8vc4
 g1owbvRcKC/77191ZTLWGJIkfe2xDkY6p0Z7jfAxJVmbJeEyIH7EdYRdbIaDHAhXxRMZboQRuVO
 Wwp+CjlkvscBGTs6PO+kzbLhep6No/k4BJmz0vsG08povlVa4wAU/wmRnY3LNcWUiS4BlkNO9v9
 Hr9Ltr/GmSESX5RE6KIxlH6zFHyZwBg8poyO08Jh2gYa1rfXBeQAxXe0Ae9X/Xs2ZtWk5ctTX5K
 yRSGCy+a61F/naO9CsbpoXfBIvVFzkOYtKofqMLrp2GVPqLfpMu6pWvazpMer5guK7x/eMavTi6
 5xkilnA1cRKkzgqWjRw6RGhTHoTa6wSu5kgs/X+ihC3Q==
X-Received: by 2002:a05:6a00:a883:b0:843:4937:6d0e with SMTP id
 d2e1a72fcca58-8434ce269a8mr4331459b3a.16.1781284479724; 
 Fri, 12 Jun 2026 10:14:39 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b05921bsm2827011b3a.59.2026.06.12.10.14.38
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 10:14:39 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sat, 13 Jun 2026 02:13:46 +0900
Message-ID: <20260612171415.988-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] power_management: rewrite runpwtests04.sh in C
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
Changes in v5:
- Remove runpwtests04.sh
- Link to v4: https://lore.kernel.org/ltp/20260612122045.14962-1-always.starving0@gmail.com

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
 .../kernel/power_management/runpwtests04.sh   | 58 ----------------
 4 files changed, 69 insertions(+), 59 deletions(-)
 create mode 100644 testcases/kernel/power_management/pwtests01.c
 delete mode 100755 testcases/kernel/power_management/runpwtests04.sh

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
diff --git a/testcases/kernel/power_management/runpwtests04.sh b/testcases/kernel/power_management/runpwtests04.sh
deleted file mode 100755
index 6565320d2..000000000
--- a/testcases/kernel/power_management/runpwtests04.sh
+++ /dev/null
@@ -1,58 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management04"
-export TST_TOTAL=1
-
-. test.sh
-. pm_include.sh
-
-check_cpuidle_sysfs_files() {
-	RC=0
-	if [ -d /sys/devices/system/cpu/cpuidle ] ; then
-		for files in current_governor_ro current_driver
-		do
-			cat /sys/devices/system/cpu/cpuidle/${files} \
-				>/dev/null 2>&1
-			if [ $? -ne 0 ] ; then
-				echo "${0}: FAIL: cat ${files}"
-				RC=1
-			fi
-		done
-	fi
-	if [ ${RC} -eq 0 ] ; then
-		echo "${0}: PASS: Checking cpu idle sysfs files"
-	else
-		echo "${0}: FAIL: Checking cpu idle sysfs files"
-	fi
-	return $RC
-}
-
-# Checking test environment
-check_arch
-
-# Checking cpuidle sysfs interface files
-if check_cpuidle_sysfs_files ; then
-	tst_resm TPASS "CPUIDLE sysfs tests passed"
-else
-    tst_resm TFAIL "CPUIDLE sysfs tests failed"
-fi
-
-tst_exit
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
