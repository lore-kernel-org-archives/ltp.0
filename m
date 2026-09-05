Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467EC624D3
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788603629; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=iCAKIXR85xdEP0gqJNgQ9stj2yzOgcfXc0EFMULdsRQ=;
 b=pz6BtNbZpvhtaUAUdTTD5ZNm7HbJxE/deMbzVZ1eDVCE42kG52PoNYz7Am1DL1SP0CBDp
 AybJn0FY7pRtRTkEK9azL5u/l5GkjHGzfZbJxJ/HQ+oOPxK6mhpadO3lXuyMfxmyTHtssH4
 p2GxQ4Fv1fHpfTrqMEN8KNseHrYG8UA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED76F3E9354
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 12:20:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A9D13D0863
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 12:20:08 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CE1F11A0042C
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 12:20:06 +0200 (CEST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 608F73F0F8
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788603605;
 bh=Xa7HuGem5EqGshIubyqIU91gVWnbEx+wCxb1o9y5UjI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Vs4+MSnR14oDoEFk8wd6Pq7lRFcMQoltwvXQkbfAdUkGu7h8bOM0Jtt4lUBuG5gfm
 EK9G9Z6SZZElZDvLK97oRIzHRB9iSwNxUlqAfcx0hYplr3fnk6cQQ1fjC3O1bUFyz4
 ju2rmDR+/X2+U9a5QZ3hlGme8Xs0H5C0j29L8E47dgLZdhswyD+IsuM7UElD+4PnKY
 deiU3rRamUELTn3F9W6cuLHPv4nT+SI8voBWglHeXRkCHNIoxu/HPV7LNNwZr8hnim
 mmPzUuywatV8t1JgA88Iia98IqSHA21krATfJ+VmWBv1MDjWHwVw8IwM/HDcfTozB5
 1SimeQPqTip+3B64i7eG37NT7j368hTvgxsDDY2VILjZb7dOGZ08oEnCphy5gDHgFU
 Ru9k5bXWqVlLWfi4i4zuuYvKyovZbr4zMtKm8w2FLUo99R58JkKjD1fPQYPT49sBAB
 8xCbnAWw5fsYoWOTD39eAmFg981EZW9hmw6dliNydzjXptbw4DtxZIuF+2oI8f1c7N
 Ldm8c60Jvys4lp1B3p5sRmQz0dmbyVSUcz0kj45Q+IZaRFTsgUVcyyFmiCI8mCI/Xy
 dT4oa95ssWQ+rBJuMLA+mjqckp9nNMLgNV8dG9kegCTenKN0IR7PdjO4JK+ZnbzKAl
 cte3fNaPFuMRicBHJL8acFJk=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39906175917so2131539a91.2
 for <ltp@lists.linux.it>; Sat, 05 Sep 2026 03:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788603603; x=1789208403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xa7HuGem5EqGshIubyqIU91gVWnbEx+wCxb1o9y5UjI=;
 b=S6tbHIH6boZo2BuhFUHiIiSyyJHyofK4rCY5snxGDS3ZXfOh+h1Wb1il+HSL2x7Et0
 B2TiFGwKqowMXDhvhFWioWc221jmYM4ZkzWO1aQkaKJhLx4s/+IsHBnxpszBELwPzo/X
 beQoOUckpSYWhENEIGdJXdJ3QMkdSAvPrBPgc3AcjV1ADEEsjBHS8sKTjmr+V63ss0wn
 mHUPpPJroTTO91gNqeW+qhdJ7t11bizHjhGYk8u2aEcmf2Kg60e2IET+tRM/vCJ/keit
 i6tD9xtoE8Fm+IkiUXbSP9HgDkclXh9kCw5eyw1d1SInFQ4md9Pq6vwgjEgzwG9KEfHi
 W4yA==
X-Gm-Message-State: AFuF++mu4N8fNAilPs/nk0QezTMPYcbzituNCZnYaznreJbIsCmDw/PY
 035hAd/8a9zajXVRBGkIGgWTkqV3cVutfTcwQrOfZiaginlGKZG2dCuScgAdExll3Ds4KEMPZKS
 6/cEAnNsAavCvTgNi0+yfNxzlIb9iOJSWReaDvmbdYDl2TuJpgYwe4d2ENI0UW9yivW7epJc64l
 yf
X-Gm-Gg: AYBFou2s6/U0MEM0/OYQxvREptC7btuA7aPmpqitiuR4IeWFzUSfbpYum1LBTJsDSoc
 2AIozqVXAqYQgMQz7IZkQrNGrtVvf/kDAsl+kLKyyAmxBi5Bfpx0dHFkPC+TqsQDGainiPybsAz
 3ZaMtkEpbOHzN86bpnAwWUmxLt7m2Ocl5EnFIp7Oq7TYJiEiaZo1/LFkDF4kLwX/+STO/atuOkQ
 qmjCS16ebEQwBJ+Yq8Ct32Q2tf24xwcy00DqdKYoDW/f0eB/0qBg4GoCOB4Np7fhXFDsbNA5adp
 kx43lIP/2yzmJoeldBoTJsIDEuSe71veKIjMLysGqrAntvXVaB0bW9gmEGfcSfyfpfkdKisVvid
 YWXhPRNXTKQ==
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-39b26104798mr16775381a91.6.1788603603156; 
 Sat, 05 Sep 2026 03:20:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-39b26104798mr16775320a91.6.1788603602564; 
 Sat, 05 Sep 2026 03:20:02 -0700 (PDT)
Received: from ZBook.gateway ([123.208.39.53])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3346ea43377sm10569128eec.3.2026.09.05.03.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 03:20:02 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat,  5 Sep 2026 20:19:53 +1000
Message-ID: <20260905101953.17464-1-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] cpuset_memory_spread: count only the test file's
 page cache
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
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: Changwei Zou <changwei.zou@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cpuset_memory_spread test, written in 2009, checks the
cpuset.memory_spread_page policy by having cpuset_mem_hog read a 100 MB
DATAFILE and then comparing the global per-node FilePages counters in
/sys/devices/system/node/nodeX/meminfo before and after.

