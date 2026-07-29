Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9836EC53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:30:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94D7A3E4AD2
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 13:29:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5680A3E49AE
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 13:29:43 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A10B6200336
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 13:29:41 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cabfb70501so2731875ad.1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785324580; x=1785929380; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qBdTULI5q2DuPate+uGqf7tgekmI0gO0y5Gjxo6U2TA=;
 b=EgDL7cg8wLbLCXW3A7pFgK33DvqyuhvuRA8NGb2Gfmp9XEDBDScwSOltxk8ZErtQK4
 wtSc0tIvaMBrd2x3uKAdyEJRh3HWaF2d4DQS+fyTPtkRHb1L7tb7wkLfzi1irSLeG/he
 2tLSNY4ZzzFtpXRpsaoc5/upVu8kvhCsfi7euwEHb4SEp3ff1nilmN+llU5ZP/Kzlq0c
 U5nPyBj3AQTkpDCLGvQIlIgqS5MvpiGvuQ9zIhDzQDAXLr0kgSwoHM8Dl8mNKG6HTL0x
 CZjVitNlu1jvBQQKEF6JyCQan9TKC5KoJ4SZt/LbWs5izn9qGR6BiO5RpEyRwSR0x42v
 uvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785324580; x=1785929380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qBdTULI5q2DuPate+uGqf7tgekmI0gO0y5Gjxo6U2TA=;
 b=Kr1pP15aLWHtP09Rh1CZ1DPB+OY+OyDvwINpOAaUgb/I4dhNFhZUiMCuAAqAjPKkY4
 /a6Ryi413ggvafpP+LsQw1wm/rEgp2nsKFLWIfZj8LC2KtIN1y4zdmdIKvnFAsEngznB
 Wa2cMZTq8R8OisT82iYWl8TSCQog3xDvwVeSq370CCWEvzbs85PHzr+cmFzoyJJ0dT07
 Z+cg0PSOoOuokvRv7vOLYMgDlJBvlCbeuOCLuRwpAHNNU9c28GZfK99c8VEFjVAwDVAC
 KmsKW0hCyscuQ28T+fCl0CqNCU5E2p4F8aUPvbFMDzkOkfj0oVD1e+8kbLzjSZB/Ec02
 QC9w==
X-Gm-Message-State: AOJu0YwabV4B9RyQ4Z9GyPXy1CoyLnjXVDDtjfkd/4c1f+J/CPX/8YFs
 ClngeBXT2JDd8acAqgu73uK8peMBkOWg6TZLL0dKKIn1+e02sHlntocgqkj1+5bfLg==
X-Gm-Gg: AR+sD12VdKJYMDXTBvCEHAWHreDU0gKSoXTWb1qD/fCVw0KFe3QDpV0tQQ8UZRRttCD
 nLXeeRmFlXGaadbkz5Oe6Oej6USsiu97cPcAwz50m0ANtIAkICqKNBs03bK2DBKTwU41EuZecFI
 +0Y3DgbNTio7joj/+TChYAeYJC1WieyWiLpe9ouLD1WFZ9JA0zpJMM9EwLxyF9zM0Do0Jnc2nUF
 fJ0IxSIyJljidrHG0dONLr3DP4vD8nYEXGgDyD7BoR6SJhN3aAXo+CRFzoc9Zw3WI8Yb5rU+NqA
 dBP1eCnK6MojE3eFW/6PKl4uHjJO6gr+8GCR+vhi6r/gLGlmuURmMcq+0zfbVjhW1W7+yOU3GRn
 vw3B6DebopFguPGe6gXVphjqCM2h0LywvElPjg1q2KX1kEYCjQbfwTmDq5JVsGFPPO3n5h/S2wV
 3G7NFOP6hFZGWmrbBxkjmeXjvXXKDtI/q53XomsnRyGBgWqoLiZ2cQdM4wSCYab70LfPP+9JvvP
 eieY1mU08hCbj8X7Q==
X-Received: by 2002:a17:903:98c:b0:2ca:ed41:d331 with SMTP id
 d9443c01a7336-2d015dc69e1mr68064865ad.45.1785324579874; 
 Wed, 29 Jul 2026 04:29:39 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf8880sm9851045ad.66.2026.07.29.04.29.38
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 04:29:39 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 20:29:15 +0900
Message-ID: <20260729112916.4958-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] power_management: rewrite runpwtests04.sh in C
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
Changes in v7:
- Replace the array-based test with dedicated helper functions.
- Use TST_EXP_FAIL2() for the invalid governor test.
- Clarify the test description.
- Link to v6: https://lore.kernel.org/ltp/20260707150920.6489-1-always.starving0@gmail.com

