Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E78DC624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788518925; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=vBBI81p07eWS3GF9sxLi7DFKIEw6ML64WZ6VDXw3/IM=;
 b=nPqhk6IQw2vmJBYFrd6Ftlj7zGYZoJkI73WL4ZXI8BxWhzI3TYoYmb0mw9dFatTbP7r8N
 uMTTcKWu2ntkPJ89jYldK+eFeJHO4aV0wNM5PbhlbwC+Nqxaf1rPP6ii4/QkwAyqk//wA8P
 kGgqyXOe7Mav4lGhkACedrmIkeet3mA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C03B83E976E
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:48:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 931C83E4B98
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:48:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0602E201108
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788518903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c70AX3uIqX37oRDY9ROB8MKsOFMYLCB7WL+BnDoy79g=;
 b=D8FHkzsWHuk1If/sF2/szxMNCtQx9PVHIFIx7bwz+LwOsXCG8HnV0AyoO4F6w7HFP74pB0
 Z8qUyCqHG3Pm0SiCY4rZQtVTzlXRyhqXxIBArDW0BVaSZgVC5TkFl3WJdV21CCaq+Kmu2i
 2NWK3auGYTzeoHsSzgcNdQWGfuWdlf8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-IGnJEC8PNnSYKypU5KowNQ-1; Fri,
 04 Sep 2026 06:48:20 -0400
X-MC-Unique: IGnJEC8PNnSYKypU5KowNQ-1
X-Mimecast-MFC-AGG-ID: IGnJEC8PNnSYKypU5KowNQ_1788518899
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDB8F195411C; Fri,  4 Sep 2026 10:48:18 +0000 (UTC)
Received: from jstancek-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E8B81955F10; Fri,  4 Sep 2026 10:48:17 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri,  4 Sep 2026 12:48:11 +0200
Message-ID: <a308e12198ce96305761a009858fa4a80c91f932.1788518850.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: COaFO9LwydFUKFwmbYQ8kNRKk6RzmTjnIe5KydSdYfg_1788518899
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getrusage03: Pin the test to a single CPU
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The inherit_fork2 subtest fails on aarch64 systems with 64K pages and a
high CPU count: after a child touches 100 MB, ru_maxrss reports only
~64 MB, outside the 20 MB delta the test allows. Since commit
f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter") the RSS
is tracked in a percpu counter whose fast read
(percpu_counter_read_positive) returns only the global count and ignores
the per-CPU caches. When a child touches memory while migrating across
many CPUs, each CPU can hold a large batch of uncounted pages, so the
sampled RSS is under-reported by tens of MB. ru_maxrss is derived from
that imprecise read, so the test observes far less than it consumed.

Pin the test process to the CPU it is currently running on before it
forks the memory-consuming children. Affinity is inherited across fork
and exec, so every descendant stays on that one CPU and at most a single
per-CPU cache is left pending, keeping the sampled RSS accurate.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/getrusage/getrusage03.c   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index a2cdd6158a6c..dcd54b772613 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -13,10 +13,12 @@
  * this program.
  */
 
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 
 #include "tst_test.h"
+#include "lapi/sched.h"
 #include "getrusage03.h"
 
 #define TESTBIN "getrusage03_child"
@@ -157,6 +159,33 @@ void (*testfunc_list[])(void) = {
 	zombie, sig_ign, inherit_exec
 };
 
+/*
+ * Pin the process (and everything it forks) to the CPU it currently runs on.
+ * Since commit f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
+ * the RSS is tracked in a percpu counter whose fast read
+ * (percpu_counter_read_positive) only returns the global count, ignoring the
+ * per-CPU caches. On many-CPU systems the caches can hold a large batch of
+ * pages each, so RSS gets under-reported by tens of MB when a child touches
+ * memory while migrating across CPUs. ru_maxrss is derived from that imprecise
+ * read, so confine the test to one CPU to keep at most a single per-CPU cache
+ * pending.
+ */
+static void setup(void)
+{
+	unsigned int cpu;
+	cpu_set_t set;
+
+	if (getcpu(&cpu, NULL))
+		tst_brk(TBROK | TERRNO, "getcpu() failed");
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	if (sched_setaffinity(0, sizeof(set), &set))
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
+
+	tst_res(TINFO, "Pinned to CPU %u", cpu);
+}
+
 static void run(unsigned int i)
 {
 	if (!SAFE_FORK()) {
@@ -180,6 +209,7 @@ static struct tst_test test = {
 		{"linux-git", "1f10206cf8e945220f7220a809d8bfc15c21f9a5"},
 		{}
 	},
+	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(testfunc_list),
 	.caps = (struct tst_cap []) {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