Those counters also account for unrelated page-cache activity elsewhere
on the system, so on large or busy NUMA machines the empirical
thresholds (upperlimit/lowerlimit) become unreliable and the test fails
spuriously, e.g.:

  cpuset_memory_spread 5 TFAIL: hog the memory on the unexpected
  node(FilePages_For_Nodes(KB): _0: 7592 _1: 108328, Expect Nodes: 1).

Here 108328 KB even exceeds the 100 MB file size, showing the counter
includes unrelated cache.

Instead of measuring the noisy global counters, account for only DATAFILE's
own page-cache pages: after reading the file, cpuset_mem_hog mmaps it,
faults every page in and uses move_pages(2) (with a NULL node array, so
nothing is migrated) to learn the NUMA node each of the file's pages
resides on. Every page must be accounted -- a per-page error (negative
status) or a short count fails the run -- so a partial measurement cannot
pass. It writes the per-node totals (in KB) to a result file that the
shell reads.

result_check() then verifies that the file's cache landed on the expected
node(s) and that the other nodes hold at most a small fraction
(UNEXPECTED_TOLERANCE, 5%) of it. When several expected nodes are given,
the kernel spreads the cache evenly, so each expected node must also hold
at least (100 - BALANCE_TOLERANCE, 80%) of its even share. Because only
this file's pages are counted, unrelated page-cache activity can no longer
perturb the result, and the check is page-size independent.

"cpuset_mem_hog check" probes for move_pages(2) up front and the
test is skipped with TCONF when it is unavailable.
On non-NUMA machines the test is still skipped as before.

Signed-off-by: Changwei Zou <changwei.zou@canonical.com>
---
 .../cpuset_mem_hog.c                          | 172 +++++++++++++++++-
 .../cpuset_memory_spread_testset.sh           | 119 ++++++------
 2 files changed, 233 insertions(+), 58 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
index 56e039eee..0bd60ecd1 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
@@ -27,17 +27,175 @@
 #include <ctype.h>
 #include <getopt.h>
 #include <err.h>
+#include <errno.h>
 #include <signal.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
 #include <fcntl.h>
 
 #include "../cpuset_lib/common.h"
+#include "lapi/syscalls.h"
 
 #define BUFFER_SIZE 100
 
