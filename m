Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09BA606A31A
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 07:08:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BD293E216C
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 08:08:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77EE13E217F
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 08:07:56 +0100 (CET)
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com
 [115.124.28.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 682546002E5
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 08:07:54 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436264|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0728574-0.00375129-0.923391;
 FP=8616006831914929659|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033032065030;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.jpkJxXX_1792998470; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jpkJxXX_1792998470 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 26 Oct 2026 15:07:51 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Mon, 26 Oct 2026 15:07:31 +0800
Message-ID: <20261026070732.74314-3-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261026070732.74314-1-yehuaisheng@open-hieco.net>
References: <20261026070732.74314-1-yehuaisheng@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] hugemmap10: Add private MAP_NORESERVE test mode
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add -n to apply MAP_NORESERVE only to private mappings. Shared
mappings retain their original flags and reservation behavior.

Use the private mapping flags for both the reservation probe and test
mappings. This makes private_resv and its TDEBUG report reflect whether
the mappings in use create a hugetlb reservation at mmap() time.

The option lets the test exercise fault-time allocation for unreserved
private mappings without booting a kernel that lacks private mmap-time
reservations. MAP_NORESERVE faults allocate unreserved hugepages without
creating a mapping reservation, so HugePages_Rsvd remains unchanged.

Add hugemmap10 -n to runtest/hugetlb with the distinct identifier
hugemmap10_noreserve so session restore and reboot recovery can track
both invocations independently.

Use private_noreserve_opt directly as the option presence flag. Define
MAP_TYPE in lapi/mmap.h for libc implementations that lack it.

Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
Reviewed-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 include/lapi/mmap.h                           |  4 +++
 runtest/hugetlb                               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 27 ++++++++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index f20eb3bd5..12085ae27 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -14,6 +14,10 @@
 # define MAP_SHARED_VALIDATE 0x03
 #endif
 
+#ifndef MAP_TYPE
+# define MAP_TYPE 0x0f
+#endif
+
 #ifndef MAP_HUGETLB
 # define MAP_HUGETLB 0x40000
 #endif
diff --git a/runtest/hugetlb b/runtest/hugetlb
index 621c9718a..5288449b7 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -13,6 +13,7 @@ hugemmap07 hugemmap07
 hugemmap08 hugemmap08
 hugemmap09 hugemmap09
 hugemmap10 hugemmap10
+hugemmap10_noreserve hugemmap10 -n
 hugemmap11 hugemmap11
 hugemmap12 hugemmap12
 hugemmap13 hugemmap13
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 7abda1182..08597049d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -25,6 +25,7 @@
 #include <sys/types.h>
 
 #include "hugetlb.h"
+#include "lapi/mmap.h"
 #include "lapi/syscalls.h"
 
 #define MNTPOINT "hugetlbfs/"
@@ -32,6 +33,7 @@
 
 static long hpage_size;
 static int private_resv;
+static char *private_noreserve_opt;
 
 #define NR_SLOTS	2
 #define SL_SETUP	0
@@ -125,6 +127,16 @@ static int mapping_creates_reservation(int flags)
 	return (flags & MAP_SHARED) || private_resv;
 }
 
+/* Exercise fault-time allocation for unreserved private mappings. */
+static int private_mmap_flags(int flags)
+{
+	if (private_noreserve_opt &&
+	    (flags & MAP_TYPE) == MAP_PRIVATE)
+		return flags | MAP_NORESERVE;
+
+	return flags;
+}
+
 static unsigned long read_allowed_free_hugepages(void)
 {
 	char path[PATH_MAX];
@@ -194,7 +206,8 @@ static int kernel_has_private_reservations(void)
 	read_meminfo_huge(&t, &f, &r, &s);
 	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 
-	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE,
+		      private_mmap_flags(MAP_PRIVATE), fd, 0);
 
 	read_meminfo_huge(&nt, &nf, &nr, &ns);
 
@@ -322,8 +335,9 @@ static int map_(int s, int hpages, int flags, char *desc, int line)
 	map_size[s] = hpages * hpage_size;
 	if (creates_reservation)
 		allowed_free = read_allowed_free_hugepages();
-	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE, flags,
-				map_fd[s], 0);
+	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE,
+			private_mmap_flags(flags),
+			map_fd[s], 0);
 	touched[s] = 0;
 
 	et = prev_total;
@@ -573,6 +587,8 @@ static void setup(void)
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
 	SAFE_FILE_PRINTF(PATH_VM_OVERCOMMIT_HPAGES, "%lu", tst_hugepages);
 	private_resv = kernel_has_private_reservations();
+	tst_res(TDEBUG, "MAP_PRIVATE mmap() %s a hugetlb reservation",
+		private_resv ? "creates" : "does not create");
 }
 
 static void cleanup(void)
@@ -582,6 +598,11 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
+	.options = (struct tst_option[]) {
+		{"n", &private_noreserve_opt,
+		 "Map private VMAs with MAP_NORESERVE"},
+		{}
+	},
 	.mntpoint = MNTPOINT,
 	.needs_hugetlbfs = 1,
 	.save_restore = (const struct tst_path_val[]) {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
