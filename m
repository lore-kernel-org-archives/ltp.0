Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618F2C0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:32:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C20D23C98B6
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:32:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BE143C79FA
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:11 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 672F8231819
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 830521F390;
 Mon, 10 Feb 2025 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilnCaveSbYo2h3dEjoisn6ciodPhxKiie6vvhy25ZWg=;
 b=iY6CY7Jgs6x2IecOgNBUI6k3eGeu+QdhSOFg2SaaoO3aYUUwjhSMQbihhclC88L1C0ZWXD
 N+PSjhQFmCNWH7Ak3EGj4LMB1BiTC9hFc4h9ZfxejQqh5GrIFbc9jFuM9mVfHZahj4S5Pc
 SqvNLF5Aek4f1KC6NN36N/kRPefxBtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilnCaveSbYo2h3dEjoisn6ciodPhxKiie6vvhy25ZWg=;
 b=mOlc7EIpXfflbemPRNPg7W6CpYPTD66HLLvpxH9CTnkvqxwPGXtkwUbit6PM9UiWxQo6Zs
 Vrdux+F1GyWoMSCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iY6CY7Jg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mOlc7EIp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilnCaveSbYo2h3dEjoisn6ciodPhxKiie6vvhy25ZWg=;
 b=iY6CY7Jgs6x2IecOgNBUI6k3eGeu+QdhSOFg2SaaoO3aYUUwjhSMQbihhclC88L1C0ZWXD
 N+PSjhQFmCNWH7Ak3EGj4LMB1BiTC9hFc4h9ZfxejQqh5GrIFbc9jFuM9mVfHZahj4S5Pc
 SqvNLF5Aek4f1KC6NN36N/kRPefxBtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilnCaveSbYo2h3dEjoisn6ciodPhxKiie6vvhy25ZWg=;
 b=mOlc7EIpXfflbemPRNPg7W6CpYPTD66HLLvpxH9CTnkvqxwPGXtkwUbit6PM9UiWxQo6Zs
 Vrdux+F1GyWoMSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7271F13AAB;
 Mon, 10 Feb 2025 11:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XzfcGrnjqWfmYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:00 +0100
Message-ID: <20250210113212.29520-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250210113212.29520-1-chrubis@suse.cz>
References: <20250210113212.29520-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 830521F390
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/13] lib: tst_sys_conf: Add two functions
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

Add two functions to read/write integer values from/to sysfs or procfs
files.

With that we replace the get_sys_tune() and set_sys_tune() from
testcases/kernel/mem/lib/mem.c with a better implementation.

We also remove the inclusion of the mem library from tunables, since
it's no longer needed there.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_sys_conf.h                        | 32 +++++++++++++++++++
 lib/tst_sys_conf.c                            | 29 +++++++++++++++++
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       |  2 +-
 testcases/kernel/mem/include/mem.h            |  2 --
 testcases/kernel/mem/lib/mem.c                | 29 -----------------
 testcases/kernel/mem/oom/oom01.c              | 10 +++---
 testcases/kernel/mem/tunable/Makefile         |  1 -
 testcases/kernel/mem/tunable/max_map_count.c  | 17 ++++++----
 .../kernel/mem/tunable/min_free_kbytes.c      | 27 ++++++++--------
 .../kernel/mem/tunable/overcommit_memory.c    | 23 +++++++------
 10 files changed, 105 insertions(+), 67 deletions(-)

diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
index 6bbf39672..a221a9a0d 100644
--- a/include/tst_sys_conf.h
+++ b/include/tst_sys_conf.h
@@ -30,4 +30,36 @@ void tst_sys_conf_dump(void);
 
 int tst_read_bool_sys_param(const char *filename);
 
+/**
+ * TST_SYS_CONF_LONG_SET() - Writes a long int into a sys or proc file.
+ *
+ * @path: A path to a sysfs or a procfs file.
+ * @val: A long int value to be written to the file.
+ * @check: If non-zero the library reads the file back and checks that the
+ *         value is the one we have written there. If not the library calls
+ *         tst_brk(TBROK, ...).
+ *
+ * Sets a sysfs or procfs file and optionally checks that it was set correctly.
+ */
+#define TST_SYS_CONF_LONG_SET(path, val, check) \
+	tst_sys_conf_long_set_(__FILE__, __LINE__, path, val, check)
+
+void tst_sys_conf_long_set_(const char *file, const int lineno,
+			    const char *path, long val, int check);
+
+
+/**
+ * TST_SYS_CONF_LONG_GET() - Reads a long int from sys or proc file.
+ *
+ * @path: A path to a sysfs or a procfs file.
+ * return: A value read from the file converted into a long.
+ *
+ * Gets a sysfs or procfs file value and converts it to long.
+ */
+#define TST_SYS_CONF_LONG_GET(path) \
+	tst_sys_conf_long_get_(__FILE__, __LINE__, path)
+
+long tst_sys_conf_long_get_(const char *file, const int lineno,
+			    const char *path);
+
 #endif
diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index 91203ea9e..80cd83569 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -180,3 +180,32 @@ int tst_read_bool_sys_param(const char *filename)
 	/* Assume that any other value than 0 or N means the param is enabled */
 	return 1;
 }
+
+long tst_sys_conf_long_get_(const char *file, const int lineno,
+			    const char *path)
+{
+	long ret;
+
+	safe_file_scanf(file, lineno, NULL, path, "%ld", &ret);
+
+	return ret;
+}
+
+void tst_sys_conf_long_set_(const char *file, const int lineno,
+			    const char *path, long val, int check)
+{
+	tst_res_(file, lineno, TINFO, "Setting %s to %ld", path, val);
+
+	safe_file_printf(file, lineno, NULL, path, "%ld", val);
+
+	if (check) {
+		long read_val;
+
+		safe_file_scanf(file, lineno, NULL, path, "%ld", &read_val);
+
+		if (val != read_val)
+			tst_brk_(file, lineno, TBROK,
+				 "Wrote %ld to %s but read back %ld",
+				 val, path, read_val);
+	}
+}
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 8ad745d5b..0d7bbf64f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -82,7 +82,7 @@ static void setup(void)
 	long hpage_size, orig_hugepages;
 	unsigned long new_shmmax;
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
+	orig_hugepages = TST_SYS_CONF_LONG_GET("/proc/sys/vm/nr_hugepages");
 	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &new_shmmax);
 
 	if (new_shmmax < SIZE)
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index cdc3ca146..865d2c7e8 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -71,8 +71,6 @@ void write_cpusets(const struct tst_cg_group *cg, long nd);
 /* shared */
 unsigned int get_a_numa_node(void);
 int  path_exist(const char *path, ...);
-void set_sys_tune(char *sys_file, long tune, int check);
-long get_sys_tune(char *sys_file);
 
 void update_shm_size(size_t *shm_size);
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index fbfeef026..3e0f5d1bb 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -638,35 +638,6 @@ int path_exist(const char *path, ...)
 	return access(pathbuf, F_OK) == 0;
 }
 
-void set_sys_tune(char *sys_file, long tune, int check)
-{
-	long val;
-	char path[BUFSIZ];
-
-	tst_res(TINFO, "set %s to %ld", sys_file, tune);
-
-	snprintf(path, BUFSIZ, PATH_SYSVM "%s", sys_file);
-	SAFE_FILE_PRINTF(path, "%ld", tune);
-
-	if (check) {
-		val = get_sys_tune(sys_file);
-		if (val != tune)
-			tst_brk(TBROK, "%s = %ld, but expect %ld",
-				 sys_file, val, tune);
-	}
-}
-
-long get_sys_tune(char *sys_file)
-{
-	char path[BUFSIZ];
-	long tune;
-
-	snprintf(path, BUFSIZ, PATH_SYSVM "%s", sys_file);
-	SAFE_FILE_SCANF(path, "%ld", &tune);
-
-	return tune;
-}
-
 void update_shm_size(size_t * shm_size)
 {
 	size_t shmmax;
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index ddb904459..4bca37963 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -18,18 +18,20 @@
 #include <unistd.h>
 #include "mem.h"
 
+#define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
+
 static void verify_oom(void)
 {
 	/* we expect mmap to fail before OOM is hit */
-	set_sys_tune("overcommit_memory", 2, 1);
+	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);
 	oom(NORMAL, 0, ENOMEM, 0);
 
 	/* with overcommit_memory set to 0 or 1 there's no
 	 * guarantee that mmap fails before OOM */
-	set_sys_tune("overcommit_memory", 0, 1);
+	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 0, 1);
 	oom(NORMAL, 0, ENOMEM, 1);
 
-	set_sys_tune("overcommit_memory", 1, 1);
+	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 1, 1);
 	testoom(0, 0, ENOMEM, 1);
 }
 
