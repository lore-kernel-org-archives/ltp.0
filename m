Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5291CC4332F
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 09:31:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCA623CE86B
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 10:31:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C96883C26EE
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 10:30:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1C001400450
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 10:30:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699263039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3X8UM2rmp/5TUEgsN2Uqr/aaYH9cCL1EEaYuRj2puLI=;
 b=CNqjHxCzTtWW8HaRK6hucz+nkfSwS4OaYpHeJGdCIunDE7ehaJErCOHdOjK96mIEavnmJT
 3/ixr9KFCqq5/1eygG8Y9Gg5zpe/C8cRxpi66RPFEJ6FY9bYFyGGugIDDk5DROY0UCPguL
 vl3yAGl9jDFQC2zNLahFGV7n0UfWMJ8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-XQLJfQOvNXSR3hT9SUsAyw-1; Mon,
 06 Nov 2023 04:30:37 -0500
X-MC-Unique: XQLJfQOvNXSR3hT9SUsAyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D3392810D44
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 09:30:37 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FD9A1C060AE
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 09:30:36 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  6 Nov 2023 17:30:29 +0800
Message-Id: <20231106093031.1844129-2-liwang@redhat.com>
In-Reply-To: <20231106093031.1844129-1-liwang@redhat.com>
References: <20231106093031.1844129-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] lib: add support for kinds of hpsize
 reservation
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

Typically when we make use of huge page via LTP library, .hugepages choose
the default hugepage size, but this can not satisfy all scenarios.

So this patch introduces applying a specified types of hugepage for user.

There is nothing that needs to change for the existing test cases which
already using .hugepages, it only needs to fill one more field in the
structure of .hugepages if a different type (GIGANTIC or HUGE) is required.

e.g.

    static struct tst_test test = {
	.needs_root = 1,
	...
	.hugepages = {2, TST_NEEDS, TST_GIGANTIC},
    };

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/C-Test-API.asciidoc | 42 +++++++++++++++++++++++++--
 include/tst_hugepage.h  | 11 +++++++
 lib/tst_hugepage.c      | 63 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
index dab811564..82a1866d3 100644
--- a/doc/C-Test-API.asciidoc
+++ b/doc/C-Test-API.asciidoc
@@ -2034,9 +2034,13 @@ For full documentation see the comments in 'include/tst_fuzzy_sync.h'.
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 Many of the LTP tests need to use hugepage in their testing, this allows the
-test can reserve hugepages from system via '.hugepages = {xx, TST_REQUEST}'.
+test can reserve specify size of hugepages from system via:
+  '.hugepages = {xx, TST_REQUEST, TST_HUGE}'  or,
+  '.hugepages = {xx, TST_NEEDS,   TST_GIGANTIC}'.
 
-We achieved two policies for reserving hugepages:
+xx: This is used to set how many pages we wanted.
+
+Two policies for reserving hugepage:
 
 TST_REQUEST:
   It will try the best to reserve available huge pages and return the number
@@ -2049,6 +2053,17 @@ TST_NEEDS:
   use these specified numbers correctly. Otherwise, test exits with TCONF if
   the attempt to reserve hugepages fails or reserves less than requested.
 
+Two types of the reserved hugepage (optional field):
+
+TST_HUGE:
+  It means target for reserve the default hugepage size (e.g. 2MB on x86_64).
+  And, if nothing fills in this field LTP also chooses the default hugepage
+  size to reserve. i.e.
+  '.hugepages = {xx, TST_REQUEST}' == '.hugepages = {xx, TST_REQUEST, TST_HUGE}'
+
+TST_GIGANTIC:
+  It means target for reserve the largest hugepage size (e.g. 1GB on x86_64)
+
 With success test stores the reserved hugepage number in 'tst_hugepages'. For
 system without hugetlb supporting, variable 'tst_hugepages' will be set to 0.
 If the hugepage number needs to be set to 0 on supported hugetlb system, please
@@ -2103,6 +2118,29 @@ struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+or,
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static void run(void)
+{
+	...
+}
+
+struct tst_test test = {
+	.test_all = run,
+	/*
+	 * Specify gigantic page sizes reserved automatically in the library
+	 * $ echo 2 > /sys/kernel/mm//hugepages/hugepages-1048576kB/nr_hugepages
+	 * Do check if 2 hpages are reserved correctly in there.
+	 */
+	.hugepages = {2, TST_NEEDS, TST_GIGANTIC},
+	...
+};
+-------------------------------------------------------------------------------
+
 1.35 Checking for required commands
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index 46327c79a..725b4ddaf 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -24,9 +24,15 @@ enum tst_hp_policy {
 	TST_NEEDS,
 };
 
+enum tst_hp_type {
+	TST_HUGE,
+	TST_GIGANTIC,
+};
+
 struct tst_hugepage {
 	const unsigned long number;
 	enum  tst_hp_policy policy;
+	enum  tst_hp_type   hptype;
 };
 
 /*
@@ -34,6 +40,11 @@ struct tst_hugepage {
  */
 size_t tst_get_hugepage_size(void);
 
