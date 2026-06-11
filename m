Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53685CD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 14:59:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 860A13CB3C2
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 16:59:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6363C1C6B
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:59:39 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F0AB11000761
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:59:37 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-8423f626a65so3558512b3a.2
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781189976; x=1781794776; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Fds8HZrme6bHhwYHYKXeI41NhIk1Sns1c7PQ6ejhQk=;
 b=KnvyPJ5j88v6B5ty2V1No7tbZICiMhmzmwMc9eLNkNYSJZVH7tEdKrX+quM+V+lpXD
 Qb6mJUrd6wrDJFvvG4q3bpB4sniqIsnuOKjnl/l8+JAs13WORXoa+ziXk2BiSyJid4nP
 c+42bX6mAbxNPpCOXfwmkcPKDNto+7/9OZl9AN+a7YAXr4cw+/Pke1uMsxbVhZjLxu0J
 VlYqhC0vy1fjfyq8cIcgjvm94wUCjvrWKaEsnLGATXt9vGwQ5Ao5vYZuc0+n0aBvoxQC
 9ccBFvonOtpQGUVNpIBsN0HK7TS84NdO/66J//4b6oJqFUHgdplm4aMs9aH/YOiddH0n
 yiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781189976; x=1781794776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Fds8HZrme6bHhwYHYKXeI41NhIk1Sns1c7PQ6ejhQk=;
 b=WZA0qU62yFIrv5EvIm3OavVYTmnwm1zy8xm0Ihmnr5ZvWT0WeZeOMx80G0Om1Uw10l
 0EdiULCezZgxu+GtrxzF8O58Eq72HT0805OesndRHmN8hd1w0ea8qQ/hYXuhhFwet4EL
 nvSZ93mm7CYq1EYzjSKxjwqZo8/MlbujmOJsv3joeEAE9MeKLD6SI7fGjpMbHTcR7w41
 AvhgPCx6qZFAfcmtdl5yQBdMcEbrn1JPkwF7n+dCmqhx4tq5b9Gj/AEMvt0ib5314QdV
 Gj5XXWRnzDb+6nDpCl0tN8Wh06WnPzhUCR7OEHnCCXyK7sOfVZG8xTPeHw0spn/xhLWC
 v+gg==
X-Gm-Message-State: AOJu0YwlsMUv3vMpSXznxhAYAUyV4bOtFT+1LrtOZSLzNp/FAlP5UJb0
 kqxKXQsCLwo4eAM8L5sFNA0RXPYR+EAY0tbm2uvdIYgdcy94m8WojCWCVzC3uNFldA==
X-Gm-Gg: Acq92OE5b3ufsC32Vq4iFd8lTojAPl3JOdjPcV8Y7qhvXrv4+FQObWhFqAmHBunBHbe
 TDkHyaLNUJ8aaDn/68DvoJt3oQjmrTOj3pXvwpWWFPGS7rBzbGk5aF6xSB2c0igGRdflCRljHqa
 bIzdN5x1pVtCBglY13PR+yaHXK3zVVzfFd1APZwyntdtVZvSTVd9SC0fHtqLhviX1I9FUxgGvsY
 mwHY9r/bHAriS81EjsCG5uEjO2dGuA48tuWCwfI6xybVOgJcjMdnjkhbi+fLCn2xJ0P7kPMaFur
 k9AuHwGpjmX3LG8ErJciFPX26IVlsnLcTzYF6A0jwOgwVi1U0H4w7nzFsyDRfZrZAobwqaP635Y
 r09EUF/uVeTJpBBDj7yaMwJjd/kyxHb5S4ab4AGqcUYuCbvWhQs4czMNqY0rCna8szsmhQllVSL
 V8yCEcalxFrXsGA5kzo4x+pCrFCelSq4uY7geA9cMZsML77Stqq0MQmx0=
X-Received: by 2002:a05:6a00:4b10:b0:842:5931:7b8c with SMTP id
 d2e1a72fcca58-843367ec11emr3568047b3a.1.1781189976254; 
 Thu, 11 Jun 2026 07:59:36 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84337b916cesm2853805b3a.8.2026.06.11.07.59.35
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:59:35 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 11 Jun 2026 23:59:10 +0900
Message-ID: <20260611145911.3752-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] power_management: rewrite runpwtests04.sh in C
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
Changes in v3:
- Replac SAFE_OPEN() with open() to convert ENOENT to TCONF.
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
 create mode 100644 testcases/kernel/power_management/.gitignore
 create mode 100644 testcases/kernel/power_management/pwtests01.c
 delete mode 100755 testcases/kernel/power_management/runpwtests04.sh

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index b670da6ec..4246a16d4 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,4 +1,4 @@
 #POWER_MANAGEMENT
+pwtests01 pwtests01
 runpwtests03 runpwtests03.sh
-runpwtests04 runpwtests04.sh
 runpwtests06 runpwtests06.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
new file mode 100644
index 000000000..33a901350
--- /dev/null
+++ b/testcases/kernel/power_management/.gitignore
@@ -0,0 +1 @@
+/pwtests01
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
