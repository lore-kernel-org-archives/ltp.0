Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0F606A336
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mBtKsMmM
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BEA73EA62A
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 05:18:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E4D93E24B2
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 05:18:22 +0200 (CEST)
Received: from mta1.migadu.com (out-180.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CF847100095A
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 05:18:21 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=Ttxnz7iDdLM3eOIBwO8vaR2om4l6fBlAh0bmOiWbrRg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792552700; v=1; x=1793157500;
 b=mBtKsMmMo4bsTecn/jPIzTahkfYlxd2ulJzL8G50EMwNx/rv4P2Y+UxQXHiZsupwBipzqZFm
 KHHPdM8TwUpxEA9SLTUPcVn8ZCNf9nFIJ5N5wS2rW+QMIz6PuxLRoPgJs00dwsEs3+OAEeQvAyK
 +BVV1H2NTPTAmKQMQwS4Ui/g=
X-Envelope-To: ltp@lists.linux.it
Received: by mta11.migadu.com with ESMTPS id dacb3c180373debe;
 Wed, 21 Oct 2026 03:18:20 +0000
X-Mizu-Trace-ID: dacb3c180373debe
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Wed, 21 Oct 2026 11:18:15 +0800
Message-ID: <20261021031816.166499-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] lib: add a checked-attribute counter to sysfs
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

Notes:
    v4:
        - drop the silent_attr_exists() helper, bump the counter
          directly after the existence check in each silent assertion,
          which also keeps the cmp_silent counting consistent.

 include/tst_sysfs_assert.h | 11 +++++++++++
 lib/tst_sysfs_assert.c     | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

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
index 98680e976..4a34acc35 100644
--- a/lib/tst_sysfs_assert.c
+++ b/lib/tst_sysfs_assert.c
@@ -15,6 +15,8 @@
 #include "tst_test.h"
 #include "tst_sysfs_assert.h"
 
+static unsigned int tst_sysfs_cnt;
+
 static void build_path(char *path, size_t size, const char *fmt, va_list ap)
 {
 	vsnprintf(path, size, fmt, ap);
@@ -98,6 +100,8 @@ void tst_sysfs_assert_rangell_silent(const char *file, const int lineno,
 	if (access(path, F_OK))
 		return;
 
+	tst_sysfs_cnt++;
+
 	range_check(file, lineno, path, min, max);
 }
 
@@ -156,6 +160,8 @@ void tst_sysfs_assert_rangeuu_silent(const char *file, const int lineno,
 	if (access(path, F_OK))
 		return;
 
+	tst_sysfs_cnt++;
+
 	range_check_u(file, lineno, path, min, max);
 }
 
@@ -242,6 +248,8 @@ void tst_sysfs_assert_bool_silent(const char *file, const int lineno,
 	if (access(path, F_OK))
 		return;
 
+	tst_sysfs_cnt++;
+
 	bool_check(file, lineno, path);
 }
 
@@ -684,6 +692,8 @@ void tst_sysfs_assert_cmp_silent(const char *file, const int lineno,
 	if (access(path1, F_OK) || access(path2, F_OK))
 		return;
 
+	tst_sysfs_cnt++;
+
 	tst_sysfs_assert_cmp(file, lineno, path1, op, path2);
 }
 
@@ -869,3 +879,13 @@ unsigned long tst_sysfs_read_lx(const char *file, const int lineno,
 
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
