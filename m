Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240151093163
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 02:08:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FD1D3E491F
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 03:08:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0964F3D0683
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 03:08:04 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 348221A0049E
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 03:08:01 +0100 (CET)
X-UUID: 965ae354240111f1a21c59e7364eecb8-20260320
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
 DMARC_NOPASS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:dc72e87a-46f9-4eb6-9d4b-37c364fe0683, IP:10,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:30
X-CID-INFO: VERSION:1.3.11, REQID:dc72e87a-46f9-4eb6-9d4b-37c364fe0683, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:30
X-CID-META: VersionHash:89c9d04, CLOUDID:c9c808d257f1a1bc761d5ac49c7dde6b,
 BulkI
 D:2603201007496OVVBHDI,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
 27|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
 S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
 ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 965ae354240111f1a21c59e7364eecb8-20260320
X-User: gaoxiang@kylinos.cn
Received: from fedora [(183.242.174.20)] by mailgw.kylinos.cn
 (envelope-from <gaoxiang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1200474721; Fri, 20 Mar 2026 10:07:46 +0800
From: Gao Xiang <gaoxiang@kylinos.cn>
To: ltp@lists.linux.it
Date: Fri, 20 Mar 2026 10:07:30 +0800
Message-ID: <20260320020730.11233-1-gaoxiang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <abvtSlnT-1P2pYZG@redhat.com>
References: <abvtSlnT-1P2pYZG@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] madvise09: support cgroup v2 via LTP cgroup API
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

Replace hard-coded cgroup v1 memory controller handling in madvise09
with the LTP cgroup framework and cgroup v2 control file names..

Rename the related limit variable to reflect the new interface instead
of the old memsw naming since memsw.limit_in_bytes and memory.swap.max
are different between cgroup v1 and v2.

Also fix the munmap length argument to unmap the whole mapped area.

Changes in v2:
- Drop .needs_cgroup_ver = 2 becasue cgroup framework already maps
v2 control files to v1.
- Renmae the comments to use v2 control file names.

Tested by running:
madvise09 -i 10
make check-madvise09

Signed-off-by: Gao Xiang <gaoxiang@kylinos.cn>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 82 +++++--------------
 1 file changed, 21 insertions(+), 61 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 1a5cc9dcf..a120c03fd 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -17,8 +17,8 @@
  * o Write to some of the madvised pages again, these must not be freed
  *
  * o Set memory limits
- *   - limit_in_bytes = 8MB
- *   - memsw.limit_in_bytes = 16MB
+ *   - memory.max = 8MB
+ *   - memory.swap.max = 16MB
  *
  *   The reason for doubling the limit_in_bytes is to have safe margin
  *   for forking the memory hungy child etc. And the reason to setting
@@ -45,13 +45,6 @@
 #include "tst_test.h"
 #include "lapi/mmap.h"
 
-#define MEMCG_PATH "/sys/fs/cgroup/memory/"
-
-static char cgroup_path[PATH_MAX];
-static char tasks_path[PATH_MAX];
-static char limit_in_bytes_path[PATH_MAX];
-static char memsw_limit_in_bytes_path[PATH_MAX];
-
 static size_t page_size;
 static int sleep_between_faults;
 
@@ -61,6 +54,9 @@ static int swap_accounting_enabled;
 #define TOUCHED_PAGE1 0
 #define TOUCHED_PAGE2 10
 
+#define MEM_LIMIT (8 * 1024 * 1024)
+#define SWAP_LIMIT (2 * MEM_LIMIT)
+
 static void memory_pressure_child(void)
 {
 	size_t i, page_size = getpagesize();
@@ -90,17 +86,6 @@ static void memory_pressure_child(void)
 	abort();
 }
 
