Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84056CCFA07
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 09:43:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4F1B3CE3C5
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 10:43:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC49C3CB4E5
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 10:43:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DDB991A00782
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 10:43:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 219DB1F394;
 Wed,  5 Nov 2025 09:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1762335804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rFBTVTLbhwhKPEoV3XZ3DijWnk0BKFPN3jRYIN4E//Y=;
 b=duYHUcQtzPoJFFqC0PDx+ab3Ry0qF+Ui12G/PeKOU8Bg0ErXug8ONE/fMmMcBSv+V7HV9n
 jQn5kPHu14QQjNpHbCfB07v9TRjWfpkz2UPZJNTjOR8mdHqLR4rHdZU4LM2g0EGv8s7Epf
 EvTpPYWkHwYAEsqY8YACiZqn/s4OcGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1762335804;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rFBTVTLbhwhKPEoV3XZ3DijWnk0BKFPN3jRYIN4E//Y=;
 b=CblSl7n/0FD/lXbBI+GUUACCoGK9+lNDnvPDAVR95tjjdFhYF1NGbmOHnR5GgvX03eFQ71
 rt2AewDW4R2v9ZAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1762335803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rFBTVTLbhwhKPEoV3XZ3DijWnk0BKFPN3jRYIN4E//Y=;
 b=bqKwZUn9XYdA1flZMhFy/2yeiXekgxaUVwXIb7wvEr3EFJiwrCVDSkSBbcE2HbghjE++11
 hMqCPjLSYm9Zrzj4nRqCDZ0GoVSwmnofDxF2cATTa9Bv/hxHfZ3/Bzi7R/mfYajqzb37I5
 gJ1Vv/mvCOzygYQyXnxMNLNhT1mSam0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1762335803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rFBTVTLbhwhKPEoV3XZ3DijWnk0BKFPN3jRYIN4E//Y=;
 b=mEBWhw8CLX2FaFiTiUtR9dOATCfROT3nMlVFGb1C3wNut+/h47iZz5YMhdLlb5cfrKr9lu
 tBNH3Byrujti3QCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 070D4132DD;
 Wed,  5 Nov 2025 09:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P3YKADscC2kRKgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 05 Nov 2025 09:43:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 05 Nov 2025 10:43:21 +0100
MIME-Version: 1.0
Message-Id: <20251105-b4-memcg_stress_rewrite-v1-1-5e354dd5439f@suse.com>
X-B4-Tracking: v=1; b=H4sIADgcC2kC/x3MSwqEMBBF0a1IjQ0kUengVkSCrU+7Bn6oEhXEv
 XdweAb33qQQhlKd3SQ4WHldElyeUf/rlgmGh2Ty1lfO2cp8SzNj7qeou0A1Ck7hHSZ0rih8CON
 nsJTqTTDy9Z6b9nn+R8uArWkAAAA=
