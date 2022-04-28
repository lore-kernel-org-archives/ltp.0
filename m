Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7A3C43217
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 13:30:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC0E83CA26E
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 15:30:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36B283CA26E
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:29:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 91BE51000417
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:29:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651152594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RuWqW10RDNCvwyLamN/fYftA/AOlbg/X/pE57HLWTrY=;
 b=SfI3cy/ck2hEtW9QKzi4KMYWQu5o7WMA6vuW/KK8MqTbb1JLXsECbhgeyoaSIrreCnLyTK
 soQH5agDyDAymZrg3Zqv5Bg1pNJqNs+Jg+QNZ+yMjnJmxXAF37HR6aP/k9x5N06n9jx8P7
 AJ935b7hleUb4WWjkD8djCA+YD9rFeE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-CHxsxG5nPYaKPs9Q5aOycA-1; Thu, 28 Apr 2022 09:29:53 -0400
X-MC-Unique: CHxsxG5nPYaKPs9Q5aOycA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15B85296A62B
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:29:53 +0000 (UTC)
Received: from liwang-laptop.redhat.com (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C325F40E7F06
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:29:51 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 28 Apr 2022 21:29:47 +0800
Message-Id: <20220428132949.11719-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/3] lib: extend .request_hugepages to guarantee
 enough pages
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

This is to satisfy some tests which need to reserved hugepage precisely
for using, with eliminating other process side effects at the same time.

For example, if there are 'N' (N > 1) hpages reserved but all occupying.
New '.request_hugepage = 1' in another test will only save the N and do
echo 1 into hugetlbfs. That obviously may cause problems during test run.

Here, we introduce two policies to make hugepage reserve work fit for
more requirements but no need to care about details.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/c-test-api.txt                    | 33 +++++++++++++++++++--------
 include/tst_hugepage.h                | 12 +++++++++-
 include/tst_test.h                    | 27 +++++++++++++++-------
 lib/newlib_tests/test20.c             | 13 +++++++----
 lib/newlib_tests/test_zero_hugepage.c |  8 +++++--
 lib/tst_hugepage.c                    | 22 ++++++++++++++----
 6 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 9f104ecd7..1eabdf7ca 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1976,15 +1976,25 @@ For full documentation see the comments in 'include/tst_fuzzy_sync.h'.
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 Many of the LTP tests need to use hugepage in their testing, this allows the
-test can reserve hugepages from system only via '.request_hugepages = xx'.
+test can reserve hugepages from system only via '.request_hugepages'.
 
-If set non-zero number of 'request_hugepages', test will try to reserve the
-expected number of hugepage for testing in setup phase. If system does not
-have enough hpage for using, it will try the best to reserve 80% available
-number of hpages. With success test stores the reserved hugepage number in
-'tst_hugepages'. For the system without hugetlb supporting, variable
-'tst_hugepages' will be set to 0. If the hugepage number needs to be set to 0
-on supported hugetlb system, please use '.request_hugepages = TST_NO_HUGEPAGES'.
+We simply achieved two policies for hugepage reserving:
+
+TST_FLEXIBLE:
+  If set non-zero number in .request_hugepages, ltp will try to reserve the
+  expected number of hugepage for testing in setup phase. If system does not
+  have enough memory for that, it will try the best to reserve 80% available
+  huge pages.
+
+TST_ENFORCED:
+  This is an enforced requirement for huge page reserve, ltp should strictly do
+  hpages applying and guarantee the 'HugePages_Free' no less than specified pages
+  which gives that test can use these specified numbers correctly.
+
+With success test stores the reserved hugepage number in 'tst_hugepages'. For
+system without hugetlb supporting, variable 'tst_hugepages' will be set to 0.
+If the hugepage number needs to be set to 0 on supported hugetlb system, please
+use '.request_hugepages = TST_NO_HUGEPAGES'.
 
 Also, we do cleanup and restore work for the hpages resetting automatically.
 
