Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E85FCA9EBE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:53:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3D093E4A1D
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:53:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1BB93E2D2C
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:52:27 +0200 (CEST)
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com
 [115.124.28.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E0DF160029E
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:52:24 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436261|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0714373-0.00369028-0.924872;
 FP=9192537403206714875|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033032062159;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.jYP2TrP_1791625940; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jYP2TrP_1791625940 cluster:ay29) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 17:52:20 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Sat, 10 Oct 2026 17:51:54 +0800
Message-ID: <20261010095155.117953-3-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261010095155.117953-1-yehuaisheng@open-hieco.net>
References: <20261010095155.117953-1-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] hugemmap10: Add private MAP_NORESERVE test mode
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add -n to apply MAP_NORESERVE only to private mappings. Shared
mappings retain their original flags and reservation behavior.

Use the private mapping flags for both the reservation probe and test
mappings. This makes private_resv and its TDEBUG report reflect whether
the mappings in use create a hugetlb reservation at mmap() time.

The option lets the test exercise the fault-time private reservation
path used by upstream kernels without booting an older kernel. Add
hugemmap10 -n to runtest/hugetlb so the default suite covers that path.

Use private_noreserve_opt directly as the option presence flag. Define
MAP_TYPE in lapi/mmap.h for libc implementations that lack it.

Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
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
index 621c9718a..f5ffa7292 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -13,6 +13,7 @@ hugemmap07 hugemmap07
 hugemmap08 hugemmap08
 hugemmap09 hugemmap09
 hugemmap10 hugemmap10
+hugemmap10 hugemmap10 -n
 hugemmap11 hugemmap11
 hugemmap12 hugemmap12
 hugemmap13 hugemmap13
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 1f8d00226..43aca50e1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -24,6 +24,7 @@
 #include <sys/types.h>
 
 #include "hugetlb.h"
+#include "lapi/mmap.h"
 #include "lapi/syscalls.h"
 
 #define MNTPOINT "hugetlbfs/"
@@ -31,6 +32,7 @@
 
 static long hpage_size;
 static int private_resv;
+static char *private_noreserve_opt;
 
 #define NR_SLOTS	2
 #define SL_SETUP	0
@@ -90,6 +92,16 @@ static int mapping_creates_reservation(int flags)
 	return (flags & MAP_SHARED) || private_resv;
 }
 
+/* Exercise the fault-time reservation path used by older kernels. */
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
@@ -155,7 +167,8 @@ static int kernel_has_private_reservations(void)
 	read_meminfo_huge(&t, &f, &r, &s);
 	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 
-	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE,
+		      private_mmap_flags(MAP_PRIVATE), fd, 0);
 
 	read_meminfo_huge(&nt, &nf, &nr, &ns);
 
@@ -283,8 +296,9 @@ static int map_(int s, int hpages, int flags, char *desc, int line)
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
@@ -534,6 +548,8 @@ static void setup(void)
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
 	SAFE_FILE_PRINTF(PATH_VM_OVERCOMMIT_HPAGES, "%lu", tst_hugepages);
 	private_resv = kernel_has_private_reservations();
+	tst_res(TDEBUG, "MAP_PRIVATE mmap() %s a hugetlb reservation",
+		private_resv ? "creates" : "does not create");
 }
 
 static void cleanup(void)
@@ -543,6 +559,11 @@ static void cleanup(void)
 
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