Changes in v6:
- Expand test coverage to include 4 core cpuidle sysfs ABIs.
- Add verification of read() system call return values (bytes read).
- Add negative testing for 'current_governor' to verify EINVAL return value.
- Replace manual access() check with LTP .save_restore.
- Link to v5: https://lore.kernel.org/ltp/20260612171415.988-1-always.starving0@gmail.com

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
 runtest/power_management_tests                |   2 +-
 testcases/kernel/power_management/.gitignore  |   1 +
 testcases/kernel/power_management/cpuidle01.c | 107 ++++++++++++++++++
 .../kernel/power_management/runpwtests04.sh   |  58 ----------
 4 files changed, 109 insertions(+), 59 deletions(-)
 create mode 100644 testcases/kernel/power_management/cpuidle01.c
 delete mode 100755 testcases/kernel/power_management/runpwtests04.sh

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 4da57ee72..0f2656b52 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,5 +1,5 @@
 #POWER_MANAGEMENT
 high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
+cpuidle01 cpuidle01
 runpwtests03 runpwtests03.sh
-runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
index 03f0c83e4..e237df1c8 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1 +1,2 @@
 high_freq_hwp_cap_cppc
+cpuidle01
diff --git a/testcases/kernel/power_management/cpuidle01.c b/testcases/kernel/power_management/cpuidle01.c
new file mode 100644
index 000000000..abbf507a0
--- /dev/null
+++ b/testcases/kernel/power_management/cpuidle01.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+ */
+
+/*\
+ * Basic cpuidle sysfs smoke test.
+ *
+ * Verify that selected cpuidle sysfs files are readable and contain
+ * non-empty values. Also verify that current_governor rejects an
+ * invalid governor.
+ *
+ * Root privileges are required to write to current_governor and to save
+ * and restore its original value.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+
+#define CPUIDLE_PATH "/sys/devices/system/cpu/cpuidle"
+#define AVAILABLE_GOVERNORS CPUIDLE_PATH "/available_governors"
+#define CURRENT_DRIVER CPUIDLE_PATH "/current_driver"
+#define CURRENT_GOVERNOR CPUIDLE_PATH "/current_governor"
+#define CURRENT_GOVERNOR_RO CPUIDLE_PATH "/current_governor_ro"
+
+static void verify_readable(const char *path)
+{
+	int ret;
+	char buf[32];
+
+	int fd = open(path, O_RDONLY);
+
+	if (fd < 0) {
+		if (errno == ENOENT)
+			tst_res(TCONF, "%s is not available", path);
+		else
+			tst_res(TFAIL | TERRNO, "open(%s) failed", path);
+		return;
+	}
+
+	ret = read(fd, buf, sizeof(buf));
+
+	if (ret < 0)
+		tst_res(TFAIL | TERRNO, "%s read() failed", path);
+	else if (ret == 0)
+		tst_res(TFAIL, "%s read() returned 0", path);
+	else
+		tst_res(TPASS, "%s read() successfully", path);
+
+	SAFE_CLOSE(fd);
+}
+
+static void check_available_governors(void)
+{
+	verify_readable(AVAILABLE_GOVERNORS);
+}
+
+static void check_current_driver(void)
+{
+	verify_readable(CURRENT_DRIVER);
+}
+
+static void check_current_governor_ro(void)
+{
+	verify_readable(CURRENT_GOVERNOR_RO);
+}
+
+static void check_current_governor(void)
+{
+	int fd;
+
+	verify_readable(CURRENT_GOVERNOR);
+
+	fd = open(CURRENT_GOVERNOR, O_WRONLY);
+
+	if (fd < 0) {
+		if (errno == ENOENT)
+			tst_res(TCONF, "%s is not available", CURRENT_GOVERNOR);
+		else
+			tst_res(TFAIL | TERRNO, "open(%s) failed", CURRENT_GOVERNOR);
+		return;
+	}
+
+	TST_EXP_FAIL2(write(fd, "invalid_governor", 16), EINVAL);
+
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	check_available_governors();
+	check_current_driver();
+	check_current_governor();
+	check_current_governor_ro();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{ CPUIDLE_PATH "/current_governor", NULL, TST_SR_TCONF },
+		{}
+	},
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