X-Change-ID: 20251105-b4-memcg_stress_rewrite-8a133288f7d0
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762335802; l=11320;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=xp2kpe3LEWAQ4qFpqZtZw4kCUPjD8DDl3Zb706+ZQ5M=;
 b=pzOMT49EJDzJKThAwY6F9z3hNw6MZSTirnsAwvr+kVH7pJJTojmWYtFgk5lirfWgpZOseOWgW
 H6oqKCBk7QDBTFOwl+Hw8UWViwIKIimGTlMZJB5MN48+AB+Ffp16gDs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[memcg_control_test.sh:url, suse.com:mid,
 suse.com:email, memcg_memsw_limit_in_bytes_test.sh:url, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memory: rewrite memcg_stress_test into C API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test will stress the cgroup implementation by allocating the whole
free system memory inside multiple containers, one page at time.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
The previous test was buggy and up to failures. This new implementation
deletes shell script code and the C utility used by it, merging the code
into C API libray.
---
 runtest/controllers                                |   3 +-
 .../kernel/controllers/memcg/stress/.gitignore     |   1 +
 testcases/kernel/controllers/memcg/stress/Makefile |   6 +-
 .../memcg/stress/memcg_process_stress.c            |  96 -----------------
 .../controllers/memcg/stress/memcg_stress01.c      | 118 +++++++++++++++++++++
 .../controllers/memcg/stress/memcg_stress_test.sh  | 108 -------------------
 6 files changed, 122 insertions(+), 210 deletions(-)

diff --git a/runtest/controllers b/runtest/controllers
index 93c52c439..d7377e94c 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -16,7 +16,8 @@ memcg_memsw_limit_in_bytes	memcg_memsw_limit_in_bytes_test.sh
 memcg_stat	memcg_stat_test.sh
 memcg_use_hierarchy	memcg_use_hierarchy_test.sh
 memcg_usage_in_bytes	memcg_usage_in_bytes_test.sh
-memcg_stress		memcg_stress_test.sh
+memcg_stress01		memcg_stress01 -n 1
+memcg_stress01		memcg_stress01 -n 150
 memcg_control		memcg_control_test.sh
 
 # kselftest ports
diff --git a/testcases/kernel/controllers/memcg/stress/.gitignore b/testcases/kernel/controllers/memcg/stress/.gitignore
new file mode 100644
index 000000000..17df954ed
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/stress/.gitignore
@@ -0,0 +1 @@
+memcg_stress01
diff --git a/testcases/kernel/controllers/memcg/stress/Makefile b/testcases/kernel/controllers/memcg/stress/Makefile
index a9678bf3b..8413e98f9 100644
--- a/testcases/kernel/controllers/memcg/stress/Makefile
+++ b/testcases/kernel/controllers/memcg/stress/Makefile
@@ -6,10 +6,6 @@ top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CPPFLAGS		+= -I$(abs_srcdir)/../../libcontrollers
-
-INSTALL_TARGETS		:= *.sh
-
 LDLIBS			+= -lm
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
deleted file mode 100644
index 422deaeee..000000000
--- a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2009 FUJITSU LIMITED
- * Author: Li Zefan <lizf@cn.fujitsu.com>
- */
-
-#include <sys/mman.h>
-#include <err.h>
-#include <math.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-int flag_exit;
-int flag_ready;
-
-int interval;
-unsigned long memsize;
-
-char **pages;
-int nr_page;
-
-void touch_memory(void)
-{
-	int i;
-
-	for (i = 0; i < nr_page; i++)
-		pages[i][0] = 0xef;
-}
-
-void sigusr_handler(int __attribute__ ((unused)) signo)
-{
-	int i;
-	int pagesize;
-
-	pagesize = getpagesize();
-
-	nr_page = ceil((double)memsize / pagesize);
-
-	pages = calloc(nr_page, sizeof(char *));
-	if (pages == NULL)
-		errx(1, "calloc failed");
-
-	for (i = 0; i < nr_page; i++) {
-		pages[i] = mmap(NULL, pagesize, PROT_WRITE | PROT_READ,
-				MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-		if (pages[i] == MAP_FAILED)
-			err(1, "map failed\n");
-	}
-
-	flag_ready = 1;
-}
-
-void sigint_handler(int __attribute__ ((unused)) signo)
-{
-	flag_exit = 1;
-}
-
-int main(int argc, char *argv[])
-{
-	char *end;
-	struct sigaction sigint_action;
-	struct sigaction sigusr_action;
-
-	if (argc != 3)
-		errx(1, "wrong argument num");
-
-	memsize = strtoul(argv[1], &end, 10);
-	if (*end != '\0')
-		errx(1, "wrong memsize");
-	memsize = memsize * 1024 * 1024;
-
-	interval = atoi(argv[2]);
-	if (interval <= 0)
-		interval = 1;
-
-	memset(&sigint_action, 0, sizeof(sigint_action));
-	sigint_action.sa_handler = &sigint_handler;
-	if (sigaction(SIGINT, &sigint_action, NULL))
-		err(1, "sigaction(%s) failed", "SIGINT");
-
-	memset(&sigusr_action, 0, sizeof(sigusr_action));
-	sigusr_action.sa_handler = &sigusr_handler;
-	if (sigaction(SIGUSR1, &sigusr_action, NULL))
-		err(1, "sigaction(%s) failed", "SIGUSR1");
-
-	while (!flag_exit) {
-		sleep(interval);
-
-		if (flag_ready)
-			touch_memory();
-	}
-
-	return 0;
-}
diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress01.c b/testcases/kernel/controllers/memcg/stress/memcg_stress01.c
new file mode 100644
index 000000000..d59f60447
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress01.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * This test will stress the cgroup implementation by allocating the whole
+ * free system memory inside multiple containers, one page at time.
+ */
+
+#include <math.h>
+#include "tst_test.h"
+#include "tst_cgroup.h"
+
+#define MAX_CGROUPS 200
+#define INTERVAL 5
+#define RUNTIME (15 * 60)
+
+static char *str_cgroups_num;
+static int cgroups_num = 1;
+static int page_size;
+static long pages_num;
+
+static void run_child(struct tst_cg_group *cg_child)
+{
+	char **pages;
+
+	SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
+
+	page_size = getpagesize();
+	pages = SAFE_CALLOC(pages_num, sizeof(char *));
+
+	for (int i = 0; i < pages_num; i++) {
+		pages[i] = (char *)SAFE_MMAP(NULL, page_size,
+				   PROT_WRITE | PROT_READ,
+				   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	}
+
+	for (int i = 0; i < pages_num; i++)
+		*(pages[i]) = 0xef;
+}
+
+static void run(void)
+{
+	struct tst_cg_group *cg_child[cgroups_num];
+
+	for (int i = 0; i < cgroups_num; i++) {
+		cg_child[i] = tst_cg_group_mk(tst_cg, "ltp_memcg_stress_%d", i);
+
+		if (!SAFE_FORK()) {
+			run_child(cg_child[i]);
+			exit(0);
+		}
+
+		sleep(INTERVAL);
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Reached maximum runtime");
+			break;
+		}
+	}
+
+	tst_reap_children();
+
+	for (int i = 0; i < cgroups_num; i++)
+		cg_child[i] = tst_cg_group_rm(cg_child[i]);
+
+	tst_res(TPASS, "Stress test has passed");
+}
+
+static void setup(void)
+{
+	unsigned long reserved_mem, mem_free, mem_avail, swap_free, mem_min;
+	unsigned long mem_per_proc;
+	int page_size;
+
+	if (tst_parse_int(str_cgroups_num, &cgroups_num, 1, MAX_CGROUPS))
+		tst_brk(TCONF, "Invalid number of cgroups: %s", str_cgroups_num);
+
+	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+
+	mem_free = SAFE_READ_MEMINFO("MemFree:");
+	mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
+	swap_free = SAFE_READ_MEMINFO("SwapFree:");
+
+	SAFE_FILE_SCANF("/proc/sys/vm/min_free_kbytes", "%zi", &mem_min);
+
+	mem_min = mem_min + mem_min / 10;
+	reserved_mem = swap_free > mem_min ? 0 : mem_min;
+
+	mem_per_proc = mem_free < mem_avail ? mem_free : mem_avail;
+	mem_per_proc -= reserved_mem;
+	mem_per_proc /= cgroups_num;
+	mem_per_proc *= TST_KB;
+
+	if (!mem_per_proc)
+		tst_brk(TCONF, "System memory has not enough available memory");
+
+	page_size = getpagesize();
+	pages_num = ceil((double)mem_per_proc / page_size);
+
+	tst_res(TINFO, "Testing %d cgroups, using %ld MB, interval %d secs",
+		cgroups_num, mem_per_proc / TST_MB, INTERVAL);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+	.runtime = RUNTIME,
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
+	.options = (struct tst_option []) {
+		{"n:", &str_cgroups_num, "Number of cgroups (default: 1)"},
+		{}
+	},
+};
diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
deleted file mode 100755
index 47cac9af8..000000000
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ /dev/null
@@ -1,108 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2009 FUJITSU LIMITED
-# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
-# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
-#
-# Author: Li Zefan <lizf@cn.fujitsu.com>
-# Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
-# Added memcg enable/disable functionality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
-
-TST_TESTFUNC=test
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-TST_CNT=2
-TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir grep awk cut"
-
-# Each test case runs for 900 secs when everything fine
-# therefore the default 5 mins timeout is not enough.
-TST_TIMEOUT=2100
-
-setup()
-{
-	cgroup_require "memory"
-	cgroup_version=$(cgroup_get_version "memory")
-	test_path=$(cgroup_get_test_path "memory")
-	task_list=$(cgroup_get_task_list "memory")
-	if [ "$cgroup_version" = "2" ]; then
-		ROD echo "+memory" \> "$test_path/cgroup.subtree_control"
-	fi
-
-	tst_res TINFO "test starts with cgroup version $cgroup_version"
-
-	echo 3 > /proc/sys/vm/drop_caches
-	sleep 2
-	local mem_free=$(awk '/MemFree/ {print $2}' /proc/meminfo)
-	local mem_available=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
-	local swap_free=$(awk '/SwapFree/ {print $2}' /proc/meminfo)
-	local mem_min=$(cat /proc/sys/vm/min_free_kbytes)
-
-	mem_min=$(( $mem_min + $mem_min/10 ))
-	[ $swap_free -gt $mem_min ] && RESERVED_MEM=0 || RESERVED_MEM=$mem_min
-	[ $mem_free -lt $mem_available ] && MEM=$mem_free || MEM=$mem_available
-	MEM=$(( $MEM - $RESERVED_MEM ))
-	MEM=$(( $MEM / 1024 ))
-	RUN_TIME=$(( 15 * 60 ))
-
-	tst_res TINFO "Calculated available memory $MEM MB"
-}
-
-cleanup()
-{
-	cgroup_cleanup
-}
-
-# $1 Number of cgroups
-# $2 Allocated MB memory in one process
-# $3 The interval to touch memory in a process
-# $4 Test duration (sec)
-run_stress()
-{
-	local cgroups="$1"
-	local mem_size="$2"
-	local interval="$3"
-	local timeout="$4"
-	local i pid pids
-
-	tst_res TINFO "Testing $cgroups cgroups, using $mem_size MB, interval $interval"
-
-	tst_res TINFO "Starting cgroups"
-	for i in $(seq 0 $(($cgroups-1))); do
-		ROD mkdir "$test_path/$i"
-		memcg_process_stress $mem_size $interval &
-		ROD echo $! \> "$test_path/$i/$task_list"
-		pids="$pids $!"
-	done
-
-	for pid in $pids; do
-		kill -USR1 $pid 2> /dev/null
-	done
-
-	tst_res TINFO "Testing cgroups for ${timeout}s"
-	sleep $timeout
-
-	tst_res TINFO "Killing groups"
-	i=0
-	for pid in $pids; do
-		kill -KILL $pid 2> /dev/null
-		wait $pid 2> /dev/null
-		ROD rmdir "$test_path/$i"
-		i=$((i+1))
-	done
-
-	tst_res TPASS "Test passed"
-}
-
-test1()
-{
-	run_stress 150 $(( $MEM  / 150 )) 5 $RUN_TIME
-}
-
-test2()
-{
-	run_stress 1 $MEM 5 $RUN_TIME
-}
-
-. cgroup_lib.sh
-tst_run

---
base-commit: 19083415169a3c5f0e07a74bea07f3690e0d041c
change-id: 20251105-b4-memcg_stress_rewrite-8a133288f7d0

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
