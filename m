Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDCBC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:33:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D45FE3C98AA
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:33:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36D663C79FA
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:12 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 638FD630072
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B30A21102;
 Mon, 10 Feb 2025 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hz0wV9Aq94pDEc9RBy+iecdyQGfIqi723/085/Nkt6M=;
 b=hXc9Ea31BtR2WomhQLzCFrz9Sa73ZiwbNEDlU8u8nqt7koBvpEbQOeinAQQiIEmwXhhRgK
 xSDq0ITZvbLlbi6beaEfAaqkt0+bVnspnmSX+uo9EphvwNRlJRXQ/o24uo7L6vTOa3GEZi
 ffPGXEhuHlseL0BXMXecwlRT1pgnzkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hz0wV9Aq94pDEc9RBy+iecdyQGfIqi723/085/Nkt6M=;
 b=vwXNuzZwgXj83hi0hTLudqyS+2EsaE7AIOcwxGm42w6nxwRXycQpJ9k1RBmgN+SSizIv5+
 2vbomsar7xRjH6DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hz0wV9Aq94pDEc9RBy+iecdyQGfIqi723/085/Nkt6M=;
 b=hXc9Ea31BtR2WomhQLzCFrz9Sa73ZiwbNEDlU8u8nqt7koBvpEbQOeinAQQiIEmwXhhRgK
 xSDq0ITZvbLlbi6beaEfAaqkt0+bVnspnmSX+uo9EphvwNRlJRXQ/o24uo7L6vTOa3GEZi
 ffPGXEhuHlseL0BXMXecwlRT1pgnzkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hz0wV9Aq94pDEc9RBy+iecdyQGfIqi723/085/Nkt6M=;
 b=vwXNuzZwgXj83hi0hTLudqyS+2EsaE7AIOcwxGm42w6nxwRXycQpJ9k1RBmgN+SSizIv5+
 2vbomsar7xRjH6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40DFA13A62;
 Mon, 10 Feb 2025 11:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y/i0DrrjqWftYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:10 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:02 +0100
Message-ID: <20250210113212.29520-4-chrubis@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/13] lib: Add tst_mapping_in_range()
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

This moves the range_is_mapped() function from
testcases/kernel/mem/lib/mem.c to a top level library and renames the
function to a better fitting name.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_memutils.h                        | 11 +++++++
 lib/tst_memutils.c                            | 31 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  4 +--
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  |  4 +--
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  |  6 ++--
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       |  2 +-
 testcases/kernel/mem/include/mem.h            |  2 --
 testcases/kernel/mem/lib/mem.c                | 32 -------------------
 8 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 0dd941ced..57c90c4a9 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -60,4 +60,15 @@ void tst_disable_oom_protection(pid_t pid);
 
 #define TST_PRINT_MEMINFO() safe_print_file(__FILE__, __LINE__, "/proc/meminfo")
 
+/**
+ * tst_mapping_in_range() - Returns true if there is a mapping provided range.
+ *
+ * @low: A lower address inside of the processe address space.
+ * @high: A higher address inside of the processe address space.
+ *
+ * return: Returns true if there is a mapping between low and high addresses in
+ *         the process address space.
+ */
+int tst_mapping_in_range(unsigned long low, unsigned long high);
+
 #endif /* TST_MEMUTILS_H__ */
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index e33f19d29..e49684ba1 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -14,6 +14,7 @@
 #include "tst_test.h"
 #include "tst_memutils.h"
 #include "tst_capability.h"
+#include "tst_safe_stdio.h"
 #include "lapi/syscalls.h"
 
 #define BLOCKSIZE (16 * 1024 * 1024)
@@ -184,3 +185,33 @@ void tst_disable_oom_protection(pid_t pid)
 {
 	set_oom_score_adj(pid, 0);
 }
+
+int tst_mapping_in_range(unsigned long low, unsigned long high)
+{
+	FILE *fp;
+
+	fp = SAFE_FOPEN("/proc/self/maps", "r");
+
+	while (!feof(fp)) {
+		unsigned long start, end;
+		int ret;
+
+		ret = fscanf(fp, "%lx-%lx %*[^\n]\n", &start, &end);
+		if (ret != 2) {
+			fclose(fp);
+			tst_brk(TBROK | TERRNO, "Couldn't parse /proc/self/maps line.");
+		}
+
+		if ((start >= low) && (start < high)) {
+			fclose(fp);
+			return 1;
+		}
+		if ((end >= low) && (end < high)) {
+			fclose(fp);
+			return 1;
+		}
+	}
+
+	fclose(fp);
+	return 0;
+}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index b788aeafb..611ae7090 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -62,7 +62,7 @@ static void test_hugemmap(void)
 		addrlist[i] = addr;
 	}
 
