Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19638606A326
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=SbEvtd6t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K6Cxw4m2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793617143; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=hu+zjgQ0cZKph9GVu1MDhxf/5GX1g3fC45tmBI4Zv7c=;
 b=SbEvtd6tCM8wXcNzuvWc/SkOVRRzuApMoo8vDple7EBrqjFG4pYuWNAMWoaOpYVJ0do4V
 QHuHijA6xxfSLQpeDzKuJNUZi9KK4aV+vNnzTkZb5uPwKaOV+xX18kp57ff+vGIGtaDcWO8
 h2r9XXyZGOsE7LmU5ZordnNp7uSemQY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A382F3E1F48
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 11:59:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D79AC3E5A16
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 11:58:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7CF19600753
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 11:58:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793617106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EbhwTUincjywiEp6tpKJNi0Oic4Kv8CbsrGQkh8Fcak=;
 b=K6Cxw4m2fvKNwDCcefW113YsCPf3DJOpbJSCl8LyjxtX80UlYa8AXUg/QV6N6yPyj845F5
 mU1LHrdrInLD76sww4WoDLGHqD+ZRbVepP1TNeOcHLQl1bmm2/pOicZpwNUQx/QJMuNYWz
 L8pKH1GBrpAmLAbtP0zh6fW4ghaF1n8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-D0rLwG_9PWylonxU0MsDjw-1; Mon,
 02 Nov 2026 05:58:25 -0500
X-MC-Unique: D0rLwG_9PWylonxU0MsDjw-1
X-Mimecast-MFC-AGG-ID: D0rLwG_9PWylonxU0MsDjw_1793617104
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2261F1944DD7
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 10:58:24 +0000 (UTC)
Received: from intrepid (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1928318001CA; Mon,  2 Nov 2026 10:58:22 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  2 Nov 2026 11:57:04 +0100
Message-ID: <20261102105704.1577364-1-afazekas@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lZtjbtt_YacGixteSfClN3pLPrri0tbgVHR5rLuqxts_1793617104
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap22: Bound child memory allocation to avoid OOM
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

Fix this by bounding the child's allocation to CHILD_ALLOC_MAX
(ALLOC_SIZE + 32MB). The total requested memory (128MB parent + 160MB
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
index 0b95c578f..16fcb6dd8 100644
--- a/testcases/kernel/syscalls/mmap/mmap22.c
+++ b/testcases/kernel/syscalls/mmap/mmap22.c
@@ -26,6 +26,7 @@
 
 #define MEM_LIMIT (256 * TST_MB)
 #define ALLOC_SIZE (128 * TST_MB)
+#define CHILD_ALLOC_MAX (ALLOC_SIZE + 32 * TST_MB)
 
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
