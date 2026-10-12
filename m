Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D056ECA9ED1
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 04:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791781027; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vhby4OeyVqzLi7NmgPF+IOpMLGcAvi2xlO9Mkkev6zY=;
 b=maHZYDIL55LVMEdNn5ApatE6+kIM0+MGJdd1GexRSA7y0+7EPkosvKwnkhvvsVGsSxSgh
 19XmDL37RtYn6+rOBHP+FsvTSwg0Nf+g+7Stpv7mZUHIhJ9vN5nC2IR09LYTElF90AL9jLf
 3HDrB3BaWqiALGKJejm90Tp1yNedCIE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EB223E25E1
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 06:57:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C36133E24CF
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 06:56:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 048542002A9
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 06:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791781004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzVhglwOm+68VEUDC0U9UDUkiLIoTQrs7W+bXtmminI=;
 b=dVRnGqtSU3XOBhs6/FIeViEWG6qJyaCHIH8kZsqCs/22awyx6jyhmtns4iVG24aGhp9Zch
 ltfdExQPnZW0oq8nYVHPMveJvtizxA6lzr0Nm9W7SZxr/tZfxp3Bttw3iYqOs6j7uiD8a/
 1mXkwTkwkdmtGJO91vv5U0MbzVTJPVo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-O3HIQxBBNpO45Y9wVYCEUA-1; Mon,
 12 Oct 2026 04:56:41 +0000
X-MC-Unique: O3HIQxBBNpO45Y9wVYCEUA-1
X-Mimecast-MFC-AGG-ID: O3HIQxBBNpO45Y9wVYCEUA_1791781000
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B7B6195422B; Mon, 12 Oct 2026 04:56:40 +0000 (UTC)
Received: from jstancek-thinkpadt14gen5.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 204AB30000E5; Mon, 12 Oct 2026 04:56:38 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 12 Oct 2026 06:56:35 +0200
Message-ID: <d462c7ccea7e45f489e9f8d5a04ec786de2014b6.1791780763.git.jstancek@redhat.com>
In-Reply-To: <24014310ac600340c4ef9720980eac1c047f4b6f.1791543115.git.jstancek@redhat.com>
References: <24014310ac600340c4ef9720980eac1c047f4b6f.1791543115.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bYaoYDFgSP9zuHk5vg2UKPn2rJ7jpm7WYV7fZzmrBbQ_1791781000
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] openposix: timers/twoevtimers: Wait for both timer
 signals
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

The test arms two timers with the same absolute expiration time and
then does a single sleep() before checking that both signals arrived.
sleep() returns as soon as the first signal interrupts it, and the
kernel delivers the two signals one at a time. This sporadically
leads to failure:

  Caught abort signal
  Test FAILED

even though the second timer fires microseconds later.

Keep sleeping on the remaining time until both signals have been caught
or the LONGTIME budget, which was defined but never used, runs out. Use
nanosleep() rather than sleep() for this, since sleep() returns the
unslept time in whole seconds and the fraction would be lost on every
interruption. Make the counters volatile sig_atomic_t and move the
printf() calls out of the signal handlers, so that they only touch the
counters and cannot clobber errno behind nanosleep()'s back.

Arm the timers to expire 50ms from now instead of 3 seconds, so the test
passes in about 50ms, and lower LONGTIME, the upper bound for when a
signal does not arrive, from 5 to 3 seconds. Also correct the header
comment: the timers live in the same process, not in different
processes, and the test only checks that both of them expire, not that
they expire at the same time.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../functional/timers/timers/twoevtimers.c    | 54 ++++++++++++++-----
 1 file changed, 41 insertions(+), 13 deletions(-)

Changes in v3:
 - move prints out of signal handlers

diff --git a/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c b/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
index 0e46229777fe..05e53ad4ba48 100644
--- a/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
+++ b/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
@@ -5,9 +5,16 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
- * Test having two timers in different processes set to expire at the
- * same time, and ensure they both expire at the same time.
+ * Test having two timers in the same process, armed with the same
+ * absolute expiration time but delivering different signals, and ensure
+ * that both of them expire.
+ *
+ * Note that the test does not (and cannot) verify that the two signals
+ * are delivered simultaneously.  Signals are delivered one at a time, so
+ * the first one interrupts nanosleep() while the second one may still be
+ * on its way.  Keep waiting until both have arrived or LONGTIME elapses.
  */
+#include <errno.h>
 #include <stdio.h>
 #include <time.h>
 #include <signal.h>
@@ -16,24 +23,23 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include "posixtest.h"
+#include "timespec.h"
 
-#define EXPIREDELTA 3
-#define LONGTIME 5
+#define EXPIREDELTA_NS 50000000
+#define LONGTIME 3
 
 #define CHILDPASS 1
 
-static int caughtabort = 0;
-static int caughtalarm = 0;
+static volatile sig_atomic_t caughtabort = 0;
+static volatile sig_atomic_t caughtalarm = 0;
 
-static void handler_abrt(int signo)
+static void handler_abrt(int signo PTS_ATTRIBUTE_UNUSED)
 {
-	printf("Caught abort signal\n");
 	caughtabort++;
 }
 
-static void handler_alrm(int signo)
+static void handler_alrm(int signo PTS_ATTRIBUTE_UNUSED)
 {
-	printf("Caught alarm signal\n");
 	caughtalarm++;
 }
 
@@ -45,6 +51,7 @@ int test_main(int argc, char **argv)
 	struct timespec ts;
 	struct itimerspec its;
 	int flags = 0;
+	struct timespec left = { .tv_sec = LONGTIME };
 
 	act1.sa_handler = handler_abrt;
 	act1.sa_flags = 0;
@@ -77,8 +84,12 @@ int test_main(int argc, char **argv)
 		return PTS_UNRESOLVED;
 	}
 
-	its.it_value.tv_sec = ts.tv_sec + EXPIREDELTA;
-	its.it_value.tv_nsec = ts.tv_nsec;
+	its.it_value.tv_sec = ts.tv_sec;
+	its.it_value.tv_nsec = ts.tv_nsec + EXPIREDELTA_NS;
+	if (its.it_value.tv_nsec >= NSEC_IN_SEC) {
+		its.it_value.tv_sec++;
+		its.it_value.tv_nsec -= NSEC_IN_SEC;
+	}
 	its.it_interval.tv_sec = 0;
 	its.it_interval.tv_nsec = 0;
 
@@ -93,7 +104,24 @@ int test_main(int argc, char **argv)
 		return PTS_UNRESOLVED;
 	}
 
-	sleep(EXPIREDELTA + 1);
+	/*
+	 * nanosleep() returns early when the first signal arrives; keep
+	 * waiting on the remaining time until the second one has been
+	 * delivered as well or we time out.
+	 */
+	while (!(caughtalarm && caughtabort)) {
+		if (nanosleep(&left, &left) == 0)
+			break;
+		if (errno != EINTR) {
+			perror("nanosleep() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
+	}
+
+	if (caughtabort)
+		printf("Caught abort signal\n");
+	if (caughtalarm)
+		printf("Caught alarm signal\n");
 
 	if ((caughtalarm == 1) && (caughtabort == 1)) {
 		printf("Test PASSED\n");
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
