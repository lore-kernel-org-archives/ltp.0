Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61333CA6019
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791543245; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=s5e8u34aEsAYH7Kd8P0+EGln6+lKT7Lf7PY4oExv4IA=;
 b=OA2lPka3Le2KjQ9QRKafGoW6o37/UYR9VUrYE+F0KEfOiyWTVPG5vGjI0GaLkBrzZqB5A
 2HPxElV/31U++B/hUa9NlLbYGutqLomzdPcoGM+qAn74Duw0LeGEcYqwN40/8hymC+oURet
 SEFr+F9KTk5vwCZtBjtGJx3U1bpwfJ0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39F9B3E6ADA
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 12:54:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CEAE3E49EF
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 12:53:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EBB1B10006D9
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 12:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791543219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zNUKYgiQs+QzqRs29XpXpDH+8SZi9yIqbBj2/LR9+s=;
 b=YXOhUoeb+6PxqtPP2CGRAZTsEnti64FhpSmW2GMX01TWIXRSJFvtIukToN1y7Kjl6CKjWA
 +eFlDFeA5YeRGV+XOmc8xr85YAS8ojqabKaAkFgqn4QksCeyvrcbGfABI4kJMVIVS9vNt3
 FewI1fQwB+tGPgclO2xdmojNbny1XPo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-CjWVNAG5NmKwsyhCQEWPBg-1; Fri,
 9 Oct 2026 10:53:37 +0000
X-MC-Unique: CjWVNAG5NmKwsyhCQEWPBg-1
X-Mimecast-MFC-AGG-ID: CjWVNAG5NmKwsyhCQEWPBg_1791543217
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EB511954218
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 10:53:36 +0000 (UTC)
Received: from jstancek-thinkpadt14gen5.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A405B30000E3
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 10:53:35 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri,  9 Oct 2026 12:52:47 +0200
Message-ID: <24014310ac600340c4ef9720980eac1c047f4b6f.1791543115.git.jstancek@redhat.com>
In-Reply-To: <4e46078e97ec7c6678cabd9f2b32cba8be3ee3cf.1791528355.git.jstancek@redhat.com>
References: <4e46078e97ec7c6678cabd9f2b32cba8be3ee3cf.1791528355.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gBeFG4BX0_N6_XNGWMgxcul3yp21fCWrFoiA1xxbcE8_1791543217
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] openposix: timers/twoevtimers: Wait for both timer
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
interruption. Make the counters volatile sig_atomic_t and print from the
handlers with the async-signal-safe PTS_WRITE_MSG() instead of printf().

Arm the timers to expire 50ms from now instead of 3 seconds, so the test
passes in about 50ms, and lower LONGTIME, the upper bound for when a
signal does not arrive, from 5 to 3 seconds. Also correct the header
comment: the timers live in the same process, not in different
processes, and the test only checks that both of them expire, not that
they expire at the same time.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../functional/timers/timers/twoevtimers.c    | 51 ++++++++++++++-----
 1 file changed, 38 insertions(+), 13 deletions(-)

Changes in v2:
 - use nanosleep
 - make signals arrive in 50ms instead of 1 second

diff --git a/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c b/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
index 0e46229777fe..1b2b20a5c399 100644
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
@@ -16,24 +23,25 @@
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
+	PTS_WRITE_MSG("Caught abort signal\n");
 	caughtabort++;
 }
 
-static void handler_alrm(int signo)
+static void handler_alrm(int signo PTS_ATTRIBUTE_UNUSED)
 {
-	printf("Caught alarm signal\n");
+	PTS_WRITE_MSG("Caught alarm signal\n");
 	caughtalarm++;
 }
 
@@ -45,6 +53,7 @@ int test_main(int argc, char **argv)
 	struct timespec ts;
 	struct itimerspec its;
 	int flags = 0;
+	struct timespec left = { .tv_sec = LONGTIME };
 
 	act1.sa_handler = handler_abrt;
 	act1.sa_flags = 0;
@@ -77,8 +86,12 @@ int test_main(int argc, char **argv)
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
 
@@ -93,7 +106,19 @@ int test_main(int argc, char **argv)
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
 
 	if ((caughtalarm == 1) && (caughtabort == 1)) {
 		printf("Test PASSED\n");
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