@@ -40,7 +42,7 @@ static struct tst_test test = {
 	.test_all = verify_oom,
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", NULL, TST_SR_TBROK},
+		{OVERCOMMIT_MEMORY, NULL, TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/tunable/Makefile b/testcases/kernel/mem/tunable/Makefile
index 80d64bb4a..e0014e683 100644
--- a/testcases/kernel/mem/tunable/Makefile
+++ b/testcases/kernel/mem/tunable/Makefile
@@ -4,5 +4,4 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index f33095473..71a7bbee0 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -48,10 +48,13 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/utsname.h>
-#include "mem.h"
+#include "tst_test.h"
 
 #define MAP_COUNT_DEFAULT	1024
-#define MAX_MAP_COUNT		65536L
+#define MAX_MAP_COUNT_MAX	65536L
+
+#define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
+#define MAX_MAP_COUNT "/proc/sys/vm/max_map_count"
 
 /* This is a filter to exclude map entries which aren't accounted
  * for in the vm_area_struct's map_count.
@@ -140,15 +143,15 @@ static void max_map_count_test(void)
 	memfree = SAFE_READ_MEMINFO("CommitLimit:") - SAFE_READ_MEMINFO("Committed_AS:");
 	/* 64 used as a bias to make sure no overflow happen */
 	max_iters = memfree / sysconf(_SC_PAGESIZE) * 1024 - 64;
-	if (max_iters > MAX_MAP_COUNT)
-		max_iters = MAX_MAP_COUNT;
+	if (max_iters > MAX_MAP_COUNT_MAX)
+		max_iters = MAX_MAP_COUNT_MAX;
 
 	max_maps = MAP_COUNT_DEFAULT;
 	if (max_iters < max_maps)
 		tst_brk(TCONF, "test requires more free memory");
 
 	while (max_maps <= max_iters) {
-		set_sys_tune("max_map_count", max_maps, 1);
+		TST_SYS_CONF_LONG_SET(MAX_MAP_COUNT, max_maps, 1);
 
 		switch (pid = SAFE_FORK()) {
 		case 0:
@@ -192,8 +195,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = max_map_count_test,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", "0", TST_SR_TBROK},
-		{"/proc/sys/vm/max_map_count", NULL, TST_SR_TBROK},
+		{OVERCOMMIT_MEMORY, "0", TST_SR_TBROK},
+		{MAX_MAP_COUNT, NULL, TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 65b467d60..68caf1b00 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -35,10 +35,14 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include "lapi/abisize.h"
-#include "mem.h"
+#include "tst_test.h"
 
 #define MAP_SIZE (1UL<<20)
 
+#define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
+#define MIN_FREE_KBYTES "/proc/sys/vm/min_free_kbytes"
+#define PANIC_ON_OOM "/proc/sys/vm/panic_on_oom"
+
 volatile int end;
 static long default_tune = -1;
 static unsigned long total_mem;
@@ -88,16 +92,13 @@ static void test_tune(unsigned long overcommit_policy)
 	int ret, i;
 	unsigned long tune, memfree, memtotal;
 
-	set_sys_tune("overcommit_memory", overcommit_policy, 1);
+	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, overcommit_policy, 1);
 
 	for (i = 0; i < 3; i++) {
-		/* case1 */
 		if (i == 0)
-			set_sys_tune("min_free_kbytes", default_tune, 1);
-		/* case2 */
+			TST_SYS_CONF_LONG_SET(MIN_FREE_KBYTES, default_tune, 1);
 		else if (i == 1) {
-			set_sys_tune("min_free_kbytes", 2 * default_tune, 1);
-			/* case3 */
+			TST_SYS_CONF_LONG_SET(MIN_FREE_KBYTES, 2 * default_tune, 1);
 		} else {
 			memfree = SAFE_READ_MEMINFO("MemFree:");
 			memtotal = SAFE_READ_MEMINFO("MemTotal:");
@@ -105,7 +106,7 @@ static void test_tune(unsigned long overcommit_policy)
 			if (tune > (memtotal / 50))
 				tune = memtotal / 50;
 
-			set_sys_tune("min_free_kbytes", tune, 1);
+			TST_SYS_CONF_LONG_SET(MIN_FREE_KBYTES, tune, 1);
 		}
 
 		fflush(stdout);
@@ -189,7 +190,7 @@ static void check_monitor(void)
 
 	while (end) {
 		memfree = SAFE_READ_MEMINFO("MemFree:");
-		tune = get_sys_tune("min_free_kbytes");
+		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
 
 		if (memfree < tune) {
 			tst_res(TINFO, "MemFree is %lu kB, "
@@ -208,14 +209,14 @@ static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
 
 static void setup(void)
 {
-	if (get_sys_tune("panic_on_oom")) {
+	if (TST_SYS_CONF_LONG_GET(PANIC_ON_OOM)) {
 		tst_brk(TCONF,
 			"panic_on_oom is set, disable it to run these testcases");
 	}
 
 	total_mem = SAFE_READ_MEMINFO("MemTotal:") + SAFE_READ_MEMINFO("SwapTotal:");
 
-	default_tune = get_sys_tune("min_free_kbytes");
+	default_tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
 }
 
 static struct tst_test test = {
@@ -225,8 +226,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = min_free_kbytes_test,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", NULL, TST_SR_TBROK},
-		{"/proc/sys/vm/min_free_kbytes", NULL, TST_SR_TBROK},
+		{OVERCOMMIT_MEMORY, NULL, TST_SR_TBROK},
+		{MIN_FREE_KBYTES, NULL, TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index d055dd18f..b5beebbcd 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -62,12 +62,15 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <limits.h>
-#include "mem.h"
+#include "tst_test.h"
 
 #define DEFAULT_OVER_RATIO	50L
 #define EXPECT_PASS		0
 #define EXPECT_FAIL		1
 
+#define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
+#define OVERCOMMIT_RATIO "/proc/sys/vm/overcommit_ratio"
+
 static char *R_opt;
 static long old_overcommit_ratio = -1;
 static long overcommit_ratio;
@@ -93,7 +96,7 @@ static void setup(void)
 	else
 		overcommit_ratio = DEFAULT_OVER_RATIO;
 
-	old_overcommit_ratio = get_sys_tune("overcommit_ratio");
+	old_overcommit_ratio = TST_SYS_CONF_LONG_GET(OVERCOMMIT_RATIO);
 
 	mem_total = SAFE_READ_MEMINFO("MemTotal:");
 	tst_res(TINFO, "MemTotal is %ld kB", mem_total);
@@ -115,7 +118,7 @@ static void setup(void)
 		SAFE_SETRLIMIT(RLIMIT_AS, &lim);
 	}
 
-	set_sys_tune("overcommit_ratio", overcommit_ratio, 1);
+	TST_SYS_CONF_LONG_SET(OVERCOMMIT_RATIO, overcommit_ratio, 1);
 
 	calculate_total_batch_size();
 	tst_res(TINFO, "TotalBatchSize is %ld kB", total_batch_size);
@@ -124,7 +127,7 @@ static void setup(void)
 static void overcommit_memory_test(void)
 {
 	/* start to test overcommit_memory=2 */
-	set_sys_tune("overcommit_memory", 2, 1);
+	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);
 
 	update_mem_commit();
 	alloc_and_check(commit_left * 2, EXPECT_FAIL);
@@ -133,14 +136,14 @@ static void overcommit_memory_test(void)
 	alloc_and_check(commit_left / 2, EXPECT_PASS);
 
 	/* start to test overcommit_memory=0 */
-	set_sys_tune("overcommit_memory", 0, 1);
+	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 0, 1);
 
 	update_mem();
 	alloc_and_check(free_total / 2, EXPECT_PASS);
 	alloc_and_check(sum_total * 2, EXPECT_FAIL);
 
 	/* start to test overcommit_memory=1 */
-	set_sys_tune("overcommit_memory", 1, 1);
+	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 1, 1);
 
 	alloc_and_check(sum_total / 2, EXPECT_PASS);
 	alloc_and_check(sum_total, EXPECT_PASS);
@@ -152,7 +155,7 @@ static int heavy_malloc(long size)
 {
 	char *p;
 
-	p = malloc(size * KB);
+	p = malloc(size * TST_KB);
 	if (p != NULL) {
 		tst_res(TINFO, "malloc %ld kB successfully", size);
 		free(p);
@@ -240,7 +243,7 @@ static void calculate_total_batch_size(void)
 	/* there are ncpu separate counters, that can all grow up to
 	 * batch_size. So the maximum error for __vm_enough_memory is
 	 * batch_size * ncpus. */
-	total_batch_size = (batch_size * ncpus * pagesize) / KB;
+	total_batch_size = (batch_size * ncpus * pagesize) / TST_KB;
 }
 
 static struct tst_test test = {
@@ -253,8 +256,8 @@ static struct tst_test test = {
 	.test_all = overcommit_memory_test,
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", NULL, TST_SR_TBROK},
-		{"/proc/sys/vm/overcommit_ratio", NULL, TST_SR_TBROK},
+		{OVERCOMMIT_MEMORY, NULL, TST_SR_TBROK},
+		{OVERCOMMIT_RATIO, NULL, TST_SR_TBROK},
 		{}
 	},
 };
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