@@ -1996,7 +2006,7 @@ static void run(void)
 {
 	...
 
-	if (tst_hugepages == test.request_hugepages)
+	if (tst_hugepages == test.request_hugepages->number)
 		TEST(do_hpage_test);
 	else
 		...
@@ -2005,7 +2015,10 @@ static void run(void)
 
 struct tst_test test = {
 	.test_all = run,
-	.request_hugepages = 2,
+	.request_hugepages = (struct tst_hugepage []){
+		{2, TST_FLEXIBLE},
+		{}
+	},
 	...
 };
 -------------------------------------------------------------------------------
diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index e08a2daa2..17bd4e9da 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -12,6 +12,16 @@
 extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
 extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
 
+enum tst_hp_policy {
+	TST_ENFORCED,
+	TST_FLEXIBLE,
+};
+
+struct tst_hugepage {
+	const unsigned long number;
+	enum  tst_hp_policy policy;
+};
+
 /*
  * Get the default hugepage size. Returns 0 if hugepages are not supported.
  */
@@ -23,7 +33,7 @@ size_t tst_get_hugepage_size(void);
  *
  * Note: this depend on the status of system memory fragmentation.
  */
-unsigned long tst_request_hugepages(unsigned long hpages);
+unsigned long tst_request_hugepages(struct tst_hugepage *hp);
 
 /*
  * This variable is used for recording the number of hugepages which system can
diff --git a/include/tst_test.h b/include/tst_test.h
index dbe303bc8..d50d213ef 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -189,17 +189,28 @@ struct tst_test {
 	unsigned long min_mem_avail;
 
 	/*
-	 * If set non-zero number of request_hugepages, test will try to reserve the
-	 * expected number of hugepage for testing in setup phase. If system does not
-	 * have enough hpage for using, it will try the best to reserve 80% available
-	 * number of hpages. With success test stores the reserved hugepage number in
-	 * 'tst_hugepages. For the system without hugetlb supporting, variable
-	 * 'tst_hugepages' will be set to 0. If the hugepage number needs to be set to
-	 * 0 on supported hugetlb system, please use '.request_hugepages = TST_NO_HUGEPAGES'.
+	 * Two policies for hugepage reserving:
+	 *
+	 * TST_FLEXIBLE:
+	 *   If set non-zero number in .request_hugepages, ltp will try to reserve the
+	 *   expected number of hugepage for testing in setup phase. If system does not
+	 *   have enough memory for that, it will try the best to reserve 80% available
+	 *   huge pages.
+	 *
+	 * TST_ENFORCED:
+	 *   This is an enforced requirement for huge page reserve, ltp should strictly do
+	 *   hpages applying and guarantee the 'HugePages_Free' no less than specified pages
+	 *   which gives that test can use these specified numbers correctly.
+	 *
+	 *
+	 * With success test stores the reserved hugepage number in 'tst_hugepages. For
+	 * the system without hugetlb supporting, variable 'tst_hugepages' will be set to 0.
+	 * If the hugepage number needs to be set to 0 on supported hugetlb system, please
+	 * use '.request_hugepages = TST_NO_HUGEPAGES'.
 	 *
 	 * Also, we do cleanup and restore work for the hpages resetting automatically.
 	 */
-	unsigned long request_hugepages;
+	struct tst_hugepage *request_hugepages;
 
 	/*
 	 * If set to non-zero, call tst_taint_init(taint_check) during setup
diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
index 5c24770a1..e8e81f8f4 100644
--- a/lib/newlib_tests/test20.c
+++ b/lib/newlib_tests/test20.c
@@ -18,14 +18,16 @@ static void do_test(void) {
 	tst_res(TINFO, "tst_hugepages = %lu", tst_hugepages);
 	SAFE_FILE_PRINTF("/proc/sys/kernel/numa_balancing", "1");
 
-	hpages = test.request_hugepages;
+	hpages = test.request_hugepages->number;
 	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
 	if (val != hpages)
 		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
 	else
-		tst_res(TPASS, "test .needs_hugepges");
+		tst_res(TPASS, "test .request_hugepges");
+
+	struct tst_hugepage hp = { 1000000000000, TST_FLEXIBLE };
+	hpages = tst_request_hugepages(&hp);
 
-	hpages = tst_request_hugepages(3);
 	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
 	if (val != hpages)
 		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
@@ -35,7 +37,10 @@ static void do_test(void) {
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.request_hugepages = 2,
+	.request_hugepages = (struct tst_hugepage []){
+		{2, TST_ENFORCED},
+		{}
+	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"!/proc/sys/kernel/numa_balancing", "0"},
 		{}
diff --git a/lib/newlib_tests/test_zero_hugepage.c b/lib/newlib_tests/test_zero_hugepage.c
index 0d85ce866..27cd196da 100644
--- a/lib/newlib_tests/test_zero_hugepage.c
+++ b/lib/newlib_tests/test_zero_hugepage.c
@@ -21,7 +21,8 @@ static void do_test(void)
 	else
 		tst_res(TPASS, "test .request_hugepages = TST_NO_HUGEPAGES");
 
-	hpages = tst_request_hugepages(3);
+	struct tst_hugepage hp = { 3, TST_FLEXIBLE };
+	hpages = tst_request_hugepages(&hp);
 	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
 	if (val != hpages)
 		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
@@ -31,5 +32,8 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.request_hugepages = TST_NO_HUGEPAGES,
+	.request_hugepages = (struct tst_hugepage []){
+		{TST_NO_HUGEPAGES, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index a7585bc3d..06e9fb7a1 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -20,11 +20,13 @@ size_t tst_get_hugepage_size(void)
 	return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 }
 
-unsigned long tst_request_hugepages(unsigned long hpages)
+unsigned long tst_request_hugepages(struct tst_hugepage *hp)
 {
 	unsigned long val, max_hpages;
 
 	if (access(PATH_HUGEPAGES, F_OK)) {
+		if (hp->policy == TST_ENFORCED)
+			tst_brk(TCONF, "hugetlbfs is not supported");
 		tst_hugepages = 0;
 		goto out;
 	}
@@ -32,16 +34,20 @@ unsigned long tst_request_hugepages(unsigned long hpages)
 	if (nr_opt)
 		tst_hugepages = SAFE_STRTOL(nr_opt, 1, LONG_MAX);
 	else
-		tst_hugepages = hpages;
+		tst_hugepages = hp->number;
 
-	if (hpages == TST_NO_HUGEPAGES) {
+	if (hp->number == TST_NO_HUGEPAGES) {
 		tst_hugepages = 0;
 		goto set_hugepages;
 	}
 
 	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
-	max_hpages = SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
+	if (hp->policy == TST_ENFORCED) {
+		tst_hugepages += SAFE_READ_MEMINFO("HugePages_Total:");
+		goto set_hugepages;
+	}
 
+	max_hpages = SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
 	if (tst_hugepages > max_hpages) {
 		tst_res(TINFO, "Requested number(%lu) of hugepages is too large, "
 				"limiting to 80%% of the max hugepage count %lu",
@@ -61,6 +67,14 @@ set_hugepages:
 				"Not enough hugepages for testing.",
 				val, tst_hugepages);
 
+	if (hp->policy == TST_ENFORCED) {
+		unsigned long free_hpages = SAFE_READ_MEMINFO("HugePages_Free:");
+		if (hp->number > free_hpages)
+			tst_brk(TCONF, "free_hpages = %lu, but expect %lu. "
+				"Not enough hugepages for testing.",
+				free_hpages, hp->number);
+	}
+
 	tst_res(TINFO, "%lu hugepage(s) reserved", tst_hugepages);
 out:
 	return tst_hugepages;
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
