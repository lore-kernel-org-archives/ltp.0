Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC14C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 13:30:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C16713CA525
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 15:30:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DD533CA727
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:30:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3F3321000417
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651152598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGK19VKuionsTLi0dmPoLQ2M97EElCq0QfU4usvO9yI=;
 b=aHXkgWutRkYkH+pCg7HyrTAzbvSChw0e2EwCSgrbMEHRS0Dw7sZBubPamez6h1Kd0/Xm21
 0v8hjL3iNuWzG2/+KWA0KQgg8xlob8RM5SF14w5sYJWeq7ZtFZy2gZ57RQJ76bH7P+0geE
 PPiV8Cldj+/i79uiMJslPtnEUsU8H5o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-Hipy9hfrNvyxXBIuSsf9BA-1; Thu, 28 Apr 2022 09:29:56 -0400
X-MC-Unique: Hipy9hfrNvyxXBIuSsf9BA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867A43C0E188
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:29:56 +0000 (UTC)
Received: from liwang-laptop.redhat.com (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44CC440F9D6D
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:29:54 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 28 Apr 2022 21:29:49 +0800
Message-Id: <20220428132949.11719-3-liwang@redhat.com>
In-Reply-To: <20220428132949.11719-1-liwang@redhat.com>
References: <20220428132949.11719-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 3/3] hugetlb: make use of new .request_hugepages
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
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c   |  5 ++++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c   |  5 ++++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c   |  5 ++++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c   |  8 ++++----
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c   |  7 ++++---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c |  5 ++++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c |  5 ++++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c |  5 ++++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 12 ++++++------
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c |  8 ++++----
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  5 ++++-
 testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c     |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c     |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c     |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c     |  5 ++++-
 testcases/kernel/syscalls/futex/futex_wake04.c       |  8 ++++----
 testcases/kernel/syscalls/ipc/shmget/shmget02.c      |  5 ++++-
 testcases/kernel/syscalls/pkeys/pkey01.c             |  7 +++++--
 21 files changed, 87 insertions(+), 38 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index fcb4443f7..13b15924f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -98,5 +98,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugemmap,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 3be68418a..c801d6ade 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -145,5 +145,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugemmap,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 236010fe0..2104528a0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -116,5 +116,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugemmap,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 40d3bd8da..2d7cf87f0 100644
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
 
@@ -307,5 +304,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_overcommit,
-	.request_hugepages = NR_HPAGES,
+	.request_hugepages = (struct tst_hugepage []){
+		{NR_HPAGES, TST_ENFORCED},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index ab2ccc40b..f57470b39 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -39,8 +39,6 @@ struct mp {
 
 static void setup(void)
 {
-	if (tst_hugepages != test.request_hugepages)
-		tst_brk(TCONF, "System RAM is not enough to test.");
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 }
 
@@ -122,7 +120,10 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test = do_mmap,
 	.setup = setup,
-	.request_hugepages = (ARSZ + 1) * LOOP,
+	.request_hugepages = (struct tst_hugepage []){
+		{(ARSZ + 1) * LOOP, TST_ENFORCED},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f522c3ac00a4"},
 		{"linux-git", "9119a41e9091"},
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 8273ede83..3258a3256 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -180,5 +180,8 @@ static struct tst_test test = {
 	.test = verify_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 11000a4f0..dc47769a7 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -107,5 +107,8 @@ static struct tst_test test = {
 	.test = verify_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 5aca7dab0..a170dd825 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -101,5 +101,8 @@ static struct tst_test test = {
 	.test_all = verify_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 128671051..d24a3b837 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -83,9 +83,6 @@ static void setup(void)
 {
 	long hpage_size, orig_hugepages;
 
-	if (tst_hugepages == 0)
-		tst_brk(TCONF, "Not enough hugepages for testing.");
-
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
 	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
@@ -96,8 +93,8 @@ static void setup(void)
 
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	hugepages = orig_hugepages + SIZE / hpage_size;
-	tst_request_hugepages(hugepages);
+	struct tst_hugepage hp = { orig_hugepages + SIZE / hpage_size, TST_FLEXIBLE };
+	tst_request_hugepages(&hp);
 	if (tst_hugepages != (unsigned long)hugepages)
 		tst_brk(TCONF, "No enough hugepages for testing.");
 }
@@ -121,5 +118,8 @@ static struct tst_test test = {
 	.min_mem_avail = 2048,
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 1,
+	.request_hugepages = (struct tst_hugepage []){
+		{1, TST_ENFORCED},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index 7152e3363..93f85646f 100644
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
@@ -91,7 +88,10 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test_all = test_hugeshmat,
 	.setup = setup,
-	.request_hugepages = N + 1,
+	.request_hugepages = (struct tst_hugepage []){
+		{N+1, TST_ENFORCED},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "091d0d55b286"},
 		{"linux-git", "af73e4d9506d"},
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 56f3a73dd..17e75f1cb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -310,5 +310,8 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = test_hugeshmctl,
 	.needs_checkpoints = 1,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 8a4c8bc2d..33c61d676 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -110,5 +110,8 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.cleanup = cleanup,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index f7dd43452..6c8fbb729 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -134,5 +134,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmctl,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 287e5990e..f5726c5f0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -152,5 +152,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = hugeshmdt_test,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 2a440f79d..5fd019fb6 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -78,5 +78,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmget,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 11497d150..fc25d2087 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -98,5 +98,8 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = test_hugeshmget,
 	.tcnt = ARRAY_SIZE(tcases),
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 72d8701f4..8c4f93a44 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -96,5 +96,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmget,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 91e30afa4..d0f9f6072 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -92,5 +92,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmget,
-	.request_hugepages = 128,
+	.request_hugepages = (struct tst_hugepage []){
+		{128, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 2260a3936..6c943d844 100644
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
@@ -135,5 +132,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.min_kver = "2.6.32",
 	.needs_tmpdir = 1,
-	.request_hugepages = 1,
+	.request_hugepages = (struct tst_hugepage []){
+		{1, TST_ENFORCED},
+		{}
+	},
 };
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 165a34456..30f829805 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -148,5 +148,8 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcases),
-	.request_hugepages = TST_NO_HUGEPAGES,
+	.request_hugepages = (struct tst_hugepage []){
+		{TST_NO_HUGEPAGES, TST_FLEXIBLE},
+		{}
+	},
 };
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index 04f50924c..74eae0624 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -52,7 +52,7 @@ static void setup(void)
 
 	check_pkey_support();
 
-	if (tst_hugepages == test.request_hugepages)
+	if (tst_hugepages == test.request_hugepages->number)
 		size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	else
 		size = getpagesize();
@@ -221,5 +221,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test = verify_pkey,
 	.setup = setup,
-	.request_hugepages = 1,
+	.request_hugepages = (struct tst_hugepage []){
+		{1, TST_FLEXIBLE},
+		{}
+	},
 };
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