+/*
+ * Get the largest hugepage (gigantic) size. Returns 0 if hugepages are not supported.
+ */
+size_t tst_get_gigantic_size(void);
+
 /*
  * Try the best to request a specified number of huge pages from system,
  * it will store the reserved hpage number in tst_hugepages.
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index d2e70a955..3a7c412f3 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -5,6 +5,7 @@
 
 #define TST_NO_DEFAULT_MAIN
 
+#include <stdio.h>
 #include "tst_test.h"
 #include "tst_hugepage.h"
 
@@ -20,11 +21,35 @@ size_t tst_get_hugepage_size(void)
 	return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 }
 
+size_t tst_get_gigantic_size(void)
+{
+	DIR *dir;
+	struct dirent *ent;
+	unsigned long max, g_pgsz;
+
+	max = tst_get_hugepage_size() / 1024;
+
+	/*
+	 * Scanning the largest hugepage sisze, for example aarch64 configuration:
+	 * hugepages-1048576kB hugepages-32768kB hugepages-2048kB hugepages-64kB
+	 */
+	dir = SAFE_OPENDIR(PATH_HUGEPAGES);
+	while ((ent = SAFE_READDIR(dir)) != NULL) {
+		if (sscanf(ent->d_name, "hugepages-%lukB", &g_pgsz)
+				&& (g_pgsz > max))
+			max = g_pgsz;
+	}
+
+	SAFE_CLOSEDIR(dir);
+	return max * 1024;
+}
+
 unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 {
-	unsigned long val, max_hpages;
+	unsigned long val, max_hpages, hpsize;
+	char hugepage_path[PATH_MAX];
 	struct tst_path_val pvl = {
-		.path = PATH_NR_HPAGES,
+		.path = hugepage_path,
 		.val = NULL,
 		.flags = TST_SR_SKIP_MISSING | TST_SR_TCONF_RO
 	};
@@ -41,6 +66,19 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 	else
 		tst_hugepages = hp->number;
 
+	if (hp->hptype == TST_GIGANTIC)
+		hpsize = tst_get_gigantic_size() / 1024;
+	else
+		hpsize = tst_get_hugepage_size() / 1024;
+
+	sprintf(hugepage_path, PATH_HUGEPAGES"/hugepages-%lukB/nr_hugepages", hpsize);
+	if (access(hugepage_path, F_OK)) {
+		if (hp->policy == TST_NEEDS)
+			tst_brk(TCONF, "Hugepage size %lu not supported", hpsize);
+		tst_hugepages = 0;
+		goto out;
+	}
+
 	if (hp->number == TST_NO_HUGEPAGES) {
 		tst_hugepages = 0;
 		goto set_hugepages;
@@ -49,11 +87,18 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
 	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");
 	if (hp->policy == TST_NEEDS) {
+		/*
+		 * In case of the gigantic page configured as the default hugepage size,
+		 * we have to garantee the TST_NEEDS take effect.
+		 */
+		if (tst_get_gigantic_size() != tst_get_hugepage_size())
+			goto set_hugepages;
+
 		tst_hugepages += SAFE_READ_MEMINFO("HugePages_Total:");
 		goto set_hugepages;
 	}
 
-	max_hpages = SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
+	max_hpages = SAFE_READ_MEMINFO("MemFree:") / hpsize;
 	if (tst_hugepages > max_hpages) {
 		tst_res(TINFO, "Requested number(%lu) of hugepages is too large, "
 				"limiting to 80%% of the max hugepage count %lu",
@@ -66,22 +111,26 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 
 set_hugepages:
 	tst_sys_conf_save(&pvl);
-	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", tst_hugepages);
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
+
+	SAFE_FILE_PRINTF(hugepage_path, "%lu", tst_hugepages);
+	SAFE_FILE_SCANF(hugepage_path, "%lu", &val);
+
 	if (val != tst_hugepages)
 		tst_brk(TCONF, "nr_hugepages = %lu, but expect %lu. "
 				"Not enough hugepages for testing.",
 				val, tst_hugepages);
 
 	if (hp->policy == TST_NEEDS) {
-		unsigned long free_hpages = SAFE_READ_MEMINFO("HugePages_Free:");
+		unsigned long free_hpages;
+		sprintf(hugepage_path, PATH_HUGEPAGES"/hugepages-%lukB/free_hugepages", hpsize);
+		SAFE_FILE_SCANF(hugepage_path, "%lu", &free_hpages);
 		if (hp->number > free_hpages)
 			tst_brk(TCONF, "free_hpages = %lu, but expect %lu. "
 				"Not enough hugepages for testing.",
 				free_hpages, hp->number);
 	}
 
-	tst_res(TINFO, "%lu hugepage(s) reserved", tst_hugepages);
+	tst_res(TINFO, "%lu (%luMB) hugepage(s) reserved", tst_hugepages, hpsize/1024);
 out:
 	return tst_hugepages;
 }
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
