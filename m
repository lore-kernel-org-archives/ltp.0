Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AF9C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:16:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE5983E56DC
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:16:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ECBD3E56E2
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:15:31 +0200 (CEST)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 389EB600077
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:15:31 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784024130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wuGPa6mq0WKUH0Er1oPWbTAAMafUlkrvZ6eWu7vsw8=;
 b=cuE1M2dyT59tCgKr4EdsNhO3w4fqlWdPCrUFx1e/PjeXgoEzAAsfKVlw2HsW+qhBnz1lPq
 x38o+JXIvUcYsRITlLX7lTP8f4EhznULlegNhsS856f+1a5PEzeu8blS+q32stg+HzAf3T
 QbmUI94rutZ2AHj8W9xmfnsUI+Cls8A=
From: Gang Yan <gang.yan@linux.dev>
To: ltp@lists.linux.it
Date: Tue, 14 Jul 2026 18:14:53 +0800
Message-ID: <20260714101454.8784-3-gang.yan@linux.dev>
In-Reply-To: <20260714101454.8784-1-gang.yan@linux.dev>
References: <20260714101454.8784-1-gang.yan@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] generate_syscall.sh: add a helper named
 tst_syscall_base
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
Cc: Gang Yan <yangang@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Gang Yan <yangang@kylinos.cn>

This patch adds a helper named tst_syscall_base, it can check the
syscall on older distros without tst_brk.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 include/lapi/syscalls/generate_syscalls.sh | 27 +++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
index 19f280dfb..95c2c9aeb 100755
--- a/include/lapi/syscalls/generate_syscalls.sh
+++ b/include/lapi/syscalls/generate_syscalls.sh
@@ -49,18 +49,23 @@ tst_brkm(TCONF, dummy_cleanup, \
 })
 #endif
 
+#define tst_syscall_base(NR, ...) ({ \
+    intptr_t tst_ret; \
+    if (NR == __LTP__NR_INVALID_SYSCALL) { \
+        errno = ENOSYS; \
+        tst_ret = -1; \
+    } else { \
+        tst_ret = syscall(NR, ##__VA_ARGS__); \
+    } \
+    tst_ret; \
+})
+
 #define tst_syscall(NR, ...) ({ \
-intptr_t tst_ret; \
-if (NR == __LTP__NR_INVALID_SYSCALL) { \
-	errno = ENOSYS; \
-	tst_ret = -1; \
-} else { \
-	tst_ret = syscall(NR, ##__VA_ARGS__); \
-} \
-if (tst_ret == -1 && errno == ENOSYS) { \
-	TST_SYSCALL_BRK__(NR, #NR); \
-} \
-tst_ret; \
+    intptr_t tst_ret = tst_syscall_base(NR, ##__VA_ARGS__); \
+    if (tst_ret == -1 && errno == ENOSYS) { \
+        TST_SYSCALL_BRK__(NR, #NR); \
+    } \
+    tst_ret; \
 })
 
 #define __LTP__NR_INVALID_SYSCALL -1' >${SYSCALLS_FILE}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
