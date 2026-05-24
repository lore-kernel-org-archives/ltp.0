Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF107CD5BAB
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 15:43:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5DE43E9E42
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 17:43:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 412303C9769
 for <ltp@lists.linux.it>; Sun, 24 May 2026 17:42:50 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E50CD1400170
 for <ltp@lists.linux.it>; Sun, 24 May 2026 17:42:48 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-836ebdeb969so4024722b3a.3
 for <ltp@lists.linux.it>; Sun, 24 May 2026 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779637367; x=1780242167; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xrYZLemoqzX0weBJIMQPQCeHaAJFsItoVFER1s6SYeI=;
 b=BHMc7QXfqz5uCjbJ7gugqKShZHErZCSKVpUHuD9PXJU2BtwkTYXbGSwu3hX+VVlyVH
 XBQxBY4j2bPp8gfBExCzDuwyA26NgPdfEW/kOkZ1Dks6lz5sciEKggmB0TnXwWfFhEkc
 TJ5Zrr1bhuxTslt/tQNegHyxCq9X7shOd3/V8MbQhY2yUM2JM0qVlmHP7XE9FortJamp
 tKz+ynqlmnH0qOZ23cRC5yV16UOVfUU3WbQLb7FvljJhpJLDihYd9JtbXy0vFpPPF6pO
 ivRN/YKx19oZoy/9+K4rfw7h038ZMjYjud/35a4eNLsRZ+RJo6/IaFhtFsEPiOAJnXaw
 A0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779637367; x=1780242167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xrYZLemoqzX0weBJIMQPQCeHaAJFsItoVFER1s6SYeI=;
 b=Ge42mIJVW4jKiaKTtAtC2evt4n4oyKXthHY0vctWdAVeRD1H7Vo0fSW7WQcP9Bih1R
 gLp9Pq3hhQl/7aOiqkxITkHP5H4lK87rAzcXfwb0bPfkLZidxKTzHdKUlMDevyIBK+zI
 dGvaBCKwDCMUmkI965ocQbWsub7AAGAicHdWpAuRh23bWM9eZ3JT+5I3cjBCluMIF5KC
 OZfP6lqZzEqo8YP6rS/3R0G2d5ulDgSSUTxeL1y3j7kjfJNtoFTG28J+02J/VtXc9WAA
 VM0+Jka7j3I6WqRgUuoZEvCht5D98B6JR4G5DQwDld7kBvhvjK6j/Jcewr0gqkm6ZZAW
 88sA==
X-Gm-Message-State: AOJu0Yz3AO8v6O/NASET50IZ0zzAn5xL8CAUkZ6cWVQOfKtDVhKdKapH
 tJUfb50Z+Qj2gUcinPqUwbYZoz0EcsiQyL7qyTTTCK9vZVox7zi4VBzIw1aOB6BkAg==
X-Gm-Gg: Acq92OGKTFhq7hNsBft9GAmrw4qVjN8qIOUBwsd/+JQcBYiEv27ymCr+jqM12Q4N3cK
 E3nJGPyP9p1NcFLwe1KKjHG91YXrBQRUJhFnc4WTHKhI7deEJQdKLMF/DSbWk7Eax6LacQ5Nnze
 SHOevgxeoYDIY/HD8BWp+HbQXhhb7JKPWYZkenddBCxIK470pKN4aNgEIdzB/c9nQ2SWCzFvUF/
 X/ueKYFwPkphhTCRoT8gCm1GBqp1zCearduOZw5JlJYa7ZSzME64ZQnbavWMnS1QTy231S3mGPP
 mNWNvtZ9ZL+BgKDajlT5gbbukr8DZzQCUIOD5Ii2UY8eZfGbvQDycDfHqcozfACclWTKuYRuhnu
 CNHUnRM1U/woz2A1/g+n+Ul2+ePVSFxJR4TgZTRHGQVxckBnTnrH4g2ExPh9v7bR29EmADEpT6J
 WrxioQ+FXSHDx6Or317vDRqTYErYrcTpPSzvzdgko9v6atox4aOub0
X-Received: by 2002:a05:6a00:950f:b0:82f:7ba2:e120 with SMTP id
 d2e1a72fcca58-8415f32f096mr10588548b3a.28.1779637366977; 
 Sun, 24 May 2026 08:42:46 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9e635sm7773503b3a.38.2026.05.24.08.42.45
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 08:42:46 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 00:42:20 +0900
Message-ID: <20260524154221.2064-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] power_management: rewrite runpwtests04.sh in C
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
Changes in v2:
- Update runtest entry
- Clarify commit message
- Link to v1 : https://lore.kernel.org/ltp/20260516200015.12689-1-always.starving0@gmail.com
---
 runtest/power_management_tests                |  2 +-
 testcases/kernel/power_management/.gitignore  |  1 +
 testcases/kernel/power_management/pwtests01.c | 52 +++++++++++++++++
 .../kernel/power_management/runpwtests04.sh   | 58 -------------------
 4 files changed, 54 insertions(+), 59 deletions(-)
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
index 000000000..90d05ee05
--- /dev/null
+++ b/testcases/kernel/power_management/pwtests01.c
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
