Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF6606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QgpjYzwe
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D01C53C01A0
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 03:44:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3BD03C01A0
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:43:36 +0100 (CET)
Received: from mta0.migadu.com (out-111.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::6f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2167E60065E
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:43:35 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=G4VJBK1MZj3X4ruj4vDcz1XKgYlP34d5Nt97PVsYecc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793587414; v=1; x=1794192214;
 b=QgpjYzweudH0tUXHpE+TQTS9+X+vGS5hA6Dyv5M7DrVrtuGQ3XxRbfqYaAP3cLp8X/t/D1No
 DQyk73i3P0N1XFNT9yJ6taxAMCg26smDUZqUVBKOSsIw3zKYQQOmge/RLQ8uB1NjprBNU8XELEC
 nQbwr29kiOZD2qndo/4N0a34=
X-Envelope-To: ltp@lists.linux.it
Received: by mta11.migadu.com with ESMTPS id 10655048bc16de58;
 Mon, 02 Nov 2026 02:43:34 +0000
X-Mizu-Trace-ID: 10655048bc16de58
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Mon,  2 Nov 2026 10:43:25 +0800
Message-ID: <20261102024328.115105-2-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102024328.115105-1-li.wang@linux.dev>
References: <20261102024328.115105-1-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/4] lib: add module is loaded check
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

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