+/* The file whose page cache placement we test and where we report it. */
+#define DATAFILE	"DATAFILE"
+#define RESULTFILE	"cpuset_mem_hog_nodes"
+
+/* Query the residing NUMA node of at most this many pages per syscall. */
+#define MOVE_PAGES_CHUNK	1024
+
+/* Upper bound on the number of NUMA nodes we count. */
+#define MAX_NODES		1024
+
 volatile int end;
 
+/*
+ * move_pages(2) with a NULL node array does not move anything; it only
+ * reports, in status[], the NUMA node each already-present page resides on.
+ */
+static long query_pages_node(unsigned long count, void **pages, int *status)
+{
+	return syscall(__NR_move_pages, 0, count, pages, NULL, status, 0);
+}
+
+/*
+ * An unimplemented syscall returns ENOSYS before its arguments are dereferenced,
+ * so a dummy page pointer is enough to probe for support.
+ * return 1 if supported, 0 if not.
+ */
+static int move_pages_supported(void)
+{
+	void *page = NULL;
+	int status = -1;
+	long ret;
+
+	ret = query_pages_node(1, &page, &status);
+
+	return !(ret == -1 && errno == ENOSYS);
+}
+
+/*
+ * Count only DATAFILE's own page-cache pages per NUMA node and write the
+ * result (node id and size in KB) to RESULTFILE.  Because we look exclusively
+ * at this file's pages -- rather than the global per-node FilePages counters
+ * in /sys -- unrelated page-cache activity on the system cannot perturb the
+ * measurement.
+ *
+ * return 0 on success, -1 on failure.
+ */
+static int count_file_pages(void)
+{
+	int fd;
+	struct stat st;
+	char *addr = MAP_FAILED;
+	long page_size = sysconf(_SC_PAGESIZE);
+	unsigned long npages, i, off, counted = 0;
+	void **pages = NULL;
+	int *status = NULL;
+	unsigned long *counts = NULL;
+	FILE *fp;
+	int ret = -1;
+
+	fd = open(DATAFILE, O_RDONLY);
+	if (fd == -1) {
+		warn("open %s failed", DATAFILE);
+		return -1;
+	}
+	if (fstat(fd, &st) == -1) {
+		warn("fstat %s failed", DATAFILE);
+		close(fd);
+		return -1;
+	}
+	npages = (st.st_size + page_size - 1) / page_size;
+	if (npages == 0) {
+		close(fd);
+		return -1;
+	}
+
+	addr = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	close(fd);
+	if (addr == MAP_FAILED) {
+		warn("mmap %s failed", DATAFILE);
+		return -1;
+	}
+
+	pages = calloc(npages, sizeof(*pages));
+	status = calloc(npages, sizeof(*status));
+	counts = calloc(MAX_NODES, sizeof(*counts));
+	if (!pages || !status || !counts) {
+		warn("calloc failed");
+		goto out;
+	}
+
+	/*
+	 * Fault in every page so it maps the page-cache page already
+	 * populated by page_cache_hog(); query_pages_node() then reports
+	 * the node that cache page resides on.
+	 */
+	for (i = 0; i < npages; i++) {
+		volatile char c = addr[i * page_size];
+
+		(void)c;
+		pages[i] = addr + i * page_size;
+		status[i] = -1;
+	}
+
+	for (off = 0; off < npages; off += MOVE_PAGES_CHUNK) {
+		unsigned long n = npages - off;
+
+		if (n > MOVE_PAGES_CHUNK)
+			n = MOVE_PAGES_CHUNK;
+		if (query_pages_node(n, pages + off, status + off) == -1) {
+			warn("move_pages failed");
+			goto out;
+		}
+	}
+
+	/*
+	 * move_pages() can return success while reporting a per-page error
+	 * (e.g. -ENOENT or -EFAULT) in status[].  Treat any such page as a
+	 * failure: otherwise the shell would compute its percentages from
+	 * only a subset of DATAFILE and could pass incorrectly.
+	 */
+	for (i = 0; i < npages; i++) {
+		if (status[i] < 0 || status[i] >= MAX_NODES) {
+			warnx("page %lu not accounted (status %d)", i,
+			      status[i]);
+			goto out;
+		}
+		counts[status[i]]++;
+		counted++;
+	}
+
+	if (counted != npages) {
+		warnx("counted %lu of %lu pages", counted, npages);
+		goto out;
+	}
+
+	fp = fopen(RESULTFILE, "w");
+	if (!fp) {
+		warn("open %s failed", RESULTFILE);
+		goto out;
+	}
+	for (i = 0; i < MAX_NODES; i++) {
+		if (counts[i])
+			fprintf(fp, "%lu %lu\n", i,
+				counts[i] * (unsigned long)page_size / 1024);
+	}
+	fclose(fp);
+	ret = 0;
+out:
+	if (addr != MAP_FAILED)
+		munmap(addr, st.st_size);
+	free(pages);
+	free(status);
+	free(counts);
+	return ret;
+}
+
 void sighandler1(UNUSED int signo)
 {
 }
