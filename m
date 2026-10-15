Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70873CC6B34
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 07:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C32F93E6A03
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 09:59:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEA9A3E6A02
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 09:58:48 +0200 (CEST)
Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AF2541401236
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 09:58:46 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=ybHoZpO6oL6NDpPIkeg+JetFFNK2jobF203EtBD/O+A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792051126; v=1; x=1792655926;
 b=t0ZGsZf4o/ZhnK4xjq553ho+Y2W45OJm7s+AMJhCqefuhfjvB3MMZoafttBualEXSDdB3kVI
 DdSUQt4rQrFS321TLGUXFPAPaClljR5K6I4gLLqmn5u5v2PJYxNLpX1Fo2/aMnXW9K8zIlFIfWa
 SaVJ1W6AO6M82kcOq5hjqsuI=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id faac2090f91424ef;
 Thu, 15 Oct 2026 07:58:46 +0000
X-Mizu-Trace-ID: faac2090f91424ef
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu, 15 Oct 2026 15:58:09 +0800
Message-ID: <20261015075812.184811-2-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015075812.184811-1-li.wang@linux.dev>
References: <20261015075812.184811-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/4] lib: add module is loaded check
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
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: "Li Wang (Hieco)" <li.wang@linux.dev>

Add a helper that checks whether a kernel module is loaded by
looking it up in /proc/modules. Module names are normalized so that
hyphens match the underscores used by the kernel.

Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 include/tst_module.h |  1 +
 lib/tst_module.c     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/tst_module.h b/include/tst_module.h
index e55321d19..9b789e289 100644
--- a/include/tst_module.h
+++ b/include/tst_module.h
@@ -49,5 +49,6 @@ static inline void tst_requires_module_signature_disabled(void)
 
 void tst_modprobe(const char *mod_name, char *const argv[]);
 void tst_module_reload(const char *mod_name, char *const argv[]);
+bool tst_module_is_loaded(const char *mod_name);
 
 #endif /* TST_MODULE_H */
diff --git a/lib/tst_module.c b/lib/tst_module.c
index cbd2415d5..db341ec57 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -21,6 +21,7 @@
  */
 
 #define _GNU_SOURCE
+#include <ctype.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -174,3 +175,41 @@ void tst_module_reload(const char *mod_name, char *const argv[])
 	tst_module_unload_(NULL, mod_name);
 	tst_modprobe(mod_name, argv);
 }
+
+bool tst_module_is_loaded(const char *mod_name)
+{
+	char line[4096];
+	size_t mod_len = strlen(mod_name);
+	FILE *file;
+
+	file = fopen("/proc/modules", "r");
+	if (!file)
+		return false;
+
+	while (fgets(line, sizeof(line), file)) {
+		char *p = line;
+		size_t i;
+
+		while (*p && !isspace(*p))
+			p++;
+
+		if ((size_t)(p - line) != mod_len)
+			continue;
+
+		for (i = 0; i < mod_len; i++) {
+			char a = (line[i] == '-') ? '_' : line[i];
+			char b = (mod_name[i] == '-') ? '_' : mod_name[i];
+
+			if (a != b)
+				break;
+		}
+
+		if (i == mod_len) {
+			fclose(file);
+			return true;
+		}
+	}
+
+	fclose(file);
+	return false;
+}
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
