Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FD3C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 13:13:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE8463D385B
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 15:13:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5932D3D3818
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 15:12:54 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=shichen@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8177E1A0114D
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 15:12:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720617171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvbz8jCu9pW44p5wMBQt9wVd9XdjzW76brou1+pcMtA=;
 b=a57NFAvhMLv7lQv4mVFThteMY/L2/PBV/qF2jkvSCs5cKJWkub6N+8lVOtG+TFIbwwr9WL
 UG18YIIFqpUQ+o5SmIMbXwhvTPjOL4ZYQMaGA47Sfd5rIxyXbApjVWEsAbb5JCYdQA6PSk
 A0E0qtiA5jFjAOOQbpuEOZJFO2EMZOA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-1gG_3-jwMAeVJQqlHOmPsQ-1; Wed,
 10 Jul 2024 09:12:50 -0400
X-MC-Unique: 1gG_3-jwMAeVJQqlHOmPsQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EABF19560AB
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 13:12:49 +0000 (UTC)
Received: from loobloo.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F07351955E85; Wed, 10 Jul 2024 13:12:46 +0000 (UTC)
From: Shizhao Chen <shichen@redhat.com>
To: ltp@lists.linux.it,
	Li Wang <liwang@redhat.com>
Date: Wed, 10 Jul 2024 21:12:41 +0800
Message-ID: <20240710131241.193232-1-shichen@redhat.com>
In-Reply-To: <CAEemH2f=PzW68A2NzdfM0BDNKRHX4sfytCkzN4oG-USPHuJk9g@mail.gmail.com>
References: <CAEemH2f=PzW68A2NzdfM0BDNKRHX4sfytCkzN4oG-USPHuJk9g@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] realtime/prio-preempt: take cpu isolation into
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
Cc: Eder Zulian <ezulian@redhat.com>
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
 .../realtime/func/prio-preempt/prio-preempt.c | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/testcases/realtime/func/prio-preempt/prio-preempt.c b/testcases/realtime/func/prio-preempt/prio-preempt.c
index 9bd5e7ad8..16abc1184 100644
--- a/testcases/realtime/func/prio-preempt/prio-preempt.c
+++ b/testcases/realtime/func/prio-preempt/prio-preempt.c
@@ -59,6 +59,7 @@
  *
  *****************************************************************************/
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
@@ -287,6 +288,19 @@ void *master_thread(void *arg)
 	return NULL;
 }
 
+int get_numcpus(void)
+{
+	long numcpus_conf = sysconf(_SC_NPROCESSORS_CONF);
+	size_t size = CPU_ALLOC_SIZE(numcpus_conf);
+	cpu_set_t *cpuset = CPU_ALLOC(numcpus_conf);
+
+	CPU_ZERO_S(size, cpuset);
+	/* Get the number of cpus accessible to the current process */
+	sched_getaffinity(0, size, cpuset);
+
+	return CPU_COUNT_S(size, cpuset);
+}
+
 int main(int argc, char *argv[])
 {
 	int pri_boost, numcpus;
@@ -295,10 +309,10 @@ int main(int argc, char *argv[])
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
