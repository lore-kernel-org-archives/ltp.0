Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D27C43334
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 10:01:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936DD3C8CA7
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 12:01:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7D663C8D54
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 12:00:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EB421200069
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 12:00:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654509644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzLRAnn2VAvDQ+NRJDd5rHQHgsA3/KK50eBEAtADXL8=;
 b=QP6vo6ZuGigajWmItKK88T2Zf5wlhltCX9F7ibzqqbvZtYk+QxLVQsGmyzSd+q0lf3vBWU
 gJLN+IjDVRnink0z1DjSgqBecsgb0DiayFtAXcPxs6YcnE75rO2HcxHVpj2996Gpzi32CU
 SU7jqgDGkXXRztVttNtiFEtZTKxwTKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-Nyhv7zJbOzyKSF3tNROt8g-1; Mon, 06 Jun 2022 06:00:41 -0400
X-MC-Unique: Nyhv7zJbOzyKSF3tNROt8g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D386100BAB9;
 Mon,  6 Jun 2022 10:00:41 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E769492C3B;
 Mon,  6 Jun 2022 10:00:39 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  6 Jun 2022 18:00:34 +0800
Message-Id: <20220606100034.169493-3-liwang@redhat.com>
In-Reply-To: <20220606100034.169493-1-liwang@redhat.com>
References: <20220606100034.169493-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] memfd_create03: make use of new .hugepages
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

To get rid of some failures like:

  memfd_create03.c:179: TINFO: --TESTING PAGE SIZE OF CREATED FILE--
  memfd_create03.c:184: TINFO: memfd_create() succeeded
  memfd_create03.c:47: TBROK: mmap((nil),1048576,2,2,3,0) failed: ENOMEM (12)

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../syscalls/memfd_create/memfd_create03.c    | 74 +------------------
 1 file changed, 4 insertions(+), 70 deletions(-)

diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create03.c b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
index 036182f0a..2f33fea50 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create03.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
@@ -32,14 +32,6 @@
 #include <stdio.h>
 #include <errno.h>
 
-#define TOTAL_HP_PATH "/proc/sys/vm/nr_hugepages"
-#define MEMINFO_PATH "/proc/meminfo"
-#define FREE_HP "HugePages_Free:\t%ld"
-#define DEFAULT_HPS "Hugepagesize:\t%ld kB"
-
-static int hugepages_allocated;
-static long og_total_pages;
-
 static void *check_huge_mmapable(int fd, unsigned long size)
 {
 	void *mem;
@@ -88,7 +80,7 @@ static void test_def_pagesize(int fd)
 	long hps;
 	void *mem;
 
-	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, DEFAULT_HPS, &hps);
+	hps = SAFE_READ_MEMINFO("Hugepagesize:");
 	hps = hps << 10;
 	unmap_size = hps / 4;
 	mem = check_huge_mmapable(fd, hps);
@@ -128,8 +120,8 @@ static void test_max_hugepages(int fd)
 	void *mem;
 	void *new_mem;
 
-	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, FREE_HP, &free_pages);
-	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, DEFAULT_HPS, &hps);
+	free_pages = SAFE_READ_MEMINFO("HugePages_Free:");
+	hps = SAFE_READ_MEMINFO("Hugepagesize:");
 	hps = hps << 10;
 	mem = check_huge_mmapable(fd, free_pages * hps);
 
@@ -188,68 +180,10 @@ static void memfd_huge_controller(unsigned int n)
 	SAFE_CLOSE(fd);
 }
 
-static void setup(void)
-{
-	char buf[8];
-	int fd;
-	long free_pages;
-	long total_pages;
-
-	if (access(MEMINFO_PATH, F_OK) ||
-	    access("/sys/kernel/mm/hugepages", F_OK) ||
-	    access(TOTAL_HP_PATH, F_OK))
-		tst_brk(TCONF, "Huge page is not supported");
-
-	SAFE_FILE_LINES_SCANF(MEMINFO_PATH, FREE_HP, &free_pages);
-	if (free_pages > 0)
-		return;
-
-	SAFE_FILE_LINES_SCANF(TOTAL_HP_PATH, "%ld", &og_total_pages);
-	sprintf(buf, "%ld", og_total_pages + 1);
-
-	fd = SAFE_OPEN(TOTAL_HP_PATH, O_RDWR | O_TRUNC);
-
-	if (write(fd, buf, strlen(buf)) == -1)
-		tst_brk(TCONF | TERRNO,
-			"write() fail: Hugepage allocation failed");
-
-	SAFE_CLOSE(fd);
-
-	SAFE_FILE_LINES_SCANF(TOTAL_HP_PATH, "%ld", &total_pages);
-	if (total_pages != (og_total_pages + 1))
-		tst_brk(TCONF, "Hugepage allocation failed");
-
-	hugepages_allocated = 1;
-}
-
-static void cleanup(void)
-{
-	char buf[8];
-	int fd;
-	long total_pages;
-
-	if (hugepages_allocated == 0)
-		return;
-
-	sprintf(buf, "%ld", og_total_pages);
-
-	fd = SAFE_OPEN(TOTAL_HP_PATH, O_RDWR | O_TRUNC);
-
-	if (write(fd, buf, strlen(buf)) == -1)
-		tst_brk(TCONF | TERRNO, "Clean-up failed: write() failed");
-
-	SAFE_CLOSE(fd);
-
-	SAFE_FILE_LINES_SCANF(TOTAL_HP_PATH, "%ld", &total_pages);
-	if (og_total_pages != total_pages)
-		tst_brk(TCONF, "Clean-up failed");
-}
-
 static struct tst_test test = {
-	.setup = setup,
 	.test = memfd_huge_controller,
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.min_kver = "4.14",
-	.cleanup = cleanup,
+	.hugepages = {1, TST_NEEDS},
 };
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
