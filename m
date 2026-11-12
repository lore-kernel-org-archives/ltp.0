Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF2606A31C
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=QKFkewI9;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=dXqEf67d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794478898; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vLTBGEHTkIqhn0A9EQYy1S5iJHMq1giL7W26JCXJQus=;
 b=QKFkewI98ArsEF560j42jyexEPqg8yGXr7frA7KwBXLZcrx5e4iSpmmhyeLeMuUifInLq
 RWqwU0qZ9XyiG/a5Cn5sUIU8HqtsecberWMYyy/irihGvVj1WnuDc2SkmWwtqG8sW1olB3g
 QBVJInEBpPeTWIQA2aP+W735w/vhqoM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35F453E94EB
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 11:21:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 535E13EA09A
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 11:21:05 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3935D1000A23
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 11:21:03 +0100 (CET)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F8223FBF3
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794478862;
 bh=/8eODYLEkr851oW0l0fFrNsrQJQIwveGp+L0B/5EcBo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=dXqEf67dDyz51DzE1zTIvN2uaRiGA6M9LbtUYLeokkYdI3UZLY9Gdf2fRe+EOW9p3
 8dzIONEk75F8J4kZFduDmVY/SmnRLkPVb6Z/si4oQOqaadf/5pyVMHTQoLUZubXKNJ
 72wDRgorIAVjA1fIDytbhWxYCgSUofIQgNxylmYNVDQUpceEBYdQRTT6A1nyrrraZH
 hebmcMJmol7LIzv8AoCkQUOmMRJbkjWyMGuHZNdtN/UZBLjXRQHQoV8SU8d+/P+nv0
 WV9kqVnUnprbNiKJP4nR2Yy+OWT/edaBOjQCjjKlCeq4nM4+Nc2lx9c3ClxKx1uWE0
 PDXklMMwbwkLclfZdPvJ7HXKVCLnToGNzrV1Qqs+7ZBUp0vmxl+ArMQelVE/8mjn91
 NMxKCVGUvEh6ZoeI1482SxQNlVAzuaHxG17bMU9KRV51wHO4L7uConrSI19+0OhT5H
 cx6BjbAFZ0qT9NNOzkfalZgx+i4Z1gJAwCcwoYVPpLfhUlk8GRSuwpdo0JTnZOQ6iu
 hGT7KTj1l8hqLarRmycGPzEH03QsTf03toMX9+IxHh5rd7TncmKFVL5+uLu434EtZ7
 j8P3t5EGjpHtuRHEmGgpAQ55ORIM5Dejq5R7z7irW7PUq29Ok7jq768xW2Pmfn7Q8Y
 RFrLtTZaHivJggFyRvIxL58o=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8b647bbf8a9so4946594b3a.0
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 02:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794478861; x=1795083661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/8eODYLEkr851oW0l0fFrNsrQJQIwveGp+L0B/5EcBo=;
 b=qC6Ryzt16mvc6tLrB/Mm5QXsVs+4YBWO0Cxp4HXaZATe+4HNwJRXevCGktCUnLjHCX
 Uok5/hoWSEW+zIJBkv29CJvKDYdWoDD3ChhENpt9dYpbSMLNWuXTc0rdfzV6DmwZKRu+
 MoSLkNYPU0MaU450PxT3kVG6C6EvB/0eTfDtBKD4xVFQRDoXO+QipIScjsQLlKQ2mQoi
 bpsvyYgcTN5dMMSG1ztuhDHW8GlQCzuJ6x1gSbI4fQAjW1h5TG8yl2FqI9nUxibGI6a9
 Dv8OfebgBQ/YFH49p6f/9mtuBNzu2XQ5b5smaRgAg7lZryW82flXnETzL/lq0eKXeuVP
 5Yjg==
X-Gm-Message-State: APuU4Z8HQGUFXesRLAXmEzcB3yjvzdndVsjsnaBpTlIz3LBZyzxMqMpo
 JVFz4JS2mF3XnEe39FbUP3lsnuE3M4Q3E6pYMrQsIOQJr+DNoiLQmYrQoFtkVaa2v4bWyTtin/d
 81+9VSsOLMRQv4gH8cHyS5+wVegOxqnDVFCFAyVQI7DrBPAjUaO8LAU5g1beL5fRkVnbkv9m34N
 yIl4U=
