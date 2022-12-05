Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD05EC4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 06:58:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24B833CC203
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 07:58:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F12B83CC1E6
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 07:57:39 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7752680133C
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 07:57:36 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NQZ52081wzqSdy
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 14:53:26 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 14:57:33 +0800
To: <ltp@lists.linux.it>
Date: Mon, 5 Dec 2022 14:54:30 +0800
Message-ID: <20221205065432.242539-2-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221205065432.242539-1-zhaogongyi@huawei.com>
References: <20221205065432.242539-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] lib/safe_macros: Add SAFE_STRTOF
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a new macro SAFE_STRTOF, which is a safe mode of strtof().

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 include/safe_macros_fn.h  |  3 +++
 include/tst_safe_macros.h |  3 +++
 lib/safe_macros.c         | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 114d8fd43..d256091b7 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -133,6 +133,9 @@ unsigned long safe_strtoul(const char *file, const int lineno,
                            void (cleanup_fn)(void),
                            char *str, unsigned long min, unsigned long max);

+float safe_strtof(const char *file, const int lineno,
+                 void (cleanup_fn)(void), char *str, float min, float max);
+
 long safe_sysconf(const char *file, const int lineno,
 		  void (cleanup_fn)(void), int name);

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index ab00dd14a..0cf3d7878 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -186,6 +186,9 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
 #define SAFE_STRTOUL(str, min, max) \
 	safe_strtoul(__FILE__, __LINE__, NULL, (str), (min), (max))

+#define SAFE_STRTOF(str, min, max) \
+	safe_strtof(__FILE__, __LINE__, NULL, (str), (min), (max))
+
 #define SAFE_SYSCONF(name) \
 	safe_sysconf(__FILE__, __LINE__, NULL, name)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index d8816631f..0fb5580ac 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -21,6 +21,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <malloc.h>
+#include <math.h>
 #include "test.h"
 #include "safe_macros.h"

@@ -629,6 +630,38 @@ unsigned long safe_strtoul(const char *file, const int lineno,
 	return rval;
 }

+float safe_strtof(const char *file, const int lineno,
+		  void (cleanup_fn) (void), char *str,
+		  float min, float max)
+{
+	float rval;
+	char *endptr;
+
+	errno = 0;
+	rval = strtof(str, &endptr);
+
+	if (errno) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"strtof(%s) failed", str);
+		return rval;
+	}
+
+	if (endptr == str || (*endptr != '\0' && *endptr != '\n')) {
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"Invalid value: '%s'", str);
+		return 0;
+	}
+
+	if (rval > max || rval < min) {
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"strtof(%s): %f is out of range %f - %f",
+			str, rval, min, max);
+		return 0;
+	}
+
+	return rval;
+}
+
 long safe_sysconf(const char *file, const int lineno,
 		  void (cleanup_fn) (void), int name)
 {
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
