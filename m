Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A27C43602
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 15:10:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D66C3E5DD7
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 17:10:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4693E5CF9
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 17:09:48 +0200 (CEST)
Received: from mail-pz2-x00.google.com (mail-pz2-x00.google.com
 [IPv6:2607:f8b0:4864:3b::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D48D46008BC
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 17:09:46 +0200 (CEST)
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-c9abbd0a2e3so1022045a12.1
 for <ltp@lists.linux.it>; Tue, 07 Jul 2026 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783436985; x=1784041785; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZGdEoi/5i/y3sm4j5VXZaVGF4cHAHnEbt/h0xQ/d1PY=;
 b=Tr6oZY0ZxmtB/D4QTK5lbuo5f77N36G3d7PwAHa1qWDW33Ew3i3zjjWrS53T0qCge/
 uhXaixWN+99tsYnmzA2jlozmWgGcjhlJRXEvs6fVNy5JZnBz8hwwbrI0Ip4vI/PV+69L
 iybHsOY6XKdy3hdLji5JPtexp+kn1KJn26+l9rWhsmp4xUfMc74uu0HFrMkNG3v+tH30
 pyJwFfHq8d+bYcGL7/XDDIRevPqeEMLd3l7yYCCsVLCVWSbtDqMcVcXCyrGl51fP4Ov8
 IX/XM/2jKpJbTIIujnULiHtdRF9VJgcCtjsn8phB8BP2jV3jiMyk/Y8GW60R2NjDykj4
 ideQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436985; x=1784041785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZGdEoi/5i/y3sm4j5VXZaVGF4cHAHnEbt/h0xQ/d1PY=;
 b=XxBsLD/Z6Ezec8o+a9MRyHYvKJP8d6xXMgJnlqwbP8Of/xCQrA7stFt34nW2lELQCJ
 8aRNPDlf37BGQoRNcoevieHYNNxCSf7wMYEFPbfx7zKmiNo1mdQCuV7eSAjb/4uJEMD0
 DBh05lJjEhhyTX7nLMlTl9UTQ1Ije0Yfa0knZJgomHMS8HO6GG5QdZIusc+aRSyLi+eb
 L3aDfDtl0asvsPsq79BAvIsN88yHnvCJgkqv1qy4KLRAkz/E9f9yFDgWop0cyNbTwXRK
 Teg/cXvdxCiIRXbMugcxWt27rmkbV3T/2oy/HzohhTl3MSu3SuPL4SxsiMAVQMkCXjvr
 3iug==
X-Gm-Message-State: AOJu0YydkqJ/Yhsx03pxrYhLetdKkXGO8PMOWVwXtjYB0HegWcHAxkMr
 ljMyqVg8Cou6aRNatF34zBEXHKkHkWUKcy4OI/zX/wtAxTFLF6XJgViJu//u5/Ypb8M4
X-Gm-Gg: AfdE7cnZxkZMOfvk48tRGHdTiEcBmW89eK2N4vavl0US86JRCi+CaUHNtGLBGgQtBLc
 u0Ew4lg1YdCBsdSin/mhkZxCFY0M+lILwG0Oj1ys5jql8+d2L4l2vDa/R5w/mYqn20dConBNxXt
 FvpphUbu5E74XpMk7D+R1Z3zVnxzQkwSXfwcU3Oi8aNrWWU70A+Eneevw6FEgbvEeCPsAE4e8jE
 wPdcZFOhHCR2mloSvJZ0mMJTAMBQVDI550E4aT/KfdUHgx5pdTPQ9zorisjelwrXEqS9wDBFA1G
 A0JLJfhe5XePtzgv7InIInWR51PIrPxA4I9OZuFTDHuzsSZTUaG+2HS4qlOsPAahHM8v48pCbhT
 o1EvFNNzAB0GkEIcTQeQf9TiQuvWsKDeDhb5WM13FaqUX3neSeUc8yp8SAOBGPxHzcSVTDx3rhE
 yyaS4RG74Gijz/mI75FimKFMsqlzg7ptUW0A==
X-Received: by 2002:a05:6a00:4515:b0:848:2f6e:e530 with SMTP id
 d2e1a72fcca58-8482f6f02e5mr3279472b3a.68.1783436985064; 
 Tue, 07 Jul 2026 08:09:45 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d4d000sm5646524b3a.34.2026.07.07.08.09.42
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:09:43 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 00:09:19 +0900
Message-ID: <20260707150920.6489-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] power_management: rewrite runpwtests04.sh in C
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
 runtest/power_management_tests                |  2 +-
 testcases/kernel/power_management/.gitignore  |  1 +
 testcases/kernel/power_management/cpuidle01.c | 90 +++++++++++++++++++
 .../kernel/power_management/runpwtests04.sh   | 58 ------------
 4 files changed, 92 insertions(+), 59 deletions(-)
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
index 000000000..919dd2b7c
--- /dev/null
+++ b/testcases/kernel/power_management/cpuidle01.c
@@ -0,0 +1,90 @@
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
+	bool is_writable;
+} tcases[] = {
+	{ "available_governors", false },
+	{ "current_driver", false },
+	{ "current_governor", true },
+	{ "current_governor_ro", false },
+};
+
+static int fd = -1;
+
+static void verify_cpuidle(unsigned int i)
+{
+	int ret;
+	char path[PATH_MAX];
+	char buf[32];
+
+	snprintf(path, sizeof(path), "%s/%s", CPUIDLE_PATH, tcases[i].name);
+
+	if (tcases[i].is_writable)
+		fd = open(path, O_RDWR);
+	else
+		fd = open(path, O_RDONLY);
+
+	if (fd < 0) {
+		if (errno == ENOENT)
+			tst_res(TCONF, "%s not available", path);
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
+	if (tcases[i].is_writable) {
+		if (write(fd, "invalid_governor", 16) < 0) {
+			if (errno == EINVAL)
+				tst_res(TPASS, "%s rejected invalid input with EINVAL", path);
+			else
+				tst_res(TFAIL | TERRNO, "%s rejected invalid input with unexpected errno", path);
+		} else {
+			tst_res(TFAIL, "%s accepted invalid input successfully", path);
+		}
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_cpuidle,
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
