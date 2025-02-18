Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AF1C021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:56:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A2923C9CE8
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 14:55:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 799C53C0229
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 14:55:40 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 84AE0100FD99
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 14:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739886937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nYsZojlf0SM07ABiNjh9tmkBm/479JcD1JGd7SrYOZY=;
 b=O7AE7I8evUx6eFeWWU3Yre4eAriXnKpnmc/rkhE7T86OA5vSeAr52R5Vp2HGKKzypD7057
 gclc86Xzr8dVzaoJV+ALr30S2l5bm1qqWZTQ208hZzet4b5mcFvvqEsU+1rwicKTbKDY19
 zhhavvjGl6Vtu2slHqo7WVz46jQKxuE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-S4zHRG9BOiOhix9m3MTxFQ-1; Tue,
 18 Feb 2025 08:55:36 -0500
X-MC-Unique: S4zHRG9BOiOhix9m3MTxFQ-1
X-Mimecast-MFC-AGG-ID: S4zHRG9BOiOhix9m3MTxFQ_1739886935
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D03D1800878
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:55:35 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E306A1955BCB; Tue, 18 Feb 2025 13:55:33 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 18 Feb 2025 14:54:31 +0100
Message-ID: <59baf41928c498349f41f468e4efdb4908bccc28.1739886583.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CPOuJzAs1aH-mdYiJFK585eUPTtZrwbP5-ouO3QMTA4_1739886935
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] aio-stress: fix memory leak
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
Cc: liwan@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

setup_shared_mem() currently runs as part of run() function,
and if it runs for too many iterations it can consume so much
memory that OOM kills it.

Move setup_shared_mem() along with the 2 checks for io_iter and
num_threads to setup(). This way it runs only once and gets
freed on test exit.

As consequence setup_ious() also needs to be modified to no longer
modify global variable 'aligned_buffer', because we don't re-initialize
it on every iteration.

And finally, at the end of run() function free also memory allocated
by setup_ious().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/io/ltp-aiodio/aio-stress.c | 45 ++++++++++++---------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 469769d5a1f4..5cce92dfa44c 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -914,14 +914,15 @@ static void setup_ious(struct thread_info *t, int num_files, int depth, int recl
 {
 	int i;
 	size_t bytes = num_files * depth * sizeof(*t->ios);
+	char *buffer = aligned_buffer;
 
 	t->ios = SAFE_MALLOC(bytes);
 
 	memset(t->ios, 0, bytes);
 
 	for (i = 0; i < depth * num_files; i++) {
-		t->ios[i].buf = aligned_buffer;
-		aligned_buffer += padded_reclen;
+		t->ios[i].buf = buffer;
+		buffer += padded_reclen;
 		t->ios[i].buf_size = reclen;
 		if (verify)
 			memset(t->ios[i].buf, 'b', reclen);
@@ -932,7 +933,7 @@ static void setup_ious(struct thread_info *t, int num_files, int depth, int recl
 	}
 
 	if (verify) {
-		verify_buf = aligned_buffer;
+		verify_buf = buffer;
 		memset(verify_buf, 'b', reclen);
 	}
 
@@ -1228,19 +1229,6 @@ static void setup(void)
 			tst_brk(TBROK, "Invalid shm option '%s'", str_use_shm);
 		}
 	}
-}
-
-static void run(void)
-{
-	char files[num_files][265];
-	int first_stage = WRITE;
-	struct io_oper *oper;
-	int status = 0;
-	int open_fds = 0;
-	struct thread_info *t;
-	int rwfd;
-	int i;
-	int j;
 
 	/*
 	 * make sure we don't try to submit more I/O than we have allocated
@@ -1256,6 +1244,22 @@ static void run(void)
 		tst_res(TINFO, "Dropping thread count to the number of contexts %d", num_threads);
 	}
 
+	if (setup_shared_mem(num_threads, num_files * num_contexts, depth, rec_len))
+		tst_brk(TBROK, "error in setup_shared_mem");
+}
+
+static void run(void)
+{
+	char files[num_files][265];
+	int first_stage = WRITE;
+	struct io_oper *oper;
+	int status = 0;
+	int open_fds = 0;
+	struct thread_info *t;
+	int rwfd;
+	int i;
+	int j;
+
 	t = SAFE_MALLOC(num_threads * sizeof(*t));
 	memset(t, 0, num_threads * sizeof(*t));
 	global_thread_info = t;
@@ -1322,8 +1326,6 @@ static void run(void)
 		}
 	}
 
-	if (setup_shared_mem(num_threads, num_files * num_contexts, depth, rec_len))
-		tst_brk(TBROK, "error in setup_shared_mem");
 
 	for (i = 0; i < num_threads; i++)
 		setup_ious(&t[i], t[i].num_files, depth, rec_len, max_io_submit);
@@ -1339,6 +1341,13 @@ static void run(void)
 	for (i = 0; i < num_files; i++)
 		SAFE_UNLINK(files[i]);
 
+	for (i = 0; i < num_threads; i++) {
+		free(t[i].ios);
+		free(t[i].iocbs);
+		free(t[i].events);
+	}
+	free(t);
+
 	if (status)
 		tst_res(TFAIL, "Test did not pass");
 	else
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
