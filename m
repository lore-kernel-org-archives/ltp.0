Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C896DC433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 06:13:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 400FA3C974A
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 07:13:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D793C3C96C0
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D57110006A1
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:08 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B1AA021921;
 Thu, 27 Jan 2022 06:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643263987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CU37hbo2o5J4fj6vIv/MqGp+YElKsr4wEuMIDGj4Lu4=;
 b=KZgcYaXOeK7m5YMAzIvR7Cl2kObjb1kEttluTZkqZMRySdif/1I2K4SRn3Dc6iLFLjFqi9
 7Y2DznlHYeFrj+wJCzUCGweBPwk55eabR9JBn4T4uJwnFnmlpHAdQESp59ICEQYS2UGDai
 1nvlNdwbfFMGDjUYStjZDAPV4M57+z0=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id 801A2A3B81;
 Thu, 27 Jan 2022 06:13:07 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 06:12:22 +0000
Message-Id: <20220127061225.23368-4-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127061225.23368-1-rpalethorpe@suse.com>
References: <20220127061225.23368-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] memcontrol: Lift out some common definitions into
 a shared header
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some simple functions can be shared between tests. The original
selftests share a bit more. However this doesn't make as much sense in
LTP due to library differences.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../kernel/controllers/memcg/memcontrol02.c   | 32 +------------
 .../controllers/memcg/memcontrol_common.h     | 48 +++++++++++++++++++
 2 files changed, 49 insertions(+), 31 deletions(-)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol_common.h

diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 548f36829..d5a24cc0a 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -23,14 +23,7 @@
  */
 #define _GNU_SOURCE
 
-#include <stdlib.h>
-#include <stdio.h>
-
-#include "tst_test.h"
-#include "tst_cgroup.h"
-
-#define TMPDIR "mntdir"
-#define MB(x) (x << 20)
+#include "memcontrol_common.h"
 
 static size_t page_size;
 static const struct tst_cgroup_group *cg_test;
@@ -38,20 +31,6 @@ static struct tst_cgroup_group *cg_child;
 static int fd;
 static int file_to_all_error = 10;
 
-/*
- * Checks if two given values differ by less than err% of their
- * sum. An extra percent is added for every doubling of the page size
- * to compensate for wastage in page sized allocations.
- */
-static inline int values_close(const ssize_t a,
-			       const ssize_t b,
-			       const ssize_t err)
-{
-	const ssize_t page_adjusted_err = ffs(page_size >> 13) + err;
-
-	return 100 * labs(a - b) <= (a + b) * page_adjusted_err;
-}
-
 static void alloc_anon_50M_check(void)
 {
 	const ssize_t size = MB(50);
@@ -78,15 +57,6 @@ static void alloc_anon_50M_check(void)
 		     current, anon);
 }
 
-static void alloc_pagecache(const int fd, size_t size)
-{
-	char buf[BUFSIZ];
-	size_t i;
-
-	for (i = 0; i < size; i += sizeof(buf))
-		SAFE_WRITE(1, fd, buf, sizeof(buf));
-}
-
 static void alloc_pagecache_50M_check(void)
 {
 	const size_t size = MB(50);
diff --git a/testcases/kernel/controllers/memcg/memcontrol_common.h b/testcases/kernel/controllers/memcg/memcontrol_common.h
new file mode 100644
index 000000000..67f3ca318
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/memcontrol_common.h
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdlib.h>
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "tst_cgroup.h"
+
+#define TMPDIR "mntdir"
+#define MB(x) (x << 20)
+
+/*
+ * Checks if two given values differ by less than err% of their
+ * sum. An extra percent is added for every doubling of the page size
+ * to compensate for wastage in page sized allocations.
+ */
+static inline int values_close(const ssize_t a,
+			       const ssize_t b,
+			       const ssize_t err)
+{
+	const size_t page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	const ssize_t page_adjusted_err = ffs(page_size >> 13) + err;
+
+	return 100 * labs(a - b) <= (a + b) * page_adjusted_err;
+}
+
+static inline void alloc_pagecache(const int fd, size_t size)
+{
+	char buf[BUFSIZ];
+	size_t i;
+
+	SAFE_LSEEK(fd, 0, SEEK_END);
+
+	for (i = 0; i < size; i += sizeof(buf))
+		SAFE_WRITE(1, fd, buf, sizeof(buf));
+}
+
+static inline void alloc_anon(const size_t size)
+{
+	const size_t page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	char *const buf = SAFE_MALLOC(size);
+	size_t i;
+
+	for (i = 0; i < size; i += page_size)
+		buf[i] = 0;
+
+	free(buf);
+}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
