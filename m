Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EA2C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 14:53:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 067013E7160
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 16:52:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68F893E2EEA
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:52:42 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 642B3200ADD
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:52:40 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc2c6e0688so9410015ad.0
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785941559; x=1786546359; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3sR1CY+PiQAiFPtEa8N1bCcqJ5M+Z7YyWlRRJJED2GM=;
 b=YpnjQyZfUMlMVMu7PQR+OVgYdHYoEsdfQq5PybtOxApsXhz5Db0EDE/yeIrIZifPhT
 zgr7NNVa40DW+lttt/Bdf9UPaYuNwF7NBg+arVpyQl0CG3nM3MSLr5crJRc+9IgUhboE
 aplqKK9GC5NjjJYM56w9LhPB2zDhM4UvLHVKD3IKfCF9cQJer+jiuZvlygo0J9lcdKJX
 rl+JTLnG9E7V1RRDdH8Aq5zHfrc80fLcvuuY5wAb3G0EcWzZyeY9Kfyg3nU0WgS8sC8u
 T1w5dBC6ykcScqFtW7ahz82FGI7FNYQMOZOOlcZuyidd1f2cFNJ7aWEkTTqaJjIiuy/x
 yl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785941559; x=1786546359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3sR1CY+PiQAiFPtEa8N1bCcqJ5M+Z7YyWlRRJJED2GM=;
 b=a/PcNOmO+wqrP5n1LuStTfSiwD6xldoNucCJXDBkfrAzAOaoQvyuchdDK7woOm4cMS
 B8+YpkBqncd+SzhG0ymh6LwCTdjrDmKvIb5YqnM5S1fhzrxOcxSeL/WBhCDICLtSmT6g
 AF9rvpD51MbrJ3OFJCiHFn4XzUeRWjpicmEwhBGLMz6S5Bu01sWe6Guo8JTKSuGbvfH6
 S0QF2Zcddqiouk1FHe1gqCKa1Kk5Rrem2DVdOLpKIr23VQIpDuCjsj5IYpkFJc61aT+g
 R1ZbW3wNlAtajNmFTYfA2v5wW/p7T202w89ar2YTZp231yx2UmeJRT2d8N55PJMHfO5s
 aHGw==
X-Gm-Message-State: AOJu0YwLikulDSY5fab4T4r3jW6Um0pHzDqpfs588hHZ6NXApj60U0Iq
 FCaXOBcBStp5sLv/55SYLn5grUoHe5jMtJMwdAhXLLZQlLo3oI42BAqqkZdlRnNpLAq1
X-Gm-Gg: AR+sD11M4S9jjbyQBegFvMERbYjYHtKKe86NPiFOyUdNhrx6+SQ6Oa+hpmFjOvoDSIC
 s8BwuMZnwJparRVuQqWjnfpzdUO8GLAREvFJhbhC5J2+d1ziDDNH6XQKYdkTepKagWV94DKPB3s
 Cl9rvzWwigT8DPt+15Gr6KUU7DQxgTHsppf6vpnDr9Sa00XppmYAdtYK7/jDG18SIL5qtdngPyB
 kikKbZ+y6hZ6K+Ol8kg3WsjRnLf1+yZeC0ubVwiDocKTQdiMgFBjW6bcrpqjaXqTOb+xC+trAqt
 N/6TGaAygasSzygpzzzQS4+hpb+OqeqJeZF04Iw4xtyzyE2YtV9MC2cS6iXS8EZZ90R45S4j7+O
 6a/zAAmD4QaYvhspDwdBXI0HyakZ1ml3LHxqwmmM5a10XwRwA08Ob7SM5AosLz1BFqJG+0B4vuZ
 fXOgJ6Z9Sm5hcfntDRvepr/GNxF1Rno1o9xvKVIn3WMQCZt4M9+As5eZ44kQkzJBeVSVnjzEZIA
 mlCfLdvWw==
X-Received: by 2002:a17:902:dad1:b0:2ca:1479:d9dc with SMTP id
 d9443c01a7336-2d0ca76b482mr78684815ad.12.1785941558535; 
 Wed, 05 Aug 2026 07:52:38 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9f8fb4bsm18242505ad.5.2026.08.05.07.52.37
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:52:37 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 23:52:12 +0900
Message-ID: <20260805145213.3066-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] power_management: rewrite runpwtests04.sh in C
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

Rewrite the cpuidle sysfs smoke test using the LTP C API.

Keep the existing readability checks for current_governor_ro and
current_driver, and extend the coverage to available_governors and
current_governor. Also verify that writing an invalid governor to
current_governor is rejected with EINVAL.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
Changes in v8:
- Reword the commit message to describe the extended test coverage.
- Remove unnecessary save/restore for current_governor.
- Sort and anchor .gitignore entries.
- Link to v7: https://lore.kernel.org/ltp/20260729112916.4958-1-always.starving0@gmail.com

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
 testcases/kernel/power_management/.gitignore  |   3 +-
 testcases/kernel/power_management/cpuidle01.c | 102 ++++++++++++++++++
 .../kernel/power_management/runpwtests04.sh   |  58 ----------
 4 files changed, 105 insertions(+), 60 deletions(-)
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
index 03f0c83e4..052696dc5 100644
--- a/testcases/kernel/power_management/.gitignore
+++ b/testcases/kernel/power_management/.gitignore
@@ -1 +1,2 @@
-high_freq_hwp_cap_cppc
+/cpuidle01
+/high_freq_hwp_cap_cppc
diff --git a/testcases/kernel/power_management/cpuidle01.c b/testcases/kernel/power_management/cpuidle01.c
new file mode 100644
index 000000000..7e7b8d01f
--- /dev/null
+++ b/testcases/kernel/power_management/cpuidle01.c
@@ -0,0 +1,102 @@
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
+ * Root privileges are required to write to current_governor.
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