-	while (range_is_mapped(low_addr, low_addr + map_sz) == 1) {
+	while (tst_mapping_in_range(low_addr, low_addr + map_sz) == 1) {
 		low_addr = low_addr + 0x10000000;
 
 		if (low_addr < LOW_ADDR)
@@ -74,7 +74,7 @@ static void test_hugemmap(void)
 	if (addr == MAP_FAILED)
 		tst_brk(TBROK | TERRNO, "mmap failed on nfildes");
 
-	while (range_is_mapped(low_addr2, low_addr2 + map_sz) == 1) {
+	while (tst_mapping_in_range(low_addr2, low_addr2 + map_sz) == 1) {
 		low_addr2 = low_addr2 + 0x10000000;
 
 		if (low_addr2 < LOW_ADDR2)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
index 06b5f8e08..90539aaeb 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -45,7 +45,7 @@ static void run_test(void)
 		below_start = FOURGB;
 		above_end = 1024ULL*1024*1024*1024;
 
-		if (range_is_mapped(below_start, above_end) == 1) {
+		if (tst_mapping_in_range(below_start, above_end) == 1) {
 			tst_res(TINFO|TERRNO, "region 4G-IT is not free & "
 					"mmap() failed expected");
 			tst_res(TPASS, "Successful but inconclusive");
@@ -70,7 +70,7 @@ static void run_test(void)
 		below_start = FOURGB - MMAP_GRANULARITY;
 		above_end = FOURGB;
 
-		if (range_is_mapped(below_start, above_end) == 1) {
+		if (tst_mapping_in_range(below_start, above_end) == 1) {
 			tst_res(TINFO|TERRNO, "region (4G-MMAP_GRANULARITY)-4G is not free & "
 					"mmap() failed expected");
 			tst_res(TPASS, "Successful but inconclusive");
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
index d262b65b2..d3c43b024 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -50,7 +50,7 @@ static void run_test(void)
 		below_start = FOURGB - 256ULL*1024*1024;
 		above_end = FOURGB;
 
-		if (range_is_mapped(below_start, above_end) == 1) {
+		if (tst_mapping_in_range(below_start, above_end) == 1) {
 			tst_res(TINFO|TERRNO, "region (4G-256M)-4G is not free & "
 					"mmap() failed expected");
 			tst_res(TPASS, "Successful but inconclusive");
@@ -73,7 +73,7 @@ static void run_test(void)
 		below_start = FOURGB;
 		above_end = FOURGB + page_size;
 
-		if (range_is_mapped(below_start, above_end) == 1) {
+		if (tst_mapping_in_range(below_start, above_end) == 1) {
 			tst_res(TINFO|TERRNO, "region 4G-(4G+page) is not free & "
 					"mmap() failed expected");
 			tst_res(TPASS, "Successful but inconclusive");
@@ -101,7 +101,7 @@ static void run_test(void)
 		below_start = highaddr;
 		above_end = highaddr + page_size;
 
-		if (range_is_mapped(below_start, above_end) == 1) {
+		if (tst_mapping_in_range(below_start, above_end) == 1) {
 			tst_res(TINFO|TERRNO, "region haddr-(haddr+page) not free & "
 					"mmap() failed unexpected");
 			tst_res(TPASS, "Successful but inconclusive");
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 0d7bbf64f..9f877fd07 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -55,7 +55,7 @@ static void shared_hugepage(void)
 		tst_brk(TBROK | TERRNO, "shmget");
 
 	while (boundary <= BOUNDARY_MAX
-		&& range_is_mapped(boundary, boundary+SIZE))
+		&& tst_mapping_in_range(boundary, boundary+SIZE))
 		boundary += 128*1024*1024;
 	if (boundary > BOUNDARY_MAX)
 		tst_brk(TCONF, "failed to find free unmapped range");
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 87528fdd0..7251a8839 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -73,6 +73,4 @@ unsigned int get_a_numa_node(void);
 
 void update_shm_size(size_t *shm_size);
 
-/* MMAP */
-int range_is_mapped(unsigned long low, unsigned long high);
 #endif
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index f293e766e..16eb39cba 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -636,35 +636,3 @@ void update_shm_size(size_t * shm_size)
 		*shm_size = shmmax;
 	}
 }
-
-int range_is_mapped(unsigned long low, unsigned long high)
-{
-	FILE *fp;
-
-	fp = fopen("/proc/self/maps", "r");
-	if (fp == NULL)
-		tst_brk(TBROK | TERRNO, "Failed to open /proc/self/maps.");
-
-	while (!feof(fp)) {
-		unsigned long start, end;
-		int ret;
-
-		ret = fscanf(fp, "%lx-%lx %*[^\n]\n", &start, &end);
-		if (ret != 2) {
-			fclose(fp);
-			tst_brk(TBROK | TERRNO, "Couldn't parse /proc/self/maps line.");
-		}
-
-		if ((start >= low) && (start < high)) {
-			fclose(fp);
-			return 1;
-		}
-		if ((end >= low) && (end < high)) {
-			fclose(fp);
-			return 1;
-		}
-	}
-
-	fclose(fp);
-	return 0;
-}
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
