Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D464C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 08:57:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37D293C9B73
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:57:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78AA93C23B0
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:57:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 33EED600C65
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644397039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KeskM+t5SJqQQtP0itVm9D5sXia9DyN9Qv3d0oFeY48=;
 b=Iajhw+Sn3e8JoT4cdqyLbow9mngb5J7V4Q3t4Qj3NRnRr4LsjBlyWEzGfORDZo26bE6v9p
 x0RjU4IzCSLSCD3k8j3TMV/O9LunR4FXHT0J/e+7KlVIhE4mcQV3akS0R9dkQd9qXpSkNq
 PtuUkZlH1dGweUNWz3B2Fvbic8Z0Zpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-cl_GelzoPO6gd2gOODi4FA-1; Wed, 09 Feb 2022 03:57:18 -0500
X-MC-Unique: cl_GelzoPO6gd2gOODi4FA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A43CF18A08D8
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 08:57:03 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCC0C4F86C
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 08:57:02 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  9 Feb 2022 16:57:00 +0800
Message-Id: <20220209085700.2882422-2-liwang@redhat.com>
In-Reply-To: <20220209085700.2882422-1-liwang@redhat.com>
References: <20220209085700.2882422-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] kernel: make use of .min_mem_avail
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

Set the minimum size of MemAvailable for tests.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c |  7 ++-----
 testcases/kernel/mem/swapping/swapping01.c           |  5 +----
 testcases/kernel/syscalls/getrusage/getrusage03.c    | 10 +---------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index b76da93a1..128671051 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -81,20 +81,16 @@ static void shared_hugepage(void)
 
 static void setup(void)
 {
-	long mem_total, hpage_size, orig_hugepages;
+	long hpage_size, orig_hugepages;
 
 	if (tst_hugepages == 0)
 		tst_brk(TCONF, "Not enough hugepages for testing.");
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
-	mem_total = SAFE_READ_MEMINFO("MemTotal:");
 	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
 	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
 	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &new_shmmax);
 
-	if (mem_total < 2L*1024*1024)
-		tst_brk(TCONF,	"Needed > 2GB RAM, have: %ld", mem_total);
-
 	if (new_shmmax < SIZE)
 		tst_brk(TCONF,	"shmmax too low, have: %ld", new_shmmax);
 
@@ -122,6 +118,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.tcnt = 3,
 	.test = test_hugeshmat,
+	.min_mem_avail = 2048,
 	.setup = setup,
 	.cleanup = cleanup,
 	.request_hugepages = 1,
diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 6db0f9866..1a494bf69 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -95,10 +95,6 @@ static void init_meminfo(void)
 	mem_over = mem_available_init * COE_SLIGHT_OVER;
 	mem_over_max = mem_available_init * COE_DELTA;
 
-	/* at least 10MB available physical memory needed */
-	if (mem_available_init < 10240)
-		tst_brk(TCONF, "Not enough available mem to test.");
-
 	if (swap_free_init < mem_over_max)
 		tst_brk(TCONF, "Not enough swap space to test: swap_free_init(%ldkB) < mem_over_max(%ldkB)",
 				swap_free_init, mem_over_max);
@@ -162,6 +158,7 @@ static void check_swapping(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
+	.min_mem_avail = 10,
 	.test_all = test_swapping,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "50a15981a1fa"},
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 201d258fa..676fea1c9 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -173,24 +173,16 @@ static void run(unsigned int i)
 	}
 }
 
-static void setup(void)
-{
-	long long mem_avail = tst_available_mem();
-
-	if (mem_avail < 512L*1024)
-		tst_brk(TCONF, "Needed > 512MB available, only have: %ld kB", mem_avail);
-}
-
 static struct tst_test test = {
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.resource_files = resource,
 	.min_kver = "2.6.32",
+	.min_mem_avail = 512,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "1f10206cf8e9"},
 		{}
 	},
-	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(testfunc_list),
 };
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
