Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C22C2BD09
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 03:25:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 250193D395E
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 05:25:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 423043D0681
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 05:24:48 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=shichen@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB438201166
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 05:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720581886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7bO/bNX4abayShREUqedtsBiSIiqyFF9vMhZsK3gCBs=;
 b=McIxEw9ctnDv8Plar3HY4ZpVHODgWJ/CPZB5p5EfyVvHnA9GwELFiMKKQtS9/M3HvaFU7T
 378Rq2BU80m6zlRLBUZ7u6aO1wNY7qEVNL+TD/D+j5keAFxeGmmMpF0x1b6ko7phjnkt4q
 8qMKBiIQo2wNc39XiwO78s03PZAMEYQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-HxN9OVuqOaKbfPELKVcQYg-1; Tue,
 09 Jul 2024 23:24:44 -0400
X-MC-Unique: HxN9OVuqOaKbfPELKVcQYg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE89819560B1
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 03:24:43 +0000 (UTC)
Received: from loobloo.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01F171955F3B; Wed, 10 Jul 2024 03:24:40 +0000 (UTC)
From: Shizhao Chen <shichen@redhat.com>
To: ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
 Eder Zulian <ezulian@redhat.com>
Date: Wed, 10 Jul 2024 11:24:34 +0800
Message-ID: <20240710032434.123315-1-shichen@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] realtime/prio-preempt: take cpu isolation into
 consideration
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

By default the test starts N-1 busy threads to monopolize N-1 available CPUs,
where N is the number of all available CPUs. However, when CPU isolation is
applied, this will lead to a hang scenario where all housekeeping CPUs are
hogged as isolated CPUs do not share the N-1 busy threads.

Signed-off-by: Shizhao Chen <shichen@redhat.com>
---
 .../realtime/func/prio-preempt/prio-preempt.c  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/testcases/realtime/func/prio-preempt/prio-preempt.c b/testcases/realtime/func/prio-preempt/prio-preempt.c
index 9bd5e7ad8..79d2115a7 100644
--- a/testcases/realtime/func/prio-preempt/prio-preempt.c
+++ b/testcases/realtime/func/prio-preempt/prio-preempt.c
@@ -59,6 +59,7 @@
  *
  *****************************************************************************/
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
@@ -287,6 +288,17 @@ void *master_thread(void *arg)
 	return NULL;
 }
 
+int get_numcpus(void)
+{
+	cpu_set_t mask;
+	CPU_ZERO(&mask);
+
+	/* Get the number of cpus accessible to the current process */
+	sched_getaffinity(getpid(), sizeof(mask), &mask);
+
+	return CPU_COUNT(&mask);
+}
+
 int main(int argc, char *argv[])
 {
 	int pri_boost, numcpus;
@@ -295,10 +307,10 @@ int main(int argc, char *argv[])
 	pass_criteria = CHECK_LIMIT;
 	rt_init("hin:", parse_args, argc, argv);
 
-	numcpus = sysconf(_SC_NPROCESSORS_ONLN);
+	numcpus = get_numcpus();
 
-	/* Max no. of busy threads should always be less than/equal the no. of cpus
-	   Otherwise, the box will hang */
+	/* Max no. of busy threads should always be less than/equal the no. of
+	   housekeeping cpus. Otherwise, the box will hang */
 
 	if (rt_threads == -1 || rt_threads > numcpus) {
 		rt_threads = numcpus;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
