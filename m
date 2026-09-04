Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E9DC61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788526265; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=hJWAzZK1PH4V45Qt8+CgtkX4HZD6/QVXKB0jH2BMFuQ=;
 b=rPXO5yRVh93ZThydfiMXphene/QYFpGiBiI+mZINSgx0ggTGcdNEf0ATTB+nsGh8ULPjj
 bYpGX3pamLqSW1pEmEnGxGgWZfhlG6SqcEKIR2reHzontCbYdILS1mSeAPIV95o6CTdtCeB
 aEA7qYiGFTC/lUg7ZIPMvB0c819mYqY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B9D03E0E5B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:51:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BA343D06E0
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:50:44 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 063E92000D5
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:50:43 +0200 (CEST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0CFF544BAE
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788526243;
 bh=W5yKBUd2B5cwiF6M9bkjuTvNROXDLQOU30Fe9BfAl8k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=sJDHfLB8nz64a+aRW+405ioP1+WRXZPYO0yPW2R55CPU1E5TCjJt+HN0I5laGSb74
 YZNWml+3MtWg91Kywe/3z+MPZvbAA1ApK3UlCwzEv5iOIFjt2Re6uggDmPUhGun4QE
 CieggOkAlTZlELUPHJ+duUnFNI3wEFQwGeVESutR/KL81D7psy+xfE+U/Z2bB9XxD/
 AO8C2wht/X5Q+c2m+0L5c0bUH7pMHkx5ObAjhsfjynfhPL/sk3n5ctgT5mCxRUAHpF
 W4ExtpGbhHy8fXPGjGOccu9czQ1Iq51Idi20PqfJJEnjWpvIIlJiWEYYtN//hgki4W
 ZkCq2JAUlJhsCVE12jMBUkV7Pf4zpmwc3cynu4nCW+Zv+VOT0WKQMXEluihSGS2n14
 3pMaB39MO+Il3iQyF0f7yqmXFrtdbrLCJ8zX86ks0ZsyDVd7RhCQq/ZzIqVI4hdW28
 eNY+a4bevY8mduEOrV6fsiZKiAsysN6ANcX1vidYe71OAowehziOHt35ToyDvQdhkX
 beKLn4gd5C4bFGMrV6VGFW2lmx25C9WR7LKxXbjrO6qMgC0MsFUzTjnoGAnVpKZDuC
 JmTlSyce7/FqmSsrBY1Mleig0IPfq14dh9eR2qpySaw5PMleQYUPaX52jDpOCgnck4
 1TWXbrezvfBRwBiGYqJt/x6M=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-399311947f6so1603954a91.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 05:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526241; x=1789131041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W5yKBUd2B5cwiF6M9bkjuTvNROXDLQOU30Fe9BfAl8k=;
 b=Z//uMx9mFTCZ0lmxODcWpQrsPm3j8Bbv5PHVwZs2fiF327FWM/9jSumS423R0YPFny
 USe/iYEDnX9GVW4Rv9gBU3MeeqRINQNYKz5975ucw3MSNIIb5k2CxSvG5RO2ecVviOGj
 6Mdo0tMNVgtsGWxsQ/T6ryu57WwWwErBsIRfjKiCIJtJR7eVQ5G5nWkqogpYMY5C3Wqj
 mFg6zPP9NOOIitol1tvsVecSRjh/E0/i0Kcoi2RfSqv/cZJiSM1g8uVbP/1ZwGBOM4vP
 Bi3KY35nz5qWtJwIazZvYRrzYj0tGppFrcecko4CMJK1l0Y1/idS70B9Jo6xIRd/KqKc
 iXxQ==
X-Gm-Message-State: AFuF++l7K/AB0DJ3e+T3lM6sWbwwPsD+zcSdx8BLRTEdtOeRPH3NhLjv
 g1uggvP66/lM+ZOCF1ztKVp0kJ7I19W8UvYm942kMqiUaZI637lZBU5xHUiq3lit+AVmVaLIhPR
 BJLKwifs436iVZ1TBE+vmWBVYD6OxV49AbP4S4yqBoGCBt3OCDzjciiZKKscdJz4PAtwfcXXH7N
 LNBtk=
X-Gm-Gg: AYBFou2g4IC8foTaLNh957GV8TEFvqG71svi9qfWt+xZhJwtwydzh9Sl6jkh0mDJbSm
 Vro7p8J+jx9HehY9SPUePL5ns6+3Kxgd01Q/JrLuiLN5cWD/yI+k/OZKAY4nFEEAYsRRlJ02YOS
 dpb8fLupwYIQpRZpEx7FBD/Meid9SsWFOGNrzIJBNpWrGHTmBbNK3pUTIGTaYEMD98QGieE2p1t
 NzIDPnBs9KBbUrfrNyndCZr4k29YDOK/x8gQRqfVVnCA8/8suK/fFWlXgkhKODNu4MtoDHZsD/G
 e5DjQptt7it09NxGYmEei+/qdMpxjbecWbfdP8QaaanPGiMPKgulCwPeQh2DYwc3XPVvL42Vk2S
 695v7RfD4Eg==
X-Received: by 2002:a17:90a:e7d2:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39b260d296cmr7820115a91.3.1788526241217; 
 Fri, 04 Sep 2026 05:50:41 -0700 (PDT)
X-Received: by 2002:a17:90a:e7d2:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39b260d296cmr7820052a91.3.1788526240580; 
 Fri, 04 Sep 2026 05:50:40 -0700 (PDT)
Received: from ZBook.gateway ([123.208.39.53])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b260cd15asm4571343a91.4.2026.09.04.05.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:50:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri,  4 Sep 2026 22:50:31 +1000
Message-ID: <20260904125031.89015-1-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cpuset_memory_spread: count only the test file's
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
resides on. It writes the per-node totals (in KB) to a result file that
the shell reads.

result_check() then simply verifies that the file's cache landed on the
expected node(s) and that the other nodes hold at most a small fraction
(UNEXPECTED_TOLERANCE, 5%) of it. Because only this file's pages are
counted, unrelated page-cache activity can no longer perturb the result,
and the check is page-size independent.

On non-NUMA machines the test is still skipped as before.

Signed-off-by: Changwei Zou <changwei.zou@canonical.com>
---
 .../cpuset_mem_hog.c                          | 130 +++++++++++++++++-
 .../cpuset_memory_spread_testset.sh           | 106 +++++++-------
 2 files changed, 175 insertions(+), 61 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
index 56e039eee..c04aabd48 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
@@ -27,17 +27,143 @@
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
+/* Upper bound on the number of NUMA nodes we account for. */
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
+	unsigned long npages, i, off;
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
+	for (i = 0; i < npages; i++) {
+		if (status[i] >= 0 && status[i] < MAX_NODES)
+			counts[status[i]]++;
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
@@ -54,7 +180,7 @@ int page_cache_hog(void)
 	char path[BUFFER_SIZE];
 	int ret = 0;
 
-	sprintf(path, "%s", "DATAFILE");
+	sprintf(path, "%s", DATAFILE);
 	fd = open(path, O_RDONLY);
 	if (fd == -1) {
 		warn("open %s failed", path);
@@ -81,6 +207,8 @@ int mem_hog(void)
 
 	while (!end) {
 		ret = page_cache_hog();
+		if (ret == 0)
+			ret = count_file_pages();
 
 		fd = open("./myfifo", O_WRONLY);
 		if (fd == -1)
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index 4c49bb8fd..3d0aff602 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -34,27 +34,22 @@ exit_status=0
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
-
-PAGE_SIZE=`tst_getconf PAGESIZE`
-lowerlimit=$((PAGE_SIZE * 512 / 1024))
+# The cache hog (cpuset_mem_hog) reads DATAFILE and reports, per NUMA node,
+# how much of DATAFILE's own page cache resides on that node (in KB).  Because
+# only this file's pages are accounted, unrelated page-cache activity on the
+# system does not affect the result.  The pages must land on the expected
+# node(s); the other nodes may hold at most the following fraction of them.
+UNEXPECTED_TOLERANCE=5
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
-mems_all="$(seq -s, 0 $((nr_mems-1)))"
 
 nodedir="/sys/devices/system/node"
 
 FIFO="./myfifo"
 
+# per-node page-cache accounting of DATAFILE written by cpuset_mem_hog
+HOG_RESULT="./cpuset_mem_hog_nodes"
+
 # memsinfo is an array implementation of the form of a multi-line string
 # _0: value0
 # _1: value1
@@ -131,69 +126,60 @@ freemem_check()
 	done
 }
 
-# get_memsinfo
-get_memsinfo()
+# load_hog_result
+# Load the per-node page-cache accounting of DATAFILE that cpuset_mem_hog
+# wrote to $HOG_RESULT into the memsinfo array.  Each line is "node kb".
+load_hog_result()
 {
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
+# other nodes should hold at most UNEXPECTED_TOLERANCE percent of it.  Only
+# DATAFILE's own pages are accounted (see cpuset_mem_hog), so unrelated
+# page-cache activity no longer perturbs the result.
 # return 0: success
 #	 1: fail
 result_check()
 {
 	local nodelist="`echo $1 | sed -e 's/,/ /g'`"
-	local i=
+	local i= total=0 expected_sum=0 unexpected_sum=0
 
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
-	done
-
-	for i in $othernodelist
-	do
-		if [ $(get_memsinfo_val $i) -gt $lowerlimit ]; then
+		# every expected node must hold a share of the cache
+		if [ $(get_memsinfo_val $i) -eq 0 ]; then
 			return 1
 		fi
+		expected_sum=$((expected_sum + $(get_memsinfo_val $i)))
 	done
+
+	unexpected_sum=$((total - expected_sum))
+
+	# report the actual fraction landing on the unexpected node(s)
+	tst_resm TINFO "unexpected nodes hold $(awk -v u=$unexpected_sum -v t=$total \
+		'BEGIN { printf "%.2f", u * 100 / t }')% of DATAFILE's page cache (tolerance ${UNEXPECTED_TOLERANCE}%)."
+
+	# the unexpected nodes must hold only a negligible fraction
+	if [ $((unexpected_sum * 100)) -ge $((total * UNEXPECTED_TOLERANCE)) ]; then
+		return 1
+	fi
 }
 
 # general_memory_spread_test <cpusetpath> <is_spread> <cpu_list> <node_list> \
@@ -238,7 +224,7 @@ general_memory_spread_test()
 		return 1
 	fi
 
-	get_memsinfo
+	rm -f $HOG_RESULT
 	/bin/kill -s SIGUSR1 $test_pid
 	read exit_num < $FIFO
 	if [ $exit_num -eq 0 ]; then
@@ -246,10 +232,10 @@ general_memory_spread_test()
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
@@ -357,6 +343,6 @@ fi
 test_spread_page1
 test_spread_page2
 
-rm -f DATAFILE $FIFO
+rm -f DATAFILE $FIFO $HOG_RESULT
 
 exit $exit_status
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