X-Gm-Gg: AYBFou0PmdoITCrOdf1idMpTqSznjfAik5eRp0WPOdZvRNHmaL0WKJkTzNtdwpsS7zY
 Fj4Scon0NvFzPJGMSXMOgtAh3ML5y9xnfwzmG33AmDtyOx20eUH86YLgKjkz+Y0nTmV1gL9LnpJ
 RnmeJujoSIhk30m6Pdwiek+kbBhT+srhL1uuPVWLcSQYWOOCNtidPuXpG7rT4H2rk/FUgvreEcX
 RG0wnIQZyy/EGFI/F3aOca5GWfnKXSVNQQ2ebaWMeJY5Qza/ie/Tg3H//IrTWMQ6wrPNkNLcl2H
 3RQjkVcZ3fRNEDbukISzT3/kImlOhbfH1tisf0MbnYq67im7+j3tJUi/7rQRqb0Agy390tNpHGF
 D0If19Yn3BEvBnlB5D97dr5t1lOloQTSVPWAuYnzaBAUd1P5ZPnh+aUmVw18=
X-Received: by 2002:a05:6a00:22cf:b0:882:d8c4:17c9 with SMTP id
 d2e1a72fcca58-8bc1bec4d9dmr5571149b3a.23.1794478860359; 
 Thu, 12 Nov 2026 02:21:00 -0800 (PST)
X-Received: by 2002:a05:6a00:22cf:b0:882:d8c4:17c9 with SMTP id
 d2e1a72fcca58-8bc1bec4d9dmr5571127b3a.23.1794478859683; 
 Thu, 12 Nov 2026 02:20:59 -0800 (PST)
Received: from ZBook.gateway ([123.208.39.53])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaa2a6c51sm3259468b3a.14.2026.11.12.02.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 02:20:59 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 12 Nov 2026 21:20:50 +1100
Message-ID: <20261112102050.76434-2-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112102050.76434-1-changwei.zou@canonical.com>
References: <20261112102050.76434-1-changwei.zou@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 1/1] cpuset_memory_spread: rewrite as a C test
 using the LTP cgroup library
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: Changwei Zou <changwei.zou@canonical.com>,
 Po-Hsu Lin <po-hsu.lin@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cpuset_memory_spread test, written in 2009, was split between a shell
script (cpuset_memory_spread_testset.sh) that mounted /dev/cpuset by hand
and a C helper (cpuset_mem_hog) driven over a FIFO and SIGUSR1/SIGUSR2.
It checked the cpuset.memory_spread_page policy by comparing the global
per-node FilePages counters in /sys/devices/system/node/nodeX/meminfo,
which also account for unrelated page-cache activity, so on large or busy
NUMA machines the empirical thresholds became unreliable and the test
failed spuriously.

Rewrite the whole thing as a single C test built on the new LTP test API,
the LTP cgroup library (tst_cgroup.h) and the NUMA helpers from
tse_numa.h, dropping the shell script, the FIFO/signal handshake and the
manual /dev/cpuset management.

For each case the test pins itself to the local node, sets cpuset.mems
and cpuset.memory_spread_page, faults a file-backed shared mapping and
uses tse_nodemap_count_pages() (get_mempolicy(2)) to learn the NUMA node
of each of the mapping's pages. Only the test mapping's own pages are
counted, so unrelated page-cache activity can no longer perturb the
result. The distribution is then verified: the pages must land on the
expected node(s), the other nodes may hold at most UNEXPECTED_TOLERANCE
(5%) of them, and when several expected nodes are given each must hold at
least (100 - BALANCE_TOLERANCE, 80%) of its even share.

