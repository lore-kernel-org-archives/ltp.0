Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2CBC02183
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 16:03:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB5A83C7996
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 17:03:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59B593C06C1
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 17:02:11 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=afazekas@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8E86862A34A
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 17:02:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736784128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HuXuitCvWC3SWJo38qVbqMoA87ljzOsHRcz/kaxKGIo=;
 b=a8eY7TURJhMnTUZJHxy6saeFmLHjp0hwR4ZNYTK21FE0QwTnj2EqaCyoCrzkNS9OmtKqXX
 bUNYcll9mDqcceecgUlZ8EPkD/8QDZHSai7ZKD5NXKIBh6DVR2dOW+M1GDozJge3AG7SPO
 rLVx+B9l2mV4iRTZWpF4KWdv0JmCQDE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-JqmyuU-1Of61Fq-vfz1gsA-1; Mon,
 13 Jan 2025 11:02:07 -0500
X-MC-Unique: JqmyuU-1Of61Fq-vfz1gsA-1
X-Mimecast-MFC-AGG-ID: JqmyuU-1Of61Fq-vfz1gsA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 029A81955DCC
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 16:02:06 +0000 (UTC)
Received: from interceptor.brq.redhat.com (unknown [10.43.2.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10E1C195608E; Mon, 13 Jan 2025 16:02:04 +0000 (UTC)
From: Attila Fazekas <afazekas@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 13 Jan 2025 17:00:40 +0100
Message-ID: <20250113160040.670737-1-afazekas@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -cWTlAxDoKr4OxsFph1FzNfnDxkG-kdw9SQvt72hocU_1736784126
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 13 Jan 2025 17:03:25 +0100
Subject: [LTP] [PATCH] sched_football: isolcpus handling
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
Cc: Attila Fazekas <afazekas@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

sched_football expects each player thread is scheduleable
to all of the physical CPU threads, however for example
when you are using isolcpus by default you threads are
not scheduled to some CPU. It leads to the test hangs.
591c56b045b2d44a0f4ba1a13545420b23e909b5solved was asimilar issue
in realtime/prio-preempt .

Signed-off-by: Attila Fazekas <afazekas@redhat.com>
---
 .../realtime/func/sched_football/sched_football.c  | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 763b41f23..e4ae6a027 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -133,6 +133,18 @@ void referee(int game_length)
 	TST_EXP_EXPR(final_ball == 0);
 }
 
+static inline int get_numcpus(void)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+
+	/* Get the number of cpus accessible to the current process */
+	sched_getaffinity(getpid(), sizeof(mask), &mask);
+
+	return CPU_COUNT(&mask);
+}
+
 static void do_test(void)
 {
 	struct sched_param param;
@@ -140,7 +152,7 @@ static void do_test(void)
 	int i;
 
 	if (players_per_team == 0)
-		players_per_team = sysconf(_SC_NPROCESSORS_ONLN);
+		players_per_team = get_numcpus();
 
 	tst_atomic_store(0, &players_ready);
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