@@ -54,7 +212,7 @@ int page_cache_hog(void)
 	char path[BUFFER_SIZE];
 	int ret = 0;
 
-	sprintf(path, "%s", "DATAFILE");
+	sprintf(path, "%s", DATAFILE);
 	fd = open(path, O_RDONLY);
 	if (fd == -1) {
 		warn("open %s failed", path);
@@ -81,6 +239,8 @@ int mem_hog(void)
 
 	while (!end) {
 		ret = page_cache_hog();
+		if (ret == 0)
+			ret = count_file_pages();
 
 		fd = open("./myfifo", O_WRONLY);
 		if (fd == -1)
@@ -102,10 +262,18 @@ int mem_hog(void)
 	return ret;
 }
 
-int main(void)
+int main(int argc, char *argv[])
 {
 	struct sigaction sa1, sa2;
 
+	/*
+	 * "cpuset_mem_hog check" only probes move_pages(2) support and exits:
+	 * 0 if supported, 1 if not.  The shell uses it to skip (TCONF) on
+	 * kernels built without CONFIG_NUMA_MIGRATION.
+	 */
+	if (argc > 1 && !strcmp(argv[1], "check"))
+		return move_pages_supported() ? 0 : 1;
+
 	sa1.sa_handler = sighandler1;
 	if (sigemptyset(&sa1.sa_mask) < 0)
 		err(1, "sigemptyset()");
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index 4c49bb8fd..6ab40ba83 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -30,31 +30,37 @@ export TST_COUNT=1
 
 check
 
+# cpuset_mem_hog counts DATAFILE's page cache via move_pages(2)
+cpuset_mem_hog check
+if [ $? -ne 0 ]; then
+	tst_brkm TCONF "move_pages() is not supported, CONFIG_NUMA_MIGRATION disabled?"
+fi
+
 exit_status=0
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
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
+# The cache hog (cpuset_mem_hog) reads DATAFILE and reports, per NUMA node,
+# how much of DATAFILE's own page cache resides on that node (in KB).  Because
+# only this file's pages are counted, unrelated page-cache activity on the
+# system does not affect the result.  The pages must land on the expected
+# node(s); the other nodes may hold at most the following fraction of them.
+UNEXPECTED_TOLERANCE=5
 
-PAGE_SIZE=`tst_getconf PAGESIZE`
-lowerlimit=$((PAGE_SIZE * 512 / 1024))
+# When the page cache is spread across several expected nodes, the kernel
+# spreads it evenly.  Every expected node must hold at least
+# (100 - BALANCE_TOLERANCE) percent of its even share.
+BALANCE_TOLERANCE=20
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
-mems_all="$(seq -s, 0 $((nr_mems-1)))"
 
 nodedir="/sys/devices/system/node"
 
 FIFO="./myfifo"
 
+# per-node page-cache count of DATAFILE written by cpuset_mem_hog
+HOG_RESULT="./cpuset_mem_hog_nodes"
+
 # memsinfo is an array implementation of the form of a multi-line string
 # _0: value0
 # _1: value1
@@ -131,66 +137,67 @@ freemem_check()
 	done
 }
 
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
+# load_hog_result
+# Load the per-node page-cache count of DATAFILE that cpuset_mem_hog
+# wrote to $HOG_RESULT into the memsinfo array.  Each line is "node kb".
+load_hog_result()
 {
-	local i=
+	local node= kb=
 
-	for i in `seq 0 $((nr_mems-1))`
+	init_memsinfo_array
+	while read node kb
 	do
-		account_meminfo $i
-	done
+		set_memsinfo_val "$node" "$kb"
+	done < "$HOG_RESULT"
 }
 
 
-# result_check <nodelist>
+# result_check <expect_nodes>
+# All of DATAFILE's page cache should reside on the expected node(s); the
+# other nodes should hold at most UNEXPECTED_TOLERANCE percent of it.  When
+# several expected nodes are given the cache must be spread evenly among
+# them.  Only DATAFILE's own pages are counted (see cpuset_mem_hog), so
+# unrelated page-cache activity no longer perturbs the result.
 # return 0: success
 #	 1: fail
 result_check()
 {
 	local nodelist="`echo $1 | sed -e 's/,/ /g'`"
-	local i=
+	local i= total=0 expected_sum=0 unexpected_sum=0 n_expected=0
 
-	for i in $nodelist
+	for i in `seq 0 $((nr_mems-1))`
 	do
-		if [ $(get_memsinfo_val $i) -le $upperlimit ]; then
-			return 1
-		fi
+		total=$((total + $(get_memsinfo_val $i)))
 	done
 
-	local allnodelist="`echo $mems_all | sed -e 's/,/ /g'`"
-	allnodelist=" "$allnodelist" "
-	nodelist=" "$nodelist" "
+	# nothing was cached: the hog did not populate the page cache
+	[ $total -gt 0 ] || return 1
 
-	local othernodelist="$allnodelist"
 	for i in $nodelist
 	do
-		othernodelist=`echo "$othernodelist" | sed -e "s/ $i / /g"`
+		expected_sum=$((expected_sum + $(get_memsinfo_val $i)))
+		n_expected=$((n_expected + 1))
 	done
 
-	for i in $othernodelist
+	unexpected_sum=$((total - expected_sum))
+
+	# report the actual fraction landing on the unexpected node(s)
+	tst_resm TINFO "unexpected nodes hold $(awk -v u=$unexpected_sum -v t=$total \
+		'BEGIN { printf "%.2f", u * 100 / t }')% of DATAFILE's page cache (tolerance ${UNEXPECTED_TOLERANCE}%)."
+
+	# the unexpected nodes must hold at most UNEXPECTED_TOLERANCE percent
+	if [ $((unexpected_sum * 100)) -gt $((total * UNEXPECTED_TOLERANCE)) ]; then
+		return 1
+	fi
+
+	# every expected node must hold at least (100 - BALANCE_TOLERANCE)% of
+	# its even share (expected_sum / n_expected).  This enforces an even
+	# spread across several expected nodes and also rejects an expected
+	# node that received nothing.  A single expected node always passes.
+	for i in $nodelist
 	do
-		if [ $(get_memsinfo_val $i) -gt $lowerlimit ]; then
+		if [ $(($(get_memsinfo_val $i) * n_expected * 100)) -lt \
+		     $((expected_sum * (100 - BALANCE_TOLERANCE))) ]; then
 			return 1
 		fi
 	done
@@ -238,7 +245,7 @@ general_memory_spread_test()
 		return 1
 	fi
 
-	get_memsinfo
+	rm -f $HOG_RESULT
 	/bin/kill -s SIGUSR1 $test_pid
 	read exit_num < $FIFO
 	if [ $exit_num -eq 0 ]; then
@@ -246,10 +253,10 @@ general_memory_spread_test()
 		return 1
 	fi
 
-	account_memsinfo
+	load_hog_result
 	result_check $expect_nodes
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "hog the memory on the unexpected node(FilePages_For_Nodes(KB): ${memsinfo}, Expect Nodes: $expect_nodes)."
+		tst_resm TFAIL "hog the memory on the unexpected node(DATAFILE_Pages_For_Nodes(KB): ${memsinfo}, Expect Nodes: $expect_nodes)."
 		return 1
 	fi
 }
@@ -357,6 +364,6 @@ fi
 test_spread_page1
 test_spread_page2
 
-rm -f DATAFILE $FIFO
+rm -f DATAFILE $FIFO $HOG_RESULT
 
 exit $exit_status
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
