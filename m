Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A22CA6002
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 05:22:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B8AD3E2A46
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 07:22:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0598A3E2A7E
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 07:22:02 +0200 (CEST)
Received: from mta1.migadu.com (out-214.mta1.migadu.com
 [IPv6:2001:41d0:203:375::d6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22D7C60066C
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 07:22:00 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=zXfQWcRW8QXnDxERk6p6chTIVuCn9r7u2TviGFuGBu4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791436920; v=1; x=1792041720;
 b=aqcHRDfkU/NhrRvoj6GCsqf9oTqLFxJ0PserawrT7CCcJjbPD8RHoqSwUMxIdsUYoR5+Shlm
 JN8+Ae6cyXalish5/nN5Nj8CiCXqzp2aAfFB9QpX1BQurS1q5hQbHBiFswQLlq/lmjaXHTneWRP
 y/T78OQC1UGkr8jSsaOfDvfA=
X-Envelope-To: ltp@lists.linux.it
Received: by mta11.migadu.com with ESMTPS id a950f534376a6be7;
 Thu, 08 Oct 2026 05:22:00 +0000
X-Mizu-Trace-ID: a950f534376a6be7
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu,  8 Oct 2026 13:21:38 +0800
Message-ID: <20261008052141.129763-2-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008052141.129763-1-li.wang@linux.dev>
References: <20261008052141.129763-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch v2 1/4] lib: add module is loaded check
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

Add a helper that checks whether a kernel module is loaded by
looking it up in /proc/modules. Module names are normalized so that
hyphens match the underscores used by the kernel.

Signed-off-by: Li Wang <li.wang@linux.dev>
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
