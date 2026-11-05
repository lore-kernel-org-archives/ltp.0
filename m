Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DFB606A328
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=g7dkE76X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYijDeaW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793865827; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=725fyercWX2VJqzq3OJzD88kiKEe2VW+qsKD+tJhIVU=;
 b=g7dkE76XaLn8ON3GYoJBMsjbgZwK/VYAfOA4w0U+JBJBjLFyOrMvgxIB9iGWOpe9GUY4q
 MqktHYCP9+bSFwQ9VeK0wrcNqz2bsNNo2V3Redsx2sLW0sqeljYHWXq5DFTTforhDPo4foq
 BdmKyn2Mz5gATPhZFa6YOYIXKgGn2NA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2086F3CDA2B
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 09:03:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 063FC3C01A0
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 09:03:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5EDEC200A08
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 09:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793865805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9zu0l/pyE4JPSDMkpK+p2RHg+GFpJNbACxqSMCykLGY=;
 b=HYijDeaWBrYadjCtbjfrUZO1R1WPHrIQJRwqeh+VGyzVyLE2fIi1tVUEQpWzrbNH0KdQsw
 LCHKVRz1JOOepfwdLiV0l7/2xWODKh8ZLF+j+BpyvnEAQA20AmGHpEF4ETQ7HWOsO2eSZt
 4rK3X0YGbtEfvjPzAr6c9xtlP71mtYg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-aEwOM43RP-WTr_yiU26bBA-1; Thu,
 05 Nov 2026 03:03:24 -0500
X-MC-Unique: aEwOM43RP-WTr_yiU26bBA-1
X-Mimecast-MFC-AGG-ID: aEwOM43RP-WTr_yiU26bBA_1793865803
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E822B18002C3
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 08:03:22 +0000 (UTC)
Received: from intrepid.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0BF21956041; Thu,  5 Nov 2026 08:03:21 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu,  5 Nov 2026 09:02:45 +0100
Message-ID: <20261105080245.2067876-1-afazekas@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JZliMo7VEZTA82L3Hz5KhHiOXH9cJD6e1ce6yESshec_1793865803
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mmap22: Bound child memory allocation to avoid OOM
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Attila Fazekas via ltp <ltp@lists.linux.it>
Reply-To: Attila Fazekas <afazekas@redhat.com>
Cc: Attila Fazekas <afazekas@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Currently, stress_child() allocates memory in an infinite loop without
bounds. Under memory pressure, once the cgroup memory limit is reached
and the parent's droppable pages are reclaimed, the child continues
allocating non-droppable heap memory. This eventually exhausts the cgroup
limit and triggers the cgroup OOM killer, terminating either the child or
the test parent process.

Fix this by bounding the child's allocation to CHILD_ALLOC_MAX.
The total requested memory (128MB parent + 160MB
child = 288MB) exceeds the 256MB cgroup limit by 32MB, which reliably
forces the kernel to reclaim MAP_DROPPABLE pages. Once CHILD_ALLOC_MAX is
reached, the child calls pause() to keep memory resident. Since 160MB is
well below the 256MB cgroup limit, non-droppable memory alone cannot
trigger an OOM.

Assisted-by: Gemini CLI
Signed-off-by: Attila Fazekas <afazekas@redhat.com>
---
 testcases/kernel/syscalls/mmap/mmap22.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap22.c b/testcases/kernel/syscalls/mmap/mmap22.c
index 0b95c578f..31acefdba 100644
--- a/testcases/kernel/syscalls/mmap/mmap22.c
+++ b/testcases/kernel/syscalls/mmap/mmap22.c
@@ -26,6 +26,7 @@
 
 #define MEM_LIMIT (256 * TST_MB)
 #define ALLOC_SIZE (128 * TST_MB)
+#define CHILD_ALLOC_MAX (MEM_LIMIT - ALLOC_SIZE + 32 * TST_MB)
 
 static struct tst_cg_group *cg_child;
 static pid_t child;
@@ -33,13 +34,15 @@ static int page_size;
 
 static void stress_child(void)
 {
-	for (;;) {
+	for (size_t sz = 0; sz < CHILD_ALLOC_MAX; sz += page_size) {
 		char *buf = malloc(page_size);
 
 		if (!buf)
-			exit(1);
+			break;
 		memset(buf, 'B', page_size);
 	}
+
+	pause();
 }
 
 static void test_mmap(void)
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
