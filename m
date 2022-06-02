Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A060C433EF
	for <ltp@archiver.kernel.org>; Thu,  2 Jun 2022 08:15:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAF7C3C7FC4
	for <ltp@archiver.kernel.org>; Thu,  2 Jun 2022 10:15:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B3793C81B2
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 10:14:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F04B0200AE3
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 10:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654157660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QYaaZcY2sngKqbM7M+2dtWneLzqtNjWLOomAKXZCjw=;
 b=CDj87CZbZ13vvx65w1ll50ET3YEQHdTCxSNlWy54/zBwThYs+J13B9Taudxm0M6ARKWEjM
 OIgyCqMLzCQs37Q5Bah1VkZpGXI4kr1v0qZx1g3r4Ff/fVjGBskfY14Ni++cL2/jicLb/V
 OxA87nrkSahBuB2HLASyMFKLL8NfaKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-dPSUWfPfPnStjNcW2uc1TA-1; Thu, 02 Jun 2022 04:14:19 -0400
X-MC-Unique: dPSUWfPfPnStjNcW2uc1TA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E79E85A5B9
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 08:14:19 +0000 (UTC)
Received: from fedora-laptop.redhat.com (ovpn-13-31.pek2.redhat.com
 [10.72.13.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BD421731B
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 08:14:18 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  2 Jun 2022 16:14:11 +0800
Message-Id: <20220602081411.33598-4-liwang@redhat.com>
In-Reply-To: <20220602081411.33598-1-liwang@redhat.com>
References: <20220602081411.33598-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] hugetlb: make use of new .hugepages
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c   |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c   |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c   |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c   |  5 +----
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c   |  4 +---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c |  2 +-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c |  2 +-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c |  2 +-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 12 +++---------
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c |  5 +----
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  2 +-
 testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c     |  2 +-
 testcases/kernel/syscalls/futex/futex_wake04.c       |  5 +----
 testcases/kernel/syscalls/ipc/shmget/shmget02.c      |  2 +-
 testcases/kernel/syscalls/pkeys/pkey01.c             |  4 ++--
 21 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index fcb4443f7..3fc730002 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -98,5 +98,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugemmap,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 3be68418a..e818cd5a3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -145,5 +145,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugemmap,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 236010fe0..6af032aa5 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -116,5 +116,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugemmap,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 40d3bd8da..d5983fc55 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -185,9 +185,6 @@ static void setup(void)
 {
 	unsigned long hpages;
 
-	if (tst_hugepages != NR_HPAGES)
-		tst_brk(TCONF, "Not enough hugepages for testing!");
-
 	hugepagesize = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	init_sys_sz_paths();
 
@@ -307,5 +304,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_overcommit,
-	.request_hugepages = NR_HPAGES,
+	.hugepages = {NR_HPAGES, TST_NEEDS},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index ab2ccc40b..91dfa0616 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -39,8 +39,6 @@ struct mp {
 
 static void setup(void)
 {
-	if (tst_hugepages != test.request_hugepages)
-		tst_brk(TCONF, "System RAM is not enough to test.");
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 }
 
@@ -122,7 +120,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test = do_mmap,
 	.setup = setup,
-	.request_hugepages = (ARSZ + 1) * LOOP,
+	.hugepages = {(ARSZ + 1) * LOOP, TST_NEEDS},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f522c3ac00a4"},
 		{"linux-git", "9119a41e9091"},
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 8273ede83..3a50e6b55 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -180,5 +180,5 @@ static struct tst_test test = {
 	.test = verify_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 11000a4f0..e79d682f3 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -107,5 +107,5 @@ static struct tst_test test = {
 	.test = verify_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 5aca7dab0..9de925739 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -101,5 +101,5 @@ static struct tst_test test = {
 	.test_all = verify_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 128671051..50efa8a52 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -27,7 +27,6 @@
 
 static long huge_free;
 static long huge_free2;
-static long hugepages;
 static long orig_shmmax = -1, new_shmmax;
 
 static void shared_hugepage(void);
@@ -83,9 +82,6 @@ static void setup(void)
 {
 	long hpage_size, orig_hugepages;
 
-	if (tst_hugepages == 0)
-		tst_brk(TCONF, "Not enough hugepages for testing.");
-
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
 	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
@@ -96,10 +92,8 @@ static void setup(void)
 
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	hugepages = orig_hugepages + SIZE / hpage_size;
-	tst_request_hugepages(hugepages);
-	if (tst_hugepages != (unsigned long)hugepages)
-		tst_brk(TCONF, "No enough hugepages for testing.");
+	struct tst_hugepage hp = { orig_hugepages + SIZE / hpage_size, TST_NEEDS };
+	tst_reserve_hugepages(&hp);
 }
 
 static void cleanup(void)
@@ -121,5 +115,5 @@ static struct tst_test test = {
 	.min_mem_avail = 2048,
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 1,
+	.hugepages = {1, TST_NEEDS},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index 7152e3363..3b2ae351c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -35,9 +35,6 @@ static long hpage_size;
 
 void setup(void)
 {
-	if (tst_hugepages != test.request_hugepages)
-		tst_brk(TCONF, "Not enough hugepages for testing.");
-
 	page_size = getpagesize();
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 }
@@ -91,7 +88,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test_all = test_hugeshmat,
 	.setup = setup,
-	.request_hugepages = N + 1,
+	.hugepages = {N+1, TST_NEEDS},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "091d0d55b286"},
 		{"linux-git", "af73e4d9506d"},
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 56f3a73dd..11cd69050 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -310,5 +310,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = test_hugeshmctl,
 	.needs_checkpoints = 1,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 8a4c8bc2d..0bc9ffd74 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -110,5 +110,5 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index f7dd43452..21ec6bf78 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -134,5 +134,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmctl,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 287e5990e..0b9515fda 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -152,5 +152,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = hugeshmdt_test,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 2a440f79d..627356510 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -78,5 +78,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmget,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 11497d150..bbd968c06 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -98,5 +98,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = test_hugeshmget,
 	.tcnt = ARRAY_SIZE(tcases),
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 72d8701f4..7e72a19ca 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -96,5 +96,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmget,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 91e30afa4..336319603 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -92,5 +92,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmget,
-	.request_hugepages = 128,
+	.hugepages = {128, TST_REQUEST},
 };
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 2260a3936..110c628c3 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -48,9 +48,6 @@ static struct futex_test_variants variants[] = {
 
 static void setup(void)
 {
-	if (tst_hugepages == 0)
-		tst_brk(TCONF, "No enough hugepages for testing.");
-
 	struct futex_test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
@@ -135,5 +132,5 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.min_kver = "2.6.32",
 	.needs_tmpdir = 1,
-	.request_hugepages = 1,
+	.hugepages = {1, TST_NEEDS},
 };
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 165a34456..7a32ec6f8 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -148,5 +148,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcases),
-	.request_hugepages = TST_NO_HUGEPAGES,
+	.hugepages = {TST_NO_HUGEPAGES, TST_REQUEST},
 };
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index 04f50924c..2daa42797 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -52,7 +52,7 @@ static void setup(void)
 
 	check_pkey_support();
 
-	if (tst_hugepages == test.request_hugepages)
+	if (tst_hugepages == test.hugepages.number)
 		size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	else
 		size = getpagesize();
@@ -221,5 +221,5 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test = verify_pkey,
 	.setup = setup,
-	.request_hugepages = 1,
+	.hugepages = {1, TST_REQUEST},
 };
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
