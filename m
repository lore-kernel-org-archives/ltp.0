Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A606C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 05:46:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 336F43C8972
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 06:46:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 150083C8973
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 06:46:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4DF4C600F58
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 06:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646977574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cAdnJs8knDel1Lnze0AzracHEl/w6k9QOd99gWXiyU0=;
 b=RUpJ8zxLIqU5IYS7THCcIfBLof7ZRGaoGrfyaI07PKtodeXFmGMjdSlaiLqa3ssFAquz6u
 EDWKrk9pF19bo5qVxiCfFJZf5WoFtAa5fKrEayuF81qkzPSEYqT+2SoVUEr1FzdCPoCuOC
 aOzha8ZxvOIk7ux6V2ZMXK7QFLnO7ZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-0im3IlfUPqO3T6LoQWe4lg-1; Fri, 11 Mar 2022 00:46:12 -0500
X-MC-Unique: 0im3IlfUPqO3T6LoQWe4lg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D2958145FA
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 05:46:12 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46E33131C3
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 05:46:11 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 11 Mar 2022 13:46:03 +0800
Message-Id: <20220311054603.57328-4-liwang@redhat.com>
In-Reply-To: <20220311054603.57328-1-liwang@redhat.com>
References: <20220311054603.57328-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] minmax: ensure the comparison numbers have
 compatible type
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

To get rid of many compiler warnings.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_cgroup.c                                  | 2 +-
 lib/tst_memutils.c                                | 4 ++--
 lib/tst_timer_test.c                              | 4 ++--
 testcases/kernel/syscalls/fallocate/fallocate06.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 8cca0654d..57940ba09 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -1116,7 +1116,7 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
 		prev_len = MIN(sizeof(prev_buf), (size_t)read_ret);
 	}
 
-	out[MAX(read_ret, 0)] = '\0';
+	out[MAX(read_ret, (ssize_t)0)] = '\0';
 
 	return read_ret;
 }
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 3741d6e6f..d95d75e5d 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -30,7 +30,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 	min_free += min_free / 10;
 
 	SAFE_SYSINFO(&info);
-	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
+	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), (long)128 * 1024 * 1024);
 	safety = MAX(safety, min_free);
 	safety /= info.mem_unit;
 
@@ -44,7 +44,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 	 * Use the lower value of both for pollutable memory. Usually this
 	 * means we will not evict any caches.
 	 */
-	freeram = MIN(info.freeram, (tst_available_mem() * 1024));
+	freeram = MIN((long long)info.freeram, (tst_available_mem() * 1024));
 
 	/* Not enough free memory to avoid invoking OOM killer */
 	if (freeram <= safety)
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 3cd52fc9d..c0e3de3e7 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -67,7 +67,7 @@ static const char *table_heading = " Time: us ";
  */
 static unsigned int header_len(long long max_sample)
 {
-	unsigned int l = 1;
+	size_t l = 1;
 
 	while (max_sample/=10)
 		l++;
@@ -184,7 +184,7 @@ static int cmp(const void *a, const void *b)
 static long long compute_threshold(long long requested_us,
 				   unsigned int nsamples)
 {
-	unsigned int slack_per_scall = MIN(100000, requested_us / 1000);
+	unsigned int slack_per_scall = MIN((long long)100000, requested_us / 1000);
 
 	slack_per_scall = MAX(slack_per_scall, timerslack);
 
diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index bf0d24328..25b27e41d 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -95,7 +95,7 @@ static void setup(void)
 	TEST(toggle_cow(fd, 0));
 	SAFE_FSTAT(fd, &statbuf);
 	blocksize = statbuf.st_blksize;
-	block_offset = MIN(blocksize / 2, 512);
+	block_offset = MIN(blocksize / 2, (blksize_t)512);
 	wbuf_size = MAX(WRITE_BLOCKS, FALLOCATE_BLOCKS) * blocksize;
 	rbuf_size = (DEALLOCATE_BLOCKS + 1) * blocksize;
 	SAFE_CLOSE(fd);
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
