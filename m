Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA143CD4F3C
	for <ltp@archiver.kernel.org>; Sat, 16 May 2026 20:01:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6109A3E57B6
	for <ltp@archiver.kernel.org>; Sat, 16 May 2026 22:01:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20F853E2418
 for <ltp@lists.linux.it>; Sat, 16 May 2026 22:00:42 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 76FBC1A00718
 for <ltp@lists.linux.it>; Sat, 16 May 2026 22:00:41 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-83945063f70so1006804b3a.0
 for <ltp@lists.linux.it>; Sat, 16 May 2026 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778961639; x=1779566439; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AgilemdE+A7tRn/9YUwTFyBmNqmUuAB6egoWFyGooPI=;
 b=sU79hiMSPJrUWomrMZIroP8fa86p0rzJdby/MQm0PB+WmIH/bRjkZgiQ/n1pkZpnrt
 DsBiZV6VTjHN7P0vhcQTrOLMqUrGHr3HZs1Al7MQEN3VZ47TEhMMp9UEYuq3IGsF1QBc
 QBdLXvVQmfoqvFkJqLWphh0pHrJTvEHWfBufgjE3yGov/onBt6lAzSD/grH2fDblKKfR
 VA8slbWd4q9rAFDSErDIGeKVi9yFs70P2ivj93JVpa4ronr9aDTCClqrJ7/nLjIbGFUB
 aU5iFHZ/8wBSSVP0vLiX7PtoBtlESDYABxEtVK4SWdOxaojeTGoP9jzo5TiluW3XCbYD
 U8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778961639; x=1779566439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgilemdE+A7tRn/9YUwTFyBmNqmUuAB6egoWFyGooPI=;
 b=TpL7+l3K2tT/u2cNVpc9TmvDBWfFqLiKrmBgG2Re+V/Im+jze2vCDD/R8SNlFWQwuh
 lKcjFJdxiv/NGIY1C+vXqjj2TZUSknkazZoMUXZdccI5d8Zikq0TZVrhJE7or8JUJ3IH
 kzwW7F4Cxfcu5gNTYARNXRgsumC0EyH+dX7hGywRVm994mGRVbTo5mIk5iHm7vtK68XT
 OM5yv39t4fHRbJ8RGmszdFH3xUed8naZTJMTXUYyVUS9bk6V8AFif8m+PsYJdZzix6sa
 eKbsX4rUaz6ghaQmFtKdwkWTlAQx07WBkqnLfsJNYog/Lg2V+ff7OzANHlfCOqoH3Q1F
 Nmkg==
X-Gm-Message-State: AOJu0Yx70OYIc6GjiFjwUy8DBaF197RnDVPtq2WP0clFefAdTdYJf9J1
 SYZX+eG3ipEYR6UhEED6LmXQrhaZYA2zJDePwefU/qt3Fk3A+wLShlJAXY6tg5cDIg==
X-Gm-Gg: Acq92OGyEbOysuSaFBW5R4svC6cbZzp2FakgwDg/dq/GBzwQldtPdEoIo96NyoMc5qn
 OPX+Tls0a3BbR77mRq0C5a3VQoucb6rHtunHEcZQmebRKUE53dtxh7ZGYhULDNCAaRehfoWPXqb
 xJMXf5xzDvm5Gra+befq2dg5OGykIDoyh/mRRvcBtaj3rzveW6iu4r7IKxZX/XnBOR6zNznjMTL
 kR/MEQTnB5snOl02CryCU/2EglRi44sptYYojE3ZHFiupC1mdE8gmqj326UekxO5pjg9X15rDyu
 iFwceQTZP0mWDu4aYOh9ApORttFwbfHSsdpoCZXdEHIpmaSvP7jXIQMR+hWBthiuNzGP1Tasrou
 icumdoNi3OvS03+etTXC8BPwiZKVQiZOdBKNe2upi5CuMjD+Mw5xaG15Cd1h3htG//wTA6jkixO
 sz4WGtA1iHGVgyyDS5di6OAvwqNTKdY9kB7nrrlSdZULsveRLdlXk2
X-Received: by 2002:a05:6a20:3950:b0:398:6fff:3dc0 with SMTP id
 adf61e73a8af0-3b0c009cf58mr13096953637.24.1778961639152; 
 Sat, 16 May 2026 13:00:39 -0700 (PDT)
Received: from localhost.localdomain ([1.232.225.242])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb121ccasm8750030a12.29.2026.05.16.13.00.38
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 13:00:38 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 17 May 2026 05:00:12 +0900
Message-ID: <20260516200015.12689-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] power_management: rewrite runpwtests04.sh in C
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

Convert the cpuidle sysfs smoke test from shell to C using the modern
LTP test API.

The new implementation preserves the original test semantics
while removing shell dependencies.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/power_management/.gitignore  |  1 +
 testcases/kernel/power_management/cpuidle01.c | 52 +++++++++++++++++
 .../kernel/power_management/runpwtests04.sh   | 58 -------------------
 3 files changed, 53 insertions(+), 58 deletions(-)
 create mode 100644 testcases/kernel/power_management/.gitignore
 create mode 100644 testcases/kernel/power_management/cpuidle01.c
 delete mode 100755 testcases/kernel/power_management/runpwtests04.sh

diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
new file mode 100644
index 000000000..48c0938dd
--- /dev/null
+++ b/testcases/kernel/power_management/.gitignore
@@ -0,0 +1 @@
+/cpuidle01
diff --git a/testcases/kernel/power_management/cpuidle01.c b/testcases/kernel/power_management/cpuidle01.c
new file mode 100644
index 000000000..90d05ee05
--- /dev/null
+++ b/testcases/kernel/power_management/cpuidle01.c
@@ -0,0 +1,52 @@
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
+static struct tcases {
+	const char *name;
+} tcases[] = {
+	{ "current_governor_ro" },
+	{ "current_driver" },
+};
+
+static void verify_cpuidle(unsigned int i)
+{
+	int fd;
+	char path[PATH_MAX];
+	char buf[32];
+
+	snprintf(path, sizeof(path), "%s/%s", CPUIDLE_PATH, tcases[i].name);
+
+	fd = SAFE_OPEN(path, O_RDONLY);
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
+static struct tst_test test = {
+	.setup = setup,
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
