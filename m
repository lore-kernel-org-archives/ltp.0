Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AF9CA9EC5
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 08:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791792261; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=oIK7jhOsMoSgWiTPQNXkq9qxc/Fu6sJzSA4xu6RevyM=;
 b=qnd5Dr8OB5rvXgXwhEADaOykjkb10KhfC+lds2F9WTlP4Meo7Xd5zDu1ebdJwcUAijrz9
 AiiV6viYjlbFunk0myIgmJN+kwtN3tmsv0YNpuf0B101h4xQS/KvpouFYZymaufmEZ6dTYa
 6XDcp7pBgXwdu8g5zbTk//HIMyOTpJY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 414693E6A94
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 10:04:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 029F23E266B
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 10:04:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E79D2003AF
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 10:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791792238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+qA7Tm4+B+7fiu91TinsuFdwyeQJgWIIXFAdG+PlKs=;
 b=WuKMt3AF0A3/heH3iwYW9uIY3+fu6Uup38RKGY97XizTO82VJZxm4raaep1AZuy1KSiWdy
 JCc34wYx+3J5hMb3EweUhuMxZ+QEVpma1sYIAvLOyYf6m9oY5yJ719reS/W0Dx+tRPVFoD
 b8fv05Wb/rG5SaGQ5s9ktohJl4/t4cE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-T1zs-h1EPs29H-IT21Jj_A-1; Mon,
 12 Oct 2026 08:03:56 +0000
X-MC-Unique: T1zs-h1EPs29H-IT21Jj_A-1
X-Mimecast-MFC-AGG-ID: T1zs-h1EPs29H-IT21Jj_A_1791792235
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1725D1954239; Mon, 12 Oct 2026 08:03:55 +0000 (UTC)
Received: from jstancek-thinkpadt14gen5.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 396A630000E7; Mon, 12 Oct 2026 08:03:53 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 12 Oct 2026 10:03:50 +0200
Message-ID: <b6d98d03422ec30d0bf5284cd094d2ecf688efe3.1791792065.git.jstancek@redhat.com>
In-Reply-To: <d462c7ccea7e45f489e9f8d5a04ec786de2014b6.1791780763.git.jstancek@redhat.com>
References: <d462c7ccea7e45f489e9f8d5a04ec786de2014b6.1791780763.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QSKwCB9yefW78cyZ0MElMKFwHGo1NRkONxBFF5k41Wo_1791792235
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] openposix: timers/twoevtimers: Wait for both timer
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

Make the counters volatile sig_atomic_t and move the printf() calls
out of the signal handlers, so that they only touch the counters and
cannot clobber errno behind nanosleep()'s back.

Arm the timers to expire 50ms from now instead of 3 seconds, so the test
passes in about 50ms, and lower LONGTIME, the upper bound for when a
signal does not arrive, from 5 to 3 seconds. Also correct the header
comment: the timers live in the same process, not in different
processes, and the test only checks that both of them expire, not that
they expire at the same time.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../functional/timers/timers/twoevtimers.c    | 58 ++++++++++++++-----
 1 file changed, 44 insertions(+), 14 deletions(-)

Changes in v4:
  - sleep in 50ms chunks

diff --git a/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c b/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
index 0e46229777fe..2bc819721fd5 100644
--- a/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
+++ b/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
@@ -5,35 +5,43 @@
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
+ * the second one may still be on its way when the first one arrives.
+ * Poll for both of them in short sleeps until LONGTIME elapses.
  */
+#include <errno.h>
 #include <stdio.h>
 #include <time.h>
 #include <signal.h>
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <unistd.h>
 #include "posixtest.h"
+#include "timespec.h"
 
-#define EXPIREDELTA 3
-#define LONGTIME 5
+#define EXPIREDELTA_NS 50000000
+#define LONGTIME 3
+
+#define POLL_MS 50
+#define POLL_COUNT (LONGTIME * 1000 / POLL_MS)
 
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
 
@@ -45,6 +53,8 @@ int test_main(int argc, char **argv)
 	struct timespec ts;
 	struct itimerspec its;
 	int flags = 0;
+	struct timespec poll_ts = { .tv_nsec = POLL_MS * 1000000 };
+	int i;
 
 	act1.sa_handler = handler_abrt;
 	act1.sa_flags = 0;
@@ -77,8 +87,12 @@ int test_main(int argc, char **argv)
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
 
@@ -93,7 +107,23 @@ int test_main(int argc, char **argv)
 		return PTS_UNRESOLVED;
 	}
 
-	sleep(EXPIREDELTA + 1);
+	/*
+	 * Sleep in short chunks rather than once for LONGTIME: a signal
+	 * that lands between the check and nanosleep() has nothing to
+	 * interrupt, so a single long sleep would run out the whole budget.
+	 * A chunk cut short by a signal only brings the next check forward.
+	 */
+	for (i = 0; i < POLL_COUNT && !(caughtalarm && caughtabort); i++) {
+		if (nanosleep(&poll_ts, NULL) != 0 && errno != EINTR) {
+			perror("nanosleep() did not return success");
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