cpuset.memory_spread_page only exists in the cgroup v1 cpuset controller,
so setup() checks for the control file and the test is skipped with TCONF
when cpuset is mounted on the unified (v2) hierarchy. Register
cpuset.memory_spread_page in the LTP cgroup library's cpuset file table so
it can be driven through the SAFE_CG_* helpers.

Reported-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1830585
Signed-off-by: Changwei Zou <changwei.zou@canonical.com>
Assisted-By: opencode (claude-opus-4.8)
---
 lib/tst_cgroup.c                              |   1 +
 runtest/controllers                           |   2 +-
 .../kernel/controllers/cpuset/.gitignore      |   2 +-
 .../cpuset/cpuset_memory_spread_test/Makefile |   7 +-
 .../cpuset_mem_hog.c                          | 126 ------
 .../cpuset_memory_spread01.c                  | 213 +++++++++++
 .../cpuset_memory_spread_testset.sh           | 362 ------------------
 7 files changed, 222 insertions(+), 491 deletions(-)
 delete mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
 create mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c
 delete mode 100755 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 7c6ecd4d2..74459138f 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -206,6 +206,7 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
 	{ "cpuset.cpus", "cpuset.cpus", CTRL_CPUSET },
 	{ "cpuset.mems", "cpuset.mems", CTRL_CPUSET },
 	{ "cpuset.memory_migrate", "cpuset.memory_migrate", CTRL_CPUSET },
+	{ "cpuset.memory_spread_page", "cpuset.memory_spread_page", CTRL_CPUSET },
 	{ }
 };
 
diff --git a/runtest/controllers b/runtest/controllers
index 93c52c439..0af338369 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -357,7 +357,7 @@ cpuset_load_balance	cpuset_load_balance_test.sh
 cpuset_hotplug	cpuset_hotplug_test.sh
 cpuset_memory	cpuset_memory_testset.sh
 cpuset_memory_pressure	cpuset_memory_pressure_testset.sh
-cpuset_memory_spread	cpuset_memory_spread_testset.sh
+cpuset_memory_spread01	cpuset_memory_spread01
 
 cpuset_regression_test cpuset_regression_test.sh
 
diff --git a/testcases/kernel/controllers/cpuset/.gitignore b/testcases/kernel/controllers/cpuset/.gitignore
index c65f2fb61..6a8d713c2 100644
--- a/testcases/kernel/controllers/cpuset/.gitignore
+++ b/testcases/kernel/controllers/cpuset/.gitignore
@@ -2,6 +2,6 @@
 /cpuset_load_balance_test/cpuset_cpu_hog
 /cpuset_load_balance_test/cpuset_sched_domains_check
 /cpuset_memory_pressure_test/cpuset_memory_pressure