-static void setup_cgroup_paths(int pid)
-{
-	snprintf(cgroup_path, sizeof(cgroup_path),
-		 MEMCG_PATH "ltp_madvise09_%i/", pid);
-	snprintf(tasks_path, sizeof(tasks_path), "%s/tasks", cgroup_path);
-	snprintf(limit_in_bytes_path, sizeof(limit_in_bytes_path),
-		 "%s/memory.limit_in_bytes", cgroup_path);
-	snprintf(memsw_limit_in_bytes_path, sizeof(memsw_limit_in_bytes_path),
-		 "%s/memory.memsw.limit_in_bytes", cgroup_path);
-}
-
 static int count_freed(char *ptr)
 {
 	int i, ret = 0;
@@ -157,14 +142,12 @@ static void child(void)
 {
 	size_t i;
 	char *ptr;
-	unsigned int usage, old_limit, old_memsw_limit;
 	int status, pid, retries = 0;
 
-	SAFE_MKDIR(cgroup_path, 0777);
-	SAFE_FILE_PRINTF(tasks_path, "%i", getpid());
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 
 	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
-	                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 	for (i = 0; i < PAGES * page_size; i++)
 		ptr[i] = 'a';
@@ -184,18 +167,15 @@ static void child(void)
 	ptr[TOUCHED_PAGE1 * page_size] = 'b';
 	ptr[TOUCHED_PAGE2 * page_size] = 'b';
 
-	usage = 8 * 1024 * 1024;
-	tst_res(TINFO, "Setting memory limits to %u %u", usage, 2 * usage);
-
-	SAFE_FILE_SCANF(limit_in_bytes_path, "%u", &old_limit);
-
-	if (swap_accounting_enabled)
-		SAFE_FILE_SCANF(memsw_limit_in_bytes_path, "%u", &old_memsw_limit);
-
-	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", usage);
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
+	tst_res(TINFO, "Setting memory.max to %d bytes", MEM_LIMIT);
 
-	if (swap_accounting_enabled)
-		SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", 2 * usage);
+	if (swap_accounting_enabled) {
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", SWAP_LIMIT);
+		tst_res(TINFO, "Setting memory.swap.max to %d bytes", SWAP_LIMIT);
+	} else {
+		tst_res(TINFO, "memory.swap.max is unavailable, running without SWAP_LIMIT");
+	}
 
 	do {
 		sleep_between_faults++;
@@ -204,7 +184,7 @@ static void child(void)
 		if (!pid)
 			memory_pressure_child();
 
-		tst_res(TINFO, "Memory hungry child %i started, try %i", pid, retries);
+		tst_res(TINFO, "Memory pressure process %i started, try %i", pid, retries);
 
 		SAFE_WAIT(&status);
 	} while (retries++ < 10 && count_freed(ptr) == 0);
@@ -251,22 +231,11 @@ static void child(void)
 	else
 		tst_res(TPASS, "All pages have expected content");
 
-	if (swap_accounting_enabled)
-		SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", old_memsw_limit);
-
-	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", old_limit);
-
-	SAFE_MUNMAP(ptr, PAGES);
+	SAFE_MUNMAP(ptr, PAGES * page_size);
 
 	exit(0);
 }
 
-static void cleanup(void)
-{
-	if (cgroup_path[0] && !access(cgroup_path, F_OK))
-		rmdir(cgroup_path);
-}
-
 static void run(void)
 {
 	pid_t pid;
@@ -275,14 +244,10 @@ static void run(void)
 retry:
 	pid = SAFE_FORK();
 
-	if (!pid) {
-		setup_cgroup_paths(getpid());
+	if (!pid)
 		child();
-	}
 
-	setup_cgroup_paths(pid);
 	SAFE_WAIT(&status);
-	cleanup();
 
 	/*
 	 * Rarely cgroup OOM kills both children not only the one that allocates
@@ -302,14 +267,9 @@ retry:
 
 static void setup(void)
 {
-	long int swap_total;
-
-	if (access(MEMCG_PATH, F_OK)) {
-		tst_brk(TCONF, "'" MEMCG_PATH
-			"' not present, CONFIG_MEMCG missing?");
-	}
+	long swap_total;
 
-	if (!access(MEMCG_PATH "memory.memsw.limit_in_bytes", F_OK))
+	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
 		swap_accounting_enabled = 1;
 	else
 		tst_res(TINFO, "Swap accounting is disabled");
@@ -323,8 +283,8 @@ static void setup(void)
 
 static struct tst_test test = {
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
