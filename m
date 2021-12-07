Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841E3C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 13:24:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5173C3C5706
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 14:24:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DF8D3C5384
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:24:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A6A7C1400F5E
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:24:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B51D51FDFE;
 Tue,  7 Dec 2021 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638883458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j7OxcYdVLvQ4pwNkXNmuJ10GBxKCS+XYSU5oSExmzlU=;
 b=adkt1NR4OqdgM9jb1cs2Xlt5ZR2C+wNJRWSMJimP7KcZDyGQ5KZjaYskzXzvsjC1pJ/sWy
 u2aVGtlbQyLl9g4Vj9W2pYzDIV9zl0f3axXXrObcTfT0Z/rPJPy4H25NBvPpPinnlG1Gm7
 Lb4KRyTsLj6gFrJnXIGQ6f2Y+/Wwa2Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A96F13A7E;
 Tue,  7 Dec 2021 13:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pKOwH4Jgr2F+SAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 07 Dec 2021 13:24:18 +0000
To: ltp@lists.linux.it
Date: Tue,  7 Dec 2021 14:24:16 +0100
Message-Id: <20211207132416.10050-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add tst_parse_filesize functionality in LTP test
 API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_test.h               |   1 +
 lib/newlib_tests/test_tst_test.c | 122 +++++++++++++++++++++++++++++++
 lib/tst_test.c                   |  41 +++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 lib/newlib_tests/test_tst_test.c

diff --git a/include/tst_test.h b/include/tst_test.h
index c06a4729b..450ddf086 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -122,6 +122,7 @@ struct tst_option {
 int tst_parse_int(const char *str, int *val, int min, int max);
 int tst_parse_long(const char *str, long *val, long min, long max);
 int tst_parse_float(const char *str, float *val, float min, float max);
+int tst_parse_filesize(const char *str, long long *val, long long min, long long max);
 
 struct tst_tag {
 	const char *name;
diff --git a/lib/newlib_tests/test_tst_test.c b/lib/newlib_tests/test_tst_test.c
new file mode 100644
index 000000000..8ee4e2932
--- /dev/null
+++ b/lib/newlib_tests/test_tst_test.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*
+ * Tests for tst_parse_filesize.
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+    long long val = 0;
+    int ret = 0;
+
+    if ((ret = tst_parse_filesize("1", &val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        if (val == 1)
+            tst_res(TPASS, "value is %lli", val);
+        else
+            tst_res(TFAIL, "%lli != %lli", val, 1);
+    }
+
+    /* small letters */
+    if ((ret = tst_parse_filesize("1k", &val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        if (val == 1024)
+            tst_res(TPASS, "value is %lli", val);
+        else
+            tst_res(TFAIL, "%lli != %lli", val, 1024);
+    }
+
+    if ((ret = tst_parse_filesize("1m", &val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        if (val == 1048576)
+            tst_res(TPASS, "value is %lli", val);
+        else
+            tst_res(TFAIL, "%lli != %lli", val, 1048576);
+    }
+
+    if ((ret = tst_parse_filesize("1g", &val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        if (val == 1073741824)
+            tst_res(TPASS, "value is %lli", val);
+        else
+            tst_res(TFAIL, "%lli != %lli", val, 1073741824);
+    }
+
+    /* big letters */
+    if ((ret = tst_parse_filesize("1K", &val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        if (val == 1024)
+            tst_res(TPASS, "value is %lli", val);
+        else
+            tst_res(TFAIL, "%lli != %lli", val, 1024);
+    }
+
+    if ((ret = tst_parse_filesize("1M", &val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        if (val == 1048576)
+            tst_res(TPASS, "value is %lli", val);
+        else
+            tst_res(TFAIL, "%lli != %lli", val, 1048576);
+    }
+
+    if ((ret = tst_parse_filesize("1G", &val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        if (val == 1073741824)
+            tst_res(TPASS, "value is %lli", val);
+        else
+            tst_res(TFAIL, "%lli != %lli", val, 1073741824);
+    }
+
+    /* test errors */
+    if ((ret = tst_parse_filesize("k", &val, LLONG_MIN, LLONG_MAX))) {
+        if (ret == EINVAL)
+            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
+        else
+            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        tst_res(TFAIL, "tst_parse_filesize should have failed");
+    }
+
+    if ((ret = tst_parse_filesize("100", &val, LLONG_MIN, 10))) {
+        if (ret == ERANGE)
+            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
+        else
+            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        tst_res(TFAIL, "tst_parse_filesize should have failed");
+    }
+
+    if ((ret = tst_parse_filesize("10", &val, 100, LLONG_MAX))) {
+        if (ret == ERANGE)
+            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
+        else
+            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        tst_res(TFAIL, "tst_parse_filesize should have failed");
+    }
+
+    if ((ret = tst_parse_filesize("10garbage", &val, LLONG_MIN, LLONG_MAX))) {
+        if (ret == EINVAL)
+            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
+        else
+            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
+    } else {
+        tst_res(TFAIL, "tst_parse_filesize should have failed");
+    }
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index a79275722..78b107ed0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -679,6 +679,47 @@ int tst_parse_float(const char *str, float *val, float min, float max)
 	return 0;
 }
 
+int tst_parse_filesize(const char *str, long long *val, long long min, long long max)
+{
+	long long rval;
+	char *end;
+
+	if (!str)
+		return 0;
+
+	errno = 0;
+	rval = strtoll(str, &end, 0);
+
+	if (str == end || (strlen(end) != 0 && strlen(end) != 1))
+		return EINVAL;
+
+	if (errno)
+		return errno;
+
+	switch (*end) {
+	case 'g':
+	case 'G':
+		rval *= (1024 * 1024 * 1024);
+		break;
+	case 'm':
+	case 'M':
+		rval *= (1024 * 1024);
+		break;
+	case 'k':
+	case 'K':
+		rval *= 1024;
+		break;
+	default:
+		break;
+	}
+
+	if (rval > max || rval < min)
+		return ERANGE;
+
+	*val = rval;
+	return 0;
+}
+
 static void print_colored(const char *str)
 {
 	if (tst_color_enabled(STDOUT_FILENO))
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