-/cpuset_memory_spread_test/cpuset_mem_hog
+/cpuset_memory_spread_test/cpuset_memory_spread01
 /cpuset_memory_test/cpuset_memory_test
 /cpuset_syscall_test/cpuset_syscall_test
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
index b3c76f0de..5b681f77c 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
@@ -22,6 +22,11 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = numa
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+
+cpuset_memory_spread01: LDLIBS += $(NUMA_LIBS)
+cpuset_memory_spread01: LTPLDLIBS = -lltpnuma
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
deleted file mode 100644
index 56e039eee..000000000
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
+++ /dev/null
@@ -1,126 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Miao Xie <miaox@cn.fujitsu.com>                                    */
-/*                                                                            */
-/******************************************************************************/
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <ctype.h>
-#include <getopt.h>
-#include <err.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "../cpuset_lib/common.h"
-
-#define BUFFER_SIZE 100
-
-volatile int end;
-
-void sighandler1(UNUSED int signo)
-{
-}
-
-void sighandler2(UNUSED int signo)
-{
-	end = 1;
-}
-
-int page_cache_hog(void)
-{
-	int fd = -1;
-	char buff[BUFFER_SIZE];
-	char path[BUFFER_SIZE];
-	int ret = 0;
-
-	sprintf(path, "%s", "DATAFILE");
-	fd = open(path, O_RDONLY);
-	if (fd == -1) {
-		warn("open %s failed", path);
-		return -1;
-	}
-
-	while ((ret = read(fd, buff, sizeof(buff))) > 0) ;
-	if (ret == -1)
-		warn("read %s failed", path);
-
-	close(fd);
-	return ret;
-}
-
-int mem_hog(void)
-{
-	sigset_t signalset;
-	int fd;
-	int ret = 0;
-
-	if (sigemptyset(&signalset) < 0)
-		err(1, "sigemptyset()");
-	sigsuspend(&signalset);
-
-	while (!end) {
-		ret = page_cache_hog();
-
-		fd = open("./myfifo", O_WRONLY);
-		if (fd == -1)
-			err(1, "open fifo failed");
-
-		if (ret) {
-			if (write(fd, "0", 1) == -1)
-				warn("write fifo failed.");
-		} else {
-			if (write(fd, "1", 1) == -1)
-				warn("write fifo failed.");
-		}
-
-		close(fd);
-
-		sigsuspend(&signalset);
-	}
-
-	return ret;
-}
-
-int main(void)
-{
-	struct sigaction sa1, sa2;
-
-	sa1.sa_handler = sighandler1;
-	if (sigemptyset(&sa1.sa_mask) < 0)
-		err(1, "sigemptyset()");
-
-	sa1.sa_flags = 0;
-	if (sigaction(SIGUSR1, &sa1, NULL) < 0)
-		err(1, "sigaction()");
-
-	sa2.sa_handler = sighandler2;
-	if (sigemptyset(&sa2.sa_mask) < 0)
-		err(1, "sigemptyset()");
-
-	sa2.sa_flags = 0;
-	if (sigaction(SIGUSR2, &sa2, NULL) < 0)
-		err(1, "sigaction()");
-
-	return mem_hog();
-}
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c
new file mode 100644
index 000000000..d43678dee
--- /dev/null
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED
+ * Author: Miao Xie <miaox@cn.fujitsu.com>
+ *
+ * Rewritten into a single C test using the LTP cgroup library.
+ */
+
+/*\
+ * Verify the ``cpuset.memory_spread_page`` control file.
+ *
+ * A task's file-backed page cache is normally allocated on the node the task
+ * runs on (local allocation). When ``cpuset.memory_spread_page`` is enabled,
+ * the page cache of a task in the cpuset is instead spread evenly over all
+ * the memory nodes allowed by ``cpuset.mems``.
+ *
+ * For every case the test pins itself to the local node, sets ``cpuset.mems``
+ * and ``cpuset.memory_spread_page``, then faults a file-backed shared mapping
+ * and uses :manpage:`get_mempolicy(2)` (through the tse_numa helpers) to learn
+ * the NUMA node each of the mapping's pages resides on. Because only the test
+ * mapping's own pages are counted, unrelated page-cache activity on the system
+ * cannot perturb the result. The resulting distribution is verified:
+ *
+ * - with spreading off the pages must land on the expected node (the local
+ *   node, or the only node allowed by ``cpuset.mems``);
+ * - with spreading on over several nodes the pages must be spread evenly.
+ *
+ * ``cpuset.memory_spread_page`` exists only in the cgroup v1 cpuset
+ * controller, so the test requires a v1 cpuset hierarchy and is skipped
+ * (TCONF) when cpuset is mounted on the unified (v2) hierarchy.
+ *
+ * The test is skipped on tmpfs/ramfs, where the mapping's pages are the
+ * backing store itself rather than ordinary page cache, so their placement
+ * is not governed by this knob.
+ */
+
+#include "config.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+
+#ifdef HAVE_NUMA_H
+# include <numa.h>
+#endif
+
+#include "tst_test.h"
+#include "tst_cgroup.h"
+#include "tse_numa.h"
+
+#ifdef HAVE_NUMA_V2
+
+/* Path of the file-backed mapping whose page placement we measure. */
+#define DATAFILE	"numa_data_file"
+
+/* Size of the mapping. Large enough to measure an even spread reliably. */
+#define SIZE_MB		100
+#define SIZE		((size_t)SIZE_MB * 1024 * 1024)
+
+/* Each node needs enough free memory to hold the whole mapping plus slack. */
+#define MIN_FREE_KB	((SIZE_MB + 50) * 1024)
+
+/*
+ * The pages must land on the expected node(s); the other nodes may hold at
+ * most this fraction (in percent) of them.
+ */
+#define UNEXPECTED_TOLERANCE	5
+
+/*
+ * When the pages are spread across several expected nodes, the kernel spreads
+ * them evenly. Every expected node must hold at least
+ * (100 - BALANCE_TOLERANCE) percent of its even share.
+ */
+#define BALANCE_TOLERANCE	20
+
+static struct tse_nodemap *nodes;
+
+/*
+ * The task's CPUs are pinned to the local node (nodes->map[0]) for every case
+ * (see setup()); only cpuset.mems and cpuset.memory_spread_page change.
+ *
+ * mems/expect are strings of single-digit indices into nodes->map: '0' is the
+ * local node, '1' the remote one.
+ */
+static const struct tcase {
+	int spread;
+	const char *mems;
+	const char *expect;
+	const char *desc;
+} tcases[] = {
+	{0, "0",  "0",  "spread off, mems on the local node"},
+	{1, "0",  "0",  "spread on, mems on the local node"},
+	{0, "1",  "1",  "spread off, mems on the remote node"},
+	{1, "1",  "1",  "spread on, mems on the remote node"},
+	{0, "01", "0",  "spread off, mems on both nodes (local allocation)"},
+	{1, "01", "01", "spread on, mems on both nodes (even spread)"},
+};
+
+static void check_result(const char *expect, const char *desc)
+{
+	unsigned int i, total = 0, expected_sum = 0, n_expect = 0, unexpected;
+
+	for (i = 0; i < nodes->cnt; i++)
+		total += nodes->counters[i];
+
+	if (!total) {
+		tst_res(TFAIL, "%s: no pages were allocated", desc);
+		return;
+	}
+
+	for (i = 0; expect[i]; i++) {
+		expected_sum += nodes->counters[expect[i] - '0'];
+		n_expect++;
+	}
+
+	unexpected = total - expected_sum;
+
+	tst_res(TINFO,
+		"%s: unexpected nodes hold %.2f%% of the pages (tolerance %d%%)",
+		desc, (double)unexpected * 100 / total, UNEXPECTED_TOLERANCE);
+
+	if (unexpected * 100 > total * UNEXPECTED_TOLERANCE) {
+		tst_res(TFAIL, "%s: too many pages on unexpected node(s)", desc);
+		return;
+	}
+
+	/*
+	 * Every expected node must hold at least (100 - BALANCE_TOLERANCE)% of
+	 * its even share. This enforces an even spread across several expected
+	 * nodes and rejects an expected node that received nothing. A single
+	 * expected node always passes this check.
+	 */
+	for (i = 0; expect[i]; i++) {
+		unsigned int idx = expect[i] - '0';
+
+		if (nodes->counters[idx] * n_expect * 100 <
+		    expected_sum * (100 - BALANCE_TOLERANCE)) {
+			tst_res(TFAIL, "%s: node %u holds too few pages",
+				desc, nodes->map[idx]);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "%s", desc);
+}
+
+static void run(unsigned int n)
+{
+	const struct tcase *tc = &tcases[n];
+	char mems[64];
+	size_t len = 0;
+	void *ptr;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; tc->mems[i]; i++) {
+		ret = snprintf(mems + len, sizeof(mems) - len, "%s%u",
+			       i ? "," : "", nodes->map[tc->mems[i] - '0']);
+		if (ret < 0 || (size_t)ret >= sizeof(mems) - len)
+			tst_brk(TBROK, "failed to build cpuset.mems string");
+		len += ret;
+	}
+
+	SAFE_CG_PRINT(tst_cg, "cpuset.mems", mems);
+	SAFE_CG_PRINTF(tst_cg, "cpuset.memory_spread_page", "%d", tc->spread);
+
+	ptr = tse_numa_map(DATAFILE, SIZE);
+	tse_numa_fault(ptr, SIZE);
+	tse_nodemap_reset_counters(nodes);
+	tse_nodemap_count_pages(nodes, ptr, SIZE);
+	tse_numa_unmap(ptr, SIZE);
+
+	check_result(tc->expect, tc->desc);
+}
+
+static void setup(void)
+{
+	nodes = tse_get_nodemap(TST_NUMA_MEM, MIN_FREE_KB);
+	if (nodes->cnt < 2)
+		tst_brk(TCONF, "requires at least 2 NUMA memory nodes");
+
+	if (!SAFE_CG_HAS(tst_cg, "cpuset.memory_spread_page"))
+		tst_brk(TCONF, "cpuset.memory_spread_page not available");
+
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+
+	/* Pin the task to the local node for every case. */
+	if (numa_run_on_node(nodes->map[0]))
+		tst_brk(TCONF, "cannot run on node %u (no CPUs?)",
+			nodes->map[0]);
+}
+
+static void cleanup(void)
+{
+	if (nodes)
+		tse_nodemap_free(nodes);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.skip_filesystems = (const char *const []){ "tmpfs", "ramfs", NULL },
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
+};
+
+#else
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+#endif
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
deleted file mode 100755
index 4c49bb8fd..000000000
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ /dev/null
@@ -1,362 +0,0 @@
-#!/bin/sh
-
-################################################################################
-#                                                                              #
-# Copyright (c) 2009 FUJITSU LIMITED                                           #
-#                                                                              #
-# This program is free software;  you can redistribute it and#or modify        #
-# it under the terms of the GNU General Public License as published by         #
-# the Free Software Foundation; either version 2 of the License, or            #
-# (at your option) any later version.                                          #
-#                                                                              #
-# This program is distributed in the hope that it will be useful, but          #
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY   #
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
-# for more details.                                                            #
-#                                                                              #
-# You should have received a copy of the GNU General Public License            #
-# along with this program;  if not, write to the Free Software                 #
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA      #
-#                                                                              #
-# Author: Miao Xie <miaox@cn.fujitsu.com>                                      #
-#                                                                              #
-################################################################################
-
-export TCID="cpuset_memory_spread"
-export TST_TOTAL=6
-export TST_COUNT=1
-
-. cpuset_funcs.sh
-
-check
-
-exit_status=0
-nr_cpus=$NR_CPUS
-nr_mems=$N_NODES
-
-# In general, the cache hog will use more than 10000 kb slab space on the nodes
-# on which it is running. The other nodes' slab space has littler change.(less
-# than 1000 kb).
-upperlimit=10000
-
-# set lowerlimit according to pagesize
-# pagesize(bytes)  | lowerlimit(kb)
-# ------------------------------------
-#  4096            | 2048
-#  16384           | 8192
-
-PAGE_SIZE=`tst_getconf PAGESIZE`
-lowerlimit=$((PAGE_SIZE * 512 / 1024))
-
-cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
-mems_all="$(seq -s, 0 $((nr_mems-1)))"
-
-nodedir="/sys/devices/system/node"
-
-FIFO="./myfifo"
-
-# memsinfo is an array implementation of the form of a multi-line string
-# _0: value0
-# _1: value1
-# _2: value2
-#
-memsinfo=""
-
-# set value to memsinfo ($1 - index, $2 - value)
-set_memsinfo_val()
-{
-	local nl='
-'
-	# clearing existent value (if present)
-	memsinfo=`echo "$memsinfo" | sed -r "/^\_$1\: /d"`
-
-	if [ -z "$memsinfo" ]; then
-		memsinfo="_$1: $2"
-	else
-		memsinfo="$memsinfo${nl}_$1: $2"
-	fi
-}
-
-# get value from memsinfo ($1 - index)
-get_memsinfo_val()
-{
-	local value=
-	value=`echo "$memsinfo" | grep -e "^_$1: "`
-	value=`echo "$value" | sed -r "s/^.*\: (.*)$/\1/"`
-	echo "$value"
-}
-
-
-init_memsinfo_array()
-{
-	local i=
-
-	for i in `seq 0 $((nr_mems-1))`
-	do
-		set_memsinfo_val $i 0
-	done
-}
-
-# get_meminfo <nodeid> <item>
-get_meminfo()
-{
-	local nodeid="$1"
-	local nodepath="$nodedir/node$nodeid"
-	local nodememinfo="$nodepath/meminfo"
-	local item="$2"
-	local info=`cat $nodememinfo | grep $item | awk '{print $4}'`
-	set_memsinfo_val $nodeid $info
-}
-
-# freemem_check
-# We need enough memory space on every node to run this test, so we must check
-# whether every node has enough free memory or not.
-# return value: 1 - Some node doesn't have enough free memory
-#               0 - Every node has enough free memory, We can do this test
-freemem_check()
-{
-	local i=
-
-	for i in `seq 0 $((nr_mems-1))`
-	do
-		get_meminfo $i "MemFree"
-	done
-
-	for i in `seq 0 $((nr_mems-1))`
-	do
-		# I think we need 100MB free memory to run test
-		if [ $(get_memsinfo_val $i) -lt 100000 ]; then
-			return 1
-		fi
-	done
-}
-
-# get_memsinfo
-get_memsinfo()
-{
-	local i=
-
-	for i in `seq 0 $((nr_mems-1))`
-	do
-		get_meminfo $i "FilePages"
-	done
-}
-
-# account_meminfo <nodeId>
-account_meminfo()
-{
-	local nodeId="$1"
-	local tmp="$(get_memsinfo_val $nodeId)"
-	get_meminfo $@ "FilePages"
-	set_memsinfo_val $nodeId $(($(get_memsinfo_val $nodeId)-$tmp))
-}
-
-# account_memsinfo
-account_memsinfo()
-{
-	local i=
-
-	for i in `seq 0 $((nr_mems-1))`
-	do
-		account_meminfo $i
-	done
-}
-
-
-# result_check <nodelist>
-# return 0: success
-#	 1: fail
-result_check()
-{
-	local nodelist="`echo $1 | sed -e 's/,/ /g'`"
-	local i=
-
-	for i in $nodelist
-	do
-		if [ $(get_memsinfo_val $i) -le $upperlimit ]; then
-			return 1
-		fi
-	done
-
-	local allnodelist="`echo $mems_all | sed -e 's/,/ /g'`"
-	allnodelist=" "$allnodelist" "
-	nodelist=" "$nodelist" "
-
-	local othernodelist="$allnodelist"
-	for i in $nodelist
-	do
-		othernodelist=`echo "$othernodelist" | sed -e "s/ $i / /g"`
-	done
-
-	for i in $othernodelist
-	do
-		if [ $(get_memsinfo_val $i) -gt $lowerlimit ]; then
-			return 1
-		fi
-	done
-}
-
-# general_memory_spread_test <cpusetpath> <is_spread> <cpu_list> <node_list> \
-# <expect_nodes> <test_pid>
-# expect_nodes: we expect to use the slab or cache on which node
-general_memory_spread_test()
-{
-	local cpusetpath="$CPUSET/1"
-	local is_spread="$1"
-	local cpu_list="$2"
-	local node_list="$3"
-	local expect_nodes="$4"
-	local test_pid="$5"
-
-	cpuset_set "$cpusetpath" "$cpu_list" "$node_list" "0" 2> $CPUSET_TMP/stderr
-	if [ $? -ne 0 ]; then
-		cpuset_log_error $CPUSET_TMP/stderr
-		tst_resm TFAIL "set general group parameter failed."
-		return 1
-	fi
-
-	/bin/echo "$is_spread" > "$cpusetpath/cpuset.memory_spread_page" 2> $CPUSET_TMP/stderr
-	if [ $? -ne 0 ]; then
-		cpuset_log_error $CPUSET_TMP/stderr
-		tst_resm TFAIL "set spread value failed."
-		return 1
-	fi
-
-	/bin/echo "$test_pid" > "$cpusetpath/tasks" 2> $CPUSET_TMP/stderr
-	if [ $? -ne 0 ]; then
-		cpuset_log_error $CPUSET_TMP/stderr
-		tst_resm TFAIL "attach task failed."
-		return 1
-	fi
-
-	# we'd better drop the caches before we test page cache.
-	sync
-	/bin/echo 3 > /proc/sys/vm/drop_caches 2> $CPUSET_TMP/stderr
-	if [ $? -ne 0 ]; then
-		cpuset_log_error $CPUSET_TMP/stderr
-		tst_resm TFAIL "drop caches failed."
-		return 1
-	fi
-
-	get_memsinfo
-	/bin/kill -s SIGUSR1 $test_pid
-	read exit_num < $FIFO
-	if [ $exit_num -eq 0 ]; then
-		tst_resm TFAIL "hot mem task failed."
-		return 1
-	fi
-
-	account_memsinfo
-	result_check $expect_nodes
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "hog the memory on the unexpected node(FilePages_For_Nodes(KB): ${memsinfo}, Expect Nodes: $expect_nodes)."
-		return 1
-	fi
-}
-
-base_test()
-{
-	local pid=
-	local result_num=
-
-	setup
-	if [ $? -ne 0 ]; then
-		exit_status=1
-	else
-		cpuset_mem_hog &
-		pid=$!
-		general_memory_spread_test "$@" "$pid"
-		result_num=$?
-		if [ $result_num -ne 0 ]; then
-			exit_status=1
-		fi
-
-		/bin/kill -s SIGUSR2 $pid
-		wait $pid
-
-		cleanup
-		if [ $? -ne 0 ]; then
-			exit_status=1
-		elif [ $result_num -eq 0 ]; then
-			tst_resm TPASS "Cpuset memory spread page test succeeded."
-		fi
-	fi
-	TST_COUNT=$(($TST_COUNT + 1))
-}
-
-# test general spread page cache in a cpuset
-test_spread_page1()
-{
-	while read spread cpus nodes exp_nodes
-	do
-		base_test "$spread" "$cpus" "$nodes" "$exp_nodes"
-	done <<- EOF
-		0	0	0	0
-		1	0	0	0
-		0	0	1	1
-		1	0	1	1
-		0	0	0,1	0
-		1	0	0,1	0,1
-	EOF
-	# while read spread cpus nodes exp_nodes
-}
-
-test_spread_page2()
-{
-	local pid=
-	local result_num=
-
-	setup
-	if [ $? -ne 0 ]; then
-		exit_status=1
-	else
-		cpuset_mem_hog &
-		pid=$!
-		general_memory_spread_test "1" "$cpus_all" "0" "0" "$pid"
-		result_num=$?
-		if [ $result_num -ne 0 ]; then
-			exit_status=1
-		else
-			general_memory_spread_test "1" "$cpus_all" "1" "1" "$pid"
-			result_num=$?
-			if [ $result_num -ne 0 ]; then
-				exit_status=1
-			fi
-		fi
-
-		/bin/kill -s SIGUSR2 $pid
-		wait $pid
-
-		cleanup
-		if [ $? -ne 0 ]; then
-			exit_status=1
-		elif [ $result_num -eq 0 ]; then
-			tst_resm TPASS "Cpuset memory spread page test succeeded."
-		fi
-	fi
-}
-
-init_memsinfo_array
-freemem_check
-if [ $? -ne 0 ]; then
-	tst_brkm TCONF "Some node doesn't has enough free memory(100MB) to do test(MemFree_For_Nodes(KB): ${memsinfo[*]})."
-fi
-
-dd if=/dev/zero of=./DATAFILE bs=1M count=100
-if [ $? -ne 0 ]; then
-	tst_brkm TFAIL "Creating DATAFILE failed."
-fi
-
-rm -f $FIFO
-mkfifo $FIFO
-if [ $? -ne 0 ]; then
-	rm -f DATAFILE
-	tst_brkm TFAIL "failed to mkfifo $FIFO"
-fi
-
-test_spread_page1
-test_spread_page2
-
-rm -f DATAFILE $FIFO
-
-exit $exit_status
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
