Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E9606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wHBjWby/
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2BE53EAF73
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 04:59:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC3803E9AC9
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 04:59:22 +0200 (CEST)
Received: from mta0.migadu.com (out-248.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::f8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 03184600736
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 04:59:21 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=Se4sDrdfPGqMuT7qj8xTUhDKAwsg9zuoC/uIfBpIGok=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792551560; v=1; x=1793156360;
 b=wHBjWby/ke3fI5qYqWTNIL8t4FZaSpaYY+bRiLw3EjGNQZQwEngiY8/IXF7ML0ptF+DirHhX
 4cYIB27KDGhebVLpuukIaN60NrGu4hBOiSrNqNNT1XeP4ugTsYx1f0j9dg/cVB4+j0ZyB4VuVBk
 x1xjHHscrQNdBbBLGjYn2Sts=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id c25b5cce21bb6321;
 Wed, 21 Oct 2026 02:59:19 +0000
X-Mizu-Trace-ID: c25b5cce21bb6321
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Wed, 21 Oct 2026 10:59:10 +0800
Message-ID: <20261021025911.165250-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] lib: add a checked-attribute counter to sysfs
 assert helpers
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The TST_SYSFS_ASSERT_*_SILENT() assertions skip silently when the
attribute does not exist. A test that only uses SILENT assertions can
therefore finish without reporting a single result on machines where
none of the probed attributes are present, which the library turns
into:

    tst_test.c:1730: TBROK: Test haven't reported results!

Add a counter that is bumped every time a SILENT assertion finds the
attribute and actually checks it, regardless of whether the check
passes or fails (failures produce TFAIL on their own). Tests can reset
it at the start, then report a TPASS summary or a TCONF based on the
final count.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>
---
 include/tst_sysfs_assert.h | 11 +++++++++++
 lib/tst_sysfs_assert.c     | 29 ++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/tst_sysfs_assert.h b/include/tst_sysfs_assert.h
index b21c09849..d2a010d80 100644
--- a/include/tst_sysfs_assert.h
+++ b/include/tst_sysfs_assert.h
@@ -649,4 +649,15 @@ long tst_sysfs_read_li(const char *file, const int lineno,
 unsigned long tst_sysfs_read_lx(const char *file, const int lineno,
 	const char *fmt, ...);
 
+/**
+ * tst_sysfs_cnt_reset() - Reset the checked-attribute counter.
+ */
+void tst_sysfs_cnt_reset(void);
+
+/**
+ * tst_sysfs_cnt_get() - Number of attributes the *_SILENT assertions
+ * found and checked (pass or fail) since the last reset.
+ */
+unsigned int tst_sysfs_cnt_get(void);
+
 #endif /* TST_SYSFS_ASSERT_H__ */
diff --git a/lib/tst_sysfs_assert.c b/lib/tst_sysfs_assert.c
index 98680e976..a50412a45 100644
--- a/lib/tst_sysfs_assert.c
+++ b/lib/tst_sysfs_assert.c
@@ -15,6 +15,17 @@
 #include "tst_test.h"
 #include "tst_sysfs_assert.h"
 
+static unsigned int tst_sysfs_cnt;
+
+static int silent_attr_exists(const char *path)
+{
+	if (access(path, F_OK))
+		return 0;
+
+	tst_sysfs_cnt++;
+	return 1;
+}
+
 static void build_path(char *path, size_t size, const char *fmt, va_list ap)
 {
 	vsnprintf(path, size, fmt, ap);
@@ -95,7 +106,7 @@ void tst_sysfs_assert_rangell_silent(const char *file, const int lineno,
 	build_path(path, sizeof(path), fmt, ap);
 	va_end(ap);
 
-	if (access(path, F_OK))
+	if (!silent_attr_exists(path))
 		return;
 
 	range_check(file, lineno, path, min, max);
@@ -153,7 +164,7 @@ void tst_sysfs_assert_rangeuu_silent(const char *file, const int lineno,
 	build_path(path, sizeof(path), fmt, ap);
 	va_end(ap);
 
-	if (access(path, F_OK))
+	if (!silent_attr_exists(path))
 		return;
 
 	range_check_u(file, lineno, path, min, max);
@@ -239,7 +250,7 @@ void tst_sysfs_assert_bool_silent(const char *file, const int lineno,
 	build_path(path, sizeof(path), fmt, ap);
 	va_end(ap);
 
-	if (access(path, F_OK))
+	if (!silent_attr_exists(path))
 		return;
 
 	bool_check(file, lineno, path);
@@ -684,6 +695,8 @@ void tst_sysfs_assert_cmp_silent(const char *file, const int lineno,
 	if (access(path1, F_OK) || access(path2, F_OK))
 		return;
 
+	tst_sysfs_cnt++;
+
 	tst_sysfs_assert_cmp(file, lineno, path1, op, path2);
 }
 
@@ -869,3 +882,13 @@ unsigned long tst_sysfs_read_lx(const char *file, const int lineno,
 
 	return val;
 }
+
+void tst_sysfs_cnt_reset(void)
+{
+	tst_sysfs_cnt = 0;
+}
+
+unsigned int tst_sysfs_cnt_get(void)
+{
+	return tst_sysfs_cnt;
+}
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
