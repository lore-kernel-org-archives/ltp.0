Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3550FC0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:33:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94FAC3C98B0
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:33:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E40623C79FA
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 67C161400042
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF9FC1F391;
 Mon, 10 Feb 2025 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pxg4SuK9+godEm823VZ98fcge+I4wzQmHmaQ3ItrFA=;
 b=acGTKIFrvYtsV10zIeAFvFDAfShDZHlUPiuUPajLhFxahaATU+dD5LeiI26MzWPDUnlTwa
 9LKgMgggTljAUv3BD1iv0MsWxeDMei7N2UgwD5AfUp1ac2H/q4DRtsFPBJWQOrIUEk5BcK
 KGSAQyi/GQK2XaAHQdqZOlR4yV09oVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pxg4SuK9+godEm823VZ98fcge+I4wzQmHmaQ3ItrFA=;
 b=qYRclWtRF5FaMYcKXA/xm9+A6SbGUocv6AxJzFuPW/+/jjeqq+869+6kJ4vpMgKOgIfCqb
 4zTPmuuQDjRNU5Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=acGTKIFr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qYRclWtR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pxg4SuK9+godEm823VZ98fcge+I4wzQmHmaQ3ItrFA=;
 b=acGTKIFrvYtsV10zIeAFvFDAfShDZHlUPiuUPajLhFxahaATU+dD5LeiI26MzWPDUnlTwa
 9LKgMgggTljAUv3BD1iv0MsWxeDMei7N2UgwD5AfUp1ac2H/q4DRtsFPBJWQOrIUEk5BcK
 KGSAQyi/GQK2XaAHQdqZOlR4yV09oVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pxg4SuK9+godEm823VZ98fcge+I4wzQmHmaQ3ItrFA=;
 b=qYRclWtRF5FaMYcKXA/xm9+A6SbGUocv6AxJzFuPW/+/jjeqq+869+6kJ4vpMgKOgIfCqb
 4zTPmuuQDjRNU5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1ED313A62;
 Mon, 10 Feb 2025 11:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0xamMrnjqWfrYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:01 +0100
Message-ID: <20250210113212.29520-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250210113212.29520-1-chrubis@suse.cz>
References: <20250210113212.29520-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DF9FC1F391
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/13] lib: Replace path_exist() with
 tst_path_exists()
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

Move and rename the path_exist() function from
testcases/kernel/mem/lib/ to the to level library.

This removes mem.h dependency from mem/cpuset/ test.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_fs.h                       | 10 ++++++++++
 lib/tst_path_exists.c                  | 23 +++++++++++++++++++++++
 testcases/kernel/mem/cpuset/Makefile   |  2 +-
 testcases/kernel/mem/cpuset/cpuset01.c |  5 +++--
 testcases/kernel/mem/include/mem.h     |  1 -
 testcases/kernel/mem/lib/mem.c         | 18 +++---------------
 6 files changed, 40 insertions(+), 19 deletions(-)
 create mode 100644 lib/tst_path_exists.c

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 835f3511c..19c240e07 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -145,6 +145,16 @@ int tst_dir_is_empty_(void (*cleanup)(void), const char *name, int verbose);
  */
 int tst_get_path(const char *prog_name, char *buf, size_t buf_len);
 
+/**
+ * tst_path_exists() - checks if path exists
+ *
+ * @fmt: A printf-like format used to construct the path.
+ * @...: A printf-like parameter list.
+ * return: Non-zero if path exists, zero otherwise.
+ */
+int tst_path_exists(const char *fmt, ...)
+    __attribute__ ((format (printf, 1, 2)));
+
 /*
  * Fill a file with specified pattern
  * @fd: file descriptor
diff --git a/lib/tst_path_exists.c b/lib/tst_path_exists.c
new file mode 100644
index 000000000..333c4b0e5
--- /dev/null
+++ b/lib/tst_path_exists.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2011-2021
+ * Copyright (c) Cyril Hrubis <chrubis@suse.cz> 2024
+ */
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <limits.h>
+#include "tst_fs.h"
+
+int tst_path_exists(const char *fmt, ...)
+{
+        va_list ap;
+        char pathbuf[PATH_MAX];
+
+        va_start(ap, fmt);
+        vsnprintf(pathbuf, sizeof(pathbuf), fmt, ap);
+        va_end(ap);
+
+        return access(pathbuf, F_OK) == 0;
+}
diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
index 8e41c0223..bac13e02b 100644
--- a/testcases/kernel/mem/cpuset/Makefile
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -20,5 +20,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 956ac30c8..e70c7c7dc 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -30,7 +30,8 @@
 #include <numaif.h>
 #endif
 
-#include "mem.h"
+#include "../include/mem.h"
+#include "tst_test.h"
 #include "numa_helper.h"
 
 #ifdef HAVE_NUMA_V2
@@ -164,7 +165,7 @@ static long count_cpu(void)
 {
 	int ncpus = 0;
 
-	while (path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+	while (tst_path_exists(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
 		ncpus++;
 
 	return ncpus;
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 865d2c7e8..87528fdd0 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -70,7 +70,6 @@ void write_cpusets(const struct tst_cg_group *cg, long nd);
 
 /* shared */
 unsigned int get_a_numa_node(void);
-int  path_exist(const char *path, ...);
 
 void update_shm_size(size_t *shm_size);
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 3e0f5d1bb..f293e766e 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -545,19 +545,19 @@ static void gather_node_cpus(char *cpus, long nd)
 	char buf[BUFSIZ];
 	char path[BUFSIZ], path1[BUFSIZ];
 
-	while (path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+	while (tst_path_exists(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
 		ncpus++;
 
 	for (i = 0; i < ncpus; i++) {
 		snprintf(path, BUFSIZ,
 			 PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i);
-		if (path_exist(path)) {
+		if (tst_path_exists("%s", path)) {
 			snprintf(path1, BUFSIZ, "%s/online", path);
 			/*
 			 * if there is no online knob, then the cpu cannot
 			 * be taken offline
 			 */
-			if (path_exist(path1)) {
+			if (tst_path_exists("%s", path1)) {
 				SAFE_FILE_SCANF(path1, "%ld", &online);
 				if (online == 0)
 					continue;
@@ -626,18 +626,6 @@ unsigned int get_a_numa_node(void)
 	abort();
 }
 
-int path_exist(const char *path, ...)
-{
-	va_list ap;
-	char pathbuf[PATH_MAX];
-
-	va_start(ap, path);
-	vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
-	va_end(ap);
-
-	return access(pathbuf, F_OK) == 0;
-}
-
 void update_shm_size(size_t * shm_size)
 {
 	size_t shmmax;
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
