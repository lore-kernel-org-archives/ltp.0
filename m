Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA21C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:34:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAE7C3C989E
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:33:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FB8F3C79FA
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:12 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D4CFB141D099
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C0C81F391;
 Mon, 10 Feb 2025 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFTDnSqz8P/7uJzgbWhwSrK8hOySvn3QHix5pphDaww=;
 b=h0MtcVItIbwGUDkYjwy2PZWV9Fr9eAL19Bzu6ZLVUY5C0wo5l6jc+t2CMCSzxcM87MGVhq
 QSw16O9+cXYSkWnzQbGjJJ+7J1QjjH1958dfGQPmhx8oyUmaAflZMVcqLnIYL/tB41U4yL
 cM42jy50jq2WDZ1mO5DMU3OCtJVfGZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFTDnSqz8P/7uJzgbWhwSrK8hOySvn3QHix5pphDaww=;
 b=IVRxild9ngDTzkED18GBbZLYq1e5Pkea/Oh1Y62bhehcaW6M2n54Qi9vn36wRNnIND0h4w
 GEMUhZhOFpwekgBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFTDnSqz8P/7uJzgbWhwSrK8hOySvn3QHix5pphDaww=;
 b=h0MtcVItIbwGUDkYjwy2PZWV9Fr9eAL19Bzu6ZLVUY5C0wo5l6jc+t2CMCSzxcM87MGVhq
 QSw16O9+cXYSkWnzQbGjJJ+7J1QjjH1958dfGQPmhx8oyUmaAflZMVcqLnIYL/tB41U4yL
 cM42jy50jq2WDZ1mO5DMU3OCtJVfGZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFTDnSqz8P/7uJzgbWhwSrK8hOySvn3QHix5pphDaww=;
 b=IVRxild9ngDTzkED18GBbZLYq1e5Pkea/Oh1Y62bhehcaW6M2n54Qi9vn36wRNnIND0h4w
 GEMUhZhOFpwekgBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C4D413A62;
 Mon, 10 Feb 2025 11:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aPCBGbvjqWf0YQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:11 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:05 +0100
Message-ID: <20250210113212.29520-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250210113212.29520-1-chrubis@suse.cz>
References: <20250210113212.29520-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 06/13] testcases/kernel/mem: Move check_hugepage()
 + PATH_THP
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

These were only used in thp testcases, also after this the mem library
is no longer needed in thp tests so it's removed from the Makefile.

Also note that PATH_HUGEPAGES is defined in tst_hugepage.h which is
included by tst_test.h so we can just remove this macro.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/include/mem.h |  7 -------
 testcases/kernel/mem/lib/mem.c     |  6 ------
 testcases/kernel/mem/thp/Makefile  |  2 +-
 testcases/kernel/mem/thp/thp.h     | 17 +++++++++++++++++
 testcases/kernel/mem/thp/thp01.c   |  1 -
 testcases/kernel/mem/thp/thp02.c   |  3 ++-
 testcases/kernel/mem/thp/thp03.c   |  5 +++--
 7 files changed, 23 insertions(+), 18 deletions(-)
 create mode 100644 testcases/kernel/mem/thp/thp.h

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 03dbe91d7..ba5a996a7 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -52,17 +52,10 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages);
 void ksm_group_check(int run, int pg_shared, int pg_sharing, int pg_volatile,
                      int pg_unshared, int sleep_msecs, int pages_to_scan);
 
-/* THP */
-
-#define PATH_THP		"/sys/kernel/mm/transparent_hugepage/"
-#define PATH_KHPD		PATH_THP "khugepaged/"
-
 /* HUGETLB */
 
-#define PATH_HUGEPAGES		"/sys/kernel/mm/hugepages/"
 #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
 
-void check_hugepage(void);
 void write_memcg(void);
 
 /* cpuset/memcg - include/tst_cgroup.h */
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index de9388a80..02199349d 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -324,12 +324,6 @@ static void verify(char **memory, char value, int proc,
 	free(s);
 }
 
-void check_hugepage(void)
-{
-	if (access(PATH_HUGEPAGES, F_OK))
-		tst_brk(TCONF, "Huge page is not supported.");
-}
-
 struct ksm_merge_data {
 	char data;
 	unsigned int mergeable_size;
diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
index e95712eaf..d89ea1dd3 100644
--- a/testcases/kernel/mem/thp/Makefile
+++ b/testcases/kernel/mem/thp/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir		?= ../../../..
 thp04:			LDLIBS += -lrt
+thp04:			CFLAGS += -pthread
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/thp/thp.h b/testcases/kernel/mem/thp/thp.h
new file mode 100644
index 000000000..7723bedc2
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2011-2021
+ * Copyright (c) Cyril Hrubis 2024
+ */
+#ifndef THP_H
+#define THP_H
+
+#define PATH_THP "/sys/kernel/mm/transparent_hugepage/"
+
+static inline void check_hugepage(void)
+{
+        if (access(PATH_HUGEPAGES, F_OK))
+                tst_brk(TCONF, "Huge page is not supported.");
+}
+
+#endif /* THP_H */
diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
index 69825b0f9..bdb2c54db 100644
--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -38,7 +38,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "tst_test.h"
-#include "mem.h"
 #include "tst_minmax.h"
 
 #define ARGS_SZ	(256 * 32)
diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
index 56568d1d1..c6f9d2fd5 100644
--- a/testcases/kernel/mem/thp/thp02.c
+++ b/testcases/kernel/mem/thp/thp02.c
@@ -38,7 +38,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "mem.h"
+#include "tst_test.h"
+#include "thp.h"
 
 static int ps;
 static long hps, size;
diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
index 839efcb0e..e8d22669e 100644
--- a/testcases/kernel/mem/thp/thp03.c
+++ b/testcases/kernel/mem/thp/thp03.c
@@ -36,7 +36,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
-#include "mem.h"
+#include "tst_test.h"
+#include "thp.h"
 #include "lapi/mmap.h"
 
 static void thp_test(void);
@@ -83,7 +84,7 @@ static void setup(void)
 
 	check_hugepage();
 
-	hugepage_size = SAFE_READ_MEMINFO("Hugepagesize:") * KB;
+	hugepage_size = SAFE_READ_MEMINFO("Hugepagesize:") * TST_KB;
 	unaligned_size = hugepage_size * 4 - 1;
 	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
 }
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
